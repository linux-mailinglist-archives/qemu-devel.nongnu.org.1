Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ED276A8AC
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 08:07:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQiVz-0001fh-Qu; Tue, 01 Aug 2023 02:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qQiVv-0001bS-Qj
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 02:05:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qQiVu-0004oD-0s
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 02:05:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8F3851728C;
 Tue,  1 Aug 2023 09:05:55 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 61A321A60D;
 Tue,  1 Aug 2023 09:05:41 +0300 (MSK)
Message-ID: <e27791ac-4c32-a511-4605-8d0dcca5e0a7@tls.msk.ru>
Date: Tue, 1 Aug 2023 09:05:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 08/10] target/ppc: Disable goto_tb with architectural
 singlestep
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230731210211.137353-1-richard.henderson@linaro.org>
 <20230731210211.137353-9-richard.henderson@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230731210211.137353-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.101,
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

01.08.2023 00:02, Richard Henderson wrote:
> The change to use translator_use_goto_tb went too far, as the
> CF_SINGLE_STEP flag managed by the translator only handles
> gdb single stepping and not the architectural single stepping
> modeled in DisasContext.singlestep_enabled.
> 
> Fixes: 6e9cc373ec5 ("target/ppc: Use translator_use_goto_tb")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1795
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/translate.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index e6a0709066..74796ec7ba 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4175,6 +4175,9 @@ static void pmu_count_insns(DisasContext *ctx)
>   
>   static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
>   {
> +    if (unlikely(ctx->singlestep_enabled)) {
> +        return false;
> +    }
>       return translator_use_goto_tb(&ctx->base, dest);
>   }

This smells like a -stable material too. Please let me know if it is not.

Thanks,

/mjt


