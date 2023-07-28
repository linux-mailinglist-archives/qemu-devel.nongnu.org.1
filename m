Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D2B76637B
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 07:05:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPFUo-0003d1-3t; Fri, 28 Jul 2023 00:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qPFUl-0003cX-FY
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 00:54:31 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qPFUj-0002iV-C3
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 00:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690520057; x=1691124857; i=deller@gmx.de;
 bh=vi57fuA25YiER519U8fKnD3YwuI2mZdmBtlNo8Jml2Q=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=RN61CABBZ7ZYL8VF9oWFDs3pDG2u6jyOpnfj2zOAszPvsYOdbV4ZP19z3IdCqKJhDwhtij7
 4M+fBS8RgwT/iOlT838ztDwFsl66akin+gYFZ+MwXocbvWkXSlbpvA5/i+g2G4FxsDS5Fxs0X
 TqT/XHmaBf1X4RVBIbn1xMWDXQ+F9n/wd2QjMkM7OPHGUhirlU7S6MCAQWipqyQpgz6QRATxm
 4/k1FZ4kMA9ci4C7jby4FTwJk3TbFBUbo91yDHPrtPj2ZppSJuxN3smeaNNAj6DNc9/H3qbph
 6gFWjt9UotjktL2fFO4QSVZJzZQ05lLSONqMqaeAY1KMBNOUpehA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.159.73]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlT2-1pzZuR2LtG-00jtVv; Fri, 28
 Jul 2023 06:54:17 +0200
Date: Fri, 28 Jul 2023 06:54:16 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 John Reiser <jreiser@bitwagon.com>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Subject: [PATCH v2] linux-user/armeb: Fix __kernel_cmpxchg() for armeb
Message-ID: <ZMNJ+Ga7A4zDXjAg@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:KfEm6USRqxXIiljbLe48LmkE4FLdaxXd6h9jLmQiGaqR2yJKUw+
 C7k969x+8Mv5HbnTRGb7SrDVu7HyvG5B/JPL8JrPh2pm5wDuVhrxEx8DSj0mCtRuQ+6BqPK
 IaPUe01KP3e/u8bYPhk0KV5nR/TJDupUF9kUFabA2fH6BhpY+25BSzFhQgpV9bcbqHo/d4t
 8OlHu579vs1xeCZgu49Ow==
UI-OutboundReport: notjunk:1;M01:P0:2OQSvq9iyto=;/muWtudt/k/rI+T5tqoohL+in4+
 2XwYm55HYCoKLAEX9rrEW68CQc849aenNVk7cavU+fA9j2gvq++udplsgWjPZ7N4BZg7Ex3MI
 s+BKGSbkPxnLMjPjU5jcFuS5mtVX8bf+2PQZGTGBHf8C8FFNfTVHxODB+2Mm9dsgd7vd6LsQw
 RtzJyDU/P3njxVcO4Pu2U1TbbE5gGlg9Wco1jsjGGgPSKCrOeG9aCUDELOU1+AVOdiuUj98KN
 lrkGBZP9eOrG7ph+3FzG4W/n2wI2NwSo3c5L6E0ac8Izf5EP0V7XMCC0cldWqrUYNt02IwMzy
 HeHkSuIj+XzTQ0OdC+0w5arQ1h4u6KH/8H7PKjV0e3j+ech9lQqXab8AFJJoc/1C7EHNAugx1
 eAZ0B22Ad+5ciasHlt76V8BU+fMk39T5fumEFE588ltUsfLLYb1LKW22T3mHTYQfKhTh9kldA
 /F64Inxl2YJ3LJp2A9sY0V+TkT7HbQF7FqCq3KaoqmqMwFC7rObnqYY2cD5Djgan1vYv8B6w5
 X9/s2BB7EWsokpp7j1OPZfqZuJHSc/rBjOdVgLqggq5anVc/5e1VtrGnFzCiQLC9rckdOCdzA
 8sKzsH7KJXSqGcGttKnOjswg9QjKsD1VCly/+sKcP6wvLzpK9CNZMldhoTtlK6jyD3SPxpvir
 LyrcDhUs/Zacn5Uc1cdnZz8kxJiwxjSPxZRHJizZ/tIfUC/NTP45MMZIIgKJT9SMUbFBferri
 FOGcSXUCAH9AjxKD5FX+9YEHTQYLA0ikpU5uun3c4/RSnB9kM8lAUKXjpWo8NOOXxTgcZPScg
 WoXQ/74m8umBu67YYSNGeJSvQRaDPmaIV707aP3mdh0OKcF8FCMUK0mt5LwxHSmfo9COljSZL
 HldNXbOEVqBYseO+rKK6FoRCgovHYwxz/HF+1Gyug1gKwhXTdV2I2R58cLC90ld6hujMYwo9P
 h0otpca8wrP/oCREst5yT39OY3w=
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
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

The bug can be verified with qemu >=3D v7.2 on any little-endian host, whe=
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
v2:
- add tswap32() in arm_kernel_cmpxchg64_helper()


diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index a992423257..0907cd8c15 100644
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
+    oldval =3D tswap32(oldval);
+    newval =3D tswap32(newval);
+
 #ifdef CONFIG_ATOMIC64
     val =3D qatomic_cmpxchg__nocheck(host_addr, oldval, newval);
     cpsr =3D (val =3D=3D oldval) * CPSR_C;

