Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A661D70D1B0
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:48:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I2D-0007s8-7L; Mon, 22 May 2023 22:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I26-0007Gb-TN
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:55 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I25-0004ed-5B
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:54 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-51452556acdso4660017a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809951; x=1687401951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZZBo6RRQOZUntMhhFOSnBgDS6dztaIMnwpdfkd3Tsfk=;
 b=dOrkOBAxmW7dFoOITSh9X9lnbixGFKQH0dG9Uq4VRvnlpEGANDo168yxi5xxhJdRIH
 0DSIzgz15AnFaJzbFaMdDyQs9t4fPyR4Nv4RnHixSZZPMWOeoaDELrPssfUSN8ecSuIM
 YnXgPIKMBQ1X5P3sT9NdJvDMS/bD8I5QbgrPD7cfduPrAHQ22dkXJB5rtqrP2qHLidlU
 wnKdvIjPBmbjR8ljRxXMTMCv0Z+zuncfMWk/XymOola4hi6GhwrINQavUJ1VFz0xFfA3
 RlTjyiKu3fiW672TuC6dQsrvcnN+9WYxpC0PAbcQYqxat/Bb+669aToF/wHY4jH7ysyE
 DB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809951; x=1687401951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZBo6RRQOZUntMhhFOSnBgDS6dztaIMnwpdfkd3Tsfk=;
 b=N1rMwo6iHGWrlG5Bgx4wRl7vE9YLj+7IA3uxaAuOO7yZff8ghNTrDEgN7P0t/VG+db
 KusS883sHjs+x8jsjoJYUrBjnp+R0r1I4UmRZPdKGR/awkChn6qqeBeF7pXgM0zQit/L
 Vk5u2wZg5Zqn50v76JXqf1oByCMvtYhAs+vh4K4Y09jvQcVjTzSlWN+pnNQ14L3triz3
 klPBQrLx0Mii352p3pteGB80BArXvQuSMv/V90CgOlF6XmCB8DyF0nhMu+i7V31R4CiE
 bihBFGOtXAlol7LlZg95ZtyB5elrTJt4JmXUdIdIDBFU1Kk+O/ucQcyC7jm6T1u1bYWr
 YLZg==
X-Gm-Message-State: AC+VfDzbHnjZsoEUXKJSLhiaNdMqX+zIbSsplPdF9L9I7EXK0QbP+n/j
 MrvXAz4tonCOwCdZjR5egYc9vQ==
X-Google-Smtp-Source: ACHHUZ7r6WwWU04o8qaWj71UgpeegKasQKV2yg1VitAB9AYP4I/yS9YNrMZeeIDQw1Ryg7h1TSukjw==
X-Received: by 2002:a17:90b:1d03:b0:24d:fba9:80e9 with SMTP id
 on3-20020a17090b1d0300b0024dfba980e9mr12917511pjb.23.1684809951746; 
 Mon, 22 May 2023 19:45:51 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:45:51 -0700 (PDT)
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
Subject: [PATCH v5 35/48] igb: Use UDP for RSS hash
Date: Tue, 23 May 2023 11:43:26 +0900
Message-Id: <20230523024339.50875-36-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52b.google.com
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

e1000e does not support using UDP for RSS hash, but igb does.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 hw/net/igb_regs.h |  3 +++
 hw/net/igb_core.c | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index eb995d8b2e..e6ac26dc0e 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -659,6 +659,9 @@ union e1000_adv_rx_desc {
 
 #define E1000_RSS_QUEUE(reta, hash) (E1000_RETA_VAL(reta, hash) & 0x0F)
 
+#define E1000_MRQ_RSS_TYPE_IPV4UDP 7
+#define E1000_MRQ_RSS_TYPE_IPV6UDP 8
+
 #define E1000_STATUS_IOV_MODE 0x00040000
 
 #define E1000_STATUS_NUM_VFS_SHIFT 14
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 6d55b43fb4..41a2e5bf7b 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -287,6 +287,11 @@ igb_rss_get_hash_type(IGBCore *core, struct NetRxPkt *pkt)
             return E1000_MRQ_RSS_TYPE_IPV4TCP;
         }
 
+        if (l4hdr_proto == ETH_L4_HDR_PROTO_UDP &&
+            (core->mac[MRQC] & E1000_MRQC_RSS_FIELD_IPV4_UDP)) {
+            return E1000_MRQ_RSS_TYPE_IPV4UDP;
+        }
+
         if (E1000_MRQC_EN_IPV4(core->mac[MRQC])) {
             return E1000_MRQ_RSS_TYPE_IPV4;
         }
@@ -322,6 +327,11 @@ igb_rss_get_hash_type(IGBCore *core, struct NetRxPkt *pkt)
                 return E1000_MRQ_RSS_TYPE_IPV6TCPEX;
             }
 
+            if (l4hdr_proto == ETH_L4_HDR_PROTO_UDP &&
+                (core->mac[MRQC] & E1000_MRQC_RSS_FIELD_IPV6_UDP)) {
+                return E1000_MRQ_RSS_TYPE_IPV6UDP;
+            }
+
             if (E1000_MRQC_EN_IPV6EX(core->mac[MRQC])) {
                 return E1000_MRQ_RSS_TYPE_IPV6EX;
             }
@@ -360,6 +370,12 @@ igb_rss_calc_hash(IGBCore *core, struct NetRxPkt *pkt, E1000E_RSSInfo *info)
     case E1000_MRQ_RSS_TYPE_IPV6EX:
         type = NetPktRssIpV6Ex;
         break;
+    case E1000_MRQ_RSS_TYPE_IPV4UDP:
+        type = NetPktRssIpV4Udp;
+        break;
+    case E1000_MRQ_RSS_TYPE_IPV6UDP:
+        type = NetPktRssIpV6Udp;
+        break;
     default:
         assert(false);
         return 0;
-- 
2.40.1


