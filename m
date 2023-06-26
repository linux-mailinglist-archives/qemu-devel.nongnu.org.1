Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0947873E45F
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:14:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoqY-0007gJ-7C; Mon, 26 Jun 2023 12:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDoqV-0007fd-Ic
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDoqT-0002rh-S2
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687796020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/JjxrSNAdYJ3YjEvsqjvOBEVgpy/3FUTtZqyQjsB1ec=;
 b=FafwDFFa2spmVZFogBVoRhnCHSH+Si6YXOFiMBANLSB5KQYSZQhJfRQQhvFVvnOfs70W58
 o8IvK/bWtJvbm/V25C/Z9iZHfXwk8bSjzYKkxqwr4uMYF464pv5xsDogga7aTgqk/nyQqn
 YJIpUmjm2EbyK6clkfZBVqsHPK4hPKA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-VVKfKLkqPp2EmOOs-03c0g-1; Mon, 26 Jun 2023 12:13:39 -0400
X-MC-Unique: VVKfKLkqPp2EmOOs-03c0g-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6b731ff7d24so2200650a34.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 09:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687796017; x=1690388017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/JjxrSNAdYJ3YjEvsqjvOBEVgpy/3FUTtZqyQjsB1ec=;
 b=lFl5HIVXT87qf213npd/myBtxgx1Gc99GXkQ8fYu7awxhxayvQvoODit6XeoolEzyj
 eJ32jGQHbD10wFRO7MvxYLTG1jniwWqfF5vXYJgF71aWGwIx+yWgXQNwlzu6M0gLYBcB
 6baI3wnNt6vVcO4DEVNpilnh9u4aUG86JNjhsVNRZ2Clw/m0uKOxIU9jJ8KKDlY/oM3D
 bfq/o+e9g66mH/bm4gujxlcwdDpC1PkxhUrTZ+JUNuBcdBtwaSNO87BAIPvkHqoLyNCZ
 UJAdYqaAYjKIznFKizcF1lAAik7JUMrPgNfz/gPzjiXGzxcPRMvn98Md38a6RuFIO2wb
 kM+w==
X-Gm-Message-State: AC+VfDwu0lKsNi/KYbgKkosdJRkYX90m9NsRvTGm3E578rW45K6wFjMK
 4dRnTraoFzEVNdWn8/VeuYtkIKW0XpeV95j3ZV0gTH1TJvuzyqP2cYJrJifMss+ChqaAzC6lYtF
 ARb2wUKnB1PrF5VKpF8Vq/wPG6VRpY++UKg0yEWCNGPjd8lCQw//RWzAPrRCJpEmcHLSRdZZ/cl
 k=
X-Received: by 2002:a05:6830:1348:b0:6b7:2c0e:9a74 with SMTP id
 r8-20020a056830134800b006b72c0e9a74mr10386266otq.13.1687796017740; 
 Mon, 26 Jun 2023 09:13:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6wVXrY50gtv7P6j9D3hRdXyqjVzokUzF7H3jRSoLKecqVher2Z82aHzu6spIZl/IwJnUZGgA==
X-Received: by 2002:a05:6830:1348:b0:6b7:2c0e:9a74 with SMTP id
 r8-20020a056830134800b006b72c0e9a74mr10386243otq.13.1687796017458; 
 Mon, 26 Jun 2023 09:13:37 -0700 (PDT)
Received: from localhost.localdomain ([115.96.139.77])
 by smtp.googlemail.com with ESMTPSA id
 q5-20020a631f45000000b0051b7d83ff22sm4318745pgm.80.2023.06.26.09.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 09:13:37 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, mst@redhat.com, imammedo@redhat.com,
 Michael Labiuk <michael.labiuk@virtuozzo.com>
Subject: [RESEND PATCH v5 4/5] tests/qtest/hd-geo-test: fix incorrect
 pcie-root-port usage and simplify test
Date: Mon, 26 Jun 2023 21:42:43 +0530
Message-Id: <20230626161244.4145-5-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230626161244.4145-1-anisinha@redhat.com>
References: <20230626161244.4145-1-anisinha@redhat.com>
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


