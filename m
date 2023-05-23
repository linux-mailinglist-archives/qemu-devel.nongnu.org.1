Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B15A570D189
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:45:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I1K-00041W-Fx; Mon, 22 May 2023 22:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I18-0003iK-O5
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:54 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I16-0004BB-AC
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:53 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2537909d28cso3057746a91.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809891; x=1687401891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UifktMeAdutabcyCUI8IkLHFZre8mrFjn86ns+XayeQ=;
 b=N/vLcjw1woIjUsN14GCrK2me6wVcNNf7vI08nTTqsEoRaQArhy7RWgExMe61CTdEzM
 JLeexC88aI3sQsRt0Egt/QaVQrdUXOzyRqdw++sFFnnMaJCKpFExStIHW1WHevBQnaUt
 GFOGUqcjK4yMjxJ9Eu+tk/Txx5RW391giUsC5Y6acxQWjhaDuyIHpQVuxTN+6EPnQ5y2
 o9amKMGv/U7j/WeMNhK6fIeQu7pinisPNlbxZCca2taG9mhnHhZhFcoDK0GlJIIeI4PY
 yXOzF2g0NhgcWyOJ9S9WHnfbpmHnqudJA91n3z2BplWBfMVu8ipYkVqXiZS9OTLjWASd
 jBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809891; x=1687401891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UifktMeAdutabcyCUI8IkLHFZre8mrFjn86ns+XayeQ=;
 b=FlARUaxKCZXL/GcOdwQJk4QSs/k9P9FopYnTXClesUSLex8r+zAyLi4Ypyrxyze3BG
 0ZHEL34dC2LIQDKo1PeNuMuM7voAV+g0OfZ9VMXe9YwmPOkK/elkMkTd7Sd9z1Vbe17S
 PVjX909wa7Gnlcd+EOGAiDPyQdIPGRUo3RhZZfWUqo4HCWkaBJjSdyetppsB1wnAqdXY
 0iJR/MC6/ih4i8bd4Bjr4HIz1YLt1zCE5eV6OuO5kj9FMr46hsX7LdaVgZ/hz8XvE4ac
 6+x2Sk3ZQ8el2snb9rt+SZU/aXP/ELZzzCGvA3SIE2OO3pe5fJ8Cl+RAIJ0N5zAFNEEj
 VPpA==
X-Gm-Message-State: AC+VfDxUkDUrY8vfkB4mBdYzMRS0pz0wpjARCstWXySDaBgrI9K0hgCw
 yAlUFq/X5Rq5wQk+0q3FxtM2HQ==
X-Google-Smtp-Source: ACHHUZ48T5gj87ItOuWacfombavxbjDpSiFKbI4lGMksxMm/OwHCtHSiHCreXMdUFhCnWrP+XwGLqQ==
X-Received: by 2002:a17:90a:928a:b0:23a:ad68:25a7 with SMTP id
 n10-20020a17090a928a00b0023aad6825a7mr12244256pjo.2.1684809891220; 
 Mon, 22 May 2023 19:44:51 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:44:50 -0700 (PDT)
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
Subject: [PATCH v5 17/48] e1000x: Rename TcpIpv6 into TcpIpv6Ex
Date: Tue, 23 May 2023 11:43:08 +0900
Message-Id: <20230523024339.50875-18-akihiko.odaki@daynix.com>
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

e1000e and igb employs NetPktRssIpV6TcpEx for RSS hash if TcpIpv6 MRQC
bit is set. Moreover, igb also has a MRQC bit for NetPktRssIpV6Tcp
though it is not implemented yet. Rename it to TcpIpv6Ex to avoid
confusion.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 hw/net/e1000x_regs.h | 24 ++++++++++++------------
 hw/net/e1000e_core.c |  8 ++++----
 hw/net/igb_core.c    |  8 ++++----
 hw/net/trace-events  |  2 +-
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/hw/net/e1000x_regs.h b/hw/net/e1000x_regs.h
index 6d3c4c6d3a..13760c66d3 100644
--- a/hw/net/e1000x_regs.h
+++ b/hw/net/e1000x_regs.h
@@ -290,18 +290,18 @@
 #define E1000_RETA_IDX(hash)        ((hash) & (BIT(7) - 1))
 #define E1000_RETA_VAL(reta, hash)  (((uint8_t *)(reta))[E1000_RETA_IDX(hash)])
 
