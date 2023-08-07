Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F164771D3F
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 11:38:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSwgy-0005C8-Dp; Mon, 07 Aug 2023 05:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qSwgr-00052u-Ve; Mon, 07 Aug 2023 05:38:18 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qSwgp-0001Et-TV; Mon, 07 Aug 2023 05:38:17 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1bb58b4c513so3194697fac.0; 
 Mon, 07 Aug 2023 02:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691401094; x=1692005894;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XmrQblq4uMvThj7m086Q1ldfXgN40t40zW1IbgQzS80=;
 b=pQc5QivbnR1xo6YvExsdvoFpeRYyoKZaIewjo+K/6LG7xrtPtaRUxOkgkVti48ZTmN
 DO+W43Ej5FiiTiuC7KDFLFZunem0vcfdAz1G5Cwwp8g09T+h3Q+GQKFBh2rjfHdXmw+0
 c5A+dQ7KQwBz+4UYybwYKj0HWG3WPhhV4TZoTngD0EhQ1iFEtckSBjExsPoZiJDL+yaj
 2HFh2ATL+Hkcm9ERQDqo5MtUHuDSLGluPhAaZUEfE8Vh1sfdAJSp91BZy5N+e5yluJ/m
 S4mX+E5faWKv4IDhWgcRKLL3+Eir81Yt+zaZCa7GcYN+4OTRglxitPoZ8VHsuDbj9940
 xwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691401094; x=1692005894;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XmrQblq4uMvThj7m086Q1ldfXgN40t40zW1IbgQzS80=;
 b=WNvA676EylVGMpObtJMYDgPdkKT6ETe6xJiQAsNRdYS2e/3c2wziRe6S4Wk7E5CcGu
 Zag6RaUYbKMRRPFMOqIM4XU1dHMDrVHCj64O+jQsz3oRUMRNP0EJH6PK3JzkGYWalrg1
 tcaGYnRP7Uni1X9+OpxJnkEg1jEXTq6mccUSuN9seCHZWtN6Ni5SFoY18Tm2YffLylgV
 e2K+PaMJ+mY9pfMFMSZp0MitYM9IqzVtcJCLFIAu+gXQXb8YFsztsvbEATgOvI4cZJWN
 Fs/y4Sl8LwtJdojAwnatgbnsIkWAl7OqyRmp2uzwblcwXn20Sy6UF2/Z9D5GupA13GWx
 Ej/Q==
X-Gm-Message-State: AOJu0YyCor2jaqUeG50ey+PSDW33F7zThnGlebTvrppgVafjlunW6mb9
 KTZk0GuGlJIfNdmW+tlUhPY=
X-Google-Smtp-Source: AGHT+IFYdy5zy8SDBy9k1OOhK0jFyeA0zGN2kwC6UqYhvVUF9PI2sCRLTEL7hp7Asoe4ZekPhvaUnw==
X-Received: by 2002:a05:6870:d79b:b0:1bf:80f2:8429 with SMTP id
 bd27-20020a056870d79b00b001bf80f28429mr10962029oab.40.1691401094063; 
 Mon, 07 Aug 2023 02:38:14 -0700 (PDT)
Received: from localhost ([1.146.117.53]) by smtp.gmail.com with ESMTPSA id
 29-20020a17090a199d00b0025dc5749b4csm8864023pji.21.2023.08.07.02.38.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 02:38:13 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Aug 2023 19:38:08 +1000
Message-Id: <CUM7N977FTPE.1GCPWFI8J03XM@wheely>
Cc: <jniethe5@gmail.com>, <qemu-ppc@nongnu.org>, <bgray@linux.ibm.com>
Subject: Re: [PATCH 7/7] tcg/ppc: Use prefixed instructions for tcg_out_goto_tb
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, "Richard Henderson"
 <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230804213355.294443-1-richard.henderson@linaro.org>
 <20230804213355.294443-8-richard.henderson@linaro.org>
 <CULH7KALGQKY.2AVIQQUXLTX5U@wheely>
 <a0db9ba1-31df-87ab-949e-518c72e3639a@linaro.org>
 <CUM4WK2EKDQ6.WGQFFO7J8IT1@wheely>
In-Reply-To: <CUM4WK2EKDQ6.WGQFFO7J8IT1@wheely>
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x2b.google.com
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

