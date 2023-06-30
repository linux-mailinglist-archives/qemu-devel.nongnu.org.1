Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3516374369D
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:11:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF98f-0003Yn-M1; Fri, 30 Jun 2023 04:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qF97r-0002kV-S2
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:05:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qF97p-0000va-86
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:05:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3E6941043C;
 Fri, 30 Jun 2023 11:05:02 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B5889109D8;
 Fri, 30 Jun 2023 11:05:01 +0300 (MSK)
Message-ID: <8a4605f1-fb1e-2243-5dff-bf1c33e11360@tls.msk.ru>
Date: Fri, 30 Jun 2023 11:05:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] accel/tcg: add assert() check in
 tb_invalidate_phys_page_range__locked()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 richard.henderson@linaro.org, clegoate@redhat.com, hsp.cat7@gmail.com,
 qemu-devel@nongnu.org
References: <20230629082522.606219-1-mark.cave-ayland@ilande.co.uk>
 <20230629082522.606219-3-mark.cave-ayland@ilande.co.uk>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230629082522.606219-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.093,
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

29.06.2023 11:25, Mark Cave-Ayland wrote:
> Add an assert() check in tb_invalidate_phys_page_range__locked() to ensure that
> both the start and last addresses are within the same target page. Note that
> due to performance concerns the check is only enabled when QEMU is configured
> with --enable-debug-tcg.

Performance concerns? That's two ANDs and on compare, - is it really that performance
critical?

I'm just asking, I dunno.

Thanks,

/mjt

> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   accel/tcg/tb-maint.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index 33ea1aadd1..8cd730dcb0 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -1092,6 +1092,10 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
>       TranslationBlock *current_tb = retaddr ? tcg_tb_lookup(retaddr) : NULL;
>   #endif /* TARGET_HAS_PRECISE_SMC */
>   
> +#ifdef CONFIG_DEBUG_TCG
> +    assert((last & TARGET_PAGE_MASK) == (start & TARGET_PAGE_MASK));
> +#endif
> +
>       /*
>        * We remove all the TBs in the range [start, last].
>        * XXX: see if in some cases it could be faster to invalidate all the code


