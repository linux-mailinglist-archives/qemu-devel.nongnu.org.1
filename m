Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFAF81AD49
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:23:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9au-0005qD-18; Wed, 20 Dec 2023 22:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9aq-0005aO-Bo
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:19:28 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ao-000465-JT
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:19:28 -0500
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-77f50307a1fso19273185a.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128765; x=1703733565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KcxQPBbfK0hVm/rtjZbMJUPe349vBJZciSYSVuekVVY=;
 b=E2CLHNPIpNaqwCoAe89lRxffKA3bs4IiLZ21fviOetA/TXPsAXUSvAZIrjCH0N8FA3
 DDKOzswdriSi8aN73rF12KI3xT9gSBGp/mk9M1dB3YL5sr8AiIJpTHXc0OsNbYf9jAfi
 BQ0cFUxyNFZ7DNtziwlb8LAz1Whyz6+CwiowWRmeaNHJCWUYT8ewqtt9TW2NI6DHHvkT
 2pTfh+sjJLG0uyFWMQnf+iSlf/9TejJwObbykvDefR7Nb0iN5bKcCGyweAJAaJ21u4T+
 YmIH3EOJ31zK771XdBre2hWtudjRhe3/HsqgKbQ+QxwvhiKUV+S6U4rRAF1eKBw3dTRt
 vJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128765; x=1703733565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KcxQPBbfK0hVm/rtjZbMJUPe349vBJZciSYSVuekVVY=;
 b=lPMRHhoEguhfvarOtLkhIKg6voCBOFtZCjYTAPYwb+ehap9xA9iGg5z49ue6oYfvXg
 fmK2ujh9aSE0UU2UvHmBG83ZUXnt5jEnOCE9LNRHnn1O9ZwrDk6DIXH3dNwP9bbm1saT
 ym1lLp1r45WlfY9QQK7pehI3weB+b0eW1vJtECA59dBOYf3cF/EaShtBeRTD3YIhImiw
 AlLq5lbNdP7k9T+kdVTdPNKIBCtLmyYBPjo7EvvGLyQQhKWUWtsuH6Om7LcRa/NDTJil
 9zzakUqLcK1wB4K/0y+r/+ZmptoC8/WYiOvoX1kSH+dmDHEgPe5PA55x+/YxPq50QzBV
 4gkQ==
X-Gm-Message-State: AOJu0YzYbnSBTKteEAbCja/njefAkjNCUpIweD98SS+xovxQbDDmr3QM
 8puv6K+2iLAOX9QqlXKg0bGUU7qgMTxpYXOGCg/sTHCT
X-Google-Smtp-Source: AGHT+IHNkcZpkK+c8JwHxGFYtEQ+KxD94QEOppUSKg1kcMcKAsjmaJMmCpRQCQDmulpYpi7Lt5UK/A==
X-Received: by 2002:a05:620a:3cf:b0:775:d7d7:cdbb with SMTP id
 r15-20020a05620a03cf00b00775d7d7cdbbmr22527019qkm.38.1703128765505; 
 Wed, 20 Dec 2023 19:19:25 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.19.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:19:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 36/71] hw/ipmi: Constify VMState
