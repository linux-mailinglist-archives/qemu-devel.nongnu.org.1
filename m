Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0D375B870
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 22:00:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMZpC-00020m-GX; Thu, 20 Jul 2023 16:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qMZp9-0001yC-TH
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 16:00:32 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qMZot-0004pA-E1
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 16:00:31 -0400
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-403a840dc64so10219391cf.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 13:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689883214; x=1690488014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cc7pj30bTxLw0j0LdD/dx5vc6B2y0c1dIX3RAge2zGQ=;
 b=MhPtZfspe98Z5FjY84L2agwJW4mLahG43rZSzUxq9/nWL6guqXbe+lmjw3DzxvkSwT
 561IcwXMqbDraxXSEyz/tP8bhN+8Q+YHHIFI6lB9+CVAabQ0Z0Q4RQ/H2SxFGxAZMSxR
 oLOjA9/O/8N9OU/PhxmRBAKaQKRJDPjy4RYfQcJLexMYQ2vyOTpLOdGUSp7PWz13lAVp
 jmX67SXx+qrK+tW6ry5FkNmdOyTKRwNzHe24X69jA+hIBqK34Jc+JjvS5MRMECZxD/Ht
 DDGsdTywzRno8IFRy76lgmMe/KyyC33Dmep6YlRkYRIZBSx6/7yoO5QKb1RKxCGbufLg
 1REQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689883214; x=1690488014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cc7pj30bTxLw0j0LdD/dx5vc6B2y0c1dIX3RAge2zGQ=;
 b=XS/eUaGE1kCRmn9bjgWczY29DFS9Iz0Xa06VFVkvhqmpPOfnY8wSnsE7b/RKG963uA
 kh6PXvhpUraQePbNBsgUckKaKmFSeWaFRyhFe9wp2KoBBE8YKHIpQl5lMIqJs7ZGpeFR
 JVLiuhNJuMuxr6EJKMoptao3/ziX1G0L9W236ZD6nugq+no05iRwCk2ZyygMBd6DGxy3
 5vDABkWqGQRpjN0+Rfnr5sTJess6IA2mlfPyyTsuNLagZfOMJLqMUfZdbaPcOZpIPO1S
 xkg1M3Yy9eD13OiJHxNHss/e4vNfppvG747lfh1Y///536uCgsdA8LxqdHKALqC25gSH
 +jyQ==
X-Gm-Message-State: ABy/qLaJLUtO0nVGaObRO6IGgacPN1GzjoN2kFCcaFWw8kKIlwxo3okM
 fNpyMSSbaYzIEWLL5y57uf2yukQcfOJN
X-Google-Smtp-Source: APBJJlEa3Gz7M8cibwn+2MsRuW/pbHQd2K77Ts4q6iKe+7yiwi/XqBkvyUtMyBfV+Vx/5FlwsbuUcA==
X-Received: by 2002:ac8:59c6:0:b0:404:c430:650b with SMTP id
 f6-20020ac859c6000000b00404c430650bmr88133qtf.33.1689883214087; 
 Thu, 20 Jul 2023 13:00:14 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 bw14-20020a05622a098e00b00404e686bcd1sm672078qtb.72.2023.07.20.13.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 13:00:13 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 Gregory Price <gregory.price@memverge.com>
Subject: [RFC 2/2] cxl/mailbox: interface to add CCI commands to an existing
 CCI
Date: Thu, 20 Jul 2023 15:58:22 -0400
Message-Id: <20230720195819.17905-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230720195819.17905-1-gregory.price@memverge.com>
References: <20230720195819.17905-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=gourry.memverge@gmail.com; helo=mail-qt1-x841.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This enables wrapper devices to customize the base device's CCI
(for example, with custom commands outside the specification)
without the need to change the base device.

The also enabled the base device to dispatch those commands without
requiring additional driver support.

Signed-off-by: Gregory Price <gregory.price@memverge.com>

---
 hw/cxl/cxl-mailbox-utils.c         |  19 +++++++++++++++++++
 include/hw/cxl/cxl_device.h        |   2 ++
 2 files changed, 21 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ddee3f1718..cad0cd0adb 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1383,6 +1383,25 @@ static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[
     }
 }
 
+void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256], size_t payload_max)
+{
+    cci->payload_max = payload_max > cci->payload_max ? payload_max : cci->payload_max;
+    for (int set = 0; set < 256; set++) {
+        for (int cmd = 0; cmd < 256; cmd++) {
+            if (cxl_cmd_set[set][cmd].handler) {
+                const struct cxl_cmd *c = &cxl_cmd_set[set][cmd];
+                cci->cxl_cmd_set[set][cmd] = *c;
+                struct cel_log *log =
+                    &cci->cel_log[cci->cel_size];
+
+                log->opcode = (set << 8) | cmd;
+                log->effect = c->effect;
+                cci->cel_size++;
+            }
+        }
+    }
+}
+
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf, DeviceState *d, size_t payload_max)
 {
     cxl_copy_cci_commands(cci, cxl_cmd_set_sw);

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 9a3c8b2dfa..abc8405cc5 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -297,6 +297,8 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
+void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
+                          size_t payload_max);
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             size_t len_in, uint8_t *pl_in,
                             size_t *len_out, uint8_t *pl_out,
-- 
2.39.1


