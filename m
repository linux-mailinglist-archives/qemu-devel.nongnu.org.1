Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D22DC7A88F9
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 17:51:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qizTM-00061E-U8; Wed, 20 Sep 2023 11:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qizTH-00060g-Jd
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 11:50:37 -0400
Received: from mail-yw1-x1142.google.com ([2607:f8b0:4864:20::1142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qizTG-0008Mq-4k
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 11:50:35 -0400
Received: by mail-yw1-x1142.google.com with SMTP id
 00721157ae682-59be8a2099bso71257267b3.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695225031; x=1695829831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0yU656d1t/TjZmcxFzpoR2akTkNkjre8EsuhC9IRXfk=;
 b=I+5QOGKW8vZM4lHq9oSqlyfJivQyiwM02MkXvyyhIAUAjqPcdQBLrYyob4zMHGFH+V
 lxUrz2PtYgnrdfmmmg5FRw0n/5KkJ+bAn4i0I4BgLQKkB0AFG/VIrMY5Qx5SjygxpE4C
 a20ZKILGNLPxTzd3rnBZjs80qxaNXcDKAilU0TMT9FPKNV7i4xMXFyiTlzoPfQSNryx1
 0Qh4R4AXpFiVG4n1e1hKLC8G4ZS4TXMZIlZuEZykmreBf610aalysrSOLVoAT8+6lsdq
 DB7gJVR/2NlxEk3Uhrvo2RsfB5uguEUhFucGYxqa/B/LwmGTPVEdqA9Am1OF/pl6ERrr
 m6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695225031; x=1695829831;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0yU656d1t/TjZmcxFzpoR2akTkNkjre8EsuhC9IRXfk=;
 b=iuDbWrgKfD9q1dxTPNgu0XTQQuP1Qt5+TkPvgMAFPgeRkYLQz8O6f4ClxkDx56AnNG
 LIiWVxrbAdGOT8lGT7WZX/gkklUTPzeSGsXDNKTf7Tu63BZAIR54NEOXFHxO6Y62X87R
 MdeQAfgPSExsP/mbYsm8/8zJZoA7VDYcEtThscqv1fVSWHE2Sid4npjyZfUZpl5c5X8E
 sf5jD6iIV0mpmpoh2MzejwOevQWDXZ5zf99owrO6b3B+eJZyueXpXxEEoTIonZ64L/y0
 P1bNOiNmk2FcZiooEkw4uzXs71Chhs6FQ5AVZEy8F5brGRXHp/ChFpVggly1Zwm7Sjxs
 cR4A==
X-Gm-Message-State: AOJu0YwQ8zlcvb9JpVXCln0uRAzEI5BovWm+bEMS+ab8BJaizipSDYrC
 sry5wg6hihWZX233GH21t0qIuCBsN3N+/AA=
X-Google-Smtp-Source: AGHT+IFIPb+1AxCwDMQ89xjXqhUbk85X53zDka8do1dS/5B+V1T/ag0zst8Y6q58ESZbkMqQAn/Nwg==
X-Received: by 2002:a0d:e3c3:0:b0:599:da80:e1e6 with SMTP id
 m186-20020a0de3c3000000b00599da80e1e6mr2668510ywe.34.1695225031262; 
 Wed, 20 Sep 2023 08:50:31 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 l6-20020a819406000000b0057085b18cddsm3861323ywg.54.2023.09.20.08.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 08:50:30 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 Gregory Price <gregory.price@memverge.com>
Subject: [PATCH] cxl/vendor: update niagara to only build on linux,
 add KConfig options
Date: Wed, 20 Sep 2023 11:50:21 -0400
Message-Id: <20230920155020.550112-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1142;
 envelope-from=gourry.memverge@gmail.com; helo=mail-yw1-x1142.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Niagara uses <sys/shm.h> which presently limits its compatibility to
linux hosts.  Change build to only build it on linux.

Add Kconfig file for skhynix directory, and make niagara depend on
CXL_MEM_DEVICE.  Add an explicit flag for niagara.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/cxl/Kconfig                    | 2 ++
 hw/cxl/vendor/Kconfig             | 1 +
 hw/cxl/vendor/skhynix/Kconfig     | 4 ++++
 hw/cxl/vendor/skhynix/meson.build | 4 +++-
 4 files changed, 10 insertions(+), 1 deletion(-)
 create mode 100644 hw/cxl/vendor/Kconfig
 create mode 100644 hw/cxl/vendor/skhynix/Kconfig

diff --git a/hw/cxl/Kconfig b/hw/cxl/Kconfig
index dd6c54b54d..88022008c7 100644
--- a/hw/cxl/Kconfig
+++ b/hw/cxl/Kconfig
@@ -1,3 +1,5 @@
+source vendor/Kconfig
+
 config CXL
     bool
     default y if PCI_EXPRESS
diff --git a/hw/cxl/vendor/Kconfig b/hw/cxl/vendor/Kconfig
new file mode 100644
index 0000000000..aa23bb051b
--- /dev/null
+++ b/hw/cxl/vendor/Kconfig
@@ -0,0 +1 @@
+source skhynix/Kconfig
diff --git a/hw/cxl/vendor/skhynix/Kconfig b/hw/cxl/vendor/skhynix/Kconfig
new file mode 100644
index 0000000000..382fa0cd6c
--- /dev/null
+++ b/hw/cxl/vendor/skhynix/Kconfig
@@ -0,0 +1,4 @@
+config CXL_SKHYNIX_NIAGARA
+    bool
+    depends on CXL_MEM_DEVICE
+    default y if CXL_VENDOR
diff --git a/hw/cxl/vendor/skhynix/meson.build b/hw/cxl/vendor/skhynix/meson.build
index 4e57db65f1..6f194aa517 100644
--- a/hw/cxl/vendor/skhynix/meson.build
+++ b/hw/cxl/vendor/skhynix/meson.build
@@ -1 +1,3 @@
-system_ss.add(when: 'CONFIG_CXL_VENDOR', if_true: files('skhynix_niagara.c',))
+if targetos == 'linux'
+    system_ss.add(when: 'CONFIG_CXL_SKHYNIX_NIAGARA', if_true: files('skhynix_niagara.c',))
+endif
-- 
2.39.1


