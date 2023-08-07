Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EE9771B82
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 09:29:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSug9-0003nr-Gc; Mon, 07 Aug 2023 03:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qSug7-0003nJ-F6; Mon, 07 Aug 2023 03:29:23 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qSug5-0008Kn-IJ; Mon, 07 Aug 2023 03:29:23 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bc73a2b0easo1470195ad.0; 
 Mon, 07 Aug 2023 00:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691393360; x=1691998160;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6l5HGHIhO9bd4DanYuUgddy+7Uq1Lrf8fPa0NpmFv9k=;
 b=MzJKmjQlnal1utUyLf44DA1fMdNhaOmSJY9ASO3ovmbRsmiIOSs5/VZxCDyCD7i3cH
 PE/t72xLbn7joawVtaiLmZLg9sDyi09GGdPsITCji44+qZjPEE7AL0jMnszyq4tupfcO
 m261qgNRfYRs1vkcKA4qsXFraIou/L/i8oWamX6PVZFpKI0eKAcp+F0kA+SEHpnSP4bQ
 6V0uImVTJfhjjDp3c0y4dCYDfwOLn1C8WbU76OWINkkSznoXv3fHIYkU+27rhRI2VQzi
 zLOnLChA8m7/v7roWr50Qf+DSoHEm/kgHECGVp+JFVTfh6QWOlitYXigExUVuENqypPx
 lONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691393360; x=1691998160;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6l5HGHIhO9bd4DanYuUgddy+7Uq1Lrf8fPa0NpmFv9k=;
 b=IiYmxcAeYCvVKJwScUPSFxgyWcmzctOZdD1LFh8u5n8TTsh9bWs+5viuX8epWRKqJO
 oKeNuhE+oa2947+tQQ0mdFtS4TvDLtpN/ULxie3+WDKJRHUy9U6V6qG2CWx5a+pMghHV
 UqrqJJyrUFdrIanRLmze/1RFUt1DR4Sc+w22eZfPDKjYl/PT4VyJ1yRe3TmGQMQagrDO
 sDrvurtfiUGBb9tcpJTyPPHQNYXps8Um7y+hj0CMT9eurWsWlGzcaMVr3r4u6fU5oi+m
 pMKPmrX0rJLAS7WEIflRD463z5M3uYeN6txuiqy/ycU3TnBmOcXRvnMRO/o0o66BgOIO
 lZhQ==
X-Gm-Message-State: AOJu0YyA28FA+Au8ezMFhprCX1UoUksHxWc9ZCNiP9XP4cpRZOHHSLXK
 PUn1JJbt0jfFy2Eq41PyJFw=
X-Google-Smtp-Source: AGHT+IHyg8RGhg0dXTuXW1mnY6LhCw6XpBKgeeDyAMSvPCFuLQc7sJU668hS9nIPNGOa3UFckoMhnA==
X-Received: by 2002:a17:903:1211:b0:1b8:6850:c3c4 with SMTP id
 l17-20020a170903121100b001b86850c3c4mr7340833plh.22.1691393359595; 
 Mon, 07 Aug 2023 00:29:19 -0700 (PDT)
Received: from localhost ([1.146.80.162]) by smtp.gmail.com with ESMTPSA id
 e6-20020a170902cf4600b001bb1f09189bsm6075211plg.221.2023.08.07.00.29.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 00:29:19 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Aug 2023 17:29:14 +1000
Message-Id: <CUM4WK2EKDQ6.WGQFFO7J8IT1@wheely>
Cc: <jniethe5@gmail.com>, <qemu-ppc@nongnu.org>, <bgray@linux.ibm.com>
Subject: Re: [PATCH 7/7] tcg/ppc: Use prefixed instructions for tcg_out_goto_tb
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230804213355.294443-1-richard.henderson@linaro.org>
 <20230804213355.294443-8-richard.henderson@linaro.org>
 <CULH7KALGQKY.2AVIQQUXLTX5U@wheely>
 <a0db9ba1-31df-87ab-949e-518c72e3639a@linaro.org>
In-Reply-To: <a0db9ba1-31df-87ab-949e-518c72e3639a@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

On Mon Aug 7, 2023 at 12:13 AM AEST, Richard Henderson wrote:
> On 8/6/23 05:55, Nicholas Piggin wrote:
> > On Sat Aug 5, 2023 at 7:33 AM AEST, Richard Henderson wrote:
> >> When a direct branch is out of range, we can load the destination for
> >> the indirect branch using PLA (for 16GB worth of buffer) and PLD from
> >> the TranslationBlock for everything larger.
> >>
> >> This means the patch affects exactly one instruction: B (plus filler),
> >> PLA or PLD.  Which means we can update and execute the patch atomicall=
y.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>   tcg/ppc/tcg-target.c.inc | 76 ++++++++++++++++++++++++++++++--------=
--
> >>   1 file changed, 58 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> >> index 5b243b2353..47c71bb5f2 100644
> >> --- a/tcg/ppc/tcg-target.c.inc
> >> +++ b/tcg/ppc/tcg-target.c.inc
> >> @@ -2642,31 +2642,41 @@ static void tcg_out_goto_tb(TCGContext *s, int=
 which)
