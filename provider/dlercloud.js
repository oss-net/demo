'use strict';
const { utils } = require('surgio');
module.exports = {
  url: 'https://dler.cloud/subscribe/qwertyui?mu=ss',
  type: 'shadowsocks_subscribe',
  // 定义所有的节点都支持 udpRelay
  udpRelay: true,
  // 开启TFO
  tfo: false,
  // 添加国旗 emoji
  addFlag: true,
  // 自定义Filter（过滤节点）
  customFilters: {
    iplc: utils.useRegexp(/.*IPLC/),
    bgp: utils.useKeywords(['BGP']),
  },
};