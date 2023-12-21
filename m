Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9106781B006
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 09:10:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGE7r-0001O2-UM; Thu, 21 Dec 2023 03:09:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1rGE7p-0001IS-Bc
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:09:49 -0500
Received: from mail.astralinux.ru ([217.74.38.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1rGE7m-00045D-Th
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:09:49 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id F31AF186440E;
 Thu, 21 Dec 2023 11:09:35 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id H7N_mgzhZ9Gi; Thu, 21 Dec 2023 11:09:35 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id A4B791863365;
 Thu, 21 Dec 2023 11:09:35 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id ZaRDx6vGNa5z; Thu, 21 Dec 2023 11:09:35 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.25])
 by mail.astralinux.ru (Postfix) with ESMTPSA id 4BAC5186330D;
 Thu, 21 Dec 2023 11:09:35 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: qemu-devel@nongnu.org
Cc: Anastasia Belova <abelova@astralinux.ru>,
	sdl.qemu@linuxtesting.org
Subject: [PATCH] load_elf: fix iterator type in glue
Date: Thu, 21 Dec 2023 11:08:58 +0300
Message-Id: <20231221080858.12876-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
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

file_size is uint32_t, so j < file_size should be
uint32_t too.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 7ef295ea5b ("loader: Add data swap option to load-elf")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 include/hw/elf_ops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index 0a5c258fe6..1defccaa71 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -500,7 +500,7 @@ static ssize_t glue(load_elf, SZ)(const char *name, i=
nt fd,
             }
=20
             if (data_swab) {
-                int j;
+                uint32_t j;
                 for (j =3D 0; j < file_size; j +=3D (1 << data_swab)) {
                     uint8_t *dp =3D data + j;
                     switch (data_swab) {
--=20
2.30.2


