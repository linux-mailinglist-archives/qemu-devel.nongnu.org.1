Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BB6717660
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 07:51:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4EjG-0002Pc-Sl; Wed, 31 May 2023 01:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4Ehu-0002C7-KZ
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:49:14 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4Ehr-0001yM-BM
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:49:14 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-30aef0b8837so2197476f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 22:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685512149; x=1688104149;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rBI9hBuG/hf9zfvHVQ5J84vkTGt/9ZLJ83giy3VSzuI=;
 b=qRpuLaHx80vNWjSrJkFWnHXLTKjA6/LDpKGkYBK0no6fcxE9jktJ/W/DINpNHkUEVM
 FS+8vCgFWX4sewSKhGX4/TKejHFlW2RHKMkldT5zUIDcP21PfqReX3utQoFbOSIPe4qi
 kJlwzedcEF/1lL0SdThDOWCkvTQQ5hRbl3jiOn8gtt6EKiG9LQumgkpdDXtfLgvk6cZ7
 5S/AzyPip7dPBl7s4DJcf1qp1FMFVx4QGzxNVY8wN6dZyduQGOVn9Fk1+UtqYXnZkql8
 iGfb2ai/bkpLVlxZrOyU2gxNBpAV4PFchRpQfFyVk4N3Jdiwq/qvAvQwsEYYp8twX/2T
 Ztiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685512149; x=1688104149;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rBI9hBuG/hf9zfvHVQ5J84vkTGt/9ZLJ83giy3VSzuI=;
 b=i9s4J9QaHoTR9V61cjmJzvgZlhje8NO3wd/0vaXavbxmjR7bN3O1/BEy2r/9/AmmQb
 UlUIHUZ+bdNU3FXvYbnAYSCtuETauigtSeMtzZpV+6a5cJz3xmWWs4Cc0R+BvmnF0n0d
 PJbhoqVhkxBBAsf/7eW9GHrTebOofs0tSNWgpT3pCdVCcbwe2oarE4HcvZ+wtf3H1Fnl
 oflUy8mX/QrfgqTTTzXiBQl2ogBysDl4lg8ffxRubWOKC2qx+pHGCMzRSi2XVR6BvUvp
 CX1vyuOe/5XHDonDe/+HyKjG+MtmrajJTuX8/agX0mCS4eEqrnziPNF53DO2b3DP5mdr
 PmSw==
X-Gm-Message-State: AC+VfDxWt99fkrPDIzKVWrQboqtjMQkrb6caBYukXMVfwqC92yv2TEr0
 42YVgHNnrNOYQkKmML/clVYaJA==
X-Google-Smtp-Source: ACHHUZ6fTRaQ1mJrc92C79+6uIFB5p9NDYxQAp2j5TA2ojx8vpFU4AIw0+Dl8Mb+p8UchmfmJ7Hy8Q==
X-Received: by 2002:a5d:65d0:0:b0:309:4988:7f83 with SMTP id
 e16-20020a5d65d0000000b0030949887f83mr2991128wrw.20.1685512149271; 
 Tue, 30 May 2023 22:49:09 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 j18-20020a5d4492000000b002ffbf2213d4sm5394665wrq.75.2023.05.30.22.49.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 22:49:08 -0700 (PDT)
Message-ID: <19c434db-b1ac-656d-474f-938cdbf96fcd@linaro.org>
Date: Wed, 31 May 2023 07:49:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 1/5] target/ppc: gdbstub init spr gdb_id for all CPUs
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Fabiano Rosas <farosas@suse.de>
References: <20230531012313.19891-1-npiggin@gmail.com>
 <20230531012313.19891-2-npiggin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531012313.19891-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 31/5/23 03:23, Nicholas Piggin wrote:
> Make sure each CPU gets its state set up for gdb, not just the ones
> before PowerPCCPUClass has had its gdb state set up.
> 

Cc: qemu-stable@nongnu.org
Fixes: 707c7c2ee1 ("target/ppc: Enable reporting of SPRs to GDB")

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/ppc/gdbstub.c | 30 +++++++++++++++++++-----------
>   1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> index 63c9abe4f1..ca39efdc35 100644
> --- a/target/ppc/gdbstub.c
> +++ b/target/ppc/gdbstub.c
> @@ -327,6 +327,25 @@ void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu)
>       unsigned int num_regs = 0;
>       int i;
>   
> +    for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
> +        ppc_spr_t *spr = &env->spr_cb[i];
> +
> +        if (!spr->name) {
> +            continue;
> +        }
> +
> +        /*
> +         * GDB identifies registers based on the order they are
> +         * presented in the XML. These ids will not match QEMU's
> +         * representation (which follows the PowerISA).
> +         *
> +         * Store the position of the current register description so
> +         * we can make the correspondence later.
> +         */
> +        spr->gdb_id = num_regs;
> +        num_regs++;
> +    }
> +
>       if (pcc->gdb_spr_xml) {
>           return;
>       }
> @@ -348,17 +367,6 @@ void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu)
>   
>           g_string_append_printf(xml, " bitsize=\"%d\"", TARGET_LONG_BITS);
>           g_string_append(xml, " group=\"spr\"/>");
> -
> -        /*
> -         * GDB identifies registers based on the order they are
> -         * presented in the XML. These ids will not match QEMU's
> -         * representation (which follows the PowerISA).
> -         *
> -         * Store the position of the current register description so
> -         * we can make the correspondence later.
> -         */
> -        spr->gdb_id = num_regs;
> -        num_regs++;
>       }
>   
>       g_string_append(xml, "</feature>");

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


