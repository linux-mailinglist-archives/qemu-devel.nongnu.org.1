Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 297CC8313B6
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 09:00:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNFs-0003OT-V3; Thu, 18 Jan 2024 02:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNFc-0003B4-Nq; Thu, 18 Jan 2024 02:55:48 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNFZ-0007sF-N0; Thu, 18 Jan 2024 02:55:47 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 518DE45041;
 Thu, 18 Jan 2024 10:54:36 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7E069661AA;
 Thu, 18 Jan 2024 10:54:06 +0300 (MSK)
Received: (nullmailer pid 2381698 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 23/38] tests/acpi: update expected data files
Date: Thu, 18 Jan 2024 10:52:50 +0300
Message-Id: <20240118075404.2381519-23-mjt@tls.msk.ru>
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

edk2 firmware update caused a address layout change.

 DefinitionBlock ("", "SSDT", 1, "BOCHS ", "NVDIMM", 0x00000001)
 {
     [ ... ]
-    Name (MEMA, 0x43C90000)
+    Name (MEMA, 0x43C80000)
 }

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 55abfc1ffbe54c00529668903fd99b4bb57a6338)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/virt/SSDT.memhp
index 31ff6ac469..fb3dcde5a1 100644
Binary files a/tests/data/acpi/virt/SSDT.memhp and b/tests/data/acpi/virt/SSDT.memhp differ
-- 
2.39.2


