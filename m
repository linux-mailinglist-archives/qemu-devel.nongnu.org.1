Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E263B74E1E2
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:08:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwM-0002M3-Kg; Mon, 10 Jul 2023 19:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwI-0001y5-DS
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvq-0004YI-85
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NyBILryif2hXI0ZSClC5i65ujuUNrZfJQjKYOUdCsOo=;
 b=O2POnCp8AN1OYk3aYyEO2XqXhCHi9vQPNs6wr06J+vMnAOkasDjKMf/Iqy/hGdCtADphUc
 nfZ55drVaPH3HJOxrcUf5PaoYBWlAnnEyonYr1tCgoTvALlHk9C4sPwfNLGU6l6ieGsGNy
 IKpE6bk+Oj22brVY6dC8LgG9BULmS24=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-XvFvdDbZMXSwH_6mQPOXgw-1; Mon, 10 Jul 2023 19:04:36 -0400
X-MC-Unique: XvFvdDbZMXSwH_6mQPOXgw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-315935c808bso908869f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030275; x=1691622275;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NyBILryif2hXI0ZSClC5i65ujuUNrZfJQjKYOUdCsOo=;
 b=LBjFkEpCohn7AkY381YEV6J6iQNK63+6n3TViFZ2jgI2kq7nkq9kfnArfIIzgrC2il
 7PDpJHbUYqVhCPXAteBM6ozbrMrHUSoWwombxzv3RSiHVUKCDN3tWdFq7VVUX/JJhGqV
 I1XOGJzSK2fUd4c+AQv0rQU6eZdrDL0p/s1eEWRbaUlgvKNI6XuvQ0YediHjF/zaZEEM
 tUUKyKrYTE95+KX11WnGV6nJZJbkAG7MSMu/veYbH3Ws3XdF2yNo04u68NFY6GUpYq8a
 uuFk0GK71j/deQ8bNZUlMdnRkPZh1N8mG1/wT1kd7hYYciI2Cg2mZ75AUZnTffEi3mDa
 FFcw==
X-Gm-Message-State: ABy/qLbFJyzcJGRG3YnEXLN+rgTCIsCYkv5095aejFZdr+UpfHZbwDKE
 1Qes6jTg/RWeVqSGZeVtaoeU11YrEuWa4Ye/qh291Ls541+34lx4QYMSl+PT61wceNK4/vTRjXC
 bRLDS0oPYu08z7Q/jWxXiAqoK/Tau8wIorlEL+lPdpIvt9b5hFpGEB6z6Dvwj5kXw4oft
X-Received: by 2002:adf:f286:0:b0:313:e20c:b90b with SMTP id
 k6-20020adff286000000b00313e20cb90bmr12949840wro.26.1689030274910; 
 Mon, 10 Jul 2023 16:04:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEYEFC+NQtx6RB8R6RLT0G5GcVubi64HOJJsuQPCx7Nz43nh7gjDcrIwq++nfytdFVA3ClxBA==
X-Received: by 2002:adf:f286:0:b0:313:e20c:b90b with SMTP id
 k6-20020adff286000000b00313e20cb90bmr12949821wro.26.1689030274581; 
 Mon, 10 Jul 2023 16:04:34 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 p7-20020a5d6387000000b003143801f8d8sm569259wru.103.2023.07.10.16.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:34 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, mst@redhat.com,
 imammedo@redhat.com, Michael Labiuk <michael.labiuk@virtuozzo.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 44/66] tests/qtest/hd-geo-test: fix incorrect pcie-root-port
 usage and simplify test
Message-ID: <579edbd459a53beb7929ee1169dc9675cc329865.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Ani Sinha <anisinha@redhat.com>

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
Message-Id: <20230705115925.5339-5-anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


