Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B22782C068
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:05:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH40-0007i5-Ro; Fri, 12 Jan 2024 07:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3z-0007hr-Fk
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:07 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3x-0006iU-FM
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=27fRoZHGPFVk58crHINcAUyDNW4V4OJIC2VY021bTNk=; b=adokEO1nzjAQ0x3B9aHjllU2CG
 7RWuaOxe6T9QpN5poGJhmXf0VcesLflZwMIPawndac+EfiIdX3liCUPmcfy01LJVvyXA6QF9zFHsN
 aJz42zzTMPCtgP2JYbvfjbsEByTKo0nLPWkS33XNPDV30UoZO1u3GcqkbJlkmssscLzLMhjNTZIDn
 jn1GbTrPOMUrsTglUwqivqaHUl43hYzTU8It4rPRxDBvuuFUQCRF9JDz1g3U56vK/wt6JoPHacs5L
 3trOoY0ySgEhC2cuCnw4L+PgW3RunsVMJRetKVfH0ZgjuBeXoc3H4eiX7ldP/+W4MiECYJ0Ttl3t5
 DSqU8ktIhPtEv+owhzherS46z9ZtvisoG20V0qGa31R9Ckpu97Xer4nc+OQIHHkr+3w1gQ4hvfBNc
 GovP5oX8Y8/C+yWW+lUpsR15wg3iHp/wGutuby7zmd6Ac0b5+3EIseaTbeiahKQpWWk0lEYS5Ac8F
 m2ptvrQFXHdUl8uENWzoEHhGfaUAwi7dch82uK+lzgustUbe2WRLPkH+tUrB9VrvBrM1hsx9rLlS2
 unSgeRYQp3O6LFDVy6c096ZTybE48FKcTq2MmMgYb+6nU9NNzSeQfdVYCPmKBbGVpK7LdOH0+XaX6
 rhmD6nTj0yQtHNXpFaSEfmsX0hG2PedhQOz2OccsI=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3I-0008jM-P8; Fri, 12 Jan 2024 12:54:28 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:00 +0000
Message-Id: <20240112125420.514425-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 08/88] esp: move command execution logic to new esp_run_cmd()
 function
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This helps to simplify esp_reg_write() and potentially allows for a 2-level
deep FIFO to be implemented in future.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 177 ++++++++++++++++++++++++++------------------------
 1 file changed, 92 insertions(+), 85 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index e717b2e216..fecfef7c89 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -980,6 +980,97 @@ static void parent_esp_reset(ESPState *s, int irq, int level)
     }
 }
 
