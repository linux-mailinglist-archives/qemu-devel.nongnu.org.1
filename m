Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA26B7483AC
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 14:01:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH1Be-0006wP-Qz; Wed, 05 Jul 2023 08:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qH1BF-0006c6-Gx
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 08:00:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qH1BD-0001Nx-Re
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 08:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688558419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uCCjtwSbbFETTKSsmt5af6YgxkBnyGQ+Ywb1vZBrF3g=;
 b=FtML/0+Jqrlw45Ie0B0fPwQHb82833E+rGQn0423mcGjKuBG/pF3cTWVW2hsZOgSIcIPKq
 4nj340+Q5BAZT0KMSUCom/TqPPfjAej/H76inotX9zOf/74UyZWWrNJa4KtafvJgo2eUuN
 br5X9Wfhie6kEaiXZ9hdNXeA0eq6fMs=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-v1i_HbBiP127zbvP0iCYwA-1; Wed, 05 Jul 2023 08:00:07 -0400
X-MC-Unique: v1i_HbBiP127zbvP0iCYwA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-55b9ed8275aso3142642a12.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 04:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688558385; x=1691150385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uCCjtwSbbFETTKSsmt5af6YgxkBnyGQ+Ywb1vZBrF3g=;
 b=KRg/gz73VxX8Tvoyv05JYHsnTd5C5T7Tk3laDmqQ9PIbl//5XfNMPhIcODPqpAeJKr
 85mnuTE7LZrpzm5WaA3cGcm/u5Ll/D/2wKMv0HLT35XfZsyUGwwMBPd8GXpvlJwGDfhQ
 aYdH5s/Zbu3MibNHnREHiFIx9H/4QSKoGMP4DTgGSlg9M6jYiUAZ4Ei4e9Qv1FY6ahVE
 HiKkdoGVYbjgTaqzFaz1vKemK8BNb8Tv8B/Yj47gmGJMqSdjde9+ss4IGsdH9v23yjPZ
 JekPOeULLTPNGsb/3uIyAM/ahFcBJZrFKl30ix1dvLZk039G3nNfz93EPHR6QqkD+leK
 AWrw==
X-Gm-Message-State: ABy/qLZd4if+jC/igRcWaDvwgOZwwZLCWm+807KP/oeD9boxb42ZAYo7
 +GWoExo+6ZEFKLzT3Oc6bL0i+aAFjG5e0ScXSBsB4IMFTIzQxjncSmGgmuk9WsO8Gs45MnpAydM
 pSV0ootrfuLOw6rPjEkkZpj3WY+84P1Xzouc9dlokC09YoryovGzy0d6FUK5O8IF0XRIak0OKAr
 4=
X-Received: by 2002:a05:6a20:a5a8:b0:12e:ab62:c94 with SMTP id
 bc40-20020a056a20a5a800b0012eab620c94mr5211697pzb.49.1688558385465; 
 Wed, 05 Jul 2023 04:59:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE/ZStnEwHOscSISZVvl414hGCzJ5pQ2nVe/+3BpMLf8vvZ1l+QCX0VqsQO6m87exoCgsVPVQ==
X-Received: by 2002:a05:6a20:a5a8:b0:12e:ab62:c94 with SMTP id
 bc40-20020a056a20a5a800b0012eab620c94mr5211681pzb.49.1688558385017; 
 Wed, 05 Jul 2023 04:59:45 -0700 (PDT)
Received: from localhost.localdomain ([115.96.119.220])
 by smtp.googlemail.com with ESMTPSA id
 v3-20020a1709028d8300b001b89c313185sm4878852plo.205.2023.07.05.04.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 04:59:44 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, mst@redhat.com, imammedo@redhat.com,
 Michael Labiuk <michael.labiuk@virtuozzo.com>
Subject: [PATCH v8 4/6] tests/qtest/hd-geo-test: fix incorrect pcie-root-port
 usage and simplify test
Date: Wed,  5 Jul 2023 17:29:22 +0530
Message-Id: <20230705115925.5339-5-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230705115925.5339-1-anisinha@redhat.com>
References: <20230705115925.5339-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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