On Mon Aug 7, 2023 at 5:29 PM AEST, Nicholas Piggin wrote:
> On Mon Aug 7, 2023 at 12:13 AM AEST, Richard Henderson wrote:
> > On 8/6/23 05:55, Nicholas Piggin wrote:
> > > On Sat Aug 5, 2023 at 7:33 AM AEST, Richard Henderson wrote:
> > >> When a direct branch is out of range, we can load the destination fo=
r
> > >> the indirect branch using PLA (for 16GB worth of buffer) and PLD fro=
m
> > >> the TranslationBlock for everything larger.
> > >>
> > >> This means the patch affects exactly one instruction: B (plus filler=
),
> > >> PLA or PLD.  Which means we can update and execute the patch atomica=
lly.
> > >>
> > >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > >> ---
> > >>   tcg/ppc/tcg-target.c.inc | 76 ++++++++++++++++++++++++++++++------=
----
> > >>   1 file changed, 58 insertions(+), 18 deletions(-)
> > >>
> > >> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> > >> index 5b243b2353..47c71bb5f2 100644
> > >> --- a/tcg/ppc/tcg-target.c.inc
> > >> +++ b/tcg/ppc/tcg-target.c.inc
> > >> @@ -2642,31 +2642,41 @@ static void tcg_out_goto_tb(TCGContext *s, i=
nt which)
> > >>       uintptr_t ptr =3D get_jmp_target_addr(s, which);
> > >>  =20
> > >>       if (USE_REG_TB) {
> > >> +        /*
> > >> +         * With REG_TB, we must always use indirect branching,
> > >> +         * so that the branch destination and TCG_REG_TB match.
> > >> +         */
> > >>           ptrdiff_t offset =3D tcg_tbrel_diff(s, (void *)ptr);
> > >>           tcg_out_mem_long(s, LD, LDX, TCG_REG_TB, TCG_REG_TB, offse=
t);
> > >> -
> > >> -        /* TODO: Use direct branches when possible. */
> > >> -        set_jmp_insn_offset(s, which);
> > >>           tcg_out32(s, MTSPR | RS(TCG_REG_TB) | CTR);
> > >> -
> > >>           tcg_out32(s, BCCTR | BO_ALWAYS);
> > >>  =20
> > >>           /* For the unlinked case, need to reset TCG_REG_TB.  */
> > >>           set_jmp_reset_offset(s, which);
> > >>           tcg_out_mem_long(s, ADDI, ADD, TCG_REG_TB, TCG_REG_TB,
> > >>                            -tcg_current_code_size(s));
> > >> +        return;
> > >> +    }
> > >> +
> > >> +    if (have_isa_3_10) {
> > >> +        /* Align, so that we can patch 8 bytes atomically. */
> > >> +        if ((uintptr_t)s->code_ptr & 7) {
> > >> +            tcg_out32(s, NOP);
> > >> +        }
> > >> +        set_jmp_insn_offset(s, which);
> > >> +        /* Direct branch will be patched by tb_target_set_jmp_targe=
t. */
> > >> +        tcg_out_mls_d(s, ADDI, TCG_REG_TMP1, 0, 0, 1);
> > >>       } else {
> > >>           /* Direct branch will be patched by tb_target_set_jmp_targ=
et. */
> > >> -        set_jmp_insn_offset(s, which);
> > >> -        tcg_out32(s, NOP);
> > >> -
> > >> +        tcg_out32(s, B);
> > >>           /* When branch is out of range, fall through to indirect. =
*/
> > >>           tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, ptr - (int16_t=
)ptr);
> > >>           tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1, (i=
nt16_t)ptr);
> > >> -        tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
> > >> -        tcg_out32(s, BCCTR | BO_ALWAYS);
> > >> -        set_jmp_reset_offset(s, which);
> > >>       }
> > >> +
> > >> +    tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
> > >> +    tcg_out32(s, BCCTR | BO_ALWAYS);
> > >> +    set_jmp_reset_offset(s, which);
> > >>   }
> > >>  =20
> > >>   void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
> > >> @@ -2674,20 +2684,50 @@ void tb_target_set_jmp_target(const Translat=
ionBlock *tb, int n,
> > >>   {
> > >>       uintptr_t addr =3D tb->jmp_target_addr[n];
> > >>       intptr_t diff =3D addr - jmp_rx;
> > >> -    tcg_insn_unit insn;
> > >>  =20
> > >>       if (USE_REG_TB) {
> > >>           return;
> > >>       }
> > >>  =20
> > >> -    if (in_range_b(diff)) {
> > >> -        insn =3D B | (diff & 0x3fffffc);
> > >> -    } else {
> > >> -        insn =3D NOP;
> > >> -    }
> > >> +    if (have_isa_3_10) {
> > >> +        tcg_insn_unit insn1, insn2;
> > >> +        uint64_t pair;
> > >>  =20
> > >> -    qatomic_set((uint32_t *)jmp_rw, insn);
> > >> -    flush_idcache_range(jmp_rx, jmp_rw, 4);
> > >> +        if (in_range_b(diff)) {
> > >> +            insn1 =3D B | (diff & 0x3fffffc);
> > >> +            insn2 =3D NOP;
> > >> +        } else if (diff =3D=3D sextract64(diff, 0, 34)) {
> > >> +            /* PLA tmp1, diff */
> > >> +            insn1 =3D OPCD(1) | (2 << 24) | (1 << 20) | ((diff >> 1=
6) & 0x3ffff);
> > >> +            insn2 =3D ADDI | TAI(TCG_REG_TMP1, 0, diff);
> > >> +        } else {
> > >> +            addr =3D (uintptr_t)&tb->jmp_target_addr[n];
> > >> +            diff =3D addr - jmp_rx;
> > >> +            tcg_debug_assert(diff =3D=3D sextract64(diff, 0, 34));
> > >> +            /* PLD tmp1, diff */
> > >> +            insn1 =3D OPCD(1) | (1 << 20) | ((diff >> 16) & 0x3ffff=
);
> > >> +            insn2 =3D PLD | TAI(TCG_REG_TMP1, 0, diff);
> > >> +        }
> > >=20
> > > B is a "patch class" word instruction as per CMODX in the ISA, which =
may
> > > be patched to/from other instructions without a flush+isync sequence
> > > betwen. So that part is okay, at least if you were just patching the =
B
> > > word. But patching between the PLA and PLD I don't think is kosher pe=
r
> > > ISA.
> > >=20
> > > I struggle a bit with this part of the ISA, particularly with prefix
> > > instructions (it only talks about patching 4 bytes at a time).
> > >=20
> > > If we patch something it has to go through a patch instruction, which
> > > is a direct branch, trap, or nop. I think that makes this non-trivial=
.
> > >=20
> > > It could work if you only patched between B and PLD. B->PLD would hav=
e
> > > to patch the suffix word first, possibly with an interleaving sync, a=
nd
> > > then the prefix. PLD->B could just patch the B word.
> > >=20
> > > How much would losing the PLA hurt?
> >
> > Really?  I can't imagine how some icache would see a torn prefixed insn=
 given an atomic=20
> > store (CMODX talks about prefixed instructions which "may be unaligned"=
 -- but what if=20
> > they are not?).
> >
> > But if patching an aligned prefixed insn isn't allowed, I would patch b=
etween B and NOP,=20
> > leave the PLD alone on the fall-through path, and drop the PLA.
>
> Hmm, even patching two different offset B instructions in some sequence
> with a PLD would go against the ISA, because PLD is not a patch class
> instruction. The only case you can patch those has to have a sequence of
> exactly two instruction values. So I think you need the B first, and you
> can patch that between any offset of B or a NOP to fall through to PLD.
> NOP and B are both patch class, so any sequence of them is allowed.

Here is an incremental diff that hopefully solves those issues. Sadly,
by removing the nice PLA patching :( But it seems to be around or close
to original performance on my test.

Feel free to squash it in or take inspiration (or dispute it).

Thanks,
Nick

---
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 47c71bb5f2..569c2e3647 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -748,6 +748,11 @@ static void tcg_out_prefix_align(TCGContext *s)
     }
 }
=20
+static ptrdiff_t tcg_pcrel_diff_for_prefix(TCGContext *s, const void *targ=
et)
+{
+    return tcg_pcrel_diff(s, target) - (tcg_out_need_prefix_align(s) ? 4 :=
 0);
+}
+
 /* Output Type 00 Prefix - 8-Byte Load/Store Form (8LS:D) */
 static void tcg_out_8ls_d(TCGContext *s, tcg_insn_unit opc, unsigned rt,
                           unsigned ra, tcg_target_long imm, bool r)
@@ -1072,8 +1077,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType t=
ype, TCGReg ret,
             return;
         }
=20
-        tmp =3D tcg_out_need_prefix_align(s) * 4;
-        tmp =3D tcg_pcrel_diff(s, (void *)arg) - tmp;
+        tmp =3D tcg_pcrel_diff_for_prefix(s, (void *)arg);
         if (tmp =3D=3D sextract64(tmp, 0, 34)) {
             /* pla ret,value =3D paddi ret,0,value,1 */
             tcg_out_mls_d(s, ADDI, ret, 0, tmp, 1);
@@ -2658,18 +2662,19 @@ static void tcg_out_goto_tb(TCGContext *s, int whic=
h)
         return;
     }
=20
+    /* Direct branch will be patched by tb_target_set_jmp_target. */
+    set_jmp_insn_offset(s, which);
+    tcg_out32(s, NOP);
+
+    /* When branch is out of range, fall through to indirect. */
     if (have_isa_3_10) {
-        /* Align, so that we can patch 8 bytes atomically. */
-        if ((uintptr_t)s->code_ptr & 7) {
-            tcg_out32(s, NOP);
-        }
-        set_jmp_insn_offset(s, which);
-        /* Direct branch will be patched by tb_target_set_jmp_target. */
-        tcg_out_mls_d(s, ADDI, TCG_REG_TMP1, 0, 0, 1);
+        ptrdiff_t offset =3D tcg_pcrel_diff_for_prefix(s, (void *)ptr);
+        /*
+         * Would be nice to use PLA if offset is in range,
+         * but CMODX rules make that difficult.
+         */
+        tcg_out_8ls_d(s, PLD, TCG_REG_TMP1, 0, offset, 1);
     } else {
-        /* Direct branch will be patched by tb_target_set_jmp_target. */
-        tcg_out32(s, B);
-        /* When branch is out of range, fall through to indirect. */
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, ptr - (int16_t)ptr);
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1, (int16_t)p=
tr);
     }
