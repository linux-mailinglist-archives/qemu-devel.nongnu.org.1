Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E7770D19A
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:47:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I2C-0007eX-D8; Mon, 22 May 2023 22:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1o-000683-I0
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:38 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1k-0004ai-W0
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:35 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-253724f6765so4201036a91.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809931; x=1687401931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XmNEAS5k04F+fR8LffeAMeCi/ZTE8MQ4RgwXqTV1U6o=;
 b=nwaLTyd0BNDxX1CL2n1NZGz65VvcaIQO976VvChdAvN5lU4yKaHkluNK7PdYZNWN5R
 fz2ZFW64jg4x/Id/fhoBs5nT6r0ZiZmt2N10oTCAuOCNypa8JALy3m0sTZpzOLvTaq9B
 cyFE0oAcJs64CTFexnCMM+OqKEDhzRBENcg+jyvywJWqfLEAcjw4TfiiuCb5ZaXIG2aY
 tNuThj4MOyf0oVj8DTPTl5qMoTr5qIMImChBo5as89R4HnZBR2akvO0Un8FH0Ij0P48s
 sxEzV4YrYpN652cAoeuTZNFmnhw+mhHS74Bfb1pUVJejbVIHHVXSVM1Pw1kUQoRf0cJL
 NDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809931; x=1687401931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XmNEAS5k04F+fR8LffeAMeCi/ZTE8MQ4RgwXqTV1U6o=;
 b=M8DuiidrZiWZv+zeMbXRTD5x9vVJ6t5e1ByS+HZfw8TgpYqAgjs2fWuWm2h/Pw7G9B
 d7oD0DsQfyVS/o3iT57chUCyOGl6/f8tLDkeNwI3AFVIiPEyhMqQu8qzBj/VFuk/mSQJ
 6WfzL0x2oHdCh7tgfPKKJ69pjaxm0YFHWWoOeAJWf6hNIXKK6fKf3wJCRwPSxUV5gikq
 piI04sw/sZS5Rf2PlIoUKzuWRU1Et8HejaheN+S0jzfg/47KAnCS74tm2caYXlGoX8Yz
 ltGT+3GgAdfZCjc138Lhz8c+dese3eYz6l4KzYU/USMKgAmQkcS8uYOewbR8HD0AY4G2
 j0vQ==
X-Gm-Message-State: AC+VfDywqsx2ULwnOffIZjA+kzk5h0kncoMLzwq9BIYyvf+mr7Jthfg3
 X6v6/ndlShLEjOPLubvpanGT7w==
X-Google-Smtp-Source: ACHHUZ7Sbe6Y6o2P6JEQgvRN+RL90BdGfMdv9Tz1AjCRJzsMYSPqgHJIiH4SNxzZQneyR+QZQPBT6w==
X-Received: by 2002:a17:90b:4b51:b0:255:8a12:241b with SMTP id
 mi17-20020a17090b4b5100b002558a12241bmr2509828pjb.22.1684809931715; 
 Mon, 22 May 2023 19:45:31 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:45:31 -0700 (PDT)
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
Subject: [PATCH v5 29/48] igb: Rename a variable in igb_receive_internal()
Date: Tue, 23 May 2023 11:43:20 +0900
Message-Id: <20230523024339.50875-30-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
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

Rename variable "n" to "causes", which properly represents the content
of the variable.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 hw/net/igb_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index edda07e564..c954369964 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1569,7 +1569,7 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
                      bool has_vnet, bool *external_tx)
 {
     uint16_t queues = 0;
-    uint32_t n = 0;
+    uint32_t causes = 0;
     union {
         L2Header l2_header;
         uint8_t octets[ETH_ZLEN];
@@ -1649,19 +1649,19 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
             e1000x_fcs_len(core->mac);
 
         if (!igb_has_rxbufs(core, rxr.i, total_size)) {
-            n |= E1000_ICS_RXO;
+            causes |= E1000_ICS_RXO;
             trace_e1000e_rx_not_written_to_guest(rxr.i->idx);
             continue;
         }
 
-        n |= E1000_ICR_RXDW;
+        causes |= E1000_ICR_RXDW;
 
         igb_rx_fix_l4_csum(core, core->rx_pkt);
         igb_write_packet_to_guest(core, core->rx_pkt, &rxr, &rss_info);
 
         /* Check if receive descriptor minimum threshold hit */
         if (igb_rx_descr_threshold_hit(core, rxr.i)) {
-            n |= E1000_ICS_RXDMT0;
+            causes |= E1000_ICS_RXDMT0;
         }
 
         core->mac[EICR] |= igb_rx_wb_eic(core, rxr.i->idx);
@@ -1669,8 +1669,8 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
         trace_e1000e_rx_written_to_guest(rxr.i->idx);
     }
 
-    trace_e1000e_rx_interrupt_set(n);
-    igb_set_interrupt_cause(core, n);
+    trace_e1000e_rx_interrupt_set(causes);
+    igb_set_interrupt_cause(core, causes);
 
     return orig_size;
 }
-- 
2.40.1


