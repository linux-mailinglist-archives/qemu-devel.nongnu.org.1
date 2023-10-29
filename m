Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F55E7DAB08
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 07:06:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwyuY-0002HR-RS; Sun, 29 Oct 2023 02:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qwyuW-0002HI-MS
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 02:04:32 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qwyuU-0001qD-5g
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 02:04:32 -0400
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-6b26a3163acso2884113b3a.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 23:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698559468; x=1699164268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G6CiwKwx1WCzxp7aOnqmL9KveZMlFyEgz0ND9shlLnU=;
 b=E+6ia1Cx9mMXF6FI2pgK6kvZVpRFXNbH/Ugz91m7XIPKpoFwHd/NzKo5c31DX+YbPl
 VZT48PenBat0WhQKp/oQ7tS5B2TPPHKXohx0y3jimi/cfcC7aOZJiTyezH+gxX6ywedw
 ybzwvAxfRbpodmnJdODrRFZDy3lZBzFoPoROUq0XFOXxO3MZphF4os6EmRFROCJwlIZP
 dYX7MDQnpAIRTUEoZR4jUVNuKSvjRyzcVL62oi2Mi/mKVJN3244YbF9IVCrEs8sJC+Ar
 auBWwwNitNBiNvKLVwE+wvXOdFJfM7QbgMIL+JLY0O/3ALXZUjJWA7gF3jwECPDbBpdu
 YJ4A==
X-Gm-Message-State: AOJu0Yx07CClTRMh9FmmrM2JzYLIM73pVQTBpWU08N586TSYtSuX2mgz
 T19jPO6xN+RgVbrCvGASzeu+efgR+8bqaQ==
X-Google-Smtp-Source: AGHT+IFg3qvtayH5RP2SFYyj/qQ3x1BbB+V3UJlJ2HsTCoy/KqoWwk6hxie3QEQVk2kMibvzn5LKBQ==
X-Received: by 2002:a17:902:e850:b0:1c9:dd73:dc9e with SMTP id
 t16-20020a170902e85000b001c9dd73dc9emr6635933plg.44.1698559468627; 
 Sat, 28 Oct 2023 23:04:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:642:4c02:6ead:344e:2b1:f5a5:58c6])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a17090341cc00b001b8943b37a5sm4019518ple.24.2023.10.28.23.04.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 28 Oct 2023 23:04:26 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v3 10/14] tests: acpi: prepare for TPM CRB tests
Date: Sat, 28 Oct 2023 23:03:23 -0700
Message-ID: <20231029060404.71196-11-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231029060404.71196-1-j@getutm.app>
References: <20231029060404.71196-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.210.181; envelope-from=osy86dev@gmail.com;
 helo=mail-pf1-f181.google.com
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


