Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA0A767674
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 21:40:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPT3f-0006Sg-5r; Fri, 28 Jul 2023 15:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qPT3c-0006SI-PC
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 15:23:25 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qPT3Z-0003uW-89
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 15:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690572192; x=1691176992; i=deller@gmx.de;
 bh=AmW2GCjxV9YeRkdz8TFBsT3ucbzO2I+VFehcFjwhZVg=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=RLWAcjcwkYThnvrKks+/IH38V2O0WrATxR3ENnB/0hOl36qWOo43jiRCU0mHzqXlw5DHIBk
 LjnRdw9c4u2M3hjdjqEJy1d4ox0AQItuvLPkomTvhY24OulzT1oHnI4u7bBUk443ZO7VMG5np
 pXySPHNgPiI0pXCOL/801DICg8JdjSqB1qgHd+5D+q7o/qOBKJLqzEiEc8Epy4VK8P3k/Uhp8
 KCXJhzX05kpsrHj3FxZC1TO6dRKgyBGbDG0QwIIcGGQ24KUkL8XP8S6utwkpQoZEMcDKZK7Qu
 CXEPOc61VcnCRayFPolz/bwF2xsaKW+JOzX91RJqRDeKoBLyqJGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.159.73]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1OXT-1pkkGy3Ttz-012m7k; Fri, 28
 Jul 2023 21:23:11 +0200
Date: Fri, 28 Jul 2023 21:23:10 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 John Reiser <jreiser@bitwagon.com>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Subject: [PATCH v3] linux-user/armeb: Fix __kernel_cmpxchg() for armeb
Message-ID: <ZMQVnqY+F+5sTNFd@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:RUohHrEhMGEK4xJlkQSY5+guKQfGB+NnZNFBC5v5bo2hItpq0dw
 vbIeUd5LTrKtJYiP+hNF9YF9vHcvtfETonmTNk15hvhDA5B0anZ5tQKEYlwfeDgaBMVNlju
 CfOW7o7ElaAm5VESNc5pKWrM/Zqgw8OIkb8oGw9zXuzZ7tSDCWLmJTDNf5Ma+BnKOD6Bo7E
 /sHFWiPy2JWj15ij2ziaA==
UI-OutboundReport: notjunk:1;M01:P0:iGrgrZy47G4=;myHMWI50dAQGCIk7XZMlGzHjjEH
 cElBgRyEXtaSYWYDZGKWJzqhya2ev7ebwlBFNNuCIw5jD5maKIqiGjQYvV0YIf1CtWgk1ILE2
 8uHbfai2Hu99gE9RObOciB9YoQ8FiHth1uhIU8tSISEMJN9uUx/5nTRENSDZafQLDq7nUp0E/
 qGW5d+TrfEPNQowaB1MV7ll5UaAkP9MNPgKkMTEVQfruKNU+QJlkEbBBGI6oraYXgCt9G9eJd
 n3fMVey3fq3SrjxNshTwBIBC8/p0Z9cUZ9Iuvq7eS12Jme6v4OskKVPXJc58jIvOIVyvgVhLT
 CLi+9T66bJE72aXIBoGfsufiBMGcDr1AaWRlWIP7pTT0NVZgQLLJsNK9elud7vN8ox72cg+1R
 rZ6ZR2B46guhZKIbgc2TCku1FJBDtR4jtw1jaR61D3zT0YehbJ9RPyqK/onzAtMUzwlTegrab
 rBpAS9QMSenH/sFPpE6mZJiZP8b0K2DZvOk1nzEWzGzpU4EdqBZoh6ierFcOSuMyyJRK3Bay8
 9MfvFONxUaAZ17GT3TqW7/YeS8t6E0Ignh5Nd6Ju8W2v07Vl2pTKRvFQr95IMZxApLxq8d6bd
 5qwOvQ3I+5XRGKkUFv8cEVe9w45kY6UHSJl/2HueXCDn36hupQjDEDfktFQalFr6mMwNjYkwp
 UJVmIe+4Xx6Pw16sEahTKwZ+eQXLvDGU68XpllfrT7EZTaclYyEKLc9Y1FCvZ+e3OuAEwTJ0R
 CeNPu55THChliLdUhclZZBsIMWeFWoWF6DT4bSoXg2rqJII/dc1fwR392VNYVhW89JJ/E4TUK
 uDwKwMpEztjLpVfov8CX7r2/ceUB+ZWzHMj46TCQ9opq0DCz75l+0s045F8ciFPD6CwUNwaA6
 N7g+zYvTX7o498xOwkyTrEVlz6FgEqG/Vs0DFJUZrZvnmOL41a4oPjUuL63c03XD5TryOfbJg
 Km049g==
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Commit 7f4f0d9ea870 ("linux-user/arm: Implement __kernel_cmpxchg with host
atomics") switched to use qatomic_cmpxchg() to swap a word with the memory
content, but missed to endianess-swap the oldval and newval values when
emulating an armeb CPU, which expects words to be stored in big endian in
the guest memory.

The bug can be verified with qemu >=3D v7.0 on any little-endian host, whe=
n
starting the armeb binary of the upx program, which just hangs without
this patch.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org
Reported-by: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Reported-by: John Reiser <jreiser@BitWagon.com>
Closes: https://github.com/upx/upx/issues/687

=2D-
v3:
- use tswap64() in arm_kernel_cmpxchg64_helper() [review from Richard]
- mention that bug exists since qemu v7.0 [info from Markus]
v2:
- add tswap32() in arm_kernel_cmpxchg64_helper() [bisected by John]


diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index a992423257..f58154108e 100644
=2D-- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -117,8 +117,9 @@ static void arm_kernel_cmpxchg32_helper(CPUARMState *e=
nv)
 {
     uint32_t oldval, newval, val, addr, cpsr, *host_addr;

-    oldval =3D env->regs[0];
-    newval =3D env->regs[1];
+    /* endianess-swap if emulating armeb */
+    oldval =3D tswap32(env->regs[0]);
+    newval =3D tswap32(env->regs[1]);
     addr =3D env->regs[2];

     mmap_lock();
@@ -174,6 +175,10 @@ static void arm_kernel_cmpxchg64_helper(CPUARMState *=
env)
         return;
     }

+    /* endianess-swap if emulating armeb */
+    oldval =3D tswap64(oldval);
+    newval =3D tswap64(newval);
+
 #ifdef CONFIG_ATOMIC64
     val =3D qatomic_cmpxchg__nocheck(host_addr, oldval, newval);
     cpsr =3D (val =3D=3D oldval) * CPSR_C;

