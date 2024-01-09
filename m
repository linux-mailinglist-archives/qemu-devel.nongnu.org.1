Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97950827BD5
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 01:04:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMza8-0002TT-IN; Mon, 08 Jan 2024 19:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3LI2cZQwKCusaNOVURfgRSNaTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--nabihestefan.bounces.google.com>)
 id 1rMza6-0002Rt-CK
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 19:02:58 -0500
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3LI2cZQwKCusaNOVURfgRSNaTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--nabihestefan.bounces.google.com>)
 id 1rMza2-0002vo-7h
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 19:02:57 -0500
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5e8996ead39so41480357b3.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 16:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704758572; x=1705363372; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=xOJL2ZOyMozLNHCFgzyIeLuO6/ZGI2/svvRBE82xI8s=;
 b=pxD0rop6s47XYHZsn/CU4J8RMakuIr0JKzIsfZu7HQQtZ/l0J5xvQumE9RawSzJRe6
 L7lZnXEBVN1Q0kAmKDe6a5XYFdkdIEDO00SCB8hZS2JeYovaRwL+nPUmcrK5dypzNq8e
 FH3LZwtBTP6hyLg4FL1gyEu68QrOUiP6UQ4eeJCgynxFL2DOb0djW85BCeR13uNbTllb
 I/j98UOrY7jnmpKaJuv2O/KA/Claw/gJRt9SEULtum6SfIf0WTPf0p4mT01lKsq5OroF
 Rjmx1UPckUwFC/DWbfEJ1J3E0dYfZNYl2Mkqx0IW07lgiH3VyDV8YidT8kx8SmuIjxIk
 i20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704758572; x=1705363372;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xOJL2ZOyMozLNHCFgzyIeLuO6/ZGI2/svvRBE82xI8s=;
 b=qBRWdVjCWvwu45UafzzV+2NhWTLkPaU6ZzsQ0c2wa9zbOHpSAb69X64O2jq/pbSGl6
 qSxA/n5Vi4DQZusAy3dtbjE6+qmg+gH0yclg3tgY+Ju7zG0lIQGvH5y9sjv/oK19hZB0
 X+4mrZRUxVopapSZjGfW4wIKocpaUZbF+6Bar+HpbEBJva5JCQKUg6D6c5XU5s5v9k0r
 THJ1+jNN81wkX5X02UJBNn1VJe7a6SMok5oXyfWMy2eV/qb72XouKB+pg3RiiYaxB+Wa
 pyrgCeegUcTTtJXmWX6L8oDtd95hRYNUoTWE7PBUyITuSPJjS/SNHOVMAm6uvTQ+wwBr
 1zfA==
X-Gm-Message-State: AOJu0YxwCgXrajzc40K5IJNxrJNAw8NF9MxWJ2ZtvyvhxVI13tFSxQBI
 b38R2u2VibY2W01piZ+/0skwuXUvcz0GhnqFWVJe4dvdlg==
X-Google-Smtp-Source: AGHT+IGVYMUR+KuuwcDSHXkfVtgXT5OQxmvH6eaouQqO4ns0MLO01YN3BdygLO50wPLTVNios1jqfXcbScYLjmG6y6U=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a25:8107:0:b0:db5:45eb:75b0 with SMTP
 id o7-20020a258107000000b00db545eb75b0mr1812904ybk.6.1704758572451; Mon, 08
 Jan 2024 16:02:52 -0800 (PST)
Date: Tue,  9 Jan 2024 00:02:33 +0000
In-Reply-To: <20240109000234.2799153-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240109000234.2799153-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240109000234.2799153-10-nabihestefan@google.com>
Subject: [PATCH v11 09/10] hw/net: GMAC Tx Implementation
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3LI2cZQwKCusaNOVURfgRSNaTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

From: Nabih Estefan Diaz <nabihestefan@google.com>

- Implementation of Transmit function for packets
- Implementation for reading and writing from and to descriptors in
  memory for Tx

Added relevant trace-events

NOTE: This function implements the steps detailed in the datasheet for
transmitting messages from the GMAC.

Change-Id: Icf14f9fcc6cc7808a41acd872bca67c9832087e6
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
---
 hw/net/trace-events | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/trace-events b/hw/net/trace-events
index f91b1a4a3d..78efa2ec2c 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -478,7 +478,9 @@ npcm_gmac_packet_desc_read(const char* name, uint32_t desc_addr) "%s: attempting
 npcm_gmac_packet_receive(const char* name, uint32_t len) "%s: RX packet length: 0x%04" PRIX32
 npcm_gmac_packet_receiving_buffer(const char* name, uint32_t buf_len, uint32_t rx_buf_addr) "%s: Receiving into Buffer size: 0x%04" PRIX32 " at address 0x%04" PRIX32
 npcm_gmac_packet_received(const char* name, uint32_t len) "%s: Reception finished, packet left: 0x%04" PRIX32
+npcm_gmac_packet_sent(const char* name, uint16_t len) "%s: TX packet sent!, length: 0x%04" PRIX16
 npcm_gmac_debug_desc_data(const char* name, void* addr, uint32_t des0, uint32_t des1, uint32_t des2, uint32_t des3)"%s: Address: %p Descriptor 0: 0x%04" PRIX32 " Descriptor 1: 0x%04" PRIX32 "Descriptor 2: 0x%04" PRIX32 " Descriptor 3: 0x%04" PRIX32
+npcm_gmac_packet_tx_desc_data(const char* name, uint32_t tdes0, uint32_t tdes1) "%s: Tdes0: 0x%04" PRIX32 " Tdes1: 0x%04" PRIX32
 
 # npcm_pcs.c
 npcm_pcs_reg_read(const char *name, uint16_t indirect_access_baes, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
-- 
2.43.0.472.g3155946c3a-goog


