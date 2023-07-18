Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF397573F1
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 08:18:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLe1h-0007cY-9A; Tue, 18 Jul 2023 02:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLe1f-0007bS-1m
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 02:17:35 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLe1d-0006Ao-Dw
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 02:17:34 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3163eb69487so3757746f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 23:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689661051; x=1692253051;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T7X3OFjMiI+Lir4GJ6w5UjqpR7Tva4nRpM2wKiG5SCE=;
 b=pO76d6XlL8GnviBQf8FNuZ2AmwnhMT9AfO5TJlLjY7LK6xSNu8gXV973Uz64HSkzIx
 HEeF/OU0Kjpd/flspKiYUuKPd99ON1dFVeOe2hRIMUd1b01EmHrZC570OyGJZR6cbVp7
 t+NNEBqr4IN1oGOzy+WzVPousQgnQ21jjHICVKr8WmsJVYbqUlVABO4f7iWzBAE2eCKU
 NjuTfhkVj605hm4p/28Son0tCakniHJMsc6nn5EzHBDa47hkNY8eKgMLJH+q2fg32O2W
 jytnDlF0y8fsLceRxCGQ5Pad37wj0KbgPYeU4uR1FXgrUpFUbtZx8Uy0hCer3vfPPGH+
 PVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689661051; x=1692253051;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T7X3OFjMiI+Lir4GJ6w5UjqpR7Tva4nRpM2wKiG5SCE=;
 b=QnLvt2E+YbDD6DwOGAzPGlxlkpAUNJnZv5cKkxPd0BfjsqT6q3ELRcwrDBtTxvgveo
 6kMCH7vNtALqk7WpfJ2Bjc1qkqxLvOqABdss/LXFlqqrsHO/psKpqqXNpqdhMKZSId43
 E0s/O+CZIZgHM/RnlC0IS5Vyn/gCrOI3bRQAfv+vUQXK6zScQOAiZ9KJJLxUR8YT6bz9
 Yx14BmnwKLbqOcNUUk1VwYiBPKtzRRBYyS1IRoOUOxUaq6q+23Jt8hZ4/wku+6fNhBOe
 ygjPScUo9/tW9CPKoH41xmPDliHs5vLxCU6EQ61ziBAXkISja8C8S1HhYd1GONl/kMSF
 jq9w==
X-Gm-Message-State: ABy/qLZEjuEkdJ49Mxj/s/0z/ouhv3OBWRWBxpq+L7w901DVJyXmhabB
 ahwNslOrFbI9pvCSA6KXJn9GBg==
X-Google-Smtp-Source: APBJJlE83J3ktOEXrpwylodpU/d7dNHbAJYNo6fovObO6z9Eys0ref13ec8abGKRQgPrCLV7hRlKbQ==
X-Received: by 2002:a5d:408c:0:b0:30a:c681:fd2e with SMTP id
 o12-20020a5d408c000000b0030ac681fd2emr10682581wrp.22.1689661051458; 
 Mon, 17 Jul 2023 23:17:31 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.222.251])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a05600004c400b00313f07ccca4sm1314159wri.117.2023.07.17.23.17.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 23:17:31 -0700 (PDT)
Message-ID: <2799e03f-3083-469b-fced-d92f6e3f1954@linaro.org>
Date: Tue, 18 Jul 2023 08:17:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] accel/tcg: Fix guest instruction address in output
 assembly log
Content-Language: en-US
To: Matt Borgerson <contact@mborgerson.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230718013531.1669100-1-contact@mborgerson.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230718013531.1669100-1-contact@mborgerson.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Matt,

On 18/7/23 03:35, Matt Borgerson wrote:
> If CF_PCREL is enabled, generated host assembly logging (command line
> option `-d out_asm`) may incorrectly report guest instruction virtual
> addresses as page offsets instead of absolute addresses. This patch
> corrects the reported guest address.
> 
> Signed-off-by: Matt Borgerson <contact@mborgerson.com>
> ---
>   accel/tcg/translate-all.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index a1782db5dd..859db95cf7 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -283,6 +283,24 @@ static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
>       return tcg_gen_code(tcg_ctx, tb, pc);
>   }
>   
> +static vaddr get_guest_insn_vaddr(TranslationBlock *tb, vaddr pc, size_t insn)
> +{
> +    g_assert(insn < tb->icount);
> +
> +    /* FIXME: This replicates the restore_state_to_opc() logic. */

Hmmm maybe we could have a public helper defined in accel/tcg/cpu-exec.c
so we cat re-use it in accel/tcg/perf.c::perf_report_code().

> +    vaddr addr = tcg_ctx->gen_insn_data[insn * TARGET_INSN_START_WORDS];
> +
> +    if (tb_cflags(tb) & CF_PCREL) {
> +        addr |= (pc & TARGET_PAGE_MASK);
> +    } else {
> +#if defined(TARGET_I386)
> +        addr -= tb->cs_base;
> +#endif
> +    }
> +
> +    return addr;
> +}


