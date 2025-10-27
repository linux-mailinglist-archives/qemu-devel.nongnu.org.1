Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE84BC11859
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Oct 2025 22:19:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDUaR-0002Y1-M2; Mon, 27 Oct 2025 17:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vDUZn-0002UR-Sc
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 17:16:32 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vDUZh-0004ze-9Q
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 17:16:27 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 77C8148C41;
 Mon, 27 Oct 2025 21:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B89AC4CEFD;
 Mon, 27 Oct 2025 21:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761599779;
 bh=FND8rsNuJWvVjbyj2hs3c750kvVjLgqtceD6fSGSOco=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Nq83XsozdX0WrJOpYqposnf6vbZbvTVcilEuApVG5yfuUmosXsEW21heeK/Y75sQE
 gGYxoef66CwxdKAwpjI5nrfza+mdiheQgML9zNqCVVSDI+4dZe0T38zGCzHg9PNcYQ
 B11TfzIcsKvyRCttvnE32VFkBL4l5FJKDK7SHHHgGSeRQ8Fp2P5/uHaTTm0Txi//2q
 wqZ/Ox80p6Escfbw56xiWvGEOKdDb6QAwQLWlt0X0URidxOifxlcUqXRcXB4viQFhF
 jeXvQ8t7fcZTQcM+CYpIQQ/N0gFrvtXncAItZkZUhaUv6lltMTpSRO0u7gT+igOlds
 SzBwBpEKP3O0w==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, deller@gmx.de
Subject: [PULL 05/11] hw/scsi: Add config option for new ncr710 driver
Date: Mon, 27 Oct 2025 22:15:57 +0100
Message-ID: <20251027211603.7141-6-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027211603.7141-1-deller@kernel.org>
References: <20251027211603.7141-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

Add config option and wire up in meson makefile.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/scsi/Kconfig     | 5 +++++
 hw/scsi/meson.build | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
index 1feab84c4c..5743ee9b4d 100644
--- a/hw/scsi/Kconfig
+++ b/hw/scsi/Kconfig
@@ -7,6 +7,11 @@ config LSI_SCSI_PCI
     depends on PCI
     select SCSI
 
+config NCR710_SCSI
+    bool
+    default y if LASI
+    select SCSI
+
 config MPTSAS_SCSI_PCI
     bool
     default y if PCI_DEVICES
diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
index bb7d289aa0..b874fe1ecd 100644
--- a/hw/scsi/meson.build
+++ b/hw/scsi/meson.build
@@ -12,6 +12,7 @@ scsi_ss.add(files(
 scsi_ss.add(when: 'CONFIG_ESP', if_true: files('esp.c'))
 scsi_ss.add(when: 'CONFIG_ESP_PCI', if_true: files('esp-pci.c'))
 scsi_ss.add(when: 'CONFIG_LSI_SCSI_PCI', if_true: files('lsi53c895a.c'))
+scsi_ss.add(when: 'CONFIG_NCR710_SCSI', if_true: files('ncr53c710.c', 'lasi_ncr710.c'))
 scsi_ss.add(when: 'CONFIG_MEGASAS_SCSI_PCI', if_true: files('megasas.c'))
 scsi_ss.add(when: 'CONFIG_MPTSAS_SCSI_PCI', if_true: files('mptsas.c', 'mptconfig.c', 'mptendian.c'))
 scsi_ss.add(when: 'CONFIG_VMW_PVSCSI_SCSI_PCI', if_true: files('vmw_pvscsi.c'))
-- 
2.51.0


