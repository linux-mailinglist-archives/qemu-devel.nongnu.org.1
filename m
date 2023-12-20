Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1359281A3A0
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:04:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFz2I-0002M3-MA; Wed, 20 Dec 2023 11:03:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFz2C-0002HM-Rb
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:03:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFz2B-0001xC-4A
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703088177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bdOCI+oozrQqgeDJFnmFvnIJn7Pgj4NIPHmk6M8LYrQ=;
 b=brpK5GddUuSlRqitVwStp9FvZCANcLRm2F/qubZsjyKYlH4AA9wGwrlgP/AErTup4TmC7h
 2/+2MzEe83Npi+PLRLzTpKDZy2XmK20i576AkagsMHJS5Iml4OQXZpfimi22lQA7f6uVs5
 VgHCQYzoqhPZmJ9fwjly7oYmK6TeTeA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-YKZQknaiOweCZ4eM4NIXew-1; Wed, 20 Dec 2023 11:02:43 -0500
X-MC-Unique: YKZQknaiOweCZ4eM4NIXew-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3D6188F2EE;
 Wed, 20 Dec 2023 16:02:39 +0000 (UTC)
Received: from localhost (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61069C15968;
 Wed, 20 Dec 2023 16:02:39 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [qemu-web PATCH] Add QEMU 8.2.0 release announcement
Date: Wed, 20 Dec 2023 11:02:37 -0500
Message-ID: <20231220160237.843113-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Cc: Michael Roth <michael.roth@amd.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 _posts/2023-12-20-qemu-8-2-0.md | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 _posts/2023-12-20-qemu-8-2-0.md

diff --git a/_posts/2023-12-20-qemu-8-2-0.md b/_posts/2023-12-20-qemu-8-2-0.md
new file mode 100644
index 0000000..c7cdd8b
--- /dev/null
+++ b/_posts/2023-12-20-qemu-8-2-0.md
@@ -0,0 +1,29 @@
+---
+layout: post
+title:  "QEMU version 8.3.0 released"
+date:   2023-12-20 10:00:00 -0600
+categories: [releases, 'qemu 8.2']
+---
+We'd like to announce the availability of the QEMU 8.2.0 release. This release contains 3200+ commits from 231 authors.
+
+You can grab the tarball from our [download page](https://www.qemu.org/download/#source). The full list of changes are available [in the changelog](https://wiki.qemu.org/ChangeLog/8.2).
+
+Highlights include:
+
+ * Arm: New CPU types cortex-a710 and neoverse-n2
+ * RISC-V: KVM AIA Support, Virtual IRQs and IRQ filtering support, and vector cryptographic instruction set support
+ * 68k: The Macintosh Quadra 800 (q800) emulation now can boot MacOS 7.1-8.1, A/UX 3.0.1, NetBSD 9.3, and Linux
+ * HPPA: New HP C3700 machine emulation and 64-bit PA-RISC 2.0 CPU emulation
+ * LoongArch: New CPU type la132 (LoongArch32)
+ * Tricore: New CPU type TC37x (ISA v1.6.2)
+ * New virtio-sound device emulation
+ * New virtio-gpu rutabaga device emulation used by Android emulator
+ * New hv-balloon for dynamic memory protocol device for Hyper-V guests
+ * New Universal Flash Storage device emulation
+ * New Xen PV console and network device emulation
+ * Network Block Device (NBD) 64-bit offsets for improved performance
+ * dump-guest-memory now supports the standard kdump format
+ * and lots more...
+
+Thank you to everybody who contributed to this release, whether that was by writing code, reporting bugs, improving documentation, testing, or providing the project with CI resources. We couldn't do these without you!
+
-- 
2.43.0


