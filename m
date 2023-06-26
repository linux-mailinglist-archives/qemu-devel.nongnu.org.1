Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBA873E0E7
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:43:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlZN-0007sL-Mc; Mon, 26 Jun 2023 08:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDlZG-0007er-So
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDlZD-0006tC-3w
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687783418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQhkOmJ+EuGVRCjI6qvvRWFSS8sApRL0pPI2JdIsZxs=;
 b=VXuYxmspcVHd4/PUVbdyvPsiLfO/VkkbbGokDsxWWBf1bUhF/qswuWEij5Q04Mqf9rp/G3
 GSBAOOSIwd3WUKfFtvHWEJAMQu/AIwC+gI17n1PtCUaNZyG/2J61wwtDW6sVf7mqqwdSyG
 dYu8qaOeyjF19nWIAsbHICI2N+JRx84=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-U1Fz-wJNPauo6w0D6d7wXA-1; Mon, 26 Jun 2023 08:43:37 -0400
X-MC-Unique: U1Fz-wJNPauo6w0D6d7wXA-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1b7dd5bca25so7865235ad.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687783416; x=1690375416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FQhkOmJ+EuGVRCjI6qvvRWFSS8sApRL0pPI2JdIsZxs=;
 b=ZJuN3ue9Evjd7Mib6k0avPMgfM9JrmDqLxHZzI6RnfBKfAzESpJDARmynsuZIzDDEH
 30bKscxpZz/5ni4M3lhEzbI5aQUqnOMp7uRdeNhJQeqTANzwHQi9iBS+pLviIhEJLjDX
 1NT+ndo1uX5Kd2qIlvHaWiXvu8SGn5lg8ZAEVrWIF223v0afmeHqjUNzOL7pHXl90izA
 yd9IWnlu2K1pSLXgvuKJXLN/3xyKztemMmEcfmc7D5BWEOGsJroVZ6vjJDU+QkKaHhGZ
 9UTu88rZDv3tRsc9tTgBqnJ+NDzNMD+MpBRiWm+mWLLSbmxqQSz5VWQhV3zCfqtGXutk
 Modg==
X-Gm-Message-State: AC+VfDziynfBXumF2nIfOzmeB4+XNhxEDKTbdVtPfsXvBPDfmf+R8huZ
 XIwfaS3yH1X0DbTbrQMR9cagm+oCfhtcrYP/4uHeYDrCnHAer5ke47GaadnbXszhil8c+z+G4/L
 XbbsSmpaxWE0lq7steyvIONmq25jz3Wb62Jd/VYMFp/T9Q59Es3yuMo53dKxecyDGe1kn+kugwJ
 M=
X-Received: by 2002:a17:902:daca:b0:1b6:822e:2bd4 with SMTP id
 q10-20020a170902daca00b001b6822e2bd4mr5020254plx.60.1687783415779; 
 Mon, 26 Jun 2023 05:43:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ZfUIAY0irEnXuzelZ9IFC1UL7cOj/zqWZhUpcVhJFbsSyfzWMU1Dw2GySfXw7CpXcoLamhg==
X-Received: by 2002:a17:902:daca:b0:1b6:822e:2bd4 with SMTP id
 q10-20020a170902daca00b001b6822e2bd4mr5020230plx.60.1687783415437; 
 Mon, 26 Jun 2023 05:43:35 -0700 (PDT)
Received: from localhost.localdomain ([115.96.139.77])
 by smtp.googlemail.com with ESMTPSA id
 j22-20020a170902759600b001b3c892c367sm4111671pll.63.2023.06.26.05.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:43:35 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, mst@redhat.com, imammedo@redhat.com,
 Michael Labiuk <michael.labiuk@virtuozzo.com>
Subject: [PATCH v3 4/5] tests/qtest/hd-geo-test: fix test by removing
 unnecessary pcie-root-port
Date: Mon, 26 Jun 2023 18:13:05 +0530
Message-Id: <20230626124306.4572-5-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230626124306.4572-1-anisinha@redhat.com>
References: <20230626124306.4572-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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

The test attaches both a SCSI controller and a pcie-to-pci bridge on the same
pcie-root-port. This is incorrect since only one downstream device can be
attached to a pcie-root-port. Further, in the test scenario, there is no need
to attach a pcie-root-port to the root complex. A SCSI controller can be
attached to a pcie-to-pci bridge which in turn can be directly attached to the
root bus (peie.0). Fix the test and simplify it.

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


