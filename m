Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA1D773AF3
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:17:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTOSm-0001mz-1z; Tue, 08 Aug 2023 11:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTOSi-0001bJ-EP
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:17:32 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTOSa-000170-Qj
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:17:30 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe24dd8898so49493215e9.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 08:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691507842; x=1692112642;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abvLaOiqeM8KcNNGOGHv4cNoMfXwLSZCo7Ztt25GFhg=;
 b=Ez2nAlNefZKOSZhKPXvvhdarP3qDfj6CtVbTVsIyBtDAP6oPS+2B0khmrPWjIslQto
 LpqcjJ5xCuohEJIR4NGDMMnCBwD14HjI6kiqtj6bmv8nmLwnhuFrtdGM3d1bYENhzLvE
 f34aeKp+GntR92KU12bD5B6BYWjcGWyQvmMRosGZJmu8oinV0YXfuOPUTx4w3FTW/Sag
 mURcB8ANpwyzzMipJ8umZC1Sfgy0XtHCYo0x4Zka3koIQfTCLNxprX9Gx4zkXvW5YVhn
 EjUh20ZNhCDh6pw7qAOlaPFEbouoQvmdZdzk+1zDtAVOtsEELC32/HhZq423/DQkB/vl
 7BNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691507842; x=1692112642;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=abvLaOiqeM8KcNNGOGHv4cNoMfXwLSZCo7Ztt25GFhg=;
 b=Hgl9iYzssz0yGLmGxmXpISqXY9mF54VISZikbuqucAhUBL2TD/1ufa/gkHEF+ZLcM2
 hlzvA0kANr3b0BztrsdEVlWPSX8Kxo18j6pWipbs6fEhyRnL3NWVKdPqwsRXUd4XJP4H
 lHbPnudhL1x3XQEddt3SdqIRTfSGZ7bO7VMUkZpYllUFXcP3p8NdESH7ooJd8VHsmN3h
 XoW+6pzl1bvTwzkMpPD0FBNGHsNtpec3lQUqDGVRpzvYwuHqLz8uRl4/AsOzLiqEmHnt
 qgDIsaGrBZimn9VXnZgVHRPHC/YxF4JU7Bbn6Bqf6NCAkkF7ByYVRniuEcSVpZ0MjL8w
 Iaqw==
X-Gm-Message-State: AOJu0YyyuGuVYmERT+3W8opPQ065jg2ep1YwjwvUviAOZmExWeYSTegl
 45nhKgBsyqdkF42oZne5LAaW1g==
X-Google-Smtp-Source: AGHT+IExelftcrDHl64FKGiSrzJdRJDLYjPoSLp85UD50XFACKJVtL9yWZhRA1GHjulM4pCuDYhx+w==
X-Received: by 2002:a5d:4402:0:b0:318:70:a4ac with SMTP id
 z2-20020a5d4402000000b003180070a4acmr204697wrq.17.1691507842244; 
 Tue, 08 Aug 2023 08:17:22 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s8-20020adfea88000000b0031272fced4dsm13892220wrm.52.2023.08.08.08.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 08:17:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6733E1FFBB;
 Tue,  8 Aug 2023 16:17:21 +0100 (BST)
References: <20230808134435.2719-1-m.tyutin@yadro.com>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mikhail Tyutin <m.tyutin@yadro.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 pbonzini@redhat.com, Aleksandr  Anenkov <a.anenkov@yadro.com>
Subject: Re: [PATCH] Add support of callbacks after instructions to plugin api
Date: Tue, 08 Aug 2023 16:15:41 +0100
In-reply-to: <20230808134435.2719-1-m.tyutin@yadro.com>
Message-ID: <87h6p97eda.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


Mikhail Tyutin <m.tyutin@yadro.com> writes:

> Initially, we can only call the callback BEFORE instructions. This
> commit adds the ability to insert the callback AFTER instructions.

What is the use case for this? Because:

<snip>
>=20=20
> +
> +        /* Stop translation if translate_insn so indicated.  */
> +        if (db->is_jmp !=3D DISAS_NEXT) {
> +            break;
> +        }
> +
>          /*
>           * We can't instrument after instructions that change control
>           * flow although this only really affects post-load operations.
> @@ -193,11 +199,6 @@ void translator_loop(CPUState *cpu, TranslationBlock=
 *tb, int *max_insns,
>              plugin_gen_insn_end();
>          }
>=20=20
> -        /* Stop translation if translate_insn so indicated.  */
> -        if (db->is_jmp !=3D DISAS_NEXT) {
> -            break;
> -        }
> -
>          /* Stop translation if the output buffer is full,
>             or we have executed all of the allowed instructions.  */
>          if (tcg_op_buf_full() || db->num_insns >=3D db->max_insns) {
> @@ -211,6 +212,13 @@ void translator_loop(CPUState *cpu, TranslationBlock=
 *tb, int *max_insns,
>      gen_tb_end(tb, cflags, icount_start_insn, db->num_insns);
>=20=20
>      if (plugin_enabled) {
> +        /*
> +         * Last chance to call plugin_gen_insn_end() if is skipped in tr=
anslation
> +         * loop above.
> +         */
> +        if (db->is_jmp !=3D DISAS_NEXT && tcg_ctx->exitreq_label =3D=3D =
NULL) {
> +            plugin_gen_insn_end();
> +        }
>          plugin_gen_tb_end(cpu);
>      }
>=20=20
<snip>
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -2819,6 +2819,22 @@ void tcg_gen_exit_tb(const TranslationBlock *tb, u=
nsigned idx)
>          tcg_debug_assert(idx =3D=3D TB_EXIT_REQUESTED);
>      }
>=20=20
> +#ifdef CONFIG_PLUGIN
> +    /*
> +     * Some of instruction generators insert exit_tb explicitelly to
> +     * trigger early exit from translation block. On the other hand
> +     * translation loop (translator_loop()) inserts plugin callbacks
> +     * after instruction is generated, but it appears as dead code
> +     * because of the explicit exit_tb insert.
> +     *
> +     * Calling plugin_gen_insn_end() here before the exit allows
> +     * plugins to receive control before translation block exits.
> +     */
> +    if (tcg_ctx->plugin_insn) {
> +        plugin_gen_insn_end();
> +    }
> +#endif
> +

This isn't enough as we can exit the run loop in helpers. This is why
the execlog plugin jumps the hoops it does to complete handling of
execution on the next instruction.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