> >>       uintptr_t ptr =3D get_jmp_target_addr(s, which);
> >>  =20
> >>       if (USE_REG_TB) {
> >> +        /*
> >> +         * With REG_TB, we must always use indirect branching,
> >> +         * so that the branch destination and TCG_REG_TB match.
> >> +         */
> >>           ptrdiff_t offset =3D tcg_tbrel_diff(s, (void *)ptr);
> >>           tcg_out_mem_long(s, LD, LDX, TCG_REG_TB, TCG_REG_TB, offset)=
;
> >> -
> >> -        /* TODO: Use direct branches when possible. */
> >> -        set_jmp_insn_offset(s, which);
> >>           tcg_out32(s, MTSPR | RS(TCG_REG_TB) | CTR);
> >> -
> >>           tcg_out32(s, BCCTR | BO_ALWAYS);
> >>  =20
> >>           /* For the unlinked case, need to reset TCG_REG_TB.  */
> >>           set_jmp_reset_offset(s, which);
> >>           tcg_out_mem_long(s, ADDI, ADD, TCG_REG_TB, TCG_REG_TB,
> >>                            -tcg_current_code_size(s));
> >> +        return;
> >> +    }
> >> +
> >> +    if (have_isa_3_10) {
> >> +        /* Align, so that we can patch 8 bytes atomically. */
> >> +        if ((uintptr_t)s->code_ptr & 7) {
> >> +            tcg_out32(s, NOP);
> >> +        }
> >> +        set_jmp_insn_offset(s, which);
> >> +        /* Direct branch will be patched by tb_target_set_jmp_target.=
 */
> >> +        tcg_out_mls_d(s, ADDI, TCG_REG_TMP1, 0, 0, 1);
> >>       } else {
> >>           /* Direct branch will be patched by tb_target_set_jmp_target=
. */
> >> -        set_jmp_insn_offset(s, which);
> >> -        tcg_out32(s, NOP);
> >> -
> >> +        tcg_out32(s, B);
> >>           /* When branch is out of range, fall through to indirect. */
> >>           tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, ptr - (int16_t)p=
tr);
> >>           tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1, (int=
16_t)ptr);
> >> -        tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
> >> -        tcg_out32(s, BCCTR | BO_ALWAYS);
> >> -        set_jmp_reset_offset(s, which);
> >>       }
> >> +
> >> +    tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
> >> +    tcg_out32(s, BCCTR | BO_ALWAYS);
> >> +    set_jmp_reset_offset(s, which);
> >>   }
> >>  =20
> >>   void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
> >> @@ -2674,20 +2684,50 @@ void tb_target_set_jmp_target(const Translatio=
nBlock *tb, int n,
> >>   {
> >>       uintptr_t addr =3D tb->jmp_target_addr[n];
> >>       intptr_t diff =3D addr - jmp_rx;
> >> -    tcg_insn_unit insn;
> >>  =20
> >>       if (USE_REG_TB) {
> >>           return;
> >>       }
> >>  =20
> >> -    if (in_range_b(diff)) {
> >> -        insn =3D B | (diff & 0x3fffffc);
> >> -    } else {
> >> -        insn =3D NOP;
> >> -    }
> >> +    if (have_isa_3_10) {
> >> +        tcg_insn_unit insn1, insn2;
> >> +        uint64_t pair;
> >>  =20
> >> -    qatomic_set((uint32_t *)jmp_rw, insn);
> >> -    flush_idcache_range(jmp_rx, jmp_rw, 4);
> >> +        if (in_range_b(diff)) {
> >> +            insn1 =3D B | (diff & 0x3fffffc);
> >> +            insn2 =3D NOP;
> >> +        } else if (diff =3D=3D sextract64(diff, 0, 34)) {
> >> +            /* PLA tmp1, diff */
> >> +            insn1 =3D OPCD(1) | (2 << 24) | (1 << 20) | ((diff >> 16)=
 & 0x3ffff);
> >> +            insn2 =3D ADDI | TAI(TCG_REG_TMP1, 0, diff);
> >> +        } else {
> >> +            addr =3D (uintptr_t)&tb->jmp_target_addr[n];
> >> +            diff =3D addr - jmp_rx;
> >> +            tcg_debug_assert(diff =3D=3D sextract64(diff, 0, 34));
> >> +            /* PLD tmp1, diff */
> >> +            insn1 =3D OPCD(1) | (1 << 20) | ((diff >> 16) & 0x3ffff);
> >> +            insn2 =3D PLD | TAI(TCG_REG_TMP1, 0, diff);
> >> +        }
> >=20
> > B is a "patch class" word instruction as per CMODX in the ISA, which ma=
y
> > be patched to/from other instructions without a flush+isync sequence
> > betwen. So that part is okay, at least if you were just patching the B
> > word. But patching between the PLA and PLD I don't think is kosher per
> > ISA.
> >=20
> > I struggle a bit with this part of the ISA, particularly with prefix
> > instructions (it only talks about patching 4 bytes at a time).
> >=20
> > If we patch something it has to go through a patch instruction, which
> > is a direct branch, trap, or nop. I think that makes this non-trivial.
> >=20
> > It could work if you only patched between B and PLD. B->PLD would have
> > to patch the suffix word first, possibly with an interleaving sync, and
> > then the prefix. PLD->B could just patch the B word.
> >=20
> > How much would losing the PLA hurt?
>
> Really?  I can't imagine how some icache would see a torn prefixed insn g=
iven an atomic=20
> store (CMODX talks about prefixed instructions which "may be unaligned" -=
- but what if=20
> they are not?).
>
> But if patching an aligned prefixed insn isn't allowed, I would patch bet=
ween B and NOP,=20
> leave the PLD alone on the fall-through path, and drop the PLA.

Hmm, even patching two different offset B instructions in some sequence
with a PLD would go against the ISA, because PLD is not a patch class
instruction. The only case you can patch those has to have a sequence of
exactly two instruction values. So I think you need the B first, and you
can patch that between any offset of B or a NOP to fall through to PLD.
NOP and B are both patch class, so any sequence of them is allowed.

Thanks,
Nick

