Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C498F79EA58
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 16:01:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgQQA-0007YK-Pz; Wed, 13 Sep 2023 10:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgQQ6-0007Wh-30; Wed, 13 Sep 2023 10:00:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgQQ0-0001EU-3T; Wed, 13 Sep 2023 10:00:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 24AD8217DF;
 Wed, 13 Sep 2023 17:00:36 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 17F1427CC8;
 Wed, 13 Sep 2023 17:00:30 +0300 (MSK)
Message-ID: <afe29ae4-4cac-4edb-b6fb-8652da03554e@tls.msk.ru>
Date: Wed, 13 Sep 2023 17:00:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/4] hw/cxl: Minor CXL emulation fixes and cleanup
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Dave Jiang <dave.jiang@intel.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 linuxarm@huawei.com, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

04.09.2023 16:28, Jonathan Cameron via wrote:
> A small set gathering patches that have been posted and reviewed on list
> over the last few months. Looking to get these upstream before making
> any significant changes to the CXL emulation for this cycle.
> 
> More wide spread cleanup will follow later this cycle (reference
> updates to available spec and line length improvements).
> 
> Dave Jiang (1):
>    hw/pci-bridge/cxl_upstream: Fix bandwidth entry base unit for SSLBIS
> 
> Fan Ni (1):
>    hw/cxl/cxl_device: Replace magic number in CXLError definition
> 
> Li Zhijian (2):
>    hw/cxl: Fix CFMW config memory leak
>    docs/cxl: Change to lowercase as others
> 
>   docs/system/devices/cxl.rst  |  8 ++++----
>   include/hw/cxl/cxl_device.h  |  2 +-
>   hw/cxl/cxl-host.c            | 12 ++++++------
>   hw/pci-bridge/cxl_upstream.c |  2 +-
>   4 files changed, 12 insertions(+), 12 deletions(-)
> 

Applied to my trivial-patches tree. Thank you!

/mjt

