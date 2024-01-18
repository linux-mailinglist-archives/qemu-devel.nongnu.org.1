Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E13A883136F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:57:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNFh-0002yy-MJ; Thu, 18 Jan 2024 02:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNFY-0002iK-3h; Thu, 18 Jan 2024 02:55:44 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNFW-0007qz-54; Thu, 18 Jan 2024 02:55:43 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 42E0745040;
 Thu, 18 Jan 2024 10:54:36 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6F650661A9;
 Thu, 18 Jan 2024 10:54:06 +0300 (MSK)
Received: (nullmailer pid 2381695 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 22/38] edk2: update binaries to git snapshot
Date: Thu, 18 Jan 2024 10:52:49 +0300
Message-Id: <20240118075404.2381519-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Gerd Hoffmann <kraxel@redhat.com>

Resolves: #1990
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 5058720151961d79ef3abdacea94327f2c63951a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/pc-bios/edk2-aarch64-code.fd.bz2 b/pc-bios/edk2-aarch64-code.fd.bz2
index 985e69a66a..fdcf89022a 100644
Binary files a/pc-bios/edk2-aarch64-code.fd.bz2 and b/pc-bios/edk2-aarch64-code.fd.bz2 differ
diff --git a/pc-bios/edk2-arm-code.fd.bz2 b/pc-bios/edk2-arm-code.fd.bz2
index ae797a8c8e..9d829f4f08 100644
Binary files a/pc-bios/edk2-arm-code.fd.bz2 and b/pc-bios/edk2-arm-code.fd.bz2 differ
diff --git a/pc-bios/edk2-i386-code.fd.bz2 b/pc-bios/edk2-i386-code.fd.bz2
index e703c2f954..1a9d392574 100644
Binary files a/pc-bios/edk2-i386-code.fd.bz2 and b/pc-bios/edk2-i386-code.fd.bz2 differ
diff --git a/pc-bios/edk2-i386-secure-code.fd.bz2 b/pc-bios/edk2-i386-secure-code.fd.bz2
index 7230d44615..fab0a77b30 100644
Binary files a/pc-bios/edk2-i386-secure-code.fd.bz2 and b/pc-bios/edk2-i386-secure-code.fd.bz2 differ
diff --git a/pc-bios/edk2-riscv-code.fd.bz2 b/pc-bios/edk2-riscv-code.fd.bz2
index c1cc08561d..6394fbfff3 100644
Binary files a/pc-bios/edk2-riscv-code.fd.bz2 and b/pc-bios/edk2-riscv-code.fd.bz2 differ
diff --git a/pc-bios/edk2-x86_64-code.fd.bz2 b/pc-bios/edk2-x86_64-code.fd.bz2
index 9b7767a3ac..0d325bd483 100644
Binary files a/pc-bios/edk2-x86_64-code.fd.bz2 and b/pc-bios/edk2-x86_64-code.fd.bz2 differ
diff --git a/pc-bios/edk2-x86_64-microvm.fd.bz2 b/pc-bios/edk2-x86_64-microvm.fd.bz2
index 17460dd380..829429082b 100644
Binary files a/pc-bios/edk2-x86_64-microvm.fd.bz2 and b/pc-bios/edk2-x86_64-microvm.fd.bz2 differ
diff --git a/pc-bios/edk2-x86_64-secure-code.fd.bz2 b/pc-bios/edk2-x86_64-secure-code.fd.bz2
index fd0efeacbf..c6b039819c 100644
Binary files a/pc-bios/edk2-x86_64-secure-code.fd.bz2 and b/pc-bios/edk2-x86_64-secure-code.fd.bz2 differ
-- 
2.39.2


