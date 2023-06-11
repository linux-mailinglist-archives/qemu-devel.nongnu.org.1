Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FB772B119
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:18:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8HCS-0005t7-6k; Sun, 11 Jun 2023 05:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q8HCL-0005sC-Nx
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:17:22 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q8HCJ-00082N-PY
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:17:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-30aebe2602fso2075585f8f.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686475037; x=1689067037;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wvJjJTGePVLD+CPe9zKO13UF7SgaHDVkDSzxjqsABWA=;
 b=A7oVtXmQqPerPSQ7yYJ7tBt9aA+qn4MSgelAOSXcwmD9aNoIuLkjzRA9/3ZrwEgx+g
 rEbARw4jViZOq+5sfKcLb+9lVTBXFxrRxsIXkkhck8VMZoFoDhPpQcDguyxAJBg+sdV0
 ROjy5G5nsP0S8f8mQglktwnQaLcNd+i4j4f/jghIozUfTMrtSwSM2DupK9X/CPerVbl2
 irbv3GtpXHKkcxEdrUO4OBr/V2z67nBMMzuwH7hVImCXPtQNyobHB3aRdCvXBXVENMS7
 Td95xUdMX3uF+Unom7IcVOVwMWvPlwqr04p9YIUlsbGZYhrHwHXfQ8hXmGDtURPvsMXS
 UJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686475037; x=1689067037;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wvJjJTGePVLD+CPe9zKO13UF7SgaHDVkDSzxjqsABWA=;
 b=BFCeWwy3nSPROMxH4XAwYo51zkHRoWXusBfV+MbAwRg8wB+kujIKlgJK4IbFXjUydV
 MDHk8j1Dj9061Mnf5KBH8EC6+/hGh+y7w0jN5OlkKCNZa41ukvf09MRHfPG5hItRzmPO
 vEJr04Q4kwgczZDIRaIXXsUcfaBp5yj7UaSClmbiDsbsUi+Het0FdBWkTd8rnBlgYV8O
 IbqhBAUuL4MNK+lbMx114+uxsAYg6YKhjs+lXnQFMG+x1VjEqCVwlwkX5DAOu2/+RTiS
 /N58ksBu4fvF1r7nkytYLMhcNsTq8IFD6JB9zNf0sYzxK9D77A/g+KjCGMZayI+L/vRK
 sM9w==
X-Gm-Message-State: AC+VfDxTxgT/yaBzdUV/g38yMb4mYzj/w7QRKrbEe33ae9jTdbqATj2k
 QhPiqnqM+RYpxmVjYb2hWQokaZncVfqryRERGTQ=
X-Google-Smtp-Source: ACHHUZ4zHVZq5CkL6PVWiOGCseIiXZnoCk6vbEwU1O0nlgfWxrrUcNK4UPrPTWpxiKMZ1XCrf9B+3w==
X-Received: by 2002:a5d:470b:0:b0:2f4:6574:5a93 with SMTP id
 y11-20020a5d470b000000b002f465745a93mr1975097wrq.4.1686475037644; 
 Sun, 11 Jun 2023 02:17:17 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d17-20020a5d6dd1000000b003095bd71159sm9221353wrz.7.2023.06.11.02.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 02:17:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5EF941FFBB;
 Sun, 11 Jun 2023 10:17:16 +0100 (BST)
References: <20230610171959.928544-1-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/plugin: Remove duplicate insn log from libinsn.so
Date: Sun, 11 Jun 2023 10:14:42 +0100
In-reply-to: <20230610171959.928544-1-richard.henderson@linaro.org>
Message-ID: <87ttvee4tf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Richard Henderson <richard.henderson@linaro.org> writes:

> This is a perfectly natural occurrence for x86 "rep movb",
> where the "rep" prefix forms a counted loop of the one insn.
>
> During the tests/tcg/multiarch/memory test, this logging is
> triggered over 350000 times.  Within the context of cross-i386-tci
> build, which is already slow by nature, the logging is sufficient
> to push the test into timeout.

How does this get triggered because I added these:

# non-inline runs will trigger the duplicate instruction heuristics in libi=
nsn.so
run-plugin-%-with-libinsn.so:
	$(call run-test, $@, \
	  $(QEMU) -monitor none -display none \
		  -chardev file$(COMMA)path=3D$@.out$(COMMA)id=3Doutput \
                  -plugin ../../plugin/libinsn.so$(COMMA)inline=3Don \
	    	  -d plugin -D $*-with-libinsn.so.pout \
		  $(QEMU_OPTS) $*)

to prevent the callback versions from being called for x86. The original
intent of the check was to detect failures due to cpu_io_recompile, see
e025d799af (tests/plugin: expand insn test to detect duplicate instructions)

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Irritatingly, it doesn't timeout locally, so I used staging to double-che=
ck:
>
> Fail: https://gitlab.com/qemu-project/qemu/-/jobs/4450754282#L5062
> Pass: https://gitlab.com/qemu-project/qemu/-/jobs/4450927108
> ---
>  tests/plugin/insn.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
> index cd5ea5d4ae..9bd6e44f73 100644
> --- a/tests/plugin/insn.c
> +++ b/tests/plugin/insn.c
> @@ -19,7 +19,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLU=
GIN_VERSION;
>  #define MAX_CPUS 8 /* lets not go nuts */
>=20=20
>  typedef struct {
> -    uint64_t last_pc;
>      uint64_t insn_count;
>  } InstructionCount;
>=20=20
> @@ -51,13 +50,7 @@ static void vcpu_insn_exec_before(unsigned int cpu_ind=
ex, void *udata)
>  {
>      unsigned int i =3D cpu_index % MAX_CPUS;
>      InstructionCount *c =3D &counts[i];
> -    uint64_t this_pc =3D GPOINTER_TO_UINT(udata);
> -    if (this_pc =3D=3D c->last_pc) {
> -        g_autofree gchar *out =3D g_strdup_printf("detected repeat execu=
tion @ 0x%"
> -                                                PRIx64 "\n", this_pc);
> -        qemu_plugin_outs(out);
> -    }
> -    c->last_pc =3D this_pc;
> +
>      c->insn_count++;
>  }


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

