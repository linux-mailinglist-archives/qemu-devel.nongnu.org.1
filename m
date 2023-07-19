Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A58759A3B
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 17:54:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM9Tv-0006zp-Ok; Wed, 19 Jul 2023 11:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qM9Tr-0006zL-5q; Wed, 19 Jul 2023 11:52:47 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qM9To-0006NH-Dl; Wed, 19 Jul 2023 11:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689781958; x=1690386758; i=deller@gmx.de;
 bh=Rx4B0JKQX5xnCv8PHKKcBOIyM5MzrsGvZF5tbMB77Mo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Yfct0ElBCLZPjmBFZls/XSvz8i6rQB68EnqDpWLKSXuXZxC4/+wF7QR/6LjOdbeDCGOnmPk
 8M/fQ/9K8UvaGMuS+DkeH+CpXXi5HMA3vz15SvCsIytgDYb6EeDOhnwspToCQTL/EWdeKuomN
 UAFsuwuzUUz0hhE9/XAC7fGFo1QQylDFZJOvUZeWg7qdJW9Ks/YHKRUMgpZAYZifF/Rs8kv9f
 rAv6zXi975opSyfHE+Xui73L7iFXorBYswCKs5pESL5diY3DR1Ucw5BwlZhNDsLkWKaAPRoc8
 JBThkS4tvElgx2/FpSAgsfVln0L/GWVZno1+ihmYTo9HiZyrtf8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.145.157]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7GS-1qBkA01hV4-00BZZk; Wed, 19
 Jul 2023 17:52:38 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Andreas Schwab <schwab@suse.de>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	qemu-stable@nongnu.org
Subject: [PULL 5/5] linux-user: Fix qemu-arm to run static armhf binaries
Date: Wed, 19 Jul 2023 17:52:35 +0200
Message-ID: <20230719155235.244478-6-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719155235.244478-1-deller@gmx.de>
References: <20230719155235.244478-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0iW520w2ysnszSIoacfznsSvEkeo+Q6oqBt4+/1hANdDSf/6GDB
 w8nWTS4gwIg6dT+1cTgeTqD+L7ZqPK7ScHJ59ZP2Q5RDd1g0GnOd3lQhptNy/KMbSpjEr5D
 t3+06M1to8J1mLLFmDjCWczEVu8gkLEyck77b97hOYTv59mQjb3GVaT3Q8IZhXwPxRxjbsb
 P4WTWpJej2oWK7/EQx/kQ==
UI-OutboundReport: notjunk:1;M01:P0:cRBrKvJQuvE=;FRjQWX3LK2tdwONyyfnhQ1od/rW
 FET+t6XnyJ55UdiFyqEJiU+u/Of407AuwJea0hD1Kg7shE2ObF8eP7wcKnrqxK+Tz0DgJowBD
 wYymor7AAgI4nXMFNKLD0Dn0CHZiK/6s41zT5JejFXTjqh/V+yuyV9z7UZcCG2jHfHTF+Lvn2
 0YvinGjmX0r6p6+aou4ezGeqqeMVi6u39SpVRW1T/tfSSu8k6osvsi1fX0NNojlC/S8bn+vev
 FwP9T7JeoagW7oH3UZy3I/Fpedr/i6ImJWsCNXSvRbe5TPzG6CLwVzNDivDYVlDl0SXdF214r
 93+gfh8w0+Mc+qraKY2jmZviN8hOO5P//aLjIkXqz+YjzKBr8D10Hl6YPNoEX1iO80DsDCzG4
 X71aDZ/eQLLzETNNHiKSjxvnJZinBO/OfzBEBl/3CZ3Mkdxc6uTQPz1UDAqcSOJn/NJygg2en
 upIH+64KrsKVZofdA9JOfPsd6CvJNdz9/ZFsXJj7N0SzsMpI9u6Amxk4bMLdtLqA1N+jvidns
 V4rLkRppi+cxhkSwByk3umMwcFKXy3tKiv+K/U1ExZhMxpDoatBC2/4weAXNsaJRR8ZITwD+u
 TdVetndfiYai4+qXhfedNfJ1NTp51kYd0hQNW05olbs8MKUtvb1zWQ/WStNpDqfHRhcLtNSaw
 CIiabRivt9wx4VW/pYlVRJ1hK9Wqm6YlgKqnAS+QO2CzDgQW5pX0m8BK8HY2Phc6NJQc3KIhG
 JbPKnM4rIF4qLzfJy4cXlhn8UZNjzc2gogcrOllGtE/gSql/15575wwObTMuuVjiAp+Is2WiZ
 tc9L8ukka272Uls4AwCy3MLzUFj8RjGHNavZWBx7/Ynq6JcY3KtolwnCp/UF4+wrRvaBu5BZ7
 xsNcv+vp8pJdVHkc/B3CsFzQtupuZiu3sGGwAwtjhKzVyzoRi2MH+6GXnpK/Hu4EqwLwiKtHK
 f3vgY6B2VrAXEOgv167mRMVB1xs=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

qemu-user crashes immediately when running static binaries on the armhf
architecture. The problem is the memory layout where the executable is
loaded before the interpreter library, in which case the reserved brk
region clashes with the interpreter code and is released before qemu
tries to start the program.

At load time qemu calculates a brk value for interpreter and executable
each.  The fix is to choose the higher one of both.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Andreas Schwab <schwab@suse.de>
Cc: qemu-stable@nongnu.org
Reported-by:  Venkata.Pyla@toshiba-tsip.com
Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1040981
=2D--
 linux-user/elfload.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a26200d9f3..94951630b1 100644
=2D-- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3615,6 +3615,13 @@ int load_elf_binary(struct linux_binprm *bprm, stru=
ct image_info *info)

     if (elf_interpreter) {
         load_elf_interp(elf_interpreter, &interp_info, bprm->buf);
+        /*
+         * adjust brk address if the interpreter was loaded above the mai=
n
+         * executable, e.g. happens with static binaries on armhf
+         */
+        if (interp_info.brk > info->brk) {
+            info->brk =3D interp_info.brk;
+        }

         /* If the program interpreter is one of these two, then assume
            an iBCS2 image.  Otherwise assume a native linux image.  */
=2D-
2.41.0


