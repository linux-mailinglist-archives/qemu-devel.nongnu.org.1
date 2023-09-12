Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4140A79D04F
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 13:46:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg1m3-0004Iv-HA; Tue, 12 Sep 2023 07:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qg1ln-0004En-Ar
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qg1ll-00034t-Ai
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694518884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yrUQPEYN8rJbR99kkxYC2pbZgTInOQ2zKVQTUfxqgCk=;
 b=CYxwexplXJ9ub2bIMXuFix3bfTnY1ilr3zVAwdU9iQwDv1e/92WoizwjpDHwggnRAJnVD7
 l4hm2f57xC2Ajwsu6pnC47/g0u8cdhvOL+IgN+KhSmfPYBD/aRbfqbj4ksBzFbWSX3+5OT
 51/SfWuymt1OX0UOFvBXy29rgMsKsk0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-0BQXttzNP_uMatmh_J87oQ-1; Tue, 12 Sep 2023 07:41:21 -0400
X-MC-Unique: 0BQXttzNP_uMatmh_J87oQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A331181A6E1;
 Tue, 12 Sep 2023 11:41:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B1F41054FC0;
 Tue, 12 Sep 2023 11:41:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 6/7] kconfig: Add NVME to s390x machines
Date: Tue, 12 Sep 2023 13:41:11 +0200
Message-ID: <20230912114112.296428-7-thuth@redhat.com>
In-Reply-To: <20230912114112.296428-1-thuth@redhat.com>
References: <20230912114112.296428-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Cédric Le Goater <clg@redhat.com>

We recently had issues with nvme devices on big endian platforms.
Include their compilation on s390x to ease tests.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20230828150148.120031-1-clg@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/nvme/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/Kconfig b/hw/nvme/Kconfig
index 8ac90942e5..cfa2ab0f9d 100644
--- a/hw/nvme/Kconfig
+++ b/hw/nvme/Kconfig
@@ -1,4 +1,4 @@
 config NVME_PCI
     bool
-    default y if PCI_DEVICES
+    default y if PCI_DEVICES || PCIE_DEVICES
     depends on PCI
-- 
2.41.0


