Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE80741F2A
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 06:10:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEixI-0004Ia-Jt; Thu, 29 Jun 2023 00:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEixD-0004Hb-VV
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 00:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEixC-00018K-8c
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 00:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688011698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8E3L/eh8xTMWqqFxd2K3iGDv+eq82X+mKSmU3uQ/MtY=;
 b=L4cpDAXrGTqCBYiE6l9b/fMzH4hjJCvuXHLc3q6OGGvTntoHL+8JdemzQ4jGBRA6+ChPzd
 qQl8ldWtStntzDixEjXXbPRLPZVBPvE3HbTjeS6gquVCCZlkY/cLtJcZ8H3LcXReI8dbvR
 AnqPKJl8ZjdzZ22dhh0Bs0xhwd8SBHo=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-sfCyeaEENTip4ggMTwu_1w-1; Thu, 29 Jun 2023 00:08:16 -0400
X-MC-Unique: sfCyeaEENTip4ggMTwu_1w-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-1b016818400so384215fac.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 21:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688011695; x=1690603695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8E3L/eh8xTMWqqFxd2K3iGDv+eq82X+mKSmU3uQ/MtY=;
 b=aY4U+QZULx8pOZC1dK7amTWbvtnAA0LJ0ePWkQIoqNSKQhDvPjxw0V+5ffScraJUCv
 J0X3NWOcjQn8xq3A+PpfB9iKuyBPuiph6ewC6WDVPO40wDGyMlJdG6N1PfbY7su0L9ma
 BeCvApxhIvnOxAQMQFmCPGS2DXFM5SuOY3WbhIl5Ni03Lwv/i2iQlFwcA5AZECPqyDf0
 D4en5yLb6wUJllWZkDP+xdrpRSNJ3ZD6kpO4nFjdyp3P0zJpXNYZgWr26hwPtcFqm7o9
 xhkp0NHyuVuK5QGwwBPZQvkgLRMIfxSXE1oUwYHQ4Fp14qnWGS8YEpizm6kne6QByGY1
 YyHA==
X-Gm-Message-State: AC+VfDzBQ4ctCLm3Dg+7KB9Lo3DOvCaTiTqffaA+PznKH5mLratuHeAj
 +b3+6Xg9ZsI9Mw6N7XVYnnbRWnsT0fJmz9tQvEyCPI5hrbq8X7B7m3JS1P9ItbUFr+Dvj218SUV
 c2kptCjBFLVTxK796TF04F/2FGHAEiu95004zBbGzEVzCSYNaSKx9SeEFJH72qOyRlhPkFW2BD9
 E=
X-Received: by 2002:a05:6870:c155:b0:1b0:89fb:9e77 with SMTP id
 g21-20020a056870c15500b001b089fb9e77mr2843584oad.35.1688011695292; 
 Wed, 28 Jun 2023 21:08:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6h1jcZbyztsCfZOqZC0QC/Oy1APsfvxMmkiQuAHZY12aYjToAoacsNNEEtt+qcr+1tI2ePxg==
X-Received: by 2002:a05:6870:c155:b0:1b0:89fb:9e77 with SMTP id
 g21-20020a056870c15500b001b089fb9e77mr2843566oad.35.1688011694980; 
 Wed, 28 Jun 2023 21:08:14 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.183])
 by smtp.googlemail.com with ESMTPSA id
 21-20020a17090a019500b00256b67208b1sm10978169pjc.56.2023.06.28.21.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 21:08:14 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, mst@redhat.com, imammedo@redhat.com,
 Michael Labiuk <michael.labiuk@virtuozzo.com>
Subject: [PATCH v6 4/5] tests/qtest/hd-geo-test: fix incorrect pcie-root-port
 usage and simplify test
Date: Thu, 29 Jun 2023 09:37:06 +0530
Message-Id: <20230629040707.115656-5-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230629040707.115656-1-anisinha@redhat.com>
References: <20230629040707.115656-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The test attaches a SCSI controller to a non-zero slot and a pcie-to-pci bridge
on slot 0 on the same pcie-root-port. Since a downstream device can be attached
to a pcie-root-port only on slot 0, the above test configuration is not allowed.
Additionally using pcie.0 as id for pcie-to-pci bridge is incorrect as that id
is reserved only for the root bus.

In the test scenario, there is no need to attach a pcie-root-port to the
root complex. A SCSI controller can be attached to a pcie-to-pci bridge
which can then be directly attached to the root bus (pcie.0).

Fix the test and simplify it.

CC: mst@redhat.com
CC: imammedo@redhat.com
CC: Michael Labiuk <michael.labiuk@virtuozzo.com>

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/hd-geo-test.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
index 5aa258a2b3..d08bffad91 100644
--- a/tests/qtest/hd-geo-test.c
+++ b/tests/qtest/hd-geo-test.c
@@ -784,14 +784,12 @@ static void test_override_scsi(void)
     test_override(args, "pc", expected);
 }
 
-static void setup_pci_bridge(TestArgs *args, const char *id, const char *rootid)
+static void setup_pci_bridge(TestArgs *args, const char *id)
 {
 
-    char *root, *br;
-    root = g_strdup_printf("-device pcie-root-port,id=%s", rootid);
-    br = g_strdup_printf("-device pcie-pci-bridge,bus=%s,id=%s", rootid, id);
+    char *br;
+    br = g_strdup_printf("-device pcie-pci-bridge,bus=pcie.0,id=%s", id);
 
-    args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, root);
     args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, br);
 }
 
@@ -811,8 +809,8 @@ static void test_override_scsi_q35(void)
     add_drive_with_mbr(args, empty_mbr, 1);
     add_drive_with_mbr(args, empty_mbr, 1);
     add_drive_with_mbr(args, empty_mbr, 1);
-    setup_pci_bridge(args, "pcie.0", "br");
-    add_scsi_controller(args, "lsi53c895a", "br", 3);
+    setup_pci_bridge(args, "pcie-pci-br");
+    add_scsi_controller(args, "lsi53c895a", "pcie-pci-br", 3);
     add_scsi_disk(args, 0, 0, 0, 0, 0, 10000, 120, 30);
     add_scsi_disk(args, 1, 0, 0, 1, 0, 9000, 120, 30);
     add_scsi_disk(args, 2, 0, 0, 2, 0, 1, 0, 0);
@@ -868,9 +866,9 @@ static void test_override_virtio_blk_q35(void)
     };
     add_drive_with_mbr(args, empty_mbr, 1);
     add_drive_with_mbr(args, empty_mbr, 1);
-    setup_pci_bridge(args, "pcie.0", "br");
-    add_virtio_disk(args, 0, "br", 3, 10000, 120, 30);
-    add_virtio_disk(args, 1, "br", 4, 9000, 120, 30);
+    setup_pci_bridge(args, "pcie-pci-br");
+    add_virtio_disk(args, 0, "pcie-pci-br", 3, 10000, 120, 30);
+    add_virtio_disk(args, 1, "pcie-pci-br", 4, 9000, 120, 30);
     test_override(args, "q35", expected);
 }
 
-- 
2.39.1


