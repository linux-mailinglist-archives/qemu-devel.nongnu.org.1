Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB3371542C
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 05:23:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3pvn-00005H-Gk; Mon, 29 May 2023 23:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1q3pvk-000052-Ji
 for qemu-devel@nongnu.org; Mon, 29 May 2023 23:21:52 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1q3pvh-0005Qc-PR
 for qemu-devel@nongnu.org; Mon, 29 May 2023 23:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685416908; x=1716952908;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Mi16hG/40W5ZL/RjUudl0lhVt83UX1umM4+JVqixf70=;
 b=AaljIziHYXmuOi0ryUTBzjEGEUPtn00EQ7z0Clxq9bv3IMc4diha+Gc1
 TBeBdWg+c5bzed1WeoZ8fSpn63F2sDF7d1EJ7Q42LiF+BO9riEDYLwkqd
 JBqR8Nx9yu7YWkLw69e/87l0gBaeC3MNcJfpssj6RnYRVevkfjNEVfwXo
 YBjrsDCjJGO9vq7+ABS3FsKE/7ZoPSjIyCwkF5+oaZQHzfcTWVFOZjge8
 muw6e6TjIxrkYZSYW+yVQp4DFVge93oBmfNm182PHeWm+e6WPKu4t3+oj
 XjvDeAqNcfCqCTZZ0iC0eznq4MveklqOLGZ7ATu6UIi4YQCuhFbQtSrXi A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420564793"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="420564793"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 20:21:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="700442674"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="700442674"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.255.29.73])
 ([10.255.29.73])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 20:21:41 -0700
Message-ID: <35e564bc-7fe0-e6e2-b674-062fe952cbcf@intel.com>
Date: Tue, 30 May 2023 11:21:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/4] migration/calc-dirty-rate: tool to predict
 migration time
Content-Language: en-US
To: Andrei Gudkov <gudkov.andrei@huawei.com>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, eblake@redhat.com, armbru@redhat.com,
 berrange@redhat.com, zhengchuan@huawei.com
References: <cover.1682598010.git.gudkov.andrei@huawei.com>
 <644a9e7f2bff9d36716a3722c729dc88ea40a35a.1682598010.git.gudkov.andrei@huawei.com>
From: "Wang, Lei" <lei4.wang@intel.com>
In-Reply-To: <644a9e7f2bff9d36716a3722c729dc88ea40a35a.1682598010.git.gudkov.andrei@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100; envelope-from=lei4.wang@intel.com;
 helo=mga07.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 4/27/2023 20:43, Andrei Gudkov via wrote:
> Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
> ---
>  MAINTAINERS                  |   1 +
>  scripts/predict_migration.py | 283 +++++++++++++++++++++++++++++++++++
>  2 files changed, 284 insertions(+)
>  create mode 100644 scripts/predict_migration.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fc225e66df..0c578446cf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3167,6 +3167,7 @@ F: docs/devel/migration.rst
>  F: qapi/migration.json
>  F: tests/migration/
>  F: util/userfaultfd.c
> +F: scripts/predict_migration.py
>  
>  D-Bus
>  M: Marc-André Lureau <marcandre.lureau@redhat.com>
> diff --git a/scripts/predict_migration.py b/scripts/predict_migration.py
> new file mode 100644
> index 0000000000..c92a97585f
> --- /dev/null
> +++ b/scripts/predict_migration.py
> @@ -0,0 +1,283 @@
> +#!/usr/bin/env python3
> +#
> +# Predicts time required to migrate VM under given max downtime constraint.
> +#
> +# Copyright (c) 2023 HUAWEI TECHNOLOGIES CO.,LTD.
> +#
> +# Authors:
> +#  Andrei Gudkov <gudkov.andrei@huawei.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +
> +# Usage:
> +#
> +# Step 1. Collect dirty page statistics from live VM:
> +# $ scripts/predict_migration.py calc-dirty-rate <qmphost> <qmpport> >dirty.json
> +# <...takes 1 minute by default...>
> +#
> +# Step 2. Run predictor against collected data:
> +# $ scripts/predict_migration.py predict < dirty.json
> +# Downtime> |    125ms |    250ms |    500ms |   1000ms |   5000ms |    unlim |
> +# -----------------------------------------------------------------------------
> +#  100 Mbps |        - |        - |        - |        - |        - |   16m45s |
> +#    1 Gbps |        - |        - |        - |        - |        - |    1m39s |
> +#    2 Gbps |        - |        - |        - |        - |    1m55s |      50s |
> +#  2.5 Gbps |        - |        - |        - |        - |    1m12s |      40s |
> +#    5 Gbps |        - |        - |        - |      29s |      25s |      20s |
> +#   10 Gbps |      13s |      13s |      12s |      12s |      12s |      10s |
> +#   25 Gbps |       5s |       5s |       5s |       5s |       4s |       4s |
> +#   40 Gbps |       3s |       3s |       3s |       3s |       3s |       3s |
> +#
> +# The latter prints table that lists estimated time it will take to migrate VM.
> +# This time depends on the network bandwidth and max allowed downtime.
> +# Dash indicates that migration does not converge.
> +# Prediction takes care only about migrating RAM and only in pre-copy mode.
> +# Other features, such as compression or local disk migration, are not supported
> +
> +
> +import sys
> +import os
> +import math
> +import json
> +from dataclasses import dataclass
> +import asyncio
> +import argparse
> +
> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'python'))
> +from qemu.qmp import QMPClient
> +
> +async def calc_dirty_rate(host, port, calc_time, sample_pages):
> +    client = QMPClient()
> +    try:
> +        await client.connect((host, port))
> +        args = {
> +            'calc-time': calc_time,
> +            'sample-pages': sample_pages
> +        }
> +        await client.execute('calc-dirty-rate', args)
> +        await asyncio.sleep(calc_time)
> +        while True:
> +            data = await client.execute('query-dirty-rate')
> +            if data['status'] == 'measuring':
> +                await asyncio.sleep(0.5)
> +            elif data['status'] == 'measured':
> +                return data
> +            else:
> +                raise ValueError(data['status'])
> +    finally:
> +        await client.disconnect()
> +
> +
> +class MemoryModel:
> +    """
> +    Models RAM state during pre-copy migration using calc-dirty-rate results.
> +    Its primary function is to estimate how many pages will be dirtied
> +    after given time starting from "clean" state.
> +    This function is non-linear and saturates at some point.
> +    """
> +
> +    @dataclass
> +    class Point:
> +        period_millis:float
> +        dirty_pages:float
> +
> +    def __init__(self, data):
> +        """
> +        :param data: dictionary returned by calc-dirty-rate
> +        """
> +        self.__points = self.__make_points(data)
> +        self.__page_size = data['page-size']
> +        self.__num_total_pages = data['n-total-pages']
> +        self.__num_zero_pages = data['n-zero-pages'] / \
> +                (data['n-sampled-pages'] / data['n-total-pages'])
> +
> +    def __make_points(self, data):
> +        points = list()
> +
> +        # Add observed points
> +        sample_ratio = data['n-sampled-pages'] / data['n-total-pages']
> +        for millis,dirty_pages in zip(data['periods'], data['n-dirty-pages']):
> +            millis = float(millis)
> +            dirty_pages = dirty_pages / sample_ratio
> +            points.append(MemoryModel.Point(millis, dirty_pages))
> +
> +        # Extrapolate function to the left.
> +        # Assuming that the function is convex, the worst case is achieved
> +        # when dirty page count immediately jumps to some value at zero time
> +        # (infinite slope), and next keeps the same slope as in the region
> +        # between the first two observed points: points[0]..points[1]
> +        slope, offset = self.__fit_line(points[0], points[1])
> +        points.insert(0, MemoryModel.Point(0.0, max(offset, 0.0)))
> +
> +        # Extrapolate function to the right.
> +        # The worst case is achieved when the function has the same slope
> +        # as in the last observed region.
> +        slope, offset = self.__fit_line(points[-2], points[-1])
> +        max_dirty_pages = \
> +                data['n-total-pages'] - (data['n-zero-pages'] / sample_ratio)
> +        if slope > 0.0:
> +            saturation_millis = (max_dirty_pages - offset) / slope
> +            points.append(MemoryModel.Point(saturation_millis, max_dirty_pages))
> +        points.append(MemoryModel.Point(math.inf, max_dirty_pages))
> +
> +        return points
> +
> +    def __fit_line(self, lhs:Point, rhs:Point):
> +        slope = (rhs.dirty_pages - lhs.dirty_pages) / \
> +                (rhs.period_millis - lhs.period_millis)
> +        offset = lhs.dirty_pages - slope * lhs.period_millis
> +        return slope, offset
> +
> +    def page_size(self):
> +        """
> +        Return page size in bytes
> +        """
> +        return self.__page_size
> +
> +    def num_total_pages(self):
> +        return self.__num_total_pages
> +
> +    def num_zero_pages(self):
> +        """
> +        Estimated total number of zero pages. Assumed to be constant.
> +        """
> +        return self.__num_zero_pages
> +
> +    def num_dirty_pages(self, millis):
> +        """
> +        Estimate number of dirty pages after given time starting from "clean"
> +        state. The estimation is based on piece-wise linear interpolation.
> +        """
> +        for i in range(len(self.__points)):
> +            if self.__points[i].period_millis == millis:
> +                return self.__points[i].dirty_pages
> +            elif self.__points[i].period_millis > millis:
> +                slope, offset = self.__fit_line(self.__points[i-1],
> +                                                        self.__points[i])

Seems the indentation is broken here.

