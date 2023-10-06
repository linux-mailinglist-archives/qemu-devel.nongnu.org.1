Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 061F47BB2B5
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 09:53:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qofdo-0004qo-Lc; Fri, 06 Oct 2023 03:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qofdm-0004qR-NW
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 03:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qofdl-00085n-9Q
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 03:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696578772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CIvnMsh+FWNPiMCXZ1XSZX0f7f2JNJfRSnryYKR28ls=;
 b=ZRZa77wtfyklgbKQ1ld+h5vZQAJgx3W5Rcr2JxHIUtyX78S089N5BoTNVKbVy4hiUCubR7
 6aDVlndetlVOLFnjGU269Z6zeXRGLI56aRad/mcg2rp9gWQ02M1dSrq4KDJlaMDA8ieKsR
 3Egkl+fPYoRgWqPT5akouiGoD8oJmYw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-ZbjQfZToPhSfmVuP2yE8jA-1; Fri, 06 Oct 2023 03:52:49 -0400
X-MC-Unique: ZbjQfZToPhSfmVuP2yE8jA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B659E80418B
 for <qemu-devel@nongnu.org>; Fri,  6 Oct 2023 07:52:48 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-205.str.redhat.com
 [10.33.192.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2921C40C2015;
 Fri,  6 Oct 2023 07:52:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] docs/about: Mark the old pc-i440fx-2.0 - 2.3 machine types as
 deprecated
Date: Fri,  6 Oct 2023 09:52:47 +0200
Message-ID: <20231006075247.403364-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

As we've seen in the past, it's useful for deprecating old machine
types to finally be able to get of legacy code or do other clean-ups
(see e.g. commit ea985d235b868047 that was used to drop the PCI code in
the 128k bios binaries to free some precious space in those binaries).

So let's continue deprecating the oldest pc machine types. QEMU 2.3
has been released 8 years ago, so that's plenty of time since such
machine types have been used by default, thus deprecating pc-i440fx-2.0
up to pc-i440fx-2.3 should be fine nowadays.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst | 8 ++++++++
 hw/i386/pc_piix.c         | 1 +
 2 files changed, 9 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index e43de9c183..c016bb9b20 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -277,6 +277,14 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
+``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+These old machine types are quite neglected nowadays and thus might have
+various pitfalls with regards to live migration. Use a newer machine type
+instead.
+
+
 Backend options
 ---------------
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ff8654ecda..9789e9e75c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -784,6 +784,7 @@ static void pc_i440fx_2_3_machine_options(MachineClass *m)
 {
     pc_i440fx_2_4_machine_options(m);
     m->hw_version = "2.3.0";
+    m->deprecation_reason = "old and unattended - use a newer version instead";
     compat_props_add(m->compat_props, hw_compat_2_3, hw_compat_2_3_len);
     compat_props_add(m->compat_props, pc_compat_2_3, pc_compat_2_3_len);
 }
-- 
2.41.0


