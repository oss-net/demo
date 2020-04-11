#!MANAGED-CONFIG {{ downloadUrl }} interval=43200 strict=false


[General]
# 日志等级: warning, notify, info, verbose (默认值: notify)
loglevel = notify
# 跳过某个域名或者 IP 段，这些目标主机将不会由 Surge Proxy 处理。(在 macOS
# 版本中，如果启用了 Set as System Proxy,  那么这些值会被写入到系统网络代理
# 设置中.)
skip-proxy = 127.0.0.1, 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12, 100.64.0.0/10, 100.84.0.0/10, localhost, *.local
# 强制使用特定的 DNS 服务器
dns-server = system, 119.29.29.29, 223.5.5.5, 1.1.1.1

# 以下参数仅供 iOS 版本使用
# 将系统相关请求交给 Surge TUN 处理，并自动追加规则
# "IP-CIDR,17.0.0.0/8,DIRECT,no-resolve"
bypass-system = true
# 将特定 IP 段跳过 Surge TUN，详见 Manual
bypass-tun = 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12
# 是否截取并保存 HTTP 流量 (启用后将对性能有较大影响) (默认值: false)
replica = false
# 是否启动完整的 IPv6 支持 (默认值: false)
ipv6 = false

# 以下参数仅供 macOS 版本使用（多端口监听仅 Surge 3 支持）
http-listen = 0.0.0.0:6152
socks5-listen = 0.0.0.0:6153

# 测速地址
internet-test-url = {{ proxyTestUrl }}
proxy-test-url = {{ proxyTestUrl }}

# 其它
# external-controller-access = password@0.0.0.0:6170
show-primary-interface-changed-notification = true
proxy-settings-interface = Primary Interface (Auto)
menu-bar-show-speed = false
allow-wifi-access = true
hide-crashlytics-request = true

[Proxy]
{{ getSurgeNodes(nodeList) }}

[Proxy Group]
🚀 Proxy = select, {{ getNodeNames(nodeList) }}
🎬 Netflix = select, {{ getNodeNames(nodeList, netflixFilter) }}
📺 YouTube = select, 🚀 Proxy, US, HK
🍎 Apple = select, DIRECT, 🚀 Proxy, US, HK
🍏 Apple CDN = select, DIRECT, 🍎 Apple
US = url-test, {{ getNodeNames(nodeList, usFilter) }}, url = {{ proxyTestUrl }}, interval = 1200
HK = url-test, {{ getNodeNames(nodeList, hkFilter) }}, url = {{ proxyTestUrl }}, interval = 1200
BGP = url-test, {{ getNodeNames(nodeList, customFilters.bgp) }}, url = {{ proxyTestUrl }}, interval = 1200
IPLC = url-test, {{ getNodeNames(nodeList, customFilters.iplc) }}, url = {{ proxyTestUrl }}, interval = 1200

[Rule]
RULE-SET,https://raw.githubusercontent.com/eHpo1/Rules/master/Surge4/Ruleset/Liby.list,REJECT, update-interval=21600
RULE-SET,https://raw.githubusercontent.com/eHpo1/Rules/master/Surge4/Ruleset/Tide.list,REJECT, update-interval=21600
RULE-SET,https://raw.githubusercontent.com/NobyDa/Script/master/Surge/Download.list,DIRECT, update-interval=21600
RULE-SET,https://raw.githubusercontent.com/eHpo1/Rules/master/Surge4/Ruleset/Apple_CDN.list,🍏 Apple CDN, update-interval=21600
RULE-SET,https://raw.githubusercontent.com/eHpo1/Rules/master/Surge4/Ruleset/Apple_API.list,🍎 Apple, update-interval=21600
RULE-SET,https://raw.githubusercontent.com/eHpo1/Rules/master/Surge4/Ruleset/AsianMedia.list,DIRECT, update-interval=21600
RULE-SET,https://raw.githubusercontent.com/eHpo1/Rules/master/Surge4/Ruleset/Sub/Netflix.list,🎬 Netflix, update-interval=21600
RULE-SET,https://raw.githubusercontent.com/eHpo1/Rules/master/Surge4/Ruleset/Sub/YouTube.list,📺 YouTube, update-interval=21600
RULE-SET,https://raw.githubusercontent.com/eHpo1/Rules/master/Surge4/Ruleset/Domestic.list,DIRECT, update-interval=21600
RULE-SET,https://raw.githubusercontent.com/eHpo1/Rules/master/Surge4/Ruleset/Global.list,🚀 Proxy, update-interval=21600
RULE-SET,https://raw.githubusercontent.com/eHpo1/Rules/master/Surge4/Ruleset/Region.list,DIRECT, update-interval=21600

# Rulesets
RULE-SET,SYSTEM,DIRECT

# LAN
RULE-SET,LAN,DIRECT

# GeoIP CN
GEOIP,CN,DIRECT

# Final
FINAL,🚀 Proxy,dns-failed

[URL Rewrite]
^https?://(www.)?g.cn https://www.google.com 302
^https?://(www.)?google.cn https://www.google.com 302
