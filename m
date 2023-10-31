Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 015BA7DC520
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 05:03:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxfw0-0001OV-DH; Tue, 31 Oct 2023 00:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfvo-0001LV-DW
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:00:46 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfvm-0005GU-OX
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:00:44 -0400
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-1c9b95943beso47482875ad.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 21:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698724841; x=1699329641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=145VN8wvl1zAFaa1Qd5kwCb0udgJKqihEQq8C5UE0Po=;
 b=eDyVP95frzm0iFDdDr0RrMuyUg4WonT9jPQCjjmwLPiajaIU/TyBKt9Xo6/xuBL5i3
 n01KByooFHug12iCjkQ+2t0MMW8zcG0487FlsHoG8HCcKMmLgsNqMeAcXtD8WwshFRBi
 4GFSKqxSu5HjXtG+r/wnJ0dT23rpJHAtH/AkbPKH6p8NgsK7a6bojkV7/FTBd05MhXBu
 AWKm+hDt7MpIQ707Lp+p+La+dokSZuz/Jt8j1y0bhPSYn9ginnknXw0orcF/higtoDJN
 88lM67qmKBamqg8WfjMAa+KMwFMKN170FfxRX14JGH/wmPEt8e0QiTzr1qA58uOT9an3
 VpbA==
X-Gm-Message-State: AOJu0Yw5MVEBV2w5y6/N+9KT5HwNarLpTnen3ONxkMl+K8P4aTgvtnkk
 OKV6mIDizWVM+Lb3SSzx8yvlqGbWjYtclQ==
X-Google-Smtp-Source: AGHT+IEMKPLsqKSSSiYp+yjWHCb46de6lknjTNTaEkzHHNj20hKlzExDVEnjYNGRFE7Nk7/hOGjMng==
X-Received: by 2002:a17:903:2342:b0:1cc:4cf7:2cd with SMTP id
 c2-20020a170903234200b001cc4cf702cdmr5614119plh.33.1698724841313; 
 Mon, 30 Oct 2023 21:00:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:642:4c02:7b37:49a8:6e6e:cee6:cee7])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a170902f54400b001bbfa86ca3bsm257975plf.78.2023.10.30.21.00.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Oct 2023 21:00:41 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 10/14] tests: acpi: prepare for TPM CRB tests
Date: Mon, 30 Oct 2023 21:00:13 -0700
Message-ID: <20231031040021.65582-11-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031040021.65582-1-j@getutm.app>
References: <20231031040021.65582-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.174; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f174.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


