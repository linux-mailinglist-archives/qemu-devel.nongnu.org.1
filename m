Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A03B273E41E
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:03:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDog8-0006Hu-4V; Mon, 26 Jun 2023 12:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDofi-00060j-HO
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDofg-0007vB-O6
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687795350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/JjxrSNAdYJ3YjEvsqjvOBEVgpy/3FUTtZqyQjsB1ec=;
 b=TakuJsvmCWVuujGcUeSRI97EfftmJEpWT26bc7M6Es9aj4kwgLZ8nXoI5lkd46IZ8TP4+h
 Ebz1kh8VM0cBV1Cslm6TTG+JsgUg7qNgOu7RwUBlKUM1Xz/8eMdD8ff2El+lPB06k5ig/i
 mso3WIPJqtQpeiqBegqdthITicqq0u0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-WKlt7b1eM1eSBQOQIfMefw-1; Mon, 26 Jun 2023 12:02:29 -0400
X-MC-Unique: WKlt7b1eM1eSBQOQIfMefw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-66a4c89bbb1so2986016b3a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 09:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687795343; x=1690387343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/JjxrSNAdYJ3YjEvsqjvOBEVgpy/3FUTtZqyQjsB1ec=;
 b=O6pzbwXQ31VSb8D3DSnZGN45vZkFRDUXC7kSFd9DAenSroD/CzVwqrm4YAJUQI8FqD
 aPzdP2+ioNHb18hi31QendN/IUZGcJQsL5cFX5VB1bnBNp/PtN8sPAEz/1N0mIv27WXX
 ItJeY0uFNt1yjCmVnXQrakxTHVRsPwXNZIPfSLVX3onEUSXMKmndGgbXH1lsuMNaUeL0
 EUf9hMqZq00fXLrZoYyu1PTR30/tWlqAnemNqEQTmmquOaGzvTj2/6ct63srrpRc2H5i
 SbWWbTDzF+OPa44tUVfAKM54cJ1x7OBibYnIRb372Hm5kjcc7yvbSP6bQPK9fcVC3vVd
 ZJtw==
X-Gm-Message-State: AC+VfDyPvARUsoOIIks9hXD94WFwuQwrosB7wGZl3COFgYylOH5atT6S
 Z7kcIyL4F2D/9JflpOKJIxe+ZggRmb0V2dAu/djLLJoA+FBmFGgiA3MUq+XwIdTFwKNE8PwbceU
 lBwhvIAvcmEoKjBsHjEXvGRejm6nKJa7aYfUVUcuZuVZKUJMLhysSwAdoU7y9zVQlvIyVP0b+RU
 I=
X-Received: by 2002:a05:6a00:198f:b0:662:5146:c77a with SMTP id
 d15-20020a056a00198f00b006625146c77amr37709649pfl.31.1687795343073; 
 Mon, 26 Jun 2023 09:02:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ44TB0C+T6L94bFufezwxdpdDAaiD5D9a1NE8wguFxUfSrEdZ9VfDifZuP8L+WuPNay3mNUCA==
X-Received: by 2002:a05:6a00:198f:b0:662:5146:c77a with SMTP id
 d15-20020a056a00198f00b006625146c77amr37709612pfl.31.1687795342641; 
 Mon, 26 Jun 2023 09:02:22 -0700 (PDT)
Received: from localhost.localdomain ([115.96.139.77])
 by smtp.googlemail.com with ESMTPSA id
 l23-20020a62be17000000b0065ebeb9bb23sm4120174pff.149.2023.06.26.09.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 09:02:22 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, mst@redhat.com, imammedo@redhat.com,
 Michael Labiuk <michael.labiuk@virtuozzo.com>
Subject: [PATCH v5 5/5] tests/qtest/hd-geo-test: fix incorrect pcie-root-port
 usage and simplify test
Date: Mon, 26 Jun 2023 21:31:56 +0530
Message-Id: <20230626160156.3938-6-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230626160156.3938-1-anisinha@redhat.com>
References: <20230626160156.3938-1-anisinha@redhat.com>
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
Additionally using pcie.0 as id for pcie-root-port is incorrect as that id is
reserved only for the root bus.

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


