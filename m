Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A017A9562
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 16:53:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjL2Y-0004VO-Q7; Thu, 21 Sep 2023 10:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjL2Q-0004VC-MZ; Thu, 21 Sep 2023 10:52:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjL2O-0001mD-KA; Thu, 21 Sep 2023 10:52:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 47F2B23FF2;
 Thu, 21 Sep 2023 17:52:27 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 784EA29D1F;
 Thu, 21 Sep 2023 17:52:05 +0300 (MSK)
Message-ID: <2bbd5d06-e62c-a608-c776-a330bd33f4db@tls.msk.ru>
Date: Thu, 21 Sep 2023 17:52:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] linux-user: Fixes for zero_bss
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, philmd@linaro.org, qemu-stable@nongnu.org
References: <20230909184559.36504-1-richard.henderson@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230909184559.36504-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

09.09.2023 21:45, Richard Henderson wrote:
> The previous change, 2d385be6152, assumed !PAGE_VALID meant that
> the page would be unmapped by the elf image.  However, since we
> reserved the entire image space via mmap, PAGE_VALID will always
> be set.  Instead, assume PROT_NONE for the same condition.
> 
> Furthermore, assume bss is only ever present for writable segments,
> and that there is no page overlap between PT_LOAD segments.
> Instead of an assert, return false to indicate failure.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1854
> Fixes: 2d385be6152 ("linux-user: Do not adjust zero_bss for host page size")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Pass errp to zero_bss, so we can give a reasonable error message.
> ---
>   linux-user/elfload.c | 53 +++++++++++++++++++++++++++++++++-----------
>   1 file changed, 40 insertions(+), 13 deletions(-)

Ping? Has this been forgotten?
I picked this one up for debian 8.1 package, at least I don't see
regressions with it applied (together with stuff staging for 8.1.1).

Thanks,

/mjt

