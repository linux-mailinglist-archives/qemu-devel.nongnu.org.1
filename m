Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 264A582BF73
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:48:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFzx-0002Uv-Fn; Fri, 12 Jan 2024 06:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1rOFzb-0002TC-Gg
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:46:34 -0500
Received: from mail.astralinux.ru ([217.74.38.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1rOFzU-0004KT-W2
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:46:28 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id F178F1869532;
 Fri, 12 Jan 2024 14:46:08 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id CdbKAxwHYBS7; Fri, 12 Jan 2024 14:46:08 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id A0A901869531;
 Fri, 12 Jan 2024 14:46:08 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id QSdq7Nq6ESlU; Fri, 12 Jan 2024 14:46:08 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (wifi.cs.msu.ru [188.44.42.48])
 by mail.astralinux.ru (Postfix) with ESMTPSA id 1640B1869530;
 Fri, 12 Jan 2024 14:46:07 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: qemu-devel@nongnu.org
Cc: Anastasia Belova <abelova@astralinux.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, sdl.qemu@linuxtesting.org
Subject: [PATCH v2] load_elf: fix iterators' types for elf file processing
Date: Fri, 12 Jan 2024 14:45:27 +0300
Message-Id: <20240112114527.7911-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAFEAcA9DU7aZjzWc+fnMw14JupM6ff1=ChxaX3+kfGt3LBrP5Q@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=217.74.38.119; envelope-from=abelova@astralinux.ru;
 helo=mail.astralinux.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

i and size should be the same type as ehdr.e_phnum (Elf32_Half or
Elf64_Half) to avoid overflows. So the bigger one is chosen.

j should be the same type as file_size for the same reasons.

This commit fixes a minor bug, maybe even a typo.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 7ef295ea5b ("loader: Add data swap option to load-elf")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 include/hw/elf_ops.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index 0a5c258fe6..6e807708f3 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -325,7 +325,7 @@ static ssize_t glue(load_elf, SZ)(const char *name, i=
nt fd,
 {
     struct elfhdr ehdr;
     struct elf_phdr *phdr =3D NULL, *ph;
-    int size, i;
+    Elf64_Half size, i;
     ssize_t total_size;
     elf_word mem_size, file_size, data_offset;
     uint64_t addr, low =3D (uint64_t)-1, high =3D 0;
@@ -464,7 +464,7 @@ static ssize_t glue(load_elf, SZ)(const char *name, i=
nt fd,
                  * the ROM overlap check in loader.c, so we don't try to
                  * explicitly detect those here.
                  */
-                int j;
+                Elf64_Half j;
                 elf_word zero_start =3D ph->p_paddr + file_size;
                 elf_word zero_end =3D ph->p_paddr + mem_size;
=20
@@ -500,7 +500,7 @@ static ssize_t glue(load_elf, SZ)(const char *name, i=
nt fd,
             }
=20
             if (data_swab) {
-                int j;
+                elf_word j;
                 for (j =3D 0; j < file_size; j +=3D (1 << data_swab)) {
                     uint8_t *dp =3D data + j;
                     switch (data_swab) {
--=20
2.30.2


