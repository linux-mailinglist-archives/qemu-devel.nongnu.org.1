Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC63D75CFB3
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 18:37:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMt8B-0003PE-62; Fri, 21 Jul 2023 12:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qMt89-0003Od-4X
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 12:37:25 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qMt87-0005Ac-Ly
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 12:37:24 -0400
Received: by mail-yb1-xb44.google.com with SMTP id
 3f1490d57ef6-c4cb4919bb9so2085237276.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689957442; x=1690562242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCxlxCkDucjgqyJyU3Oue/fnEXKDKF8PNCPD5OQGcak=;
 b=LE0skMiW+AIH9AdEitz+QvtO5F5y4hjqHyJvcZ7KFgRh5hyaU0jo/Ees0GFLiDwZLz
 jcZn/V5N9n8776veFXkpJDsdxbz5/6jVzNNRgCoJitOrGwsEwQ4mi6B28VUzVB1uTSq5
 P6sgKDqGeckcczMrYahoi4pCmZW75E5A815/hTXl5MPA/N6zYuAG1wnR3TC7phz+73fj
 IuonAC6i8JZsmIQrUDapUnnlxw7sWUK0htkLtRpd9vmHcnOaQ5t8kCvV5H2HyarTFwX/
 5L0TF+6Rw5IFcV6PhgaHyDEHvqaqlWIaahFw0vHBAvd/jyLgtI+XGjzxfUHIGEaYgIDB
 OC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689957442; x=1690562242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCxlxCkDucjgqyJyU3Oue/fnEXKDKF8PNCPD5OQGcak=;
 b=BTTXMGJoFXDNmhqbsvRurUh6b9ZeAxIwFiv3AFbAgz+V2fH9sSBAVy00Jjhu3KIaag
 0jkdZZ7koMdxqCYnsv1FaWxH6vuaKT4EdenOIz4XStT0xa8yHlL5ySjFpUOr4LXkhxS+
 55MYQ1ktLotzHsvpx9SSbh7rfwEz/gMdAqMxBAs8hFCXKyZde1izGm8Wfy6Xfnppisml
 ba5rDWJSudNMBAgKl9ea2B+i3jfuJrjyzRQLAWjIqiVY2nDgJUheB0aXRMnZ5ctMbvIY
 4bkf4lYxn3EvDXcy/cXohgv+zF+MAalynezcIkHs49f8W+PUGnwosIuuUw5OFhED0uSJ
 xlKg==
X-Gm-Message-State: ABy/qLZshDP4mYYVJZ9Z0zvDFbe19+9uXFUFlFmRnYDg0imMY3Z8aPUz
 0a810VNoLCNfEtNj0NI0H8atHypcOnyV
X-Google-Smtp-Source: APBJJlHgBiaBhLzzLKSQzU9vgX03UOlsab2e7R/fTJSNHBp76nl2F3xwc1GfSQ9hKOyTQtouaqaGFA==
X-Received: by 2002:a25:780e:0:b0:cfd:1ea:888e with SMTP id
 t14-20020a25780e000000b00cfd01ea888emr2116596ybc.60.1689957442377; 
 Fri, 21 Jul 2023 09:37:22 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 v196-20020a25c5cd000000b00c62e0df7ca8sm863822ybe.24.2023.07.21.09.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jul 2023 09:37:22 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org, junhee.ryu@sk.com,
 kwangjin.ko@sk.com, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 2/4] cxl/mailbox: interface to add CCI commands to an existing
 CCI
Date: Fri, 21 Jul 2023 12:35:06 -0400
Message-Id: <20230721163505.1910-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230721163505.1910-1-gregory.price@memverge.com>
References: <20230721163505.1910-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=gourry.memverge@gmail.com; helo=mail-yb1-xb44.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 hw/cxl/cxl-mailbox-utils.c  | 19 +++++++++++++++++++
 include/hw/cxl/cxl_device.h |  2 ++
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


