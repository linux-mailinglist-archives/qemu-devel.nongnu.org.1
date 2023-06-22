Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 458B3739E9B
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 12:35:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCHdV-00030h-NL; Thu, 22 Jun 2023 06:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qCHdT-00030J-Uf
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:33:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qCHdS-00084V-FB
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687430033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pyQyRKdFEQ4EC5eNXAMXjDISjG8P020ZAbI1pYzbLyU=;
 b=SKrqK6locbhejdsBtJ0NhEU0Lfv4661rmHzd183ppoa3TE6K4UsR5Uh/UE4CJDsLjmXk+Q
 OSj2L3PGICvysNSJZ5Yc3ClKiY0gRMK2Ayg8NezvaJDrzE960S5gg5H/xXPiyf+3d6SGl4
 wCdfIc2nY+EQo9qwr/W2AbRau+t4srY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-F48S63UMMZeYThDViVrL6Q-1; Thu, 22 Jun 2023 06:33:52 -0400
X-MC-Unique: F48S63UMMZeYThDViVrL6Q-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-25ea8a43649so5228225a91.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 03:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687430031; x=1690022031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pyQyRKdFEQ4EC5eNXAMXjDISjG8P020ZAbI1pYzbLyU=;
 b=G8lnl44colAfaU+CNt6i0VqQhqUsPIW+IX8OteFUswgyj1e0XtzE+vIm0c4Vfg3T3H
 ploU6w1n1tV5dVA2A+mYdV6VUP7Ox+u/J37Sw1xEADiD65wL8KLNzYjvnkdjIyUTWdR9
 sF4jomktoK6hsidqxp9PKazJXJye54rT3gmyUJdnUOfJYOq2EYZo+vj0A5vCVySEj8cv
 72X2h7RQoOn4ZeS6hhjxRLwE/UOvG3DWmx8yMQlVx/Tszbw7XAIZjUkQ+HmSoJBiCUD+
 cDfL5NvEjFIBOKQaDPm7iQ4CE8F1gVO9sHrNq1zAtuhmvwx7RSD+OoBZVJVPgHfh/J44
 JbNg==
X-Gm-Message-State: AC+VfDxQpLlT9kqCTfaqJxopZYmA3YDmA1CwDh67DDpFbjkbzNYDvEic
 5XV7ctjEUkiKUQNetull6obCfiapioszOAtvbDInle47ItScZooFPLL/bWLHjR3WDB9pS86Q1NY
 B0Zi2UZKKx+rUVu8LiLfoLOTxEGUo++DZ9gOmoEawmAWsXKbud0DqbKRuZFm7RM9oseLxepfHlJ
 c=
X-Received: by 2002:a17:90a:8a82:b0:25b:e0fb:1b22 with SMTP id
 x2-20020a17090a8a8200b0025be0fb1b22mr16273031pjn.33.1687430031236; 
 Thu, 22 Jun 2023 03:33:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5kcdvDVK/YyJT0/DwMlEbVfFN0OYagRWrsx7c2E+nw3aoNuFZ6n3ASMkcq3S9XC826Mxww7Q==
X-Received: by 2002:a17:90a:8a82:b0:25b:e0fb:1b22 with SMTP id
 x2-20020a17090a8a8200b0025be0fb1b22mr16273009pjn.33.1687430030848; 
 Thu, 22 Jun 2023 03:33:50 -0700 (PDT)
Received: from localhost.localdomain ([115.96.105.213])
 by smtp.googlemail.com with ESMTPSA id
 29-20020a17090a035d00b0025eb3b237b4sm11004872pjf.44.2023.06.22.03.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 03:33:50 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, mst@redhat.com, imammedo@redhat.com,
 Michael Labiuk <michael.labiuk@virtuozzo.com>
Subject: [PATCH v2 4/5] tests/qtest/hd-geo-test: fix test by removing
 unnecessary pcie-root-port
Date: Thu, 22 Jun 2023 16:02:54 +0530
Message-Id: <20230622103255.267289-5-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230622103255.267289-1-anisinha@redhat.com>
References: <20230622103255.267289-1-anisinha@redhat.com>
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

A SCSI controller can be attached to a pcie-to-pci bridge which in turn can be
attached directly to the root bus (peie.0). There is no need to attach a
pcie-root-port on the root bus in order to attach the pcie-ro-pci bridge.
Fix it.

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


