Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B687D1D26
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 14:31:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quB7b-0001ot-Gc; Sat, 21 Oct 2023 08:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1quB7X-0001gP-Uz; Sat, 21 Oct 2023 08:30:23 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1quB7U-0007Ol-Vv; Sat, 21 Oct 2023 08:30:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 444982C369;
 Sat, 21 Oct 2023 15:30:40 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2F4E930693;
 Sat, 21 Oct 2023 15:30:15 +0300 (MSK)
Message-ID: <779fbc42-c397-44e0-8682-9a330cd1ec4f@tls.msk.ru>
Date: Sat, 21 Oct 2023 15:30:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/boot: Set SCR_EL3.FGTEn when booting kernel
Content-Language: en-US
To: Fabian Vogt <fvogt@suse.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
References: <4831384.GXAFRqVoOG@linux-e202.suse.de>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <4831384.GXAFRqVoOG@linux-e202.suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

13.09.2023 14:57, Fabian Vogt :
> Just like d7ef5e16a17c sets SCR_EL3.HXEn for FEAT_HCX, this commit
> handles SCR_EL3.FGTEn for FEAT_FGT:
> 
> When we direct boot a kernel on a CPU which emulates EL3, we need to
> set up the EL3 system registers as the Linux kernel documentation
> specifies:
>      https://www.kernel.org/doc/Documentation/arm64/booting.rst
> 
>> For CPUs with the Fine Grained Traps (FEAT_FGT) extension present:
>> - If EL3 is present and the kernel is entered at EL2:
>>    - SCR_EL3.FGTEn (bit 27) must be initialised to 0b1.

Am I right assuming this makes no sense to pick up for stable-7.2 since
it doesn't even have aa64_fgt definitions (commit 15126d9ce2
"target/arm: Define the FEAT_FGT registers"), or should this commit
be picked up too?

This and subsequent change in this area, "target/arm: Fix CNTPCT_EL0
trapping from EL0 when HCR_EL2.E2H is 0"

Thanks,

/mjt

