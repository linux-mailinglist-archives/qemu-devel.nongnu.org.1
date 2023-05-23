Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FF170D1BA
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:49:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I0V-00037f-IU; Mon, 22 May 2023 22:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0T-00037D-Am
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:13 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0R-00046E-V3
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:13 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ae54b623c2so63707155ad.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809851; x=1687401851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JWGE4S4rPXKGMW5kyd7FDSiXC4WTsYFl6VqGlHNwJvw=;
 b=deFvVzFDSVyWa7zj6ZrW4EW0He6kd/rPaxOjcntAKNwwNj9Dw2zL8SqaCU8jlpxBNK
 jXINVHfDOC8EScG9Xv8G2NTV4IYPnVWFqhhNwv4P6V7vyA6sl3LI4662JUnSM7eYR4W9
 +3nj+8xHilkOpTCcT1EkRd/RlbREfU218cWljEVjPVSOoGLT22ajnJ1A5t27nDdZphrD
 NSjLwOTNZc5d+EkALHnBUR2gffOlVKr0i7Qgwe4eESgN71Lr/vUKXr+xR6V2tFbgsI6w
 zKOEAYjcRsAYjjx8NUH/OjKgTG05d5IWX67fUYDhmG/tS6/GY45vBndgOIeVxprPr6yh
 rmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809851; x=1687401851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JWGE4S4rPXKGMW5kyd7FDSiXC4WTsYFl6VqGlHNwJvw=;
 b=aX4pmc2mFPYmC69c6rVy4Tnle2kgjw/iHgi5FMM5IObEi3hStCAT6+JM0+VeaU3q9o
 jEkEomzqb49XPl9LGIBzQs0rQflNa+XjQNDnHcbeD+fKipd494ppro0IJ9hEHVK4/XQn
 in5xboO1W+KP6JFb0ssxk28oSpiPTTzI6qfxsCR/ZYSOkM0PGp8ULjd9ZnHqmwBbNE6A
 D4NAwu0/cQc3NrbtdNFQjHcPTkXjlf4YmSG0p7SPw3/Va6vqjCnpFUa2+iXHsnvBwLtg
 hW8SO2D2Wb80HFHwW5bl4OEnVxn6aLb+kF08G+BF6FDy029j/eO6FL5u1U7TCOQgXAji
 wJmA==
X-Gm-Message-State: AC+VfDwxKzlKurRBqn+3RCS7Yzfw7bem0lRVlYOb67Ps4x7AzZYPO/Wu
 xZDxsN7u/E4EgkqsZnyPucb19Q==
X-Google-Smtp-Source: ACHHUZ4O1jnzKynEpoymx59tjTq7KJIPy+KIxHT/rgbR1bVnmJlhaTrmzJZ1gAH+8lSuj7513nLTYA==
X-Received: by 2002:a17:903:2311:b0:1af:bb27:f55f with SMTP id
 d17-20020a170903231100b001afbb27f55fmr4806107plh.55.1684809850824; 
 Mon, 22 May 2023 19:44:10 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:44:10 -0700 (PDT)
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
Subject: [PATCH v5 05/48] igb: Do not require CTRL.VME for tx VLAN tagging
Date: Tue, 23 May 2023 11:42:56 +0900
Message-Id: <20230523024339.50875-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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

While the datasheet of e1000e says it checks CTRL.VME for tx VLAN
tagging, igb's datasheet has no such statements. It also says for
"CTRL.VLE":
> This register only affects the VLAN Strip in Rx it does not have any
> influence in the Tx path in the 82576.
(Appendix A. Changes from the 82575)

There is no "CTRL.VLE" so it is more likely that it is a mistake of
CTRL.VME.

Fixes: fba7c3b788 ("igb: respect VMVIR and VMOLR for VLAN")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 hw/net/igb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index dbd1192a8e..96a118b6c1 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -402,7 +402,7 @@ igb_tx_insert_vlan(IGBCore *core, uint16_t qn, struct igb_tx *tx,
         }
     }
 
-    if (insert_vlan && e1000x_vlan_enabled(core->mac)) {
+    if (insert_vlan) {
         net_tx_pkt_setup_vlan_header_ex(tx->tx_pkt, vlan,
             core->mac[VET] & 0xffff);
     }
-- 
2.40.1


