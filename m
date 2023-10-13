Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 071ED7C80D5
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqZ-0000kP-Tj; Fri, 13 Oct 2023 04:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqI-0008NO-A3
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:22 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqG-00012d-GH
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:22 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-406618d080eso19647945e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186899; x=1697791699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bii0rHRSdZ2Rl+GPf0Y8R9WktLp/w9/VC7JeiOohbU8=;
 b=peIfjyntfCrqbrQGG0fT5hz062kSObeEg6A6aewQbPU4yUClnRqAV4QIMlS3Sp1glX
 cwXangKjWqWquebbbC7nfSJXd7+HIKidFBtkbYTqQDZcKKNEbCYeD1+FH4eI4Ze1mjr7
 krJAgkKXvkEyOmhm038089HsPdzVLY/KQ+VlsKxaYClURxTerYwo2hewcDf8LGVoGH/V
 MXoHN+oALUvwSwLWQ1UppCMeDIhIqzKx39R5/zletMQathwnIDnxJEp8qoc16PRxbo3t
 hL5EJ9wMZcimL0cF6dso7TNVbMYWHBKkMwaRHvfpfpp64OHHa4nJ97nS5IeCqyUCvhw6
 Mz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186899; x=1697791699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bii0rHRSdZ2Rl+GPf0Y8R9WktLp/w9/VC7JeiOohbU8=;
 b=eaT1c44bPt4wbwo7/ymNDc/XYg8TyfyPBKjbGW5J0V1yTu8NC0arUmhS1ZxgFz47l+
 OHVg+mkzxrcfYujb+MtCTGuJSA9pplhofdEReAlXLhzozE27HVME+L1Hxbb5hgol5nzW
 N2zF9O4mQC2cjQJyRFgozRyUsGTLo9r4FYj/XQoL2/YDIA6T3KCYd0ET0GaGZ0m1SGgP
 TSvsKvUPJ37GcmTnS2VJbPfLYncqD8XYS95KeHcgq36FxsMDCzxwsvtK2lP6L2RE1Jb0
 cDKFxvekHN1I20q177FYYtQvC/uNk8orLogZPC8iTasIPh5z66DKcQubeQ+5Y7HtfnKY
 fv/w==
X-Gm-Message-State: AOJu0YxcaM9Ye2x9K3VhZ4onTXJ2ptR9a0SlALBCoKKhBUmfy4wdIFNg
 OMNc5ChQf71D9Sqm+lPWvH9UyFTp3XtEsWKzEgw=
X-Google-Smtp-Source: AGHT+IEa0Z5aw0hpNYCZ8StGbExJ3u/hKPJKmKqa0k1Nu+SLymCl0naYiZ0IYRk3kLNFyJqk5nGu9w==
X-Received: by 2002:a1c:6a0c:0:b0:404:757e:c5ba with SMTP id
 f12-20020a1c6a0c000000b00404757ec5bamr21746781wmc.26.1697186898806; 
 Fri, 13 Oct 2023 01:48:18 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:18 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hannes Reinecke <hare@suse.com>, qemu-block@nongnu.org (open list:megasas)
Subject: [RFC PATCH v3 39/78] hw/scsi: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:07 +0300
Message-Id: <f42b4f75d7006a0f34a713c380cf7e7680a84dab.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/scsi/esp.c       | 2 +-
 hw/scsi/megasas.c   | 2 +-
 hw/scsi/scsi-bus.c  | 4 ++--
 hw/scsi/scsi-disk.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 9b11d8c573..d6c8298f51 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1025,7 +1025,7 @@ void esp_reg_write(ESPState *s, uint32_t saddr, uint64_t val)
     switch (saddr) {
     case ESP_TCHI:
         s->tchi_written = true;
-        /* fall through */
+        fallthrough;
     case ESP_TCLO:
     case ESP_TCMID:
         s->rregs[ESP_RSTAT] &= ~STAT_TC;
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 32c70c9e99..54e4d7c8b6 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2151,7 +2151,7 @@ static void megasas_mmio_write(void *opaque, hwaddr addr,
     case MFI_IQPL:
         trace_megasas_mmio_writel("MFI_IQPL", val);
         /* Received low 32 bits of a 64 bit MFI frame address */
-        /* Fallthrough */
+        fallthrough;
     case MFI_IQP:
         if (addr == MFI_IQP) {
             trace_megasas_mmio_writel("MFI_IQP", val);
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index fc4b77fdb0..a1c298a92c 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1078,7 +1078,7 @@ static int scsi_req_xfer(SCSICommand *cmd, SCSIDevice *dev, uint8_t *buf)
         if (cmd->xfer == 0) {
             cmd->xfer = 256;
         }
-        /* fall through */
+        fallthrough;
     case WRITE_10:
     case WRITE_VERIFY_10:
     case WRITE_12:
@@ -1093,7 +1093,7 @@ static int scsi_req_xfer(SCSICommand *cmd, SCSIDevice *dev, uint8_t *buf)
         if (cmd->xfer == 0) {
             cmd->xfer = 256;
         }
-        /* fall through */
+        fallthrough;
     case READ_10:
     case READ_12:
     case READ_16:
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 6691f5edb8..6564ca638c 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2302,7 +2302,7 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
         trace_scsi_disk_dma_command_WRITE(
                 (command & 0xe) == 0xe ? "And Verify " : "",
                 r->req.cmd.lba, len);
-        /* fall through */
+        fallthrough;
     case VERIFY_10:
     case VERIFY_12:
     case VERIFY_16:
-- 
2.39.2


