Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 091CC7C7FF0
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:21:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCxt-000117-8b; Fri, 13 Oct 2023 03:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxB-0006jv-KH
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:27 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCws-0004yA-RB
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:23 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-323168869daso1723173f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183465; x=1697788265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8M1jOKfcEW9WnCMrA6OabjFDX8Mu0kJ8wWs4dOttOyc=;
 b=j8hbjcJvdL6azvzwnNs9yLDREcmEBbmsUl+dvRVAkJ5a+QQwjiIFQN9gwYCWT/3umM
 Z0lFd2/SkT92OAJXJAdKjoVRjB9D7FfTB7m9vl2yv40Dvmn5n9bDr2ThgmQ9GQm0CyTe
 eBxafkRNSARHmHUPnJt4tuUKFk+OKlLVCRqkvmTbKEvi5cbNZnB9Dy9Ha3WCzNv3pry4
 OIXBfiebzWyPkvhs3ZsGnp2iEk6kWbHyePCfP0nYMmFXZmeXS4np2dQJkOGZSMOvLPsk
 7mv3ObFiPV6bQCkfa8j3kIxZzNheV/WZU0O9csz+UwnrP3tyIAoqJnxiEriAGrwXOVNr
 1+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183465; x=1697788265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8M1jOKfcEW9WnCMrA6OabjFDX8Mu0kJ8wWs4dOttOyc=;
 b=vakS4LQKyv2zUWpPdSZQ3KlSIlnx6IDsOROndzICkCM/Q/k8CvLsls8MJdane8TpHX
 Xa6+LGkg2C9uVvpuQPJ7tr5Q9j+m7QEtbqoInRL6bj/c6NJBHBG6LjN6vdY/qQqlluw5
 BaDnSf7roRJGihlwM1PEoW27uXMtvKdbtRj4JIn2gUCZfWdHB2/VNMOyOGdnRQwcx614
 K9ufugXSuH+0UQ953YiiEsiPd7/OVRW4hGJsj0IqRNPRYNsIgD+gnMouz2SD62hA0A7j
 8s+bybgk6/EKhCl+KlLuTaV4D7QpOa0FF+zJgMJXq72JrqppPpTmGWuhjm+XxgL7QVXP
 cKGg==
X-Gm-Message-State: AOJu0Ywlgy7l+N2qht+/OblnQSbX68CmVjltGBtJp9bGDRmalZTaJZOu
 SEyEgMzXjNILgm289YNzzTX4wz/dHmhkondFxYY=
X-Google-Smtp-Source: AGHT+IFl+aYgUeJ0blUvODxqJnUSS/KdSTXMMr9aCfpD52AuvyzPRrLm52kRIDLur1KZHJor2a3Y8A==
X-Received: by 2002:a5d:6748:0:b0:32d:9efe:ccd7 with SMTP id
 l8-20020a5d6748000000b0032d9efeccd7mr438196wrw.27.1697183465054; 
 Fri, 13 Oct 2023 00:51:05 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:51:04 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hannes Reinecke <hare@suse.com>
