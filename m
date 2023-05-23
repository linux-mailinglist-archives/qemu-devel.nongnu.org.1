Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFE070D195
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:46:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I1z-0006II-JD; Mon, 22 May 2023 22:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1j-0005w1-MA
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:33 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1R-0004Q7-OQ
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:31 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-25394160fd3so2445192a91.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809911; x=1687401911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2/liiZ3TVpnprvr/3nGrr3vDF7yO65Gh2yux/g7Esg=;
 b=lRz1ZRRVMxIdpa1zDrg40WDG4nfGLpuqYllALICt+IzswLD/sJkXj1ekcHkW2JOi3q
 rWnGRJvhTW6z4yXm0zbwVtuFjhQfaZAKwB2FdaFVpO+KUVkpAJvvSJkW6s2ABI1OxuUE
 ryJLB4pxl7qjGp5UYf4Pamu8sJFR2WqxGPMNnbiGben6ONeAmLKrqioUeptTAJ4QUXV/
 AehHcCjRg3tbs2MhzdvBIbePmqm7G2n4CcOipTtOalSm8s8sQnC6+lrm6KeZkspvTzUO
 f4gjq+c4PiOmYRcdC46wilJn7XrxY99neWz19WF9IP1pnqnIgPIdRm96LkSKT4B38cXQ
 4WPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809911; x=1687401911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k2/liiZ3TVpnprvr/3nGrr3vDF7yO65Gh2yux/g7Esg=;
 b=JABg0nQ1NyK9z89XEiqrbwPwkzYo2ascp6BBdDtGw/42oj9qq7yB/E+Z7VViry6Ljf
 PEacluPzPbTUGQbnUlLoyTbDnSNbn2hKRGepZda43L30NbGez/WaETOmsa0d7a/bF/vL
 P+P9KVMiwlwgDhyI4nZfyj5sws3LqRizPgN83LwdF9v+5mtDakVf7g1KyZmIjZYvOrez
 Z/6VPKv7Ydgo8caRuQP5oxLtr7YTsT0A92JhFw8fAkkEuGVq1EPBIqzWSU93vzX6veFM
 Nvqo6TFP9veuk+iRRU8poO1TNF9nzxbFFY3vPfkJVe+Xp8SX3PjNxRqLzWWGnAt9zdPL
 mwYQ==
X-Gm-Message-State: AC+VfDw+yEWN5KAF87A1JrfAXqW4E1JfYTxqltMLV5xxCeJRtxaA4COq
 AlI+SBSsWEhpaW7rI8UboS7aJA==
X-Google-Smtp-Source: ACHHUZ7DrVkwQv/Bi/iJggmrQL/ZU5CgI3LjK9uDsIzHjSstO7hM3wyAbZ2QNRlVYBvNaU4ueuICAw==
X-Received: by 2002:a17:90a:ea04:b0:24c:df8:8efa with SMTP id
 w4-20020a17090aea0400b0024c0df88efamr12032443pjy.39.1684809911448; 
 Mon, 22 May 2023 19:45:11 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:45:11 -0700 (PDT)
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
Subject: [PATCH v5 23/48] vmxnet3: Reset packet state after emptying Tx queue
Date: Tue, 23 May 2023 11:43:14 +0900
Message-Id: <20230523024339.50875-24-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Keeping Tx packet state after the transmit queue is emptied but this
behavior is unreliable as the state can be reset anytime the migration
happens.

Always reset Tx packet state always after the queue is emptied.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/vmxnet3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 05f41b6dfa..18b9edfdb2 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -681,6 +681,8 @@ static void vmxnet3_process_tx_queue(VMXNET3State *s, int qidx)
                              net_tx_pkt_unmap_frag_pci, PCI_DEVICE(s));
         }
     }
+
+    net_tx_pkt_reset(s->tx_pkt, net_tx_pkt_unmap_frag_pci, PCI_DEVICE(s));
 }
 
 static inline void
@@ -1159,7 +1161,6 @@ static void vmxnet3_deactivate_device(VMXNET3State *s)
 {
     if (s->device_active) {
         VMW_CBPRN("Deactivating vmxnet3...");
-        net_tx_pkt_reset(s->tx_pkt, net_tx_pkt_unmap_frag_pci, PCI_DEVICE(s));
         net_tx_pkt_uninit(s->tx_pkt);
         net_rx_pkt_uninit(s->rx_pkt);
         s->device_active = false;
-- 
2.40.1


