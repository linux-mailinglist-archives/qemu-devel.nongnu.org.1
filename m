Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 023F176C0E1
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 01:30:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQymX-0001XW-0C; Tue, 01 Aug 2023 19:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQymT-0001Jk-He
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:27:57 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQymP-000788-Lo
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690932467; x=1691537267; i=deller@gmx.de;
 bh=682nIaPBgnz2pLAOe9TKVmBAtWcENqYxpj26a83E5nY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rlnQ+OrnJGQDFHgAyrnhw/E/qhvTftkCnbKP5duD4NA6JGu5TfGyQCbmf6BNArRbxfMWeb4
 I2YYVeqOkJQADD2r/cnYj+uKNi9blULwlTj5QKQ80knCKsQXy2xkoIGMhhXqXqCDpLNwnW/Cc
 z50ip8iHBCY4sR2eFgpAbVknhxFKYeJAXhfKcvW/fie5tXBGigShoXMl2FTrZOeQriGiRMO8z
 08BZIqxzMDWM1zr7lUGXu0Ve7JlZ6zSvV80hd4KZYqVA2CRmEHapi9NvC1KKeLOTfRNrMN26/
 gkIHzL+6+nmHnmoLjUXqCUYVnbX2ICQ9Q7Xq6REsB+YuoJ0KAtjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.150.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtOKc-1pZZNd2RYs-00uqI8; Wed, 02
 Aug 2023 01:27:47 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v6 3/8] linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
Date: Wed,  2 Aug 2023 01:27:40 +0200
Message-ID: <20230801232745.4125-4-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801232745.4125-1-deller@gmx.de>
References: <20230801232745.4125-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2zbxf4Mlm/sfRfMCxhUDsMmDMmpgR4UM56FXN4/Xnj4ZbT4C38u
 2ydGFZ2GmTlK3BEdAPI8FOUf70MnDWYhypt2bT7HoovpI9wT+4BeQTE5yharYHzcoVRcwXH
 Meq5RUSwuuSO6SPBSoy7kqORAkULNtBi1mlmSSLLNEFG3tSvoAv1jbYbYOGPTGj30h4VtH8
 WUW81iQPndRcfbsY18JNw==
UI-OutboundReport: notjunk:1;M01:P0:vUQg5kBlA4w=;alQkAbN6aqIx1M49faYAsK8oKVp
 QLf1y3o3V9aMUppmo/vd23t0mW7XlyzmU2cgxUXWrTQCp7ONqSThcYtSPGmYnoKFmhQ/JasDh
 cP7txei3w/CgK1Jz/SxTHsnvd8sTl3ZuFT+Wyi3uWDWfxOMn4mmIakjOTsNMr+ioiN/SfKMRX
 7/p7E+3BAKZFDdHD8yGArTQ+Yf/4XwMHD8d9boLKVrGV3Qvv3aBn0AE33oO6FVgh6X3CT0EKg
 /JRZAFqowvNFrc9Z+FIFnfL9gkjjqVmgvQpsMrJeiSouDoMe0gQ9xAARZxncympNikXo8szq/
 0T6VTT6sa9vqpdtMeNV50CvojPTR+eLqmPqrbb8RXLLJjAiqXTCGuW4KUDAbVc804RF0JSNk2
 reU+H34upvgr/yjfr0WN1YDNozINWscfjY1AcG/SEC8wB36MMbtuswaGidZCtrqwkqtBI53M9
 bk3ge1D8Ci+WQvIzI+hlNYSQackZa9gx/hthZfLf+UKZ6rXEVm7Fi1CU8CLLAtwBQ/6qtiTTs
 eGEqh+LHUoPnSx67bDZnJ7+WAmgpwLfl2HzTU2H7gnBqscw9bI/XpemDdj91H1zH/3JYy3NAT
 Em4o1tWjkOvHDJg9Qu4NY8jqV7Ya5mLrBCIzJPMKVEbmuFnXXc2qo1FGDr5eKOP4T2J2p0BQl
 VBLsDM/QBsBTigyHeWtjkYGtAjOcAa72o1DwrwKSImJyH+mI9k5Xrs/HRAfu+buU/fyHb8/aC
 YT91PGw2DBd+tbC+XiszHbHvakfNraVJe71pMZ74lCrKdqNbTqsmikm1GdANQkyXGBy5yznMi
 eCPzA9vkUN7S081mlYmYtG3D292FQnYsPJ+B7buWOqmUVxsp720PLvPv3a1DyLB14JwE/oU27
 imfvLW8iTqkgGdpgICURAwRKzmMGH7r631qHHxl4GHuFHutHsw67zf0Idzq4WhTyFqTqRAycb
 d1UoQT6h/N+Gx/WZ3reDXyqoT1Q=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

MAP_FIXED_NOREPLACE can ensure the mapped address is fixed without
concerning that the new mapping overwrites something else.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/syscall.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b9d2ec02f9..ac429a185a 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -854,17 +854,12 @@ abi_long do_brk(abi_ulong brk_val)
         return target_brk;
     }

-    /* We need to allocate more memory after the brk... Note that
-     * we don't use MAP_FIXED because that will map over the top of
-     * any existing mapping (like the one with the host libc or qemu
-     * itself); instead we treat "mapped but at wrong address" as
-     * a failure and unmap again.
-     */
     if (new_host_brk_page > brk_page) {
         new_alloc_size =3D new_host_brk_page - brk_page;
         mapped_addr =3D target_mmap(brk_page, new_alloc_size,
-                                  PROT_READ|PROT_WRITE,
-                                  MAP_ANON|MAP_PRIVATE, 0, 0);
+                                  PROT_READ | PROT_WRITE,
+                                  MAP_FIXED_NOREPLACE | MAP_ANON | MAP_PR=
IVATE,
+                                  0, 0);
     } else {
         new_alloc_size =3D 0;
         mapped_addr =3D brk_page;
@@ -883,12 +878,6 @@ abi_long do_brk(abi_ulong brk_val)
         target_brk =3D brk_val;
         brk_page =3D new_host_brk_page;
         return target_brk;
-    } else if (mapped_addr !=3D -1) {
-        /* Mapped but at wrong address, meaning there wasn't actually
-         * enough space for this brk.
-         */
-        target_munmap(mapped_addr, new_alloc_size);
-        mapped_addr =3D -1;
     }

 #if defined(TARGET_ALPHA)
=2D-
2.41.0


