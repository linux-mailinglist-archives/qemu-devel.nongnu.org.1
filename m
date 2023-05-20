Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA4B70A563
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 06:47:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0EUI-0007t5-9B; Sat, 20 May 2023 00:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q0EUF-0007sK-7R
 for qemu-devel@nongnu.org; Sat, 20 May 2023 00:46:35 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q0EUD-0007CA-Da
 for qemu-devel@nongnu.org; Sat, 20 May 2023 00:46:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 761EF74B5;
 Sat, 20 May 2023 07:46:18 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A7B6B6C08;
 Sat, 20 May 2023 07:46:16 +0300 (MSK)
Message-ID: <d53a8882-eb59-cf09-6ab7-b4a712f20668@tls.msk.ru>
Date: Sat, 20 May 2023 07:46:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] hw/cxl: CDAT file handling fixes.
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 linuxarm@huawei.com, Zeng Hao <zenghao@kylinos.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230421132020.7408-1-Jonathan.Cameron@huawei.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230421132020.7408-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.527,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

21.04.2023 16:20, Jonathan Cameron via wrote:
> I've picked up Hao Zeng's v5 and added a patch to deal with the
> issues that Peter pointed out in this area.
> 
> On error, the CDAT file handling left resource dangling and didn't
> cleanly exit from calling functions.  Hao Zeng dealt with closing
> the file. The second patch deals with the buffer allocation and
> ensuring a clean exit at the two callers.
> 
> Hao Zeng (1):
>    hw/cxl: cdat: Fix open file not closed in ct3_load_cdat()
> 
> Jonathan Cameron (1):
>    hw/cxl: cdat: Fix failure to free buffer in erorr paths
> 
>   hw/cxl/cxl-cdat.c            | 60 +++++++++++++++---------------------
>   hw/mem/cxl_type3.c           |  4 +++
>   hw/pci-bridge/cxl_upstream.c |  3 ++
>   3 files changed, 32 insertions(+), 35 deletions(-)

Hi!

Is it a stable (8.0 & 7.2) material?
The issues does not seem to be very important, still smells like
a good thing to have in -stable.

Thanks,

/mjt