@@ -2684,50 +2689,19 @@ void tb_target_set_jmp_target(const TranslationBloc=
k *tb, int n,
 {
     uintptr_t addr =3D tb->jmp_target_addr[n];
     intptr_t diff =3D addr - jmp_rx;
+    tcg_insn_unit insn;
=20
     if (USE_REG_TB) {
         return;
     }
=20
-    if (have_isa_3_10) {
-        tcg_insn_unit insn1, insn2;
-        uint64_t pair;
-
-        if (in_range_b(diff)) {
-            insn1 =3D B | (diff & 0x3fffffc);
-            insn2 =3D NOP;
-        } else if (diff =3D=3D sextract64(diff, 0, 34)) {
-            /* PLA tmp1, diff */
-            insn1 =3D OPCD(1) | (2 << 24) | (1 << 20) | ((diff >> 16) & 0x=
3ffff);
-            insn2 =3D ADDI | TAI(TCG_REG_TMP1, 0, diff);
-        } else {
-            addr =3D (uintptr_t)&tb->jmp_target_addr[n];
-            diff =3D addr - jmp_rx;
-            tcg_debug_assert(diff =3D=3D sextract64(diff, 0, 34));
-            /* PLD tmp1, diff */
-            insn1 =3D OPCD(1) | (1 << 20) | ((diff >> 16) & 0x3ffff);
-            insn2 =3D PLD | TAI(TCG_REG_TMP1, 0, diff);
-        }
-
-        if (HOST_BIG_ENDIAN) {
-            pair =3D ((uint64_t)insn1) << 32 | insn2;
-        } else {
-            pair =3D ((uint64_t)insn2) << 32 | insn1;
-        }
-
-        qatomic_set((uint64_t *)jmp_rw, pair);
-        flush_idcache_range(jmp_rx, jmp_rw, 8);
+    if (in_range_b(diff)) {
+        insn =3D B | (diff & 0x3fffffc);
     } else {
-        tcg_insn_unit insn;
-
-        if (in_range_b(diff)) {
-            insn =3D B | (diff & 0x3fffffc);
-        } else {
-            insn =3D NOP;
-        }
-        qatomic_set((uint32_t *)jmp_rw, insn);
-        flush_idcache_range(jmp_rx, jmp_rw, 4);
+        insn =3D NOP;
     }
+    qatomic_set((uint32_t *)jmp_rw, insn);
+    flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
=20
 static void tcg_out_op(TCGContext *s, TCGOpcode opc,

