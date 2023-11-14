Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B97B37EA893
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 03:10:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2isJ-0001PB-F8; Mon, 13 Nov 2023 21:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2isH-0001Oz-Sm
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 21:09:57 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2isD-0007bV-8W
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 21:09:57 -0500
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-5b8f68ba4e5so3549478a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 18:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699927791; x=1700532591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=145VN8wvl1zAFaa1Qd5kwCb0udgJKqihEQq8C5UE0Po=;
 b=ajx7LVlgnvRxmpid3kLAVEevD0U+PJyZWV0qDY0Gk9dUqHqpbvAmt70F/eBLgm9JnF
 T6HFSHjZ0i16xEqVz8wmD6M0IcghDSJunBeLxrasa42Hsp/bOdQU/37he4GNMZ2mljwV
 SJiDM/RAzWuo+HBeDOXlQc3MVHLXdiPOS63opVkvDtlQZzUETKnzXNbjAEQb3hzq3d9P
 Xt1CI17ZIlKTZRWLBWz9EbG69oujNu7DvzZMuhV1eqvJ6bktKLq4WEYKwC72Mjavhb7d
 x3bOa83HM5Zj/8y8BiPjcO7xv8fcxjnwruVdFFBOizk53HKVzJmtdWNG2Xys9223ppts
 yJXA==
X-Gm-Message-State: AOJu0YxG6GzA+tValxTfVzXp8hhussDFCBi7+30RAOyA9xr8JQGeYRLM
 vWd80QHqfmlDknLoXN6N+uRfsupAPXY1hQ==
X-Google-Smtp-Source: AGHT+IHCeFSGVIU1bDa4P3JL9KftRpbpeHscZGhIWX26DRQHGn/lgxqeH04oUn+5VnktFkZWWH2waw==
X-Received: by 2002:a05:6a20:3c90:b0:186:6dd1:b334 with SMTP id
 b16-20020a056a203c9000b001866dd1b334mr4322385pzj.27.1699927791598; 
 Mon, 13 Nov 2023 18:09:51 -0800 (PST)
Received: from localhost.localdomain ([2601:642:4c01:2f7:5d09:c219:9099:a639])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a17090ae58d00b0027d12b1e29dsm6175362pjz.25.2023.11.13.18.09.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 18:09:50 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v5 10/14] tests: acpi: prepare for TPM CRB tests
Date: Mon, 13 Nov 2023 18:09:20 -0800
Message-ID: <20231114020927.62315-11-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114020927.62315-1-j@getutm.app>
References: <20231114020927.62315-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.179; envelope-from=osy86dev@gmail.com;
 helo=mail-pg1-f179.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Joelle van Dyne <j@getutm.app>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 4 ++++
 tests/data/acpi/q35/DSDT.crb.tpm2           | 0
 tests/data/acpi/q35/TPM2.crb.tpm2           | 0
 tests/data/acpi/virt/DSDT.crb-device.tpm2   | 0
 tests/data/acpi/virt/TPM2.crb-device.tpm2   | 0
 5 files changed, 4 insertions(+)
 create mode 100644 tests/data/acpi/q35/DSDT.crb.tpm2
 create mode 100644 tests/data/acpi/q35/TPM2.crb.tpm2
 create mode 100644 tests/data/acpi/virt/DSDT.crb-device.tpm2
 create mode 100644 tests/data/acpi/virt/TPM2.crb-device.tpm2

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..c2d1924c2f 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,5 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/DSDT.crb.tpm2",
+"tests/data/acpi/q35/TPM2.crb.tpm2",
+"tests/data/acpi/virt/DSDT.crb.tpm2",
+"tests/data/acpi/virt/TPM2.crb.tpm2",
diff --git a/tests/data/acpi/q35/DSDT.crb.tpm2 b/tests/data/acpi/q35/DSDT.crb.tpm2
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/TPM2.crb.tpm2 b/tests/data/acpi/q35/TPM2.crb.tpm2
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/DSDT.crb-device.tpm2 b/tests/data/acpi/virt/DSDT.crb-device.tpm2
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/TPM2.crb-device.tpm2 b/tests/data/acpi/virt/TPM2.crb-device.tpm2
new file mode 100644
index 0000000000..e69de29bb2
-- 
2.41.0


