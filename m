Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B4270D1A5
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:48:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I1A-0003f5-Ol; Mon, 22 May 2023 22:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0v-0003NI-Sz
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:42 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0u-00049a-Fd
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:41 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-64d41763796so2471466b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809877; x=1687401877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oERuBkIJa1L84Gt8ryLl7gNohjOzEDyL2xcegi4Ja6g=;
 b=QPf66iLAkgqfsee4XxIXi4Tc/b5SPCzFyaQHadNX8RYMVVk6e6TYX4ho0XAdd43CyH
 38UpKbJylUMObjvRUGCl/UTcNps5TpTeVtQl9GBfG1Asui+hc90QCDmCd8012LvsXAnV
 XGJ47y0PUNfs+29G0K7NidUEnoXKAofeIcNUUtl9WXVt7lP0AbLeV7xayJeKXXyJXop+
 XTCFwWcERYgI3+VfIk1dsI14gu/PfqSuM28lK2yiQGYH9kdpFiVsACMTfnjzI/JG8EJ6
 peTSR07NAZ90/goawRfiFLAEJmVbX1zajiEzKRruDtWewwnbLqftkDh1+ypKuSjpQKu6
 RMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809877; x=1687401877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oERuBkIJa1L84Gt8ryLl7gNohjOzEDyL2xcegi4Ja6g=;
 b=d56j+qp3QTSm+y2TYftlp0pHjDAr8a4BrdhwsBeApeyBt1Dx8R5ApHa5TNacpyPcdl
 FT/goFAZJzzo69ufStlDIgp0WhjwQC3e83xP6RtCnr8hPel/bfcYw5UXQ8qt09VKmiwj
 sTYYHI+nB87vsR5jtZtlauYPyJm1jMdursXvHgUT9WTp9RPHm9+X99BNIxG8tKqGhihM
 sLAseCBqzSrOCn8w8JtcuelCod4ULLCBt5fPqc4PiPQh/6yk4DsDhxvhv7VS5WEeLm8t
 BlrcDLdTzI8lax9VZCI0R8dbNPR1wkUgOAR06885AajAGjQcBdlqVPQJ0PHYL7TbY5F8
 9x0w==
X-Gm-Message-State: AC+VfDxhRlnFuAwtjytFt3zSOFTHydclSC62Ha1MzAb4nXC1TXWVLWek
 p7u9Iem6ZpFVNJRBYkROjFnlCQ==
X-Google-Smtp-Source: ACHHUZ599roCzTaznZJ/4hnpA6OQHYNnuzoma7Ywg5LlQWBUEU7gd2ohvHCarPZwl2v07YTEJAKw3g==
X-Received: by 2002:a05:6a21:6da5:b0:10b:78d6:a2c8 with SMTP id
 wl37-20020a056a216da500b0010b78d6a2c8mr6113556pzb.15.1684809877766; 
 Mon, 22 May 2023 19:44:37 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:44:37 -0700 (PDT)
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
Subject: [PATCH v5 13/48] hw/net/net_tx_pkt: Remove net_rx_pkt_get_l4_info
Date: Tue, 23 May 2023 11:43:04 +0900
Message-Id: <20230523024339.50875-14-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
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

This function is not used.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/net_rx_pkt.h | 9 ---------
 hw/net/net_rx_pkt.c | 5 -----
 2 files changed, 14 deletions(-)

diff --git a/hw/net/net_rx_pkt.h b/hw/net/net_rx_pkt.h
index a06f5c2675..ce8dbdb284 100644
--- a/hw/net/net_rx_pkt.h
+++ b/hw/net/net_rx_pkt.h
@@ -119,15 +119,6 @@ eth_ip6_hdr_info *net_rx_pkt_get_ip6_info(struct NetRxPkt *pkt);
  */
 eth_ip4_hdr_info *net_rx_pkt_get_ip4_info(struct NetRxPkt *pkt);
 
-/**
- * fetches L4 header analysis results
- *
- * Return:  pointer to analysis results structure which is stored in internal
- *          packet area.
- *
- */
-eth_l4_hdr_info *net_rx_pkt_get_l4_info(struct NetRxPkt *pkt);
-
 typedef enum {
     NetPktRssIpV4,
     NetPktRssIpV4Tcp,
diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 63be6e05ad..6125a063d7 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -236,11 +236,6 @@ eth_ip4_hdr_info *net_rx_pkt_get_ip4_info(struct NetRxPkt *pkt)
     return &pkt->ip4hdr_info;
 }
 
-eth_l4_hdr_info *net_rx_pkt_get_l4_info(struct NetRxPkt *pkt)
-{
-    return &pkt->l4hdr_info;
-}
-
 static inline void
 _net_rx_rss_add_chunk(uint8_t *rss_input, size_t *bytes_written,
                       void *ptr, size_t size)
-- 
2.40.1


