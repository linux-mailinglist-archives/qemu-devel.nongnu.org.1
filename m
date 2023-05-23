Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E571470D19D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:47:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I25-0006gy-1a; Mon, 22 May 2023 22:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1i-0005vg-Kh
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:32 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1c-0004Sq-6U
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:29 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-53469299319so4084662a12.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809921; x=1687401921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WASY6DGju7Fn/10kqZP743Zopo9BmHeIwCDBmzoRfa8=;
 b=lY3IojkAVKf+zm+bBd4I2IHN4yqYqUF2M8wuOrqe2b7OnIf4/AmrUXRdfGAut6Fj4G
 zKJQ6mO4S+kXoix5UHXvI9Zk+r/u80J0EjTfnS+i2I2b5YfmBQ7Sl6NUD+/3Jp9rIRie
 STfljFPrQAF/ELDjTVYpqgH1/PkrjAMD4JMfKG1hFVhygVp/BHucKlH2yQRLRs1wn9fM
 /D9WaqnxLIhl+ruJxLNOg32khozf6sqB2uOoBBPA88OOE2tpNt0g9uuLXJIMTYfjPKhs
 LMtz3c76pBuvqEFff3x1EpdmKQiA2p4o4CKSA7tcxX20iU0c39Ig9vMv2NBOXIdSyVOC
 8XSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809921; x=1687401921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WASY6DGju7Fn/10kqZP743Zopo9BmHeIwCDBmzoRfa8=;
 b=O+CO/7G9TdE+qi9tk9wlI7OFYY2t0983ao/9li4aAgh4hNTMaeGyqbZYsAXAIdSQkG
 0V3uJ+AZ4MtlusIfjtwsBC175LT7m4LOATIscjlLYxfljcMA+R2z3ywXeS8iliJz8g5N
 AWoYLoRghE1mrQz3E/0/UAbr+qF0k9yZcv3T9rPyuv7SVio6m/R26h0woFZGHElUeow0
 TA9VoQrJNqQ1vIw6zFIPV6cdO6CY2b4lyIR/5fW1q2u57gM9vTHHHp6m1bPHKnTreb87
 UigJgTi1Zd3NJrOJQex5LPCkCf24NS1C8W+P6Ys1bjqQoxdi0NlQoVQ5kRHOPrI8Lh2n
 WgmA==
X-Gm-Message-State: AC+VfDx28f3yqX3ZDNl7pgaeOO4NU5UTRlp88BNSGtGiikZzneTl0u43
 clsxGWeUl/WWRS0CHah4z6o+eg==
X-Google-Smtp-Source: ACHHUZ6O/kji4Hqu6uniAj4aYzZxOu1HaQpkVzPyGwfm9EeEGVZCYpOw2oILeSKW9t3Tq7q+5wwwTA==
X-Received: by 2002:a17:90a:c405:b0:24e:4cf8:235 with SMTP id
 i5-20020a17090ac40500b0024e4cf80235mr11675626pjt.0.1684809921468; 
 Mon, 22 May 2023 19:45:21 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:45:21 -0700 (PDT)
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
Subject: [PATCH v5 26/48] igb: Fix igb_mac_reg_init coding style alignment
Date: Tue, 23 May 2023 11:43:17 +0900
Message-Id: <20230523024339.50875-27-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/igb_core.c | 96 +++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 56a53872cf..20645c4764 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -4027,54 +4027,54 @@ static const uint32_t igb_mac_reg_init[] = {
     [VMOLR0 ... VMOLR0 + 7] = 0x2600 | E1000_VMOLR_STRCRC,
     [RPLOLR]        = E1000_RPLOLR_STRCRC,
     [RLPML]         = 0x2600,
-    [TXCTL0]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL1]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL2]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL3]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL4]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL5]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL6]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL7]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL8]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL9]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL10]      = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL11]      = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL12]      = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL13]      = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL14]      = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL15]      = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL0]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL1]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL2]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL3]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL4]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL5]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL6]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL7]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL8]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL9]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL10]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL11]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL12]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL13]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL14]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL15]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
 };
 
 static void igb_reset(IGBCore *core, bool sw)
-- 
2.40.1