Subject: [RFC PATCH 39/78] hw/scsi: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:45 +0300
Message-Id: <115c73da79fff8e91d402248b3456b7345813e68.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
@@ -1022,130 +1022,130 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
 void esp_reg_write(ESPState *s, uint32_t saddr, uint64_t val)
 {
     trace_esp_mem_writeb(saddr, s->wregs[saddr], val);
     switch (saddr) {
     case ESP_TCHI:
         s->tchi_written = true;
-        /* fall through */
+        fallthrough;
     case ESP_TCLO:
     case ESP_TCMID:
         s->rregs[ESP_RSTAT] &= ~STAT_TC;
         break;
     case ESP_FIFO:
         if (s->do_cmd) {
             esp_fifo_push(&s->cmdfifo, val);
 
             /*
              * If any unexpected message out/command phase data is
              * transferred using non-DMA, raise the interrupt
              */
             if (s->rregs[ESP_CMD] == CMD_TI) {
                 s->rregs[ESP_RINTR] |= INTR_BS;
                 esp_raise_irq(s);
             }
         } else {
             esp_fifo_push(&s->fifo, val);
         }
         break;
     case ESP_CMD:
         s->rregs[saddr] = val;
         if (val & CMD_DMA) {
             s->dma = 1;
             /* Reload DMA counter.  */
             if (esp_get_stc(s) == 0) {
                 esp_set_tc(s, 0x10000);
             } else {
                 esp_set_tc(s, esp_get_stc(s));
             }
         } else {
             s->dma = 0;
         }
         switch (val & CMD_CMD) {
         case CMD_NOP:
             trace_esp_mem_writeb_cmd_nop(val);
             break;
         case CMD_FLUSH:
             trace_esp_mem_writeb_cmd_flush(val);
             fifo8_reset(&s->fifo);
             break;
         case CMD_RESET:
             trace_esp_mem_writeb_cmd_reset(val);
             esp_soft_reset(s);
             break;
         case CMD_BUSRESET:
             trace_esp_mem_writeb_cmd_bus_reset(val);
             esp_bus_reset(s);
             if (!(s->wregs[ESP_CFG1] & CFG1_RESREPT)) {
                 s->rregs[ESP_RINTR] |= INTR_RST;
                 esp_raise_irq(s);
             }
             break;
         case CMD_TI:
             trace_esp_mem_writeb_cmd_ti(val);
             handle_ti(s);
             break;
         case CMD_ICCS:
             trace_esp_mem_writeb_cmd_iccs(val);
             write_response(s);
             s->rregs[ESP_RINTR] |= INTR_FC;
             s->rregs[ESP_RSTAT] |= STAT_MI;
             break;
         case CMD_MSGACC:
             trace_esp_mem_writeb_cmd_msgacc(val);
             s->rregs[ESP_RINTR] |= INTR_DC;
             s->rregs[ESP_RSEQ] = 0;
             s->rregs[ESP_RFLAGS] = 0;
             esp_raise_irq(s);
             break;
         case CMD_PAD:
             trace_esp_mem_writeb_cmd_pad(val);
             s->rregs[ESP_RSTAT] = STAT_TC;
             s->rregs[ESP_RINTR] |= INTR_FC;
             s->rregs[ESP_RSEQ] = 0;
             break;
         case CMD_SATN:
             trace_esp_mem_writeb_cmd_satn(val);
             break;
         case CMD_RSTATN:
             trace_esp_mem_writeb_cmd_rstatn(val);
             break;
         case CMD_SEL:
             trace_esp_mem_writeb_cmd_sel(val);
             handle_s_without_atn(s);
             break;
         case CMD_SELATN:
             trace_esp_mem_writeb_cmd_selatn(val);
             handle_satn(s);
             break;
         case CMD_SELATNS:
             trace_esp_mem_writeb_cmd_selatns(val);
             handle_satn_stop(s);
             break;
         case CMD_ENSEL:
             trace_esp_mem_writeb_cmd_ensel(val);
             s->rregs[ESP_RINTR] = 0;
             break;
         case CMD_DISSEL:
             trace_esp_mem_writeb_cmd_dissel(val);
             s->rregs[ESP_RINTR] = 0;
             esp_raise_irq(s);
             break;
         default:
             trace_esp_error_unhandled_command(val);
             break;
         }
         break;
     case ESP_WBUSID ... ESP_WSYNO:
         break;
     case ESP_CFG1:
     case ESP_CFG2: case ESP_CFG3:
     case ESP_RES3: case ESP_RES4:
         s->rregs[saddr] = val;
         break;
     case ESP_WCCF ... ESP_WTEST:
         break;
     default:
         trace_esp_error_invalid_write(val, saddr);
         return;
     }
     s->wregs[saddr] = val;
 }
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 32c70c9e99..54e4d7c8b6 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2084,113 +2084,113 @@ static int adp_reset_seq[] = {0x00, 0x04, 0x0b, 0x02, 0x07, 0x0d};
 static void megasas_mmio_write(void *opaque, hwaddr addr,
                                uint64_t val, unsigned size)
 {
     MegasasState *s = opaque;
     PCIDevice *pci_dev = PCI_DEVICE(s);
     uint64_t frame_addr;
     uint32_t frame_count;
     int i;
 
     switch (addr) {
     case MFI_IDB:
         trace_megasas_mmio_writel("MFI_IDB", val);
         if (val & MFI_FWINIT_ABORT) {
             /* Abort all pending cmds */
             for (i = 0; i < s->fw_cmds; i++) {
                 megasas_abort_command(&s->frames[i]);
             }
         }
         if (val & MFI_FWINIT_READY) {
             /* move to FW READY */
             megasas_soft_reset(s);
         }
         if (val & MFI_FWINIT_MFIMODE) {
             /* discard MFIs */
         }
         if (val & MFI_FWINIT_STOP_ADP) {
             /* Terminal error, stop processing */
             s->fw_state = MFI_FWSTATE_FAULT;
         }
         break;
     case MFI_OMSK:
         trace_megasas_mmio_writel("MFI_OMSK", val);
         s->intr_mask = val;
         if (!megasas_intr_enabled(s) &&
             !msi_enabled(pci_dev) &&
             !msix_enabled(pci_dev)) {
             trace_megasas_irq_lower();
             pci_irq_deassert(pci_dev);
         }
         if (megasas_intr_enabled(s)) {
             if (msix_enabled(pci_dev)) {
                 trace_megasas_msix_enabled(0);
             } else if (msi_enabled(pci_dev)) {
                 trace_megasas_msi_enabled(0);
             } else {
                 trace_megasas_intr_enabled();
             }
         } else {
             trace_megasas_intr_disabled();
             megasas_soft_reset(s);
         }
         break;
     case MFI_ODCR0:
         trace_megasas_mmio_writel("MFI_ODCR0", val);
         s->doorbell = 0;
         if (megasas_intr_enabled(s)) {
             if (!msix_enabled(pci_dev) && !msi_enabled(pci_dev)) {
                 trace_megasas_irq_lower();
                 pci_irq_deassert(pci_dev);
             }
         }
         break;
     case MFI_IQPH:
         trace_megasas_mmio_writel("MFI_IQPH", val);
         /* Received high 32 bits of a 64 bit MFI frame address */
         s->frame_hi = val;
         break;
     case MFI_IQPL:
         trace_megasas_mmio_writel("MFI_IQPL", val);
         /* Received low 32 bits of a 64 bit MFI frame address */
-        /* Fallthrough */
+        fallthrough;
     case MFI_IQP:
         if (addr == MFI_IQP) {
             trace_megasas_mmio_writel("MFI_IQP", val);
             /* Received 64 bit MFI frame address */
             s->frame_hi = 0;
         }
         frame_addr = (val & ~0x1F);
         /* Add possible 64 bit offset */
         frame_addr |= ((uint64_t)s->frame_hi << 32);
         s->frame_hi = 0;
         frame_count = (val >> 1) & 0xF;
         megasas_handle_frame(s, frame_addr, frame_count);
         break;
     case MFI_SEQ:
         trace_megasas_mmio_writel("MFI_SEQ", val);
         /* Magic sequence to start ADP reset */
         if (adp_reset_seq[s->adp_reset++] == val) {
             if (s->adp_reset == 6) {
                 s->adp_reset = 0;
                 s->diag = MFI_DIAG_WRITE_ENABLE;
             }
         } else {
             s->adp_reset = 0;
             s->diag = 0;
         }
         break;
     case MFI_DIAG:
         trace_megasas_mmio_writel("MFI_DIAG", val);
         /* ADP reset */
         if ((s->diag & MFI_DIAG_WRITE_ENABLE) &&
             (val & MFI_DIAG_RESET_ADP)) {
             s->diag |= MFI_DIAG_RESET_ADP;
             megasas_soft_reset(s);
             s->adp_reset = 0;
             s->diag = 0;
         }
         break;
     default:
         trace_megasas_mmio_invalid_writel(addr, val);
         break;
     }
 }
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index fc4b77fdb0..a1c298a92c 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1015,141 +1015,141 @@ static int ata_passthrough_16_xfer(SCSIDevice *dev, uint8_t *buf)
 static int scsi_req_xfer(SCSICommand *cmd, SCSIDevice *dev, uint8_t *buf)
 {
     cmd->xfer = scsi_cdb_xfer(buf);
     switch (buf[0]) {
     case TEST_UNIT_READY:
     case REWIND:
     case START_STOP:
     case SET_CAPACITY:
     case WRITE_FILEMARKS:
     case WRITE_FILEMARKS_16:
     case SPACE:
     case RESERVE:
     case RELEASE:
     case ERASE:
     case ALLOW_MEDIUM_REMOVAL:
     case SEEK_10:
     case SYNCHRONIZE_CACHE:
     case SYNCHRONIZE_CACHE_16:
     case LOCATE_16:
     case LOCK_UNLOCK_CACHE:
     case SET_CD_SPEED:
     case SET_LIMITS:
     case WRITE_LONG_10:
     case UPDATE_BLOCK:
     case RESERVE_TRACK:
     case SET_READ_AHEAD:
     case PRE_FETCH:
     case PRE_FETCH_16:
     case ALLOW_OVERWRITE:
         cmd->xfer = 0;
         break;
     case VERIFY_10:
     case VERIFY_12:
     case VERIFY_16:
         if ((buf[1] & 2) == 0) {
             cmd->xfer = 0;
         } else if ((buf[1] & 4) != 0) {
             cmd->xfer = 1;
         }
         cmd->xfer *= dev->blocksize;
         break;
     case MODE_SENSE:
         break;
     case WRITE_SAME_10:
     case WRITE_SAME_16:
         cmd->xfer = buf[1] & 1 ? 0 : dev->blocksize;
         break;
     case READ_CAPACITY_10:
         cmd->xfer = 8;
         break;
     case READ_BLOCK_LIMITS:
         cmd->xfer = 6;
         break;
     case SEND_VOLUME_TAG:
         /* GPCMD_SET_STREAMING from multimedia commands.  */
         if (dev->type == TYPE_ROM) {
             cmd->xfer = buf[10] | (buf[9] << 8);
         } else {
             cmd->xfer = buf[9] | (buf[8] << 8);
         }
         break;
     case WRITE_6:
         /* length 0 means 256 blocks */
         if (cmd->xfer == 0) {
             cmd->xfer = 256;
         }
-        /* fall through */
+        fallthrough;
     case WRITE_10:
     case WRITE_VERIFY_10:
     case WRITE_12:
     case WRITE_VERIFY_12:
     case WRITE_16:
     case WRITE_VERIFY_16:
         cmd->xfer *= dev->blocksize;
         break;
     case READ_6:
     case READ_REVERSE:
         /* length 0 means 256 blocks */
         if (cmd->xfer == 0) {
             cmd->xfer = 256;
         }
-        /* fall through */
+        fallthrough;
     case READ_10:
     case READ_12:
     case READ_16:
         cmd->xfer *= dev->blocksize;
         break;
     case FORMAT_UNIT:
         /* MMC mandates the parameter list to be 12-bytes long.  Parameters
          * for block devices are restricted to the header right now.  */
         if (dev->type == TYPE_ROM && (buf[1] & 16)) {
             cmd->xfer = 12;
         } else {
             cmd->xfer = (buf[1] & 16) == 0 ? 0 : (buf[1] & 32 ? 8 : 4);
         }
         break;
     case INQUIRY:
     case RECEIVE_DIAGNOSTIC:
     case SEND_DIAGNOSTIC:
         cmd->xfer = buf[4] | (buf[3] << 8);
         break;
     case READ_CD:
     case READ_BUFFER:
     case WRITE_BUFFER:
     case SEND_CUE_SHEET:
         cmd->xfer = buf[8] | (buf[7] << 8) | (buf[6] << 16);
         break;
     case PERSISTENT_RESERVE_OUT:
         cmd->xfer = ldl_be_p(&buf[5]) & 0xffffffffULL;
         break;
     case ERASE_12:
         if (dev->type == TYPE_ROM) {
             /* MMC command GET PERFORMANCE.  */
             cmd->xfer = scsi_get_performance_length(buf[9] | (buf[8] << 8),
                                                     buf[10], buf[1] & 0x1f);
         }
         break;
     case MECHANISM_STATUS:
     case READ_DVD_STRUCTURE:
     case SEND_DVD_STRUCTURE:
     case MAINTENANCE_OUT:
     case MAINTENANCE_IN:
         if (dev->type == TYPE_ROM) {
             /* GPCMD_REPORT_KEY and GPCMD_SEND_KEY from multi media commands */
             cmd->xfer = buf[9] | (buf[8] << 8);
         }
         break;
     case ATA_PASSTHROUGH_12:
         if (dev->type == TYPE_ROM) {
             /* BLANK command of MMC */
             cmd->xfer = 0;
         } else {
             cmd->xfer = ata_passthrough_12_xfer(dev, buf);
         }
         break;
     case ATA_PASSTHROUGH_16:
         cmd->xfer = ata_passthrough_16_xfer(dev, buf);
         break;
     }
     return 0;
 }
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 6691f5edb8..6564ca638c 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2256,86 +2256,86 @@ illegal_lba:
 static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
 {
     SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
     SCSIDiskClass *sdc = (SCSIDiskClass *) object_get_class(OBJECT(s));
     uint32_t len;
     uint8_t command;
 
     command = buf[0];
 
     if (!blk_is_available(s->qdev.conf.blk)) {
         scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
         return 0;
     }
 
     len = scsi_data_cdb_xfer(r->req.cmd.buf);
     switch (command) {
     case READ_6:
     case READ_10:
     case READ_12:
     case READ_16:
         trace_scsi_disk_dma_command_READ(r->req.cmd.lba, len);
         /* Protection information is not supported.  For SCSI versions 2 and
          * older (as determined by snooping the guest's INQUIRY commands),
          * there is no RD/WR/VRPROTECT, so skip this check in these versions.
          */
         if (s->qdev.scsi_version > 2 && (r->req.cmd.buf[1] & 0xe0)) {
             goto illegal_request;
         }
         if (!check_lba_range(s, r->req.cmd.lba, len)) {
             goto illegal_lba;
         }
         r->sector = r->req.cmd.lba * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
         r->sector_count = len * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
         break;
     case WRITE_6:
     case WRITE_10:
     case WRITE_12:
     case WRITE_16:
     case WRITE_VERIFY_10:
     case WRITE_VERIFY_12:
     case WRITE_VERIFY_16:
         if (!blk_is_writable(s->qdev.conf.blk)) {
             scsi_check_condition(r, SENSE_CODE(WRITE_PROTECTED));
             return 0;
         }
         trace_scsi_disk_dma_command_WRITE(
                 (command & 0xe) == 0xe ? "And Verify " : "",
                 r->req.cmd.lba, len);
-        /* fall through */
+        fallthrough;
     case VERIFY_10:
     case VERIFY_12:
     case VERIFY_16:
         /* We get here only for BYTCHK == 0x01 and only for scsi-block.
          * As far as DMA is concerned, we can treat it the same as a write;
          * scsi_block_do_sgio will send VERIFY commands.
          */
         if (s->qdev.scsi_version > 2 && (r->req.cmd.buf[1] & 0xe0)) {
             goto illegal_request;
         }
         if (!check_lba_range(s, r->req.cmd.lba, len)) {
             goto illegal_lba;
         }
         r->sector = r->req.cmd.lba * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
         r->sector_count = len * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
         break;
     default:
         abort();
     illegal_request:
         scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
         return 0;
     illegal_lba:
         scsi_check_condition(r, SENSE_CODE(LBA_OUT_OF_RANGE));
         return 0;
     }
     r->need_fua_emulation = sdc->need_fua_emulation(&r->req.cmd);
     if (r->sector_count == 0) {
         scsi_req_complete(&r->req, GOOD);
     }
     assert(r->iov.iov_len == 0);
     if (r->req.cmd.mode == SCSI_XFER_TO_DEV) {
         return -r->sector_count * BDRV_SECTOR_SIZE;
     } else {
         return r->sector_count * BDRV_SECTOR_SIZE;
     }
 }
-- 
2.39.2


