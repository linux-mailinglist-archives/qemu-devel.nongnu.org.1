Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAB470D1B1
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:48:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I2O-0001Pp-HG; Mon, 22 May 2023 22:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2L-0000yS-0T
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:09 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2I-0004he-DT
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:08 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2536b4b3398so4457049a91.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809965; x=1687401965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwZvJhc3RmNT91cD+11N33umRH8e+JRAQzDvd1+zY3M=;
 b=P1A3SNLSir+/5Jl9l4puD9vteCvKr8Q4f9QjtrglRvzLRqiG3dQ6lOU45cfr81mhxe
 74WlOCQpw4EoKqCMWPEXbLHJ4zLsNNNYl23blyppizeNPsvG/8QTj+kNXiUWe0rj5qmh
 QUJOTMQOTGbms8Qy0L7wgvGZcLe5H+cMgmoBTBd3lNnlvqk6XdYWe/UVy3bQLwvO3bIR
 MTKU2YZyLSS7KxbGfKeGA+LjH7n7eKadEPPOCDcOHmKfYBpr0TuK1axU95drXGBMAWYG
 CJiDjV1sK43KGH8XaOGdH9b/IgtfmUIKJ2WwTXKDEgLsvxsMo5hW36ko8NezWuN9rgCK
 PEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809965; x=1687401965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwZvJhc3RmNT91cD+11N33umRH8e+JRAQzDvd1+zY3M=;
 b=DIdTTX8s8Z1oTOGxbYjLeGXlo6Y0u8wFV48KoT78W+QRM4juy4EkuwbrvZlVDIwpqQ
 6fEV6kHdyBNobTzES/iX1LGj2FTqi6zWZS4kco+TGE1H7zVRECZ9URLqzWVDiljEFfqo
 1SV29zM602yXyF4izDu/xPhUqgiyuabr3NE20tSyNr6e9nhFviKinjJVecQCzFjUDBf6
 JOmFlzceai5vMCS6/PGllYDjpKRG/aaxtir3j6+ekDr2iYYGdd6iCxlpLLmqie0ZYICj
 1cKKA59wyE17/Vd0v9uhnToB4fJnNcgLkLx5mRwfK2FhNq2B+exOnre/xRUMbeXDgimz
 LTJg==
X-Gm-Message-State: AC+VfDwiMunEMsVeDIThnevq9r4HUicx0skl+Y9IK9Rc37k1TBWfFz/y
 l7C7expZXYR3JjrU7NpKTp4ufA==
X-Google-Smtp-Source: ACHHUZ4sw2HKUf+fIVMfJBkGTnu++7nPaP/OxXbLV9o5X1U5bRrAR0019hlmH2vYoYqEys135uIp/A==
X-Received: by 2002:a17:90a:6fc6:b0:255:6c22:5ccb with SMTP id
 e64-20020a17090a6fc600b002556c225ccbmr4690847pjk.7.1684809965104; 
 Mon, 22 May 2023 19:46:05 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:46:04 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 39/48] igb: Filter with the second VLAN tag for extended
 VLAN
Date: Tue, 23 May 2023 11:43:30 +0900
Message-Id: <20230523024339.50875-40-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/igb_core.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 688eaf7319..5345f57031 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -69,7 +69,7 @@ typedef struct IGBTxPktVmdqCallbackContext {
 
 typedef struct L2Header {
     struct eth_header eth;
-    struct vlan_header vlan;
+    struct vlan_header vlan[2];
 } L2Header;
 
 static ssize_t
@@ -1001,7 +1001,7 @@ static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
     uint32_t f, ra[2], *macp, rctl = core->mac[RCTL];
     uint16_t queues = 0;
     uint16_t oversized = 0;
-    uint16_t vid = be16_to_cpu(l2_header->vlan.h_tci) & VLAN_VID_MASK;
+    size_t vlan_num = 0;
     int i;
 
     memset(rss_info, 0, sizeof(E1000E_RSSInfo));
@@ -1010,8 +1010,19 @@ static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
         *external_tx = true;
     }
 
-    if (e1000x_is_vlan_packet(ehdr, core->mac[VET] & 0xffff) &&
-        !e1000x_rx_vlan_filter(core->mac, PKT_GET_VLAN_HDR(ehdr))) {
+    if (core->mac[CTRL_EXT] & BIT(26)) {
+        if (be16_to_cpu(ehdr->h_proto) == core->mac[VET] >> 16 &&
+            be16_to_cpu(l2_header->vlan[0].h_proto) == (core->mac[VET] & 0xffff)) {
+            vlan_num = 2;
+        }
+    } else {
+        if (be16_to_cpu(ehdr->h_proto) == (core->mac[VET] & 0xffff)) {
+            vlan_num = 1;
+        }
+    }
+
+    if (vlan_num &&
+        !e1000x_rx_vlan_filter(core->mac, l2_header->vlan + vlan_num - 1)) {
         return queues;
     }
 
@@ -1065,7 +1076,9 @@ static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
         if (e1000x_vlan_rx_filter_enabled(core->mac)) {
             uint16_t mask = 0;
 
-            if (e1000x_is_vlan_packet(ehdr, core->mac[VET] & 0xffff)) {
+            if (vlan_num) {
+                uint16_t vid = be16_to_cpu(l2_header->vlan[vlan_num - 1].h_tci) & VLAN_VID_MASK;
+
                 for (i = 0; i < E1000_VLVF_ARRAY_SIZE; i++) {
                     if ((core->mac[VLVF0 + i] & E1000_VLVF_VLANID_MASK) == vid &&
                         (core->mac[VLVF0 + i] & E1000_VLVF_VLANID_ENABLE)) {
-- 
2.40.1