> +                return offset + slope * millis
> +        raise RuntimeError("unreachable")
> +
> +
> +def predict_migration_time(model, bandwidth, downtime, deadline=3600*1000):
> +    """
> +    Predict how much time it will take to migrate VM under under given

Nit: Duplicated "under".

> +    deadline constraint.
> +
> +    :param model: `MemoryModel` object for a given VM
> +    :param bandwidth: Bandwidth available for migration [bytes/s]
> +    :param downtime: Max allowed downtime [milliseconds]
> +    :param deadline: Max total time to migrate VM before timeout [milliseconds]
> +    :return: Predicted migration time [milliseconds] or `None`
> +             if migration process doesn't converge before given deadline
> +    """
> +
> +    left_zero_pages = model.num_zero_pages()
> +    left_normal_pages = model.num_total_pages() - model.num_zero_pages()
> +    header_size = 8

In the cover letter: "Typical prediction error is 6-7%". I'm wondering if the
6-7% is less or more than the real migration time. I think 2 potential factors
will lead to less estimation time:

  1. Network protocol stack's headers are not counted in, e.g., TCP's header can
     be 20 ~ 60 bytes.

  2. The bandwidth may not be saturated all the time.

> +
> +    total_millis = 0.0
> +    while True:
> +        iter_bytes = 0.0
> +        iter_bytes += left_normal_pages * (model.page_size() + header_size)
> +        iter_bytes += left_zero_pages * header_size
> +
> +        iter_millis = iter_bytes * 1000.0 / bandwidth
> +
> +        total_millis += iter_millis
> +
> +        if iter_millis <= downtime:
> +            return int(math.ceil(total_millis))
> +        elif total_millis > deadline:
> +            return None
> +        else:
> +            left_zero_pages = 0
> +            left_normal_pages = model.num_dirty_pages(iter_millis)
> +
> +
> +def run_predict_cmd(model):
> +    @dataclass
> +    class ValStr:
> +        value:object
> +        string:str
> +
> +    def gbps(value):
> +        return ValStr(value*1024*1024*1024/8, f'{value} Gbps')
> +
> +    def mbps(value):
> +        return ValStr(value*1024*1024/8, f'{value} Mbps')
> +
> +    def dt(millis):
> +        if millis is not None:
> +            return ValStr(millis, f'{millis}ms')
> +        else:
> +            return ValStr(math.inf, 'unlim')
> +
> +    def eta(millis):
> +        if millis is not None:
> +            seconds = int(math.ceil(millis/1000.0))
> +            minutes, seconds = divmod(seconds, 60)
> +            s = ''
> +            if minutes > 0:
> +                s += f'{minutes}m'
> +            if len(s) > 0:
> +                s += f'{seconds:02d}s'
> +            else:
> +                s += f'{seconds}s'
> +        else:
> +            s = '-'
> +        return ValStr(millis, s)
> +
> +
> +    bandwidths = [mbps(100), gbps(1), gbps(2), gbps(2.5), gbps(5), gbps(10),
> +                  gbps(25), gbps(40)]
> +    downtimes = [dt(125), dt(250), dt(500), dt(1000), dt(5000), dt(None)]
> +
> +    out = ''
> +    out += 'Downtime> |'
> +    for downtime in downtimes:
> +        out += f'  {downtime.string:>7} |'
> +    print(out)
> +
> +    print('-'*len(out))
> +
> +    for bandwidth in bandwidths:
> +        print(f'{bandwidth.string:>9} | ', '', end='')
> +        for downtime in downtimes:
> +            millis = predict_migration_time(model,
> +                                            bandwidth.value,
> +                                            downtime.value)
> +            print(f'{eta(millis).string:>7} | ', '', end='')
> +        print()
> +
> +def main():
> +    parser = argparse.ArgumentParser()
> +    subparsers = parser.add_subparsers(dest='command', required=True)
> +
> +    parser_cdr = subparsers.add_parser('calc-dirty-rate',
> +            help='Collect and print dirty page statistics from live VM')
> +    parser_cdr.add_argument('--calc-time', type=int, default=60,
> +                            help='Calculation time in seconds')
> +    parser_cdr.add_argument('--sample-pages', type=int, default=512,
> +            help='Number of sampled pages per one gigabyte of RAM')
> +    parser_cdr.add_argument('host', metavar='host', type=str, help='QMP host')
> +    parser_cdr.add_argument('port', metavar='port', type=int, help='QMP port')
> +
> +    subparsers.add_parser('predict', help='Predict migration time')
> +
> +    args = parser.parse_args()
> +
> +    if args.command == 'calc-dirty-rate':
> +        data = asyncio.run(calc_dirty_rate(host=args.host,
> +                                           port=args.port,
> +                                           calc_time=args.calc_time,
> +                                           sample_pages=args.sample_pages))
> +        print(json.dumps(data))
> +    elif args.command == 'predict':
> +        data = json.load(sys.stdin)
> +        model = MemoryModel(data)
> +        run_predict_cmd(model)
> +
> +if __name__ == '__main__':
> +    main()

