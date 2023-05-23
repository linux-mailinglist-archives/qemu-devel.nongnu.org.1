Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE0F70D199
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:46:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I2F-0008DB-0t; Mon, 22 May 2023 22:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I23-0006so-Vr
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:52 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I21-0004eI-HK
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:51 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2537a79b9acso3096924a91.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809948; x=1687401948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZndx2f/U+2/EUhyRqu8CMrFTLfLBLfJ0RsuxddlFN0=;
 b=ryRYI7xvDHyJ/n4XBrED/AkxvGFiEIHDgitLvjXSDR1rwSajRvDDAvmdBfboC4/Rln
 0Zq6g7pFreWsVyjQiK+GRBWiq3ALcH2K2SM+CQeFrR9kzYeq6SGZCo6jNvG03OkgoOIt
 cl4mbMsa9l+jQdHV/BIz0zFwrbCRxA+wr6GGmImDDSsDFq25h8JwjENpm2oK/V5k1ejd
 kNn6T35NKi83ccovOqBk6eGIoePcEgEndfB6m2pXC4ZAVFrSXZMnqlTSwNj2dgZoFcGu
 ZtUIbLGmgU5mTvRIHxymHI5UzInxmHOn9k4Eg8hyuKLlMEUXYKbYweu04KdK+FFv+qF7
 oIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809948; x=1687401948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZndx2f/U+2/EUhyRqu8CMrFTLfLBLfJ0RsuxddlFN0=;
 b=NydPaxEXyeiCGBLAJZUAMuAw0tPhLlKNcDp6khKn1SsoAnv2qZ3vvVn4K5s+okvd9P
 yWIoeVSSNg9fXXE0mPPIr0tmAIYcRqnecK0VgrE4y5VHYW4GEa2DZrgd2xQjD5Mvrdcn
 mNNufAG2nzloFNO7c053syUfacXqewRRUj2JkvaB9ZybErxz5K0ued+v7UmwN+I6k/b0
 w+44rhtT580v2WI2S4nJQ8RfuRipsAHeC5Icy3D3w6rfz0geTV7vqmN3Q+TeqkaFDUzi
 JaWEdrrUZtIzxrqqbtqkdKqueUCqQEG5U3mtY+VCQGdIDd2812xAfnhLahcZWEOgsI15
 L1LQ==
X-Gm-Message-State: AC+VfDwuETUhdsCdjrh+YeaFviBnx6lvm4TudigQxxHjIg4gCoGycN45
 ypFLWBy0ao0b4c83E5v51E6YQg==
X-Google-Smtp-Source: ACHHUZ7TNw7Z6eNI8yLS2GFlzDP3w6AJ8khLPOxyIGY/5kNtPypaLWT69A/FLR6PoMnRx+D3ROaO9Q==
X-Received: by 2002:a17:90a:a6f:b0:252:bb8d:3dce with SMTP id
 o102-20020a17090a0a6f00b00252bb8d3dcemr11970452pjo.39.1684809948377; 
 Mon, 22 May 2023 19:45:48 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:45:48 -0700 (PDT)
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
Subject: [PATCH v5 34/48] igb: Implement MSI-X single vector mode
Date: Tue, 23 May 2023 11:43:25 +0900
Message-Id: <20230523024339.50875-35-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102a.google.com
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 hw/net/igb_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index c954369964..6d55b43fb4 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1873,7 +1873,7 @@ igb_update_interrupt_state(IGBCore *core)
 
     icr = core->mac[ICR] & core->mac[IMS];
 
-    if (msix_enabled(core->owner)) {
+    if (core->mac[GPIE] & E1000_GPIE_MSIX_MODE) {
         if (icr) {
             causes = 0;
             if (icr & E1000_ICR_DRSTA) {
@@ -1908,7 +1908,12 @@ igb_update_interrupt_state(IGBCore *core)
         trace_e1000e_irq_pending_interrupts(core->mac[ICR] & core->mac[IMS],
                                             core->mac[ICR], core->mac[IMS]);
 
-        if (msi_enabled(core->owner)) {
+        if (msix_enabled(core->owner)) {
+            if (icr) {
+                trace_e1000e_irq_msix_notify_vec(0);
+                msix_notify(core->owner, 0);
+            }
+        } else if (msi_enabled(core->owner)) {
             if (icr) {
                 msi_notify(core->owner, 0);
             }
-- 
2.40.1


