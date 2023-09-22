Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFFE7AAABF
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 09:50:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjauM-0007Wl-Oe; Fri, 22 Sep 2023 03:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <estarriol@SSLAB-3090Ti>)
 id 1qjauK-0007WT-SK; Fri, 22 Sep 2023 03:49:00 -0400
Received: from [140.112.90.93] (helo=SSLAB-3090Ti)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <estarriol@SSLAB-3090Ti>)
 id 1qjauE-00082R-MN; Fri, 22 Sep 2023 03:49:00 -0400
Received: from SSLAB-3090Ti (localhost [127.0.0.1])
 by SSLAB-3090Ti (8.15.2/8.15.2/Debian-18) with ESMTP id 38M7dq6Y520002;
 Fri, 22 Sep 2023 15:39:52 +0800
Received: (from estarriol@localhost)
 by SSLAB-3090Ti (8.15.2/8.15.2/Submit) id 38M7dp5C519996;
 Fri, 22 Sep 2023 15:39:51 +0800
From: Jianlin Li <ljianlin99@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, thomas.lendacky@amd.com, dovmurik@linux.ibm.com, 
 Jianlin Li <ljianlin99@gmail.com>
Subject: [PATCH] Update AMD memory encryption document links.
Date: Fri, 22 Sep 2023 15:38:35 +0800
Message-Id: <20230922073834.519945-1-ljianlin99@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 140.112.90.93 (failed)
Received-SPF: none client-ip=140.112.90.93;
 envelope-from=estarriol@SSLAB-3090Ti; helo=SSLAB-3090Ti
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_CUSTOM_MED=0.001,
 FORGED_GMAIL_RCVD=1, FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 FSL_HELO_NON_FQDN_1=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 HELO_NO_DOMAIN=0.178, NML_ADSP_CUSTOM_MED=0.9, RDNS_NONE=0.793, SPF_NONE=0.001,
 SPOOFED_FREEMAIL=0.001, SPOOFED_FREEMAIL_NO_RDNS=0.001,
 SPOOF_GMAIL_MID=0.001 autolearn=no autolearn_force=no
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

The previous links for the white paper and programmer's manual 
are no longer available. Replace them with the new ones.

Signed-off-by: Jianlin Li <ljianlin99@gmail.com>
---
 docs/system/i386/amd-memory-encryption.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/system/i386/amd-memory-encryption.rst b/docs/system/i386/amd-memory-encryption.rst
index dcf4add0e7..e9bc142bc1 100644
--- a/docs/system/i386/amd-memory-encryption.rst
+++ b/docs/system/i386/amd-memory-encryption.rst
@@ -183,13 +183,13 @@ References
 ----------
 
 `AMD Memory Encryption whitepaper
-<https://developer.amd.com/wordpress/media/2013/12/AMD_Memory_Encryption_Whitepaper_v7-Public.pdf>`_
+<https://www.amd.com/content/dam/amd/en/documents/epyc-business-docs/white-papers/memory-encryption-white-paper.pdf>`_
 
 .. [SEVAPI] `Secure Encrypted Virtualization API
    <https://www.amd.com/system/files/TechDocs/55766_SEV-KM_API_Specification.pdf>`_
 
 .. [APMVOL2] `AMD64 Architecture Programmer's Manual Volume 2: System Programming
-   <https://www.amd.com/system/files/TechDocs/24593.pdf>`_
+   <https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf>`_
 
 KVM Forum slides:
 
@@ -199,7 +199,7 @@ KVM Forum slides:
   <https://www.linux-kvm.org/images/9/94/Extending-Secure-Encrypted-Virtualization-with-SEV-ES-Thomas-Lendacky-AMD.pdf>`_
 
 `AMD64 Architecture Programmer's Manual:
-<http://support.amd.com/TechDocs/24593.pdf>`_
+<https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf>`_
 
 * SME is section 7.10
 * SEV is section 15.34
-- 
2.25.1


