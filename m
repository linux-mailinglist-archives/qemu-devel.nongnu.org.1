Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB49470D1AD
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:48:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I1Y-0005Ir-Nm; Mon, 22 May 2023 22:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1V-00058F-Lf
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:17 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1P-0004PW-Uv
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:17 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-528cdc9576cso4763888a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809908; x=1687401908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EyzYlEpyIG/ebqVyA+h2LJsZoF1O3ElISWW+LjGgxJs=;
 b=vDR7oV+FJUCpEB83dv9PZg44whKgs+IdOO/PWFNcZyIbJGRgbXBzEfVp7X+/1DnkUF
 pHkIre2vcHiK5hVye3BLwZT4OY5i1ibiZI4bc29Dkq/r2v0wM2vuL1lUnnURMN+uT45F
 Gz3V1+PmvUhjLpMyfBgzJu/ic96z8gT34J+1OqfSnXgR2nvpCiGVhr9AbgBQrIUE4PO5
 cS/y0PeLf5z2jtHIyvdRWf+dFtzs3oijfTgpypRGeqUDNFGZgr4l512Nr3LmKLhSkcxy
 7Asf2IIWT5fMRXKcsPzWt21xvUMwKbButhSJ6ZzJmCMdE5e93UIzJo1NtjC852YQGn80
 FP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809908; x=1687401908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EyzYlEpyIG/ebqVyA+h2LJsZoF1O3ElISWW+LjGgxJs=;
 b=NpfMIWdN3d+YJHfwHCf2vVlxzt8pz/HgCdg6hVM1/uVvZb8ySklcrJNX2TffsS/7n3
 2Bwe3/l/76pgF/oCC3J6gaWI30B1z6c/dYgJvEwHNU0qtk7c6cyEd+jPiEVa7KdiQUE6
 YQTFO3dl8Fh6XzS0KafVHeZKBl08kAvJvSw1bA7/73DjsMwj+8BmfiGZdkFDqxdH4AFh
 TigVbmyrPYo0O00ILJnBoWOwFGalum+LXooqNDIgUABqkPekbV7zQstg0f+MlPYSiLIg
 pDHPvuR4BUGH8HY7wvdMAQ7659eU9m5tgS5ojKAu8+82WAnDHOMG475cBLqxM0Ihsdv/
 p0Dw==
X-Gm-Message-State: AC+VfDzLBpjkKRY4ljZiz9MVX11WjqYljYX8Ipg4zTQRX/tksSL3HAiB
 0K05U+k40fXBUedc1ji3EriP8w==
X-Google-Smtp-Source: ACHHUZ6EnnLtXQD4t9Prj+yJF5IWtAINvSKBMnM2zqClHbcBdHA27nXhdGoyEimTTTWqMJwQHUiBcw==
X-Received: by 2002:a17:902:b618:b0:1ad:e633:ee96 with SMTP id
 b24-20020a170902b61800b001ade633ee96mr10157337pls.55.1684809908098; 
 Mon, 22 May 2023 19:45:08 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:45:07 -0700 (PDT)
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
Subject: [PATCH v5 22/48] e1000e: Reset packet state after emptying Tx queue
Date: Tue, 23 May 2023 11:43:13 +0900
Message-Id: <20230523024339.50875-23-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Keeping Tx packet state after the transmit queue is emptied has some
problems:
- The datasheet says the descriptors can be reused after the transmit
  queue is emptied, but the Tx packet state may keep references to them.
- The Tx packet state cannot be migrated so it can be reset anytime the
  migration happens.

Always reset Tx packet state always after the queue is emptied.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/e1000e_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 6a213c0224..7dce448657 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -959,6 +959,8 @@ e1000e_start_xmit(E1000ECore *core, const E1000E_TxRing *txr)
     if (!ide || !e1000e_intrmgr_delay_tx_causes(core, &cause)) {
         e1000e_set_interrupt_cause(core, cause);
     }
+
+    net_tx_pkt_reset(txr->tx->tx_pkt, net_tx_pkt_unmap_frag_pci, core->owner);
 }
 
 static bool
@@ -3389,8 +3391,6 @@ e1000e_core_pci_uninit(E1000ECore *core)
     qemu_del_vm_change_state_handler(core->vmstate);
 
     for (i = 0; i < E1000E_NUM_QUEUES; i++) {
-        net_tx_pkt_reset(core->tx[i].tx_pkt,
-                         net_tx_pkt_unmap_frag_pci, core->owner);
         net_tx_pkt_uninit(core->tx[i].tx_pkt);
     }
 
@@ -3515,8 +3515,6 @@ static void e1000e_reset(E1000ECore *core, bool sw)
     e1000x_reset_mac_addr(core->owner_nic, core->mac, core->permanent_mac);
 
     for (i = 0; i < ARRAY_SIZE(core->tx); i++) {
-        net_tx_pkt_reset(core->tx[i].tx_pkt,
-                         net_tx_pkt_unmap_frag_pci, core->owner);
         memset(&core->tx[i].props, 0, sizeof(core->tx[i].props));
         core->tx[i].skip_cp = false;
     }
-- 
2.40.1