-#define E1000_MRQC_EN_TCPIPV4(mrqc) ((mrqc) & BIT(16))
-#define E1000_MRQC_EN_IPV4(mrqc)    ((mrqc) & BIT(17))
-#define E1000_MRQC_EN_TCPIPV6(mrqc) ((mrqc) & BIT(18))
-#define E1000_MRQC_EN_IPV6EX(mrqc)  ((mrqc) & BIT(19))
-#define E1000_MRQC_EN_IPV6(mrqc)    ((mrqc) & BIT(20))
-
-#define E1000_MRQ_RSS_TYPE_NONE     (0)
-#define E1000_MRQ_RSS_TYPE_IPV4TCP  (1)
-#define E1000_MRQ_RSS_TYPE_IPV4     (2)
-#define E1000_MRQ_RSS_TYPE_IPV6TCP  (3)
-#define E1000_MRQ_RSS_TYPE_IPV6EX   (4)
-#define E1000_MRQ_RSS_TYPE_IPV6     (5)
+#define E1000_MRQC_EN_TCPIPV4(mrqc)   ((mrqc) & BIT(16))
+#define E1000_MRQC_EN_IPV4(mrqc)      ((mrqc) & BIT(17))
+#define E1000_MRQC_EN_TCPIPV6EX(mrqc) ((mrqc) & BIT(18))
+#define E1000_MRQC_EN_IPV6EX(mrqc)    ((mrqc) & BIT(19))
+#define E1000_MRQC_EN_IPV6(mrqc)      ((mrqc) & BIT(20))
+
+#define E1000_MRQ_RSS_TYPE_NONE       (0)
+#define E1000_MRQ_RSS_TYPE_IPV4TCP    (1)
+#define E1000_MRQ_RSS_TYPE_IPV4       (2)
+#define E1000_MRQ_RSS_TYPE_IPV6TCPEX  (3)
+#define E1000_MRQ_RSS_TYPE_IPV6EX     (4)
+#define E1000_MRQ_RSS_TYPE_IPV6       (5)
 
 #define E1000_ICR_ASSERTED BIT(31)
 #define E1000_EIAC_MASK    0x01F00000
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 41d2435074..38d465a203 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -537,7 +537,7 @@ e1000e_rss_get_hash_type(E1000ECore *core, struct NetRxPkt *pkt)
                                 ip6info->rss_ex_dst_valid,
                                 ip6info->rss_ex_src_valid,
                                 core->mac[MRQC],
-                                E1000_MRQC_EN_TCPIPV6(core->mac[MRQC]),
+                                E1000_MRQC_EN_TCPIPV6EX(core->mac[MRQC]),
                                 E1000_MRQC_EN_IPV6EX(core->mac[MRQC]),
                                 E1000_MRQC_EN_IPV6(core->mac[MRQC]));
 
