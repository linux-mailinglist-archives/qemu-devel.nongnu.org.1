Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4D570D1C1
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:49:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I17-0003Sv-Hj; Mon, 22 May 2023 22:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0x-0003Or-Sn
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:44 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0w-00049u-BR
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:43 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-25376483f66so3223760a91.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809881; x=1687401881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=As44EvDKe5F3A7y2pEDwPEQkJZ3O6lbWcqZylXZFXdQ=;
 b=vsoHaZfZKza3Fjq1fv+4QHj77uBEIKPqaSF/eol8+rMDabfKtbdPbQ0WLSX7E+K0w/
 gF+LgRuD2XUpdn0ammlbdbz+krbXJiBAiywQ60T+5kFqzV+mn30CVKoPa/QGhTPQevhg
 EJalScgbiKPkXszqDmynyQuTfZM/7gjB5Kl3DicUGNSfMnch7PIBRrJkBQKb7k+1WPxK
 uHCDnnOSRBqfMgjgopYQEdgYcC/pGsfnimZ2FmgUAvaqH3yQr5CwsVy0z8XxhwRZ8GV9
 ZlQbcon2a67vCUnkWa7VcEkdR0oFBkjSjScT4zSt52LeHKoz7vdJAfEFBwnsusYwkltd
 DpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809881; x=1687401881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=As44EvDKe5F3A7y2pEDwPEQkJZ3O6lbWcqZylXZFXdQ=;
 b=hkh0KYVJr7gQU+pP6F95HdQS22CRyyF/Hfianbc+cO8Wk/jS5F7Qd58XM2rp/ZEZoE
 e7XH6TrtgOmmJky8do0cqJpg/PF+OXdwqKnldk2p/lBuSwb2kG2eyuTyW5Tw0rSyL8dM
 Up8Yx4kyl6aK0NFP+MbmRjGaSrHCoPM4iEADYVD/RjQZovXqWYnGlp0zjNinU6OjIG3L
 Hzj05msQRgVTPdi70KnQI1E9kRIvKtbXt0/51TPbC4hPOeCvWx/MtFxfSyNczzmpyp5G
 lSLT/MuqLnrB8UWaLf2LRJkyXtJbieK7X4vtxonx09tmxd1o7sDYFMnpaoV76O9Ul+g4
 5PNQ==
X-Gm-Message-State: AC+VfDwBpp64134hosyoVZGMZtzbK/QKQutZX1Vb5Nk9nz5jEUYxeQNt
 J/Nv0VT/tvJStVw3d7Shdu9DLA==
X-Google-Smtp-Source: ACHHUZ7XjQbYd8ZNRTE3sbWYRzb5pLJb+zbpic0uk8k6RSLnB9EO2LCr7v3ox+AtRcwcjGNwhaUgPg==
X-Received: by 2002:a17:90a:4a07:b0:253:440b:7aed with SMTP id
 e7-20020a17090a4a0700b00253440b7aedmr11930031pjh.32.1684809881128; 
 Mon, 22 May 2023 19:44:41 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:44:40 -0700 (PDT)
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
Subject: [PATCH v5 14/48] net/eth: Rename eth_setup_vlan_headers_ex
Date: Tue, 23 May 2023 11:43:05 +0900
Message-Id: <20230523024339.50875-15-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
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

The old eth_setup_vlan_headers has no user so remove it and rename
eth_setup_vlan_headers_ex.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/net/eth.h   | 9 +--------
 hw/net/net_tx_pkt.c | 2 +-
 net/eth.c           | 2 +-
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index 9f19c3a695..e8af5742be 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -351,16 +351,9 @@ eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
 uint16_t
 eth_get_l3_proto(const struct iovec *l2hdr_iov, int iovcnt, size_t l2hdr_len);
 
-void eth_setup_vlan_headers_ex(struct eth_header *ehdr, uint16_t vlan_tag,
+void eth_setup_vlan_headers(struct eth_header *ehdr, uint16_t vlan_tag,
     uint16_t vlan_ethtype, bool *is_new);
 
-static inline void
-eth_setup_vlan_headers(struct eth_header *ehdr, uint16_t vlan_tag,
-    bool *is_new)
-{
-    eth_setup_vlan_headers_ex(ehdr, vlan_tag, ETH_P_VLAN, is_new);
-}
-
 
 uint8_t eth_get_gso_type(uint16_t l3_proto, uint8_t *l3_hdr, uint8_t l4proto);
 
diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index cc36750c9b..ce6b102391 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -368,7 +368,7 @@ void net_tx_pkt_setup_vlan_header_ex(struct NetTxPkt *pkt,
     bool is_new;
     assert(pkt);
 
-    eth_setup_vlan_headers_ex(pkt->vec[NET_TX_PKT_L2HDR_FRAG].iov_base,
+    eth_setup_vlan_headers(pkt->vec[NET_TX_PKT_L2HDR_FRAG].iov_base,
         vlan, vlan_ethtype, &is_new);
 
     /* update l2hdrlen */
diff --git a/net/eth.c b/net/eth.c
index d7b30df79f..b6ff89c460 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -21,7 +21,7 @@
 #include "net/checksum.h"
 #include "net/tap.h"
 
-void eth_setup_vlan_headers_ex(struct eth_header *ehdr, uint16_t vlan_tag,
+void eth_setup_vlan_headers(struct eth_header *ehdr, uint16_t vlan_tag,
     uint16_t vlan_ethtype, bool *is_new)
 {
     struct vlan_header *vhdr = PKT_GET_VLAN_HDR(ehdr);
-- 
2.40.1


