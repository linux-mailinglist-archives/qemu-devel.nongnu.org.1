Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F7476870E
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 20:08:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQAf7-0000ye-PN; Sun, 30 Jul 2023 13:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQAf2-0000x7-5M
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 13:56:56 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQAf0-0008Re-BZ
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 13:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690739811; x=1691344611; i=deller@gmx.de;
 bh=AvYxrSCaTkYW1Ki7kGR6deSg6YvOAOVEtGYv15Krc/U=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=JfMj59JGyIixk89yGIVbOhjceEVchyPNOr0v26AnYyc/Vm/K4wSJ7zhjvdNBEpbwkm2RK8F
 FTVJmVT8I5QYpC1tPPwrTYvoyb9mSpmxUwIbEJRkdyeLnS67/XXsWftD5zDOx+OwHGONLbGYT
 U+EjoPcJ+0cTMyICwnQVhGT7Napmbdroudi+A62U0StzxoTcEEMd8O97hPf80AO/tx1BmDAMY
 +J5fw1fqGuA2iqrVUY+rutU9w2QWLVUjGuiaUD9zg+eTh8Z2wGP+fsW2D78dIKmmMm6vpeRye
 3bs5qOwlcOuZbqVQ5ZSuKqgmul80W3oNNheS1xsM/MxCSPg0AhQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.144.241]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KYb-1poyLK2gYb-016gE3; Sun, 30
 Jul 2023 19:56:51 +0200
Date: Sun, 30 Jul 2023 19:56:50 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Subject: [RFC][PATCH] accel/tcg: Use lookup_and_goto_ptr() for linux-user in
 translator_use_goto_tb()
Message-ID: <ZMakYpOgco2Ihg0G@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:yexKCKXR83SmljFsRKTd3enoZo2Ceibjc7PqUWGQx85He2b6/fm
 Z7dSgemnYTYyIldLmK9QAMh8JnjMPSIQN+jI0++A4czftuE0Y5HIytb+wU2Y+J570WScfzC
 iZ6e8fFXFAde0ggRXOKuh0ZcJVMI/X7Nauz6L77aCHf9bEr+KLKF9fAYb2zZYiDx2vnKlVt
 8A1K5JS05Ou6TpULc9uwA==
UI-OutboundReport: notjunk:1;M01:P0:pzwldy9NnQs=;yNd41EtdNwmFsuWgXdlDcS58k9x
 GnAZLUVV22C0rXuw5KAJ8DhZ2BiUQ0wgXlXs3wL/DYI9D1UwjG5qQ+WIZsnAy9453ayRuc/dO
 kmWRRHUJqb3zXoX2WjKfb62pI/x3rLz/5qg9TChDubt6Wmeo7L1Ksx5+PJBovBWf0WCIgpw3a
 QApeBTgFhJRF8mxD+yOLr/rdCYCucAkDsFzS8yHm3YxEJoei7Dnkb712wltq6kwwCgtLkVySW
 3keFARPPHvBGejJpe5eiJ/P164wFFGjbqs+pH9qTPLUVFsT6T896AIHglmocuF6Oxuj6sjtun
 q8yZC2Oz5oAI7E59hqqMM3fNVp2STA2hts0ipxNqlW9lRilgJeQ4vVR13CQCL97iw/ybJXC5a
 +vrXL0WeMeorqNJgnDnV0s1K+JBpHZh+GkafgyJoYZMbmfGNJFvTXwg/g8LnVomsvxmKJVTO7
 87NzHLjffPn1xKFOKJxkE/Gvxm696QAvTbV7LPe00Fswi9/yNyZnSsNql9TpkPqCC6tuy1y3A
 JWMzgEUBaDDrCmYTtDF4NCAP+1f7sHvdroFGSXdJoffus/kGNBWPuvvqqcL0NiYQWbw64hsLj
 5ZQAp7hZxXO+J6i4JDeUnjGtfW4x6ewNRYFEetvK3SpnUWH/tHM0AVWkJ9KRSozfpHS8tIiLS
 1nIgPC0EpAN9IXoYyjEYjWE5t7UdKcj9zM1br7lo4DLQRmzxjxfmSphDx47oKqEdfHNeKNu7M
 qbDtsoTRXU1vHURIYn0nE9iaYZFmOnZujI/+VkbV6Xw6HrLLrxv5RnlGkpSKg/nDR+4c1sqOA
 JV+TyGiI40I/RsdUK0ejw8Jnimw0Oqjg8sNvPKfv+NWX2/7Jq8kDLBjEVBRNRoobfCBF1qo3O
 TFvafuyv+8VIekhyQsWXGjuR+1/33RoIiuHBu8UvRUpxW39Jv/c7/fpuLlccYffibE8rTUvy+
 9KbNuNGym6ihroq6SYyHsvPZnuE=
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

I'm quite unclear about translator_use_goto_tb() for qemu-user
emulation....(and in general).

Based on the function name, the function translator_use_goto_tb() shall
help to decide if a program should use goto_tb() and exit_tb() to jump
to the next instruction.

Currently, if the destination is on the same page, it returns true.
I wonder, if it shouldn't return false in this case instead, because
arches have code like this: (taken from target/hppa/translate.c):
    if (... && translator_use_goto_tb(ctx, f)) {
        tcg_gen_goto_tb(which);
        tcg_gen_movi_reg(cpu_iaoq_f, f);
        tcg_gen_movi_reg(cpu_iaoq_b, b);
        tcg_gen_exit_tb(ctx->base.tb, which);
    } else {
        copy_iaoq_entry(cpu_iaoq_f, f, cpu_iaoq_b);
        copy_iaoq_entry(cpu_iaoq_b, b, ctx->iaoq_n_var);
        tcg_gen_lookup_and_goto_ptr();
    }

Shouldn't, if the destination is on the same page, the (faster?)
path with tcg_gen_lookup_and_goto_ptr() be taken instead?

Now, for user-mode emulation page faults can't happen at all.
Shouldn't in this case the tcg_gen_lookup_and_goto_ptr() path been taken
unconditionally, as shown in the patch below?

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 1a6a5448c8..07224a7f83 100644
=2D-- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -124,8 +124,13 @@ bool translator_use_goto_tb(DisasContextBase *db, vad=
dr dest)
         return false;
     }

+#ifndef CONFIG_USER_ONLY
     /* Check for the dest on the same page as the start of the TB.  */
     return ((db->pc_first ^ dest) & TARGET_PAGE_MASK) =3D=3D 0;
+#else
+    /* linux-user doesn't need to fear pagefaults for exec swap-in */
+    return false;
+#endif
 }

 void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,