+static void esp_run_cmd(ESPState *s)
+{
+    uint8_t cmd = s->rregs[ESP_CMD];
+
+    if (cmd & CMD_DMA) {
+        s->dma = 1;
+        /* Reload DMA counter.  */
+        if (esp_get_stc(s) == 0) {
+            esp_set_tc(s, 0x10000);
+        } else {
+            esp_set_tc(s, esp_get_stc(s));
+        }
+    } else {
+        s->dma = 0;
+    }
+    switch (cmd & CMD_CMD) {
+    case CMD_NOP:
+        trace_esp_mem_writeb_cmd_nop(cmd);
+        break;
+    case CMD_FLUSH:
+        trace_esp_mem_writeb_cmd_flush(cmd);
+        fifo8_reset(&s->fifo);
+        break;
+    case CMD_RESET:
+        trace_esp_mem_writeb_cmd_reset(cmd);
+        esp_soft_reset(s);
+        break;
+    case CMD_BUSRESET:
+        trace_esp_mem_writeb_cmd_bus_reset(cmd);
+        esp_bus_reset(s);
+        if (!(s->wregs[ESP_CFG1] & CFG1_RESREPT)) {
+            s->rregs[ESP_RINTR] |= INTR_RST;
+            esp_raise_irq(s);
+        }
+        break;
+    case CMD_TI:
+        trace_esp_mem_writeb_cmd_ti(cmd);
+        handle_ti(s);
+        break;
+    case CMD_ICCS:
+        trace_esp_mem_writeb_cmd_iccs(cmd);
+        write_response(s);
+        s->rregs[ESP_RINTR] |= INTR_FC;
+        s->rregs[ESP_RSTAT] |= STAT_MI;
+        break;
+    case CMD_MSGACC:
+        trace_esp_mem_writeb_cmd_msgacc(cmd);
+        s->rregs[ESP_RINTR] |= INTR_DC;
+        s->rregs[ESP_RSEQ] = 0;
+        s->rregs[ESP_RFLAGS] = 0;
+        esp_raise_irq(s);
+        break;
+    case CMD_PAD:
+        trace_esp_mem_writeb_cmd_pad(cmd);
+        s->rregs[ESP_RSTAT] = STAT_TC;
+        s->rregs[ESP_RINTR] |= INTR_FC;
+        s->rregs[ESP_RSEQ] = 0;
+        break;
+    case CMD_SATN:
+        trace_esp_mem_writeb_cmd_satn(cmd);
+        break;
+    case CMD_RSTATN:
+        trace_esp_mem_writeb_cmd_rstatn(cmd);
+        break;
+    case CMD_SEL:
+        trace_esp_mem_writeb_cmd_sel(cmd);
+        handle_s_without_atn(s);
+        break;
+    case CMD_SELATN:
+        trace_esp_mem_writeb_cmd_selatn(cmd);
+        handle_satn(s);
+        break;
+    case CMD_SELATNS:
+        trace_esp_mem_writeb_cmd_selatns(cmd);
+        handle_satn_stop(s);
+        break;
+    case CMD_ENSEL:
+        trace_esp_mem_writeb_cmd_ensel(cmd);
+        s->rregs[ESP_RINTR] = 0;
+        break;
+    case CMD_DISSEL:
+        trace_esp_mem_writeb_cmd_dissel(cmd);
+        s->rregs[ESP_RINTR] = 0;
+        esp_raise_irq(s);
+        break;
+    default:
+        trace_esp_error_unhandled_command(cmd);
+        break;
+    }
+}
+
 uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
 {
     uint32_t val;
@@ -1076,91 +1167,7 @@ void esp_reg_write(ESPState *s, uint32_t saddr, uint64_t val)
         break;
     case ESP_CMD:
         s->rregs[saddr] = val;
-        if (val & CMD_DMA) {
-            s->dma = 1;
-            /* Reload DMA counter.  */
-            if (esp_get_stc(s) == 0) {
-                esp_set_tc(s, 0x10000);
-            } else {
-                esp_set_tc(s, esp_get_stc(s));
-            }
-        } else {
-            s->dma = 0;
-        }
-        switch (val & CMD_CMD) {
-        case CMD_NOP:
-            trace_esp_mem_writeb_cmd_nop(val);
-            break;
-        case CMD_FLUSH:
-            trace_esp_mem_writeb_cmd_flush(val);
-            fifo8_reset(&s->fifo);
-            break;
-        case CMD_RESET:
-            trace_esp_mem_writeb_cmd_reset(val);
-            esp_soft_reset(s);
-            break;
-        case CMD_BUSRESET:
-            trace_esp_mem_writeb_cmd_bus_reset(val);
-            esp_bus_reset(s);
-            if (!(s->wregs[ESP_CFG1] & CFG1_RESREPT)) {
-                s->rregs[ESP_RINTR] |= INTR_RST;
-                esp_raise_irq(s);
-            }
-            break;
-        case CMD_TI:
-            trace_esp_mem_writeb_cmd_ti(val);
-            handle_ti(s);
-            break;
-        case CMD_ICCS:
-            trace_esp_mem_writeb_cmd_iccs(val);
-            write_response(s);
-            s->rregs[ESP_RINTR] |= INTR_FC;
-            s->rregs[ESP_RSTAT] |= STAT_MI;
-            break;
-        case CMD_MSGACC:
-            trace_esp_mem_writeb_cmd_msgacc(val);
-            s->rregs[ESP_RINTR] |= INTR_DC;
-            s->rregs[ESP_RSEQ] = 0;
-            s->rregs[ESP_RFLAGS] = 0;
-            esp_raise_irq(s);
-            break;
-        case CMD_PAD:
-            trace_esp_mem_writeb_cmd_pad(val);
-            s->rregs[ESP_RSTAT] = STAT_TC;
-            s->rregs[ESP_RINTR] |= INTR_FC;
-            s->rregs[ESP_RSEQ] = 0;
-            break;
-        case CMD_SATN:
-            trace_esp_mem_writeb_cmd_satn(val);
-            break;
-        case CMD_RSTATN:
-            trace_esp_mem_writeb_cmd_rstatn(val);
-            break;
-        case CMD_SEL:
-            trace_esp_mem_writeb_cmd_sel(val);
-            handle_s_without_atn(s);
-            break;
-        case CMD_SELATN:
-            trace_esp_mem_writeb_cmd_selatn(val);
-            handle_satn(s);
-            break;
-        case CMD_SELATNS:
-            trace_esp_mem_writeb_cmd_selatns(val);
-            handle_satn_stop(s);
-            break;
-        case CMD_ENSEL:
-            trace_esp_mem_writeb_cmd_ensel(val);
-            s->rregs[ESP_RINTR] = 0;
-            break;
-        case CMD_DISSEL:
-            trace_esp_mem_writeb_cmd_dissel(val);
-            s->rregs[ESP_RINTR] = 0;
-            esp_raise_irq(s);
-            break;
-        default:
-            trace_esp_error_unhandled_command(val);
-            break;
-        }
+        esp_run_cmd(s);
         break;
     case ESP_WBUSID ... ESP_WSYNO:
         break;
-- 
2.39.2