@@ -546,8 +546,8 @@ e1000e_rss_get_hash_type(E1000ECore *core, struct NetRxPkt *pkt)
                               ip6info->rss_ex_src_valid))) {
 
             if (l4hdr_proto == ETH_L4_HDR_PROTO_TCP &&
-                E1000_MRQC_EN_TCPIPV6(core->mac[MRQC])) {
-                return E1000_MRQ_RSS_TYPE_IPV6TCP;
+                E1000_MRQC_EN_TCPIPV6EX(core->mac[MRQC])) {
+                return E1000_MRQ_RSS_TYPE_IPV6TCPEX;
             }
 
             if (E1000_MRQC_EN_IPV6EX(core->mac[MRQC])) {
@@ -581,7 +581,7 @@ e1000e_rss_calc_hash(E1000ECore *core,
     case E1000_MRQ_RSS_TYPE_IPV4TCP:
         type = NetPktRssIpV4Tcp;
         break;
-    case E1000_MRQ_RSS_TYPE_IPV6TCP:
+    case E1000_MRQ_RSS_TYPE_IPV6TCPEX:
         type = NetPktRssIpV6TcpEx;
         break;
     case E1000_MRQ_RSS_TYPE_IPV6:
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 934db3c3e5..209fdad862 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -301,7 +301,7 @@ igb_rss_get_hash_type(IGBCore *core, struct NetRxPkt *pkt)
                                 ip6info->rss_ex_dst_valid,
                                 ip6info->rss_ex_src_valid,
                                 core->mac[MRQC],
-                                E1000_MRQC_EN_TCPIPV6(core->mac[MRQC]),
+                                E1000_MRQC_EN_TCPIPV6EX(core->mac[MRQC]),
                                 E1000_MRQC_EN_IPV6EX(core->mac[MRQC]),
                                 E1000_MRQC_EN_IPV6(core->mac[MRQC]));
 
@@ -310,8 +310,8 @@ igb_rss_get_hash_type(IGBCore *core, struct NetRxPkt *pkt)
                               ip6info->rss_ex_src_valid))) {
 
             if (l4hdr_proto == ETH_L4_HDR_PROTO_TCP &&
-                E1000_MRQC_EN_TCPIPV6(core->mac[MRQC])) {
-                return E1000_MRQ_RSS_TYPE_IPV6TCP;
+                E1000_MRQC_EN_TCPIPV6EX(core->mac[MRQC])) {
+                return E1000_MRQ_RSS_TYPE_IPV6TCPEX;
             }
 
             if (E1000_MRQC_EN_IPV6EX(core->mac[MRQC])) {
@@ -343,7 +343,7 @@ igb_rss_calc_hash(IGBCore *core, struct NetRxPkt *pkt, E1000E_RSSInfo *info)
     case E1000_MRQ_RSS_TYPE_IPV4TCP:
         type = NetPktRssIpV4Tcp;
         break;
-    case E1000_MRQ_RSS_TYPE_IPV6TCP:
+    case E1000_MRQ_RSS_TYPE_IPV6TCPEX:
         type = NetPktRssIpV6TcpEx;
         break;
     case E1000_MRQ_RSS_TYPE_IPV6:
diff --git a/hw/net/trace-events b/hw/net/trace-events
index a34d196ff7..64d776bc2a 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -179,7 +179,7 @@ e1000e_rx_rss_disabled(void) "RSS is disabled"
 e1000e_rx_rss_type(uint32_t type) "RSS type is %u"
 e1000e_rx_rss_ip4(int l4hdr_proto, uint32_t mrqc, bool tcpipv4_enabled, bool ipv4_enabled) "RSS IPv4: L4 header protocol %d, mrqc 0x%X, tcpipv4 enabled %d, ipv4 enabled %d"
 e1000e_rx_rss_ip6_rfctl(uint32_t rfctl) "RSS IPv6: rfctl 0x%X"
-e1000e_rx_rss_ip6(bool ex_dis, bool new_ex_dis, int l4hdr_proto, bool has_ext_headers, bool ex_dst_valid, bool ex_src_valid, uint32_t mrqc, bool tcpipv6_enabled, bool ipv6ex_enabled, bool ipv6_enabled) "RSS IPv6: ex_dis: %d, new_ex_dis: %d, L4 header protocol %d, has_ext_headers %d, ex_dst_valid %d, ex_src_valid %d, mrqc 0x%X, tcpipv6 enabled %d, ipv6ex enabled %d, ipv6 enabled %d"
+e1000e_rx_rss_ip6(bool ex_dis, bool new_ex_dis, int l4hdr_proto, bool has_ext_headers, bool ex_dst_valid, bool ex_src_valid, uint32_t mrqc, bool tcpipv6ex_enabled, bool ipv6ex_enabled, bool ipv6_enabled) "RSS IPv6: ex_dis: %d, new_ex_dis: %d, L4 header protocol %d, has_ext_headers %d, ex_dst_valid %d, ex_src_valid %d, mrqc 0x%X, tcpipv6ex enabled %d, ipv6ex enabled %d, ipv6 enabled %d"
 
 e1000e_rx_metadata_protocols(bool hasip4, bool hasip6, int l4hdr_protocol) "protocols: ip4: %d, ip6: %d, l4hdr: %d"
 e1000e_rx_metadata_vlan(uint16_t vlan_tag) "VLAN tag is 0x%X"
-- 
2.40.1


