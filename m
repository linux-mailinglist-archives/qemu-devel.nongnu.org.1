Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE9970D17E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:44:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I0S-00036x-Fu; Mon, 22 May 2023 22:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0Q-00036T-Az
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:10 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0O-00045a-PR
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:10 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2535d86a41bso3746531a91.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809847; x=1687401847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRiwHOP/LRx7fFokqI6Ne+sigkhawLGOzwtp4xDjzzU=;
 b=H7V2Jy1T1yVI3pgcZVqpV38ajc2u4jlrXKoFcpu/VkIr9uJF96NLfdb0LAVAOSaLJz
 EvFZsImUrBlWzsUxj+gFLdM9JHmqq81FtNkfFXcB1vmfkClDVI05C8lppYmS1QI2dgoV
 uT7MsEFRos/JGbQQ0K5Mv7zrj/aRbuVkGYu629P8MA8gRcA32tMXh+MgfkuJDksD8sha
 sQIVHfvXD2i6LmdYCN11jr1gLb7ejyC6ayMEFRn1spmGNdMAgTqJ3bl9Gn2J7LH5Ou5P
 ETAORaFQeIqjA0bqe7qxkjgv0KWlEY9HSUEPGblxQqCTnOao3LICgTFr5r2lsCLKXp46
 uLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809847; x=1687401847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iRiwHOP/LRx7fFokqI6Ne+sigkhawLGOzwtp4xDjzzU=;
 b=ijVxRogBMY2IDmv0P/1m7qYC8wG+4d96W9cLqnzbdimXSQ7K++iHjG5jb4jDFpaMm/
 SszYFdR5bybqpTpi5OCCGzLGKw5MD5Lpkmt+hZC1mhiddPmqw1u4TL9oQQP/1SzgtA+d
 N+iZLwLw+TkHwrzwATSzcrz28P3dEUZ5zBX4uHcV24tES67dbZzgcSyINTj1d7FolXks
 XtSWP5lYBH4E64rTguxsES99y4/UtmLweeXOjk9Oi/8j1Ojj5TCF0NcePQbzYKEqDtCf
 hWwpUlmuzjMD6vPfeHMqyzzIXta98KwHYsHAulpNdcwPiZz3qTvPtkbJlKmxtPSkr4Yc
 Dv3g==
X-Gm-Message-State: AC+VfDzwAQQDpwHuA9z+ixDIvMgGuWltSC867O52Svf+fciHzVWTMN6d
 ge4hcEzWf/lLYeJinFQ5R77xjR6AKzR35IF8lWA=
X-Google-Smtp-Source: ACHHUZ6y5jWo5k0mlA6//yYtIZNp1KlyCRbj2uLXR5VKy6NO2YxBg7p6XjbSsGFbc1k4t6NgrP0ScQ==
X-Received: by 2002:a17:90a:8a92:b0:253:342b:a14e with SMTP id
 x18-20020a17090a8a9200b00253342ba14emr11860808pjn.21.1684809847392; 
 Mon, 22 May 2023 19:44:07 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:44:07 -0700 (PDT)
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
Subject: [PATCH v5 04/48] igb: Fix Rx packet type encoding
Date: Tue, 23 May 2023 11:42:55 +0900
Message-Id: <20230523024339.50875-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1032;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1032.google.com
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

igb's advanced descriptor uses a packet type encoding different from
one used in e1000e's extended descriptor. Fix the logic to encode
Rx packet type accordingly.

Fixes: 3a977deebe ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 hw/net/igb_regs.h |  5 +++++
 hw/net/igb_core.c | 38 +++++++++++++++++++-------------------
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index c5c5b3c3b8..21ee9a3b2d 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -641,6 +641,11 @@ union e1000_adv_rx_desc {
 
 #define E1000_STATUS_NUM_VFS_SHIFT 14
 
+#define E1000_ADVRXD_PKT_IP4 BIT(4)
+#define E1000_ADVRXD_PKT_IP6 BIT(6)
+#define E1000_ADVRXD_PKT_TCP BIT(8)
+#define E1000_ADVRXD_PKT_UDP BIT(9)
+
 static inline uint8_t igb_ivar_entry_rx(uint8_t i)
 {
     return i < 8 ? i * 4 : (i - 8) * 4 + 2;
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 464a41d0aa..dbd1192a8e 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1227,7 +1227,6 @@ igb_build_rx_metadata(IGBCore *core,
     struct virtio_net_hdr *vhdr;
     bool hasip4, hasip6;
     EthL4HdrProto l4hdr_proto;
-    uint32_t pkt_type;
 
     *status_flags = E1000_RXD_STAT_DD;
 
@@ -1266,28 +1265,29 @@ igb_build_rx_metadata(IGBCore *core,
         trace_e1000e_rx_metadata_ack();
     }
 
-    if (hasip6 && (core->mac[RFCTL] & E1000_RFCTL_IPV6_DIS)) {
-        trace_e1000e_rx_metadata_ipv6_filtering_disabled();
-        pkt_type = E1000_RXD_PKT_MAC;
-    } else if (l4hdr_proto == ETH_L4_HDR_PROTO_TCP ||
-               l4hdr_proto == ETH_L4_HDR_PROTO_UDP) {
-        pkt_type = hasip4 ? E1000_RXD_PKT_IP4_XDP : E1000_RXD_PKT_IP6_XDP;
-    } else if (hasip4 || hasip6) {
-        pkt_type = hasip4 ? E1000_RXD_PKT_IP4 : E1000_RXD_PKT_IP6;
-    } else {
-        pkt_type = E1000_RXD_PKT_MAC;
-    }
+    if (pkt_info) {
+        *pkt_info = rss_info->enabled ? rss_info->type : 0;
 
-    trace_e1000e_rx_metadata_pkt_type(pkt_type);
+        if (hasip4) {
+            *pkt_info |= E1000_ADVRXD_PKT_IP4;
+        }
 
-    if (pkt_info) {
-        if (rss_info->enabled) {
-            *pkt_info = rss_info->type;
+        if (hasip6) {
+            *pkt_info |= E1000_ADVRXD_PKT_IP6;
         }
 
-        *pkt_info |= (pkt_type << 4);
-    } else {
-        *status_flags |= E1000_RXD_PKT_TYPE(pkt_type);
+        switch (l4hdr_proto) {
+        case ETH_L4_HDR_PROTO_TCP:
+            *pkt_info |= E1000_ADVRXD_PKT_TCP;
+            break;
+
+        case ETH_L4_HDR_PROTO_UDP:
+            *pkt_info |= E1000_ADVRXD_PKT_UDP;
+            break;
+
+        default:
+            break;
+        }
     }
 
     if (hdr_info) {
-- 
2.40.1


