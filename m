Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DDB753B99
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 15:15:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKIcw-0001xS-Eh; Fri, 14 Jul 2023 09:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKIct-0001xE-Ty; Fri, 14 Jul 2023 09:14:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKIcr-0001dp-Vl; Fri, 14 Jul 2023 09:14:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 25F4813E80;
 Fri, 14 Jul 2023 16:14:40 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0498414C25;
 Fri, 14 Jul 2023 16:14:24 +0300 (MSK)
Message-ID: <40bffdbc-5067-3ac2-ac57-ed37d02d8419@tls.msk.ru>
Date: Fri, 14 Jul 2023 16:14:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH, trivial 15/29] tree-wide spelling fixes in comments and
 some messages: other architectures
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
 <20230714113834.1186117-17-mjt@tls.msk.ru>
 <CAFEAcA-VJG_Mt3AVtUeFPK+2sdg=kNabMijy0og9_fH=rQ92fw@mail.gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CAFEAcA-VJG_Mt3AVtUeFPK+2sdg=kNabMijy0og9_fH=rQ92fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
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

14.07.2023 15:49, Peter Maydell wrote:
> On Fri, 14 Jul 2023 at 12:40, Michael Tokarev <mjt@tls.msk.ru> wrote:
>>
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>> ---
>>   host/include/aarch64/host/cpuinfo.h              |  2 +-
> 
> This...
> 
>>   hw/misc/allwinner-r40-dramc.c                    |  2 +-
>>   hw/misc/exynos4210_rng.c                         |  2 +-
> 
> ...these...
> 
>>   tests/tcg/aarch64/gdbstub/test-sve.py            |  2 +-
>>   tests/tcg/aarch64/sme-outprod1.c                 |  2 +-
>>   tests/tcg/aarch64/system/boot.S                  |  6 +++---
>>   tests/tcg/aarch64/system/semiheap.c              |  2 +-
> 
> ...and these are all arm, not "other".

I'll move these 7 files to the "arm" part, and both can now have
your r-b.

> But anyway, for the whole patch
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thank you!

/mjt

