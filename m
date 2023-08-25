Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6AA788160
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 09:59:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZRiR-0003gd-Dd; Fri, 25 Aug 2023 03:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qZRiP-0003gN-Tw; Fri, 25 Aug 2023 03:58:45 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qZRiN-0002Dd-OD; Fri, 25 Aug 2023 03:58:45 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bf48546ccfso5056505ad.2; 
 Fri, 25 Aug 2023 00:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692950321; x=1693555121;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Ex5eUDLlGoTe6YDjrCyOFPB52kSWDwBSB4UinefOKU=;
 b=Ufpuyw5ob/Y8nuem1RqwxRWo5ufA41YQP7nEt4CGxu/V5lbZoYym+nJfAgaGUBkRAt
 nMQpBtQaPPakPafUACbEPWCyg4/TXrWD5TyZU7Mz9MBP7ntPULjsWxRBVkio1ZddzYue
 OA/q9/JsS0diFvduNo4WDI6VdTl+v9LLEGH1JGTYoq8EhHR4/W74XPbqiN7TotdQEIO6
 0zd5SPaJHbZAPxuGTHK71EszVk3T2mqLFFkV9vyVbkojL2RzdRwLFyDHyFpPU9vPwS7S
 tyelhXMn9Pzkipz0GZNNPFRXCLpyYBgOD8zZSPwhQ1i9u8P3IlNGClSy6R/BQ+Hp2Bzy
 Nqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692950321; x=1693555121;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2Ex5eUDLlGoTe6YDjrCyOFPB52kSWDwBSB4UinefOKU=;
 b=UxNl4jydyrAYU8Acu+P5cnxa/dP79Z3XlgCmcR4GjyVirAVaYkQa8IptHwhFLn6+aC
 HeDgw07NQPIX3cuDvqKYLZiDQz7f755jMXASRmUngBRO0MKN6ONG36S6jFpL1vD50jyK
 Ih0DpJAik41s/CALgGGXs7H+vRI83mVILMZtTXNoSOxdLQnsqxKedEhh69DlWydOI0Q+
 l0Q9nLZ5D9XIacxG0DmAFj0k1DL/+42xZBh6Z0On1zGUxuIckEbbTu8Dp6NHAWiEqB6c
 +JGT+mH5PiS9Xd3pE+ERQm2dn2excI5qE2+fEC8fx2iJyFJHiG3n6haPdYlyctLkZtLb
 ez6Q==
X-Gm-Message-State: AOJu0Yx76b/X5YjK58fcAa4BXcx0bOPXqffEnOHo4V0LrzrujQ28uqp5
 2PQv266mb1IrWEL8PswPQMc=
X-Google-Smtp-Source: AGHT+IHgVIJIkBEZDIZx1Q0h+n+5URe2SGzm+lXSilbYG994c6D+0668EzeOjfPMGSUvOjrOY7hKjQ==
X-Received: by 2002:a17:902:c155:b0:1bb:d280:5e0b with SMTP id
 21-20020a170902c15500b001bbd2805e0bmr14988495plj.18.1692950321047; 
 Fri, 25 Aug 2023 00:58:41 -0700 (PDT)
Received: from localhost ([1.146.69.243]) by smtp.gmail.com with ESMTPSA id
 jj14-20020a170903048e00b001bbaf09ce15sm997183plb.152.2023.08.25.00.58.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 00:58:40 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Aug 2023 17:58:32 +1000
Message-Id: <CV1GSSQY2ZP3.35GU250DO5E39@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
Cc: "Song Gao" <gaosong@loongson.cn>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "Richard Henderson"
 <richard.henderson@linaro.org>, "Greg Kurz" <groug@kaod.org>, "Aurelien
 Jarno" <aurelien@aurel32.net>, "Peter Maydell" <peter.maydell@linaro.org>,
 <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 "Aleksandar Rikalo" <aleksandar.rikalo@syrmia.com>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "David Gibson" <david@gibson.dropbear.id.au>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "Yoshinori Sato" <ysato@users.sourceforge.jp>, "Xiaojuan
 Yang" <yangxiaojuan@loongson.cn>, <qemu-arm@nongnu.org>
Subject: Re: [PATCH 00/12] tcg: Factor hrev{32,64}_{i32,i64,tl} out
X-Mailer: aerc 0.15.2
References: <20230822124042.54739-1-philmd@linaro.org>
In-Reply-To: <20230822124042.54739-1-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Aug 22, 2023 at 10:40 PM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> This series factor the "byteswap each halfword within a
> 32/64-bit value" code duplication as generic helpers.
>
> Modulo the documentation added, there is a good negative
> diff-stat, so I believe this is a win from a maintainance
> point of view.
>
> I used "hrev" to follow the other bswap/hswap/rev helpers
> but it isn't very descriptive, so any better name suggestion
> is welcomed.
> (In particular because there are other patterns I'd like to
> factor out and then naming is getting worse, such 'wrev').

I know bswap has alrady precedent, but you could drop the bit
size when it matches the operand size, hrev_i64.

Could possibly also follow ppc and call it brevh, which tells
you the units being swapped and the size they are swapped in.
Then you could add brevw or hrevw etc. and it might be a bit
less ambiguous.

Looks like a nice cleanup though.

Thanks,
Nick

>
> Philippe Mathieu-Daud=C3=A9 (12):
>   tcg/tcg-op: Factor tcg_gen_hrev32_i32() out
>   target/arm: Use generic hrev32_i32() in ARM REV16 and VREV16 opcodes
>   target/cris: Use generic hrev32_i32() in SWAPB opcode
>   target/rx: Use generic hrev32_i32() in REVW opcode
>   tcg/tcg-op: Factor tcg_gen_hrev64_i64() out
>   target/mips: Use generic hrev64_i64() in DSBH opcode
>   target/ppc: Use generic hrev64_i64() in BRH / BSWAP16x8 opcodes
>   target/loongarch: Use generic hrev64_i64() in REVB.4H opcode
>   tcg/tcg-op: Add tcg_gen_hrev32_i64() and tcg_gen_hrev_i64()
>   target/arm: Use generic hrev_i64() in Aarch64 REV16 opcode
>   target/loongarch: Use generic hrev64_i32() in REVB.2H opcode
>   target/mips: Use generic hrev32_tl() in WSBH opcode
>
>  docs/devel/tcg-ops.rst                      | 10 +++
>  include/tcg/tcg-op-common.h                 |  4 +
>  include/tcg/tcg-op.h                        |  2 +
>  target/arm/tcg/translate-a32.h              |  1 -
>  target/arm/tcg/translate-a64.c              | 11 +--
>  target/arm/tcg/translate-neon.c             |  2 +-
>  target/arm/tcg/translate.c                  | 14 +---
>  target/cris/translate.c                     | 20 +----
>  target/mips/tcg/translate.c                 | 24 +-----
>  target/ppc/translate.c                      | 10 +--
>  target/rx/translate.c                       |  8 +-
>  tcg/tcg-op.c                                | 81 ++++++++++++++++++---
>  target/cris/translate_v10.c.inc             |  2 +-
>  target/loongarch/insn_trans/trans_bit.c.inc | 30 +-------
>  target/ppc/translate/vsx-impl.c.inc         | 19 +----
>  15 files changed, 99 insertions(+), 139 deletions(-)


