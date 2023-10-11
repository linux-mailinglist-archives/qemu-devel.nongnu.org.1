Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F1C7C51DF
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 13:23:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqXHB-0007RQ-V9; Wed, 11 Oct 2023 07:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qqXH5-0007Qi-08; Wed, 11 Oct 2023 07:21:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qqXH2-0000ee-3b; Wed, 11 Oct 2023 07:21:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3B91029671;
 Wed, 11 Oct 2023 14:21:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9C5222E6F7;
 Wed, 11 Oct 2023 14:20:55 +0300 (MSK)
Received: (nullmailer pid 1032019 invoked by uid 1000);
 Wed, 11 Oct 2023 11:20:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Jianlin Li <ljianlin99@gmail.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 01/13] Update AMD memory encryption document links.
Date: Wed, 11 Oct 2023 14:20:42 +0300
Message-Id: <20231011112054.1031975-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011112054.1031975-1-mjt@tls.msk.ru>
References: <20231011112054.1031975-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jianlin Li <ljianlin99@gmail.com>

The previous links for the white paper and programmer's manual
are no longer available. Replace them with the new ones.

Signed-off-by: Jianlin Li <ljianlin99@gmail.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
2.39.2


