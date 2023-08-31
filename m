Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9E278EF71
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 16:17:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbiTk-0005W5-Sd; Thu, 31 Aug 2023 10:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fvogt@suse.de>) id 1qbd9m-0007hd-6D
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:36:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fvogt@suse.de>) id 1qbd9k-00022K-0Y
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:36:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B1D65216DC;
 Thu, 31 Aug 2023 08:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693470958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r2fGW7Cah87CYFIZohPL4zxnbtjc2VTh1Xlfvid0CNs=;
 b=EqoDr2FJ1NdCJTMnh86ClexjO0rB1qqp+yqvQCl03aD2jN7u2T8Dr/I+taZAmOw4HwoDTh
 KsS+RrjsHBG0nMUjcGGtlFuu/Q8nFMvGDMYjuzFPDdj+4aOhKMo6w+DU+OIthSXMlyZYXZ
 wf2WQ03QAAV2jhI3D0oZbX8ZHmo8k94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693470958;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r2fGW7Cah87CYFIZohPL4zxnbtjc2VTh1Xlfvid0CNs=;
 b=ciu6AibKrTd0z+rcZaeIUgxz4Cb90LutBWVEi6GGWxpv9SjHbAv/Mhzx+VNfHo+ubGu+1D
 UoIC+YFlghINulDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A62CD13583;
 Thu, 31 Aug 2023 08:35:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Oc9FKO5Q8GRzegAAMHmgww
 (envelope-from <fvogt@suse.de>); Thu, 31 Aug 2023 08:35:58 +0000
From: Fabian Vogt <fvogt@suse.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, Gabriel Somlo <somlo@cmu.edu>
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] firmware: qemu_fw_cfg: Do not hard depend on
 CONFIG_HAS_IOPORT_MAP
Date: Thu, 31 Aug 2023 10:35:58 +0200
Message-ID: <2294036.ElGaqSPkdT@linux-e202.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=195.135.220.28; envelope-from=fvogt@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 31 Aug 2023 10:16:57 -0400
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

Some platforms require CONFIG_NO_IOPORT_MAP=y but would also support
qemu_fw_cfg over MMIO. Currently the qemu_fw_cfg module can't be built for
those as it needs HAS_IOPORT_MAP=y for ioport remapping.

This patch allows to build the qemu_fw_cfg in those cases. If
CONFIG_HAS_IOPORT_MAP=n, qemu_fw_cfg is built without support for ioport
based access.

Signed-off-by: Fabian Vogt <fvogt@suse.de>
---
Applies on top of 6c1b980a7e79.
Resent because the first time I somehow lost the "[PATCH]" prefix.

 drivers/firmware/Kconfig       | 1 -
 drivers/firmware/qemu_fw_cfg.c | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e3041fd62..f8aad7de8c72 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -156,7 +156,6 @@ config RASPBERRYPI_FIRMWARE
 config FW_CFG_SYSFS
 	tristate "QEMU fw_cfg device support in sysfs"
 	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || SPARC || X86)
-	depends on HAS_IOPORT_MAP
 	default n
 	help
 	  Say Y or M here to enable the exporting of the QEMU firmware
diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index a69399a6b7c0..1d60ac74a403 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -258,6 +258,7 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
 			return -EFAULT;
 		}
 	} else {
+#ifdef CONFIG_HAS_IOPORT_MAP
 		if (!request_region(fw_cfg_p_base,
 				    fw_cfg_p_size, "fw_cfg_io"))
 			return -EBUSY;
@@ -266,6 +267,10 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
 			release_region(fw_cfg_p_base, fw_cfg_p_size);
 			return -EFAULT;
 		}
+#else
+		dev_err(&pdev->dev, "IO region given but CONFIG_HAS_IOPORT_MAP=n");
+		return -EINVAL;
+#endif
 	}
 
 	/* were custom register offsets provided (e.g. on the command line)? */
-- 
2.41.0