Date: Thu, 21 Dec 2023 14:16:17 +1100
Message-Id: <20231221031652.119827-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ipmi/ipmi_bmc_extern.c | 2 +-
 hw/ipmi/ipmi_bmc_sim.c    | 2 +-
 hw/ipmi/ipmi_bt.c         | 2 +-
 hw/ipmi/ipmi_kcs.c        | 2 +-
 hw/ipmi/isa_ipmi_bt.c     | 2 +-
 hw/ipmi/isa_ipmi_kcs.c    | 2 +-
 hw/ipmi/pci_ipmi_bt.c     | 2 +-
 hw/ipmi/pci_ipmi_kcs.c    | 2 +-
 hw/ipmi/smbus_ipmi.c      | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 2117dad35a..29c5af3cc3 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -479,7 +479,7 @@ static const VMStateDescription vmstate_ipmi_bmc_extern = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = ipmi_bmc_extern_post_migrate,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(send_reset, IPMIBmcExtern),
         VMSTATE_BOOL(waiting_rsp, IPMIBmcExtern),
         VMSTATE_END_OF_LIST()
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 905e091094..33c839c65a 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -2103,7 +2103,7 @@ static const VMStateDescription vmstate_ipmi_sim = {
     .name = TYPE_IPMI_BMC_SIMULATOR,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(bmc_global_enables, IPMIBmcSim),
         VMSTATE_UINT8(msg_flags, IPMIBmcSim),
         VMSTATE_BOOL(watchdog_initialized, IPMIBmcSim),
diff --git a/hw/ipmi/ipmi_bt.c b/hw/ipmi/ipmi_bt.c
index 22f94fb98d..583fc64730 100644
--- a/hw/ipmi/ipmi_bt.c
+++ b/hw/ipmi/ipmi_bt.c
@@ -396,7 +396,7 @@ const VMStateDescription vmstate_IPMIBT = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = ipmi_bt_vmstate_post_load,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(obf_irq_set, IPMIBT),
         VMSTATE_BOOL(atn_irq_set, IPMIBT),
         VMSTATE_BOOL(irqs_enabled, IPMIBT),
diff --git a/hw/ipmi/ipmi_kcs.c b/hw/ipmi/ipmi_kcs.c
index a77612946a..c15977cab4 100644
--- a/hw/ipmi/ipmi_kcs.c
+++ b/hw/ipmi/ipmi_kcs.c
@@ -379,7 +379,7 @@ const VMStateDescription vmstate_IPMIKCS = {
     .version_id = 2,
     .minimum_version_id = 1,
     .post_load = ipmi_kcs_vmstate_post_load,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(obf_irq_set, IPMIKCS),
         VMSTATE_BOOL(atn_irq_set, IPMIKCS),
         VMSTATE_UNUSED_TEST(vmstate_kcs_before_version2, 1), /* Was use_irq */
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index aec064d3cd..7b36d51494 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -77,7 +77,7 @@ static const VMStateDescription vmstate_ISAIPMIBTDevice = {
      * because it used VMSTATE_VBUFFER_UINT32, but it did not transfer
      * the buffer length, so random things would happen.
      */
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(bt, ISAIPMIBTDevice, 1, vmstate_IPMIBT, IPMIBT),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index b5dcb64616..f52b32e590 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -76,7 +76,7 @@ static const VMStateDescription vmstate_ISAIPMIKCSDevice = {
     .name = TYPE_IPMI_INTERFACE,
     .version_id = 2,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VSTRUCT_TEST(kcs, ISAIPMIKCSDevice, vmstate_kcs_before_version2,
                              0, vmstate_IPMIKCS, IPMIKCS, 1),
         VMSTATE_VSTRUCT_V(kcs, ISAIPMIKCSDevice, 2, vmstate_IPMIKCS,
diff --git a/hw/ipmi/pci_ipmi_bt.c b/hw/ipmi/pci_ipmi_bt.c
index 633931b825..afeea6f303 100644
--- a/hw/ipmi/pci_ipmi_bt.c
+++ b/hw/ipmi/pci_ipmi_bt.c
@@ -87,7 +87,7 @@ const VMStateDescription vmstate_PCIIPMIBTDevice = {
     .name = TYPE_IPMI_INTERFACE_PREFIX "pci-bt",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, PCIIPMIBTDevice),
         VMSTATE_STRUCT(bt, PCIIPMIBTDevice, 1, vmstate_IPMIBT, IPMIBT),
         VMSTATE_END_OF_LIST()
diff --git a/hw/ipmi/pci_ipmi_kcs.c b/hw/ipmi/pci_ipmi_kcs.c
index 1a581413c2..05ba97ec58 100644
--- a/hw/ipmi/pci_ipmi_kcs.c
+++ b/hw/ipmi/pci_ipmi_kcs.c
@@ -87,7 +87,7 @@ const VMStateDescription vmstate_PCIIPMIKCSDevice = {
     .name = TYPE_IPMI_INTERFACE_PREFIX "pci-kcs",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, PCIIPMIKCSDevice),
         VMSTATE_STRUCT(kcs, PCIIPMIKCSDevice, 1, vmstate_IPMIKCS, IPMIKCS),
         VMSTATE_END_OF_LIST()
diff --git a/hw/ipmi/smbus_ipmi.c b/hw/ipmi/smbus_ipmi.c
index d0991ab7f9..56865df7db 100644
--- a/hw/ipmi/smbus_ipmi.c
+++ b/hw/ipmi/smbus_ipmi.c
@@ -299,7 +299,7 @@ static const VMStateDescription vmstate_smbus_ipmi = {
     .name = TYPE_SMBUS_IPMI,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_SMBUS_DEVICE(parent, SMBusIPMIDevice),
         VMSTATE_UINT8(waiting_rsp, SMBusIPMIDevice),
         VMSTATE_UINT32(outlen, SMBusIPMIDevice),
-- 
2.34.1


