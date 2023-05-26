Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E22A713046
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 01:16:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2gfL-0004di-KT; Fri, 26 May 2023 19:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q2gfJ-0004cR-C8
 for qemu-devel@nongnu.org; Fri, 26 May 2023 19:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q2gfH-0007yr-Mo
 for qemu-devel@nongnu.org; Fri, 26 May 2023 19:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685142966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RYrP0o+CAqP3kVFMwvnEaTCaiiKfYNj8nTDnmx99pDo=;
 b=LJ3tIRghVTGtGSbknXYW2dEDkARv4jI3HvPsfK9z7FL7jiZQzXIi+aIG8l0PldbslC0o1+
 rb2pF/naqASTRn0o4LDN5lQIVP6rcjsbrhkncLCjwDnjQSgzQayvphQ5Jynd9izXlZpU1b
 mfAiIEgZA2oxH/gOVBoQQxFwBZLJlQI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-658i01JjMOCa8covHj8yEQ-1; Fri, 26 May 2023 19:16:05 -0400
X-MC-Unique: 658i01JjMOCa8covHj8yEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AB1C8002BF;
 Fri, 26 May 2023 23:16:05 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.10.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B51F740C1438;
 Fri, 26 May 2023 23:16:04 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: robin@streamhpc.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 clg@redhat.com
Subject: [RFC PATCH v2 1/4] linux-headers: Update for vfio capability
 reporting AtomicOps
Date: Fri, 26 May 2023 17:15:55 -0600
Message-Id: <20230526231558.1660396-2-alex.williamson@redhat.com>
In-Reply-To: <20230526231558.1660396-1-alex.williamson@redhat.com>
References: <20230526231558.1660396-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is a partial linux-headers update for illustrative and testing
purposes only, NOT FOR COMMIT.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 linux-headers/linux/vfio.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 4a534edbdcba..443a8851e156 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -240,6 +240,20 @@ struct vfio_device_info {
 #define VFIO_DEVICE_INFO_CAP_ZPCI_UTIL		3
 #define VFIO_DEVICE_INFO_CAP_ZPCI_PFIP		4
 
+/*
+ * The following VFIO_DEVICE_INFO capability reports support for PCIe AtomicOp
+ * completion to the root bus with supported widths provided via flags.
+ */
+#define VFIO_DEVICE_INFO_CAP_PCI_ATOMIC_COMP	5
+struct vfio_device_info_cap_pci_atomic_comp {
+	struct vfio_info_cap_header header;
+	__u32 flags;
+#define VFIO_PCI_ATOMIC_COMP32	(1 << 0)
+#define VFIO_PCI_ATOMIC_COMP64	(1 << 1)
+#define VFIO_PCI_ATOMIC_COMP128	(1 << 2)
+	__u32 reserved;
+};
+
 /**
  * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
  *				       struct vfio_region_info)
-- 
2.39.2


