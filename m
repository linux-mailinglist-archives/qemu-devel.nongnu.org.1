Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A995676C0DD
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 01:29:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQymU-0001K6-LE; Tue, 01 Aug 2023 19:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQymS-0001Im-8C
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:27:56 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQymP-00077u-0T
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690932467; x=1691537267; i=deller@gmx.de;
 bh=N0Dlhp9SfJjPZs7/6Px6gA2M4iFsr6qxZXp6AFGyc34=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ae2GvHY+wc+d5DW1xyLJfYeC4bMWpFF4zpZCDuY1L6e57LY80RFSpvdA2uu3l1p9MxxO0cL
 Ke3p0a7DgI2u7nmQ27/O8ilv32Z9xoDRt6UodpDX4prWDficF2GKsEacJwzNxpCaWTrJFaZz7
 4LSsa3fgua12L1lSphZqIeQWk/NJdUUr8GD+Mql9Geql6RCxMTt2WnwdwcRyxz63xIy7SXQr1
 F7U/y5B+fcNgs2NWqQPC9BOMbOpXIi5spkXLxrwQT9FXyNjE65wSjtVXUZbRf7Mkof1KmUFtK
 RJlY/HmVLFeolsFXDDqsuKI22b18wOqi9XrzwR0uWb8+o3OnDQ4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.150.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mGB-1plPrs1Emh-0179wv; Wed, 02
 Aug 2023 01:27:47 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v6 2/8] linux-user: Do not call get_errno() in do_brk()
Date: Wed,  2 Aug 2023 01:27:39 +0200
Message-ID: <20230801232745.4125-3-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801232745.4125-1-deller@gmx.de>
References: <20230801232745.4125-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TmUFxzVccsPk1UUJ2K+MD5sAUSAzgEXo8tLUBGR2FYcGWfFhPK9
 giW/X8ohG8VXEZQzMSTwK/VQpbdX+uwZ9FBLBTGwfdGPgnWeWbJ+LIpM6zclNDCIB0X30rK
 fnPy8ywWu6U34YTTN0oulZoWtIiemJ8Yibw1Yb+RJ8C99tvbhWBFD9FPYZafkA4MsgVJOBa
 ZXtFRjbCCB1n7c9ULFuKA==
UI-OutboundReport: notjunk:1;M01:P0:2CFNa0EdhMA=;rp4y4vDVstcfqiOUZoWJFcA9N/I
 gqBJzdtpRtk5cDCCJQxVlIx3kPgslCixFWPCx1E7OtjhKJTd3NLRiGnDRQCN6KlVU2YWeyMvK
 skyYMKLfdfnpdjQ/bT7IwNjY8Q5G6m5fIbOD2SflvD54k1F9dXUkwGPAxSQc4z4FmBSmeVXax
 Z4LRrlwXCLYQkMWxkfRS5rw/jMAoooyPW4uYnaebjrX8Syrz4B1+VPt1Q/FSWwIkLnwLkBMv8
 aNq2unxHda9HPc5qv4mjythJ7gCIJkBzvNZod7I79yWoSMvPDz6hIXiy6ZM6mrwepi33ey56G
 fFP0An5Wzgeohdv1T0ukyg1eD0yIcz5bo642iBWDQwZBgqf4sAhpJLpuxINPqG0yeExS9Q65J
 rRooX3/k5SAuCcCGDEFm60hhXbeg70myo8QSVx4iP0ol1m75qhDxqcSHlZjQUGtFeJJANhNtA
 gkUO41cg+sQ48L1BJm+ypPzFJTFwGPY4lblnvWSQzELB7hXHrSxH7XKlAniOaQFUb46YivXsa
 BnuiDz7SUF8y0/0g2439JnYWVj8BRluVPZsfdl06i1+xpT1ty+DVGUfV0d+UnpmeZ+r+JC0qo
 JG1O/rHz/rGLKADfhcTbTiF1qLm3PJQOpUIXIUMVOpVMKjQ8utuIt+BUREJXFknKkBxKHyrc+
 47vTafTIDOGFGDdt8KVRBOA1qpled2bNZbVEeDpT2mVLeAq/JZ0oj592+kGQbJwWDmRrYxa+b
 AEk816+FttGxnq0rfHNkqX/yAEobFCROs+zE8hfzOljNPABcXqANk0uyPUpSoAR+z5MFvbG3P
 aLLjSkIbQpsG3dz8GS3s/Jx+ovYII+GIn0dt4Gz5VqhN3CPS9LjXA8fnGXDiP/lyAYqZJvzya
 IxAKjvYaEmm4GbUUVbZ6ijZi3sTYyB/XVuT/poTO3YwzchpKzl1fZMWeyqF7c+CEj4bnDeFLf
 gCGOnuGwVG0r7yaxncT5vdPLqOQ=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Later the returned value is compared with -1, and negated errno is not
expected.

Fixes: 00faf08c95 ("linux-user: Don't use MAP_FIXED in do_brk()")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 95727a816a..b9d2ec02f9 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -862,9 +862,9 @@ abi_long do_brk(abi_ulong brk_val)
      */
     if (new_host_brk_page > brk_page) {
         new_alloc_size =3D new_host_brk_page - brk_page;
-        mapped_addr =3D get_errno(target_mmap(brk_page, new_alloc_size,
-                                        PROT_READ|PROT_WRITE,
-                                        MAP_ANON|MAP_PRIVATE, 0, 0));
+        mapped_addr =3D target_mmap(brk_page, new_alloc_size,
+                                  PROT_READ|PROT_WRITE,
+                                  MAP_ANON|MAP_PRIVATE, 0, 0);
     } else {
         new_alloc_size =3D 0;
         mapped_addr =3D brk_page;
=2D-
2.41.0


