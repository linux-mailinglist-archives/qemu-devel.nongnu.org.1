Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC09789CDB
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 12:00:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaCYa-0001Mn-HN; Sun, 27 Aug 2023 05:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qaCYZ-0001MR-1r
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 05:59:43 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qaCYW-0004PK-OZ
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 05:59:42 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2bcde83ce9fso34099861fa.1
 for <qemu-devel@nongnu.org>; Sun, 27 Aug 2023 02:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693130377; x=1693735177;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+pHSRZnVyLWBgANdJc+RDlydoOk8kYURdKE3lykQXo=;
 b=N0AG6CQcRxaPDlr1cGgrNTUUm7UjjRm41GmS0C2DHDaGAh/7rg/UmZJLFkMqwCR3mp
 NGdPgmFiAHY36EBLPdVpaCrvwViREGkNLIHyqSEg5EasdYIOTv8q+af5DAp7el725TMG
 ylNCd3rs23EeOXD4raG+JDHrItowwJB4m5E68ToQyFhZaW+4ojfFd6SAzfVIYCvCWntt
 4X2oEeXxFKyKV3vgGQNGN/1ILV73I9stiiGSyjfNr/KGeaGqpW1XGU9sy/QvSsXUN6Am
 v09sjcTcmgaIlxdOeZx0f6+LqHbJbAyq3ClyYkZh08I/Nu8ClIYMJQe08yslGPLlNQMb
 rpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693130377; x=1693735177;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p+pHSRZnVyLWBgANdJc+RDlydoOk8kYURdKE3lykQXo=;
 b=G9iBSreacreZr0F7xouJ0KP6KmKnaF7CUzMVTEP8axYFbzxpMTNCSkM+GQYShdynoJ
 5ZIjLbQM97ghlpuLvuOS3zg46Qy4coCLe2iMJBI6v4yUNV9LPRJBIYJQdqhIO4Vtit45
 TmBE6F39RZiuFlb207elTugDvBh4p3qCNQVeUwe44KwRNjBxpr2GNPLMgXnysjPRvv/h
 ETvg7IYr8fzVNoxudjOY3Nxd5vTIUl5GhsiwUb8NAsDQa9GRvNMbNKHQEiyqzpg9g940
 uvLJ27UYrEeyC4fzBZtGr1G+4T9BdF8axeFzqr1/gjtbBWAhfvaeeWBbSLI5m6xlVWGh
 V7tg==
X-Gm-Message-State: AOJu0Yw0qREu6kHl0qkkycm5MSJRhgY1k31ge28dkle5shL2gPbV244K
 XJQBaJZHSOcw80xnzErsP24zgP30i90Iuv3C8KU=
X-Google-Smtp-Source: AGHT+IHzpDImEaj9EZ2ESLO0kr94i0oFdcrI99KrxL+JuSfMI9CT5GqukeDV1KaPgd6KmGDhyfbXqA==
X-Received: by 2002:a2e:9185:0:b0:2bc:bb46:4fc7 with SMTP id
 f5-20020a2e9185000000b002bcbb464fc7mr14586726ljg.24.1693130377609; 
 Sun, 27 Aug 2023 02:59:37 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k8-20020a7bc408000000b003fe23b10fdfsm10516167wmi.36.2023.08.27.02.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Aug 2023 02:59:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 03DDE1FFBB;
 Sun, 27 Aug 2023 10:59:37 +0100 (BST)
References: <20230826232415.80233-1-richard.henderson@linaro.org>
 <20230826232415.80233-4-richard.henderson@linaro.org>
User-agent: mu4e 1.11.15; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH 3/3] softmmu: Remove cpu_reloading_memory_map as unused
Date: Sun, 27 Aug 2023 10:59:24 +0100
In-reply-to: <20230826232415.80233-4-richard.henderson@linaro.org>
Message-ID: <87sf844xh2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22a.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

This is just cleanup, I think it should be merged with 2/3

> ---
>  include/exec/cpu-common.h   |  1 -
>  accel/tcg/cpu-exec-common.c | 30 ------------------------------
>  2 files changed, 31 deletions(-)
>
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 87dc9a752c..41788c0bdd 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -133,7 +133,6 @@ static inline void cpu_physical_memory_write(hwaddr a=
ddr,
>  {
>      cpu_physical_memory_rw(addr, (void *)buf, len, true);
>  }
> -void cpu_reloading_memory_map(void);
>  void *cpu_physical_memory_map(hwaddr addr,
>                                hwaddr *plen,
>                                bool is_write);
> diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
> index 9a5fabf625..7e35d7f4b5 100644
> --- a/accel/tcg/cpu-exec-common.c
> +++ b/accel/tcg/cpu-exec-common.c
> @@ -33,36 +33,6 @@ void cpu_loop_exit_noexc(CPUState *cpu)
>      cpu_loop_exit(cpu);
>  }
>=20=20
> -#if defined(CONFIG_SOFTMMU)
> -void cpu_reloading_memory_map(void)
> -{
> -    if (qemu_in_vcpu_thread() && current_cpu->running) {
> -        /* The guest can in theory prolong the RCU critical section as l=
ong
> -         * as it feels like. The major problem with this is that because=
 it
> -         * can do multiple reconfigurations of the memory map within the
> -         * critical section, we could potentially accumulate an unbounded
> -         * collection of memory data structures awaiting reclamation.
> -         *
> -         * Because the only thing we're currently protecting with RCU is=
 the
> -         * memory data structures, it's sufficient to break the critical=
 section
> -         * in this callback, which we know will get called every time the
> -         * memory map is rearranged.
> -         *
> -         * (If we add anything else in the system that uses RCU to prote=
ct
> -         * its data structures, we will need to implement some other mec=
hanism
> -         * to force TCG CPUs to exit the critical section, at which poin=
t this
> -         * part of this callback might become unnecessary.)
> -         *
> -         * This pair matches cpu_exec's rcu_read_lock()/rcu_read_unlock(=
), which
> -         * only protects cpu->as->dispatch. Since we know our caller is =
about
> -         * to reload it, it's safe to split the critical section.
> -         */
> -        rcu_read_unlock();
> -        rcu_read_lock();
> -    }
> -}
> -#endif
> -
>  void cpu_loop_exit(CPUState *cpu)
>  {
>      /* Undo the setting in cpu_tb_exec.  */


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

