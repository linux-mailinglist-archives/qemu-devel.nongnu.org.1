Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C06CD70D1A4
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:48:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I2D-00083v-Fv; Mon, 22 May 2023 22:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1w-0006SB-SB
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:45 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1v-0004d9-1E
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:44 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2533d3acd5fso6007872a91.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809941; x=1687401941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pMCpACAZge1E4OQs9mXGD6eSM6O8EW4vtTqVXgW72I4=;
 b=T1M2chITuV3DwPbKV6WBdivm1io9j04w9yDRDQAu7MF20rJlj0IxSMlorlos445WbU
 BUUF7lDpfpFqqyjaUIplXS5u4Jm896Eqrw/IwDXhxrF5J3zTwxnlddILS9kzUKsA3ys7
 6h0KV9cO6CAXvxHTDqm5vmVCA911Ls8Iz7xZ6FIXO3aE3eFujxMGzh40rUpqoO+/uzgB
 ZG0UXW4hSVXOS3VZZXcHuHPy7fOCYbEzwDQR+o4VOVhxZ9UYMhAKJVw+nDUZE2TTo4Sy
 jXU/V0GJL3PVaRaoemboj+3aZCPWbbjx03m5oTiDx3E46O+sQtzajOlb9gjkwgg/sfbe
 qyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809941; x=1687401941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pMCpACAZge1E4OQs9mXGD6eSM6O8EW4vtTqVXgW72I4=;
 b=PZEQZ2vNjYtUYAUmeupPCofsSuwI0IvLLgnKOzoTA63B6FhnGh59FfdAsw8vYn87Su
 ObU/pTsaC3Wkfm57WOjajEjxU79pJhtdVbNGmxl6ciD1KyiIW10PrN1QdBTjn53L09No
 R7HqF/wA0d7Vox/KVBgM/cOxwMQ2ljsLdugxlb5cKmCC+/N3D+ntARTo8NXBYOFLDrEF
 sax+k7YDcV1jw56fMGzmgbS1N/FxESfS3PY7l4CfSfhjxLMp1MF3n5p6IPYA2Uag+WBM
 s4lWUAG1fjWBi11b0R7uc9Ie2AfOC93MLqXdLvw7YVCacOolCMiatURmLzGknfv5LhAJ
 31yw==
X-Gm-Message-State: AC+VfDyGLWSoOSYI+2mt1wrtU6frrA4dHoj2aaxRxmPaFGZyup0H63ye
 vcCFUkxXMA7GCaEb1WB0aWelDQ==
X-Google-Smtp-Source: ACHHUZ6tiKeNipM3Qo9iZNeSHUCJmpuob93VXbTIMAzoHQ/loJPtuybR2T9wH0fnRoalQXdDCiyQ8A==
X-Received: by 2002:a17:90b:3587:b0:24d:ebfe:be93 with SMTP id
 mm7-20020a17090b358700b0024debfebe93mr11613177pjb.37.1684809941721; 
 Mon, 22 May 2023 19:45:41 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:45:41 -0700 (PDT)
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
Subject: [PATCH v5 32/48] hw/net/net_rx_pkt: Enforce alignment for eth_header
Date: Tue, 23 May 2023 11:43:23 +0900
Message-Id: <20230523024339.50875-33-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1029;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1029.google.com
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

eth_strip_vlan and eth_strip_vlan_ex refers to ehdr_buf as struct
eth_header. Enforce alignment for the structure.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 hw/net/net_rx_pkt.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 6125a063d7..1de42b4f51 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -23,7 +23,10 @@
 
 struct NetRxPkt {
     struct virtio_net_hdr virt_hdr;
-    uint8_t ehdr_buf[sizeof(struct eth_header) + sizeof(struct vlan_header)];
+    struct {
+        struct eth_header eth;
+        struct vlan_header vlan;
+    } ehdr_buf;
     struct iovec *vec;
     uint16_t vec_len_total;
     uint16_t vec_len;
@@ -89,7 +92,7 @@ net_rx_pkt_pull_data(struct NetRxPkt *pkt,
     if (pkt->ehdr_buf_len) {
         net_rx_pkt_iovec_realloc(pkt, iovcnt + 1);
 
-        pkt->vec[0].iov_base = pkt->ehdr_buf;
+        pkt->vec[0].iov_base = &pkt->ehdr_buf;
         pkt->vec[0].iov_len = pkt->ehdr_buf_len;
 
         pkt->tot_len = pllen + pkt->ehdr_buf_len;
@@ -120,7 +123,7 @@ void net_rx_pkt_attach_iovec(struct NetRxPkt *pkt,
     assert(pkt);
 
     if (strip_vlan) {
-        pkt->ehdr_buf_len = eth_strip_vlan(iov, iovcnt, iovoff, pkt->ehdr_buf,
+        pkt->ehdr_buf_len = eth_strip_vlan(iov, iovcnt, iovoff, &pkt->ehdr_buf,
                                            &ploff, &tci);
     } else {
         pkt->ehdr_buf_len = 0;
@@ -142,7 +145,7 @@ void net_rx_pkt_attach_iovec_ex(struct NetRxPkt *pkt,
 
     if (strip_vlan) {
         pkt->ehdr_buf_len = eth_strip_vlan_ex(iov, iovcnt, iovoff, vet,
-                                              pkt->ehdr_buf,
+                                              &pkt->ehdr_buf,
                                               &ploff, &tci);
     } else {
         pkt->ehdr_buf_len = 0;
-- 
2.40.1


