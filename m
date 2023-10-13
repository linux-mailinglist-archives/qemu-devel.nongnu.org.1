Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 296E87C811E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:58:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDtR-00019k-9Z; Fri, 13 Oct 2023 04:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsl-00078L-IQ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsj-0001be-3P
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:54 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-405361bb9f7so19686605e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187050; x=1697791850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LNddm/56qMiLEmccznxtcpKgNr+eWKfyBYoNrGitmVI=;
 b=RMb2xPuJRYxpwEI2I8ARZkrPFjMn16remR2X5qIPAAP3o40f7nyO4FrwEnx35NAoDP
 sALMaqXmGHarTfPNrwQHyDclikhdROgPIfsZUKDwAnHV2lYpQF9JJYBErBfA+MuVGbtF
 9Gg+RPzoKtSFeq8WTYcUsLFWkSSM+UVoZEy/24xJC/LqtZ5WmvAJofzeGaDg16ju04Y/
 HWPP46bp8AUEBBn7NmI4i3dfim7+1tKe4hSNf59JsCRwkfDAL97GwRKmBZGqtsjVScDX
 wNAsTIu7FL6eg5L+L+u7bgyAKECpOdzsyD/AonqlbfDpouwMJmjeelEoa/AeOru9SQyO
 cVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187050; x=1697791850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LNddm/56qMiLEmccznxtcpKgNr+eWKfyBYoNrGitmVI=;
 b=f+eBug6UdajzescbrlrMhE1x7N3M0cejyR2u/uUuTnx+s+ulufV5wrXEYDeugQI0S5
 Z0XrY4TUTUG3rDoS00aC46VK34xmYjMd4vlS8hZVoQuH+BuLkCKj99ehBYd715rOX5dQ
 qu4G23PbZgNinkVRLgR8A8gvJfhFItgqxXAOxnVHMSC0wDqpYoWuInt1lXAynDpSnUTz
 3GpvQVpkGxhc4H+0vsqXqAlwBGQ7QteDAU3FEmcxIY03s440n4NE1va9YBd+jOHRUr/x
 H59r9YYyMPpdNtfjH9TtU3KcgjrWJY2hDWo5I/oB2CItFRsYdTUW8ugHIIi7vAw8FXNM
 XP2A==
X-Gm-Message-State: AOJu0Yw06Fxowt3rdQTAS6a393wEwPJGZ+KFmkW9XmISMgxzeI7RLau6
 uXXZylPY6QtwDihicJltoeSCjceRnEMNFpMIKXo=
X-Google-Smtp-Source: AGHT+IFu0gJZoUyuikgk1hEMxJxAaFxwkGWVhVCEJKsTDMagsXaKjbsccwZEX+arEI5TDhwQ2ORj2g==
X-Received: by 2002:a05:6000:98f:b0:32d:89b5:6d05 with SMTP id
 by15-20020a056000098f00b0032d89b56d05mr6334558wrb.35.1697187050570; 
 Fri, 13 Oct 2023 01:50:50 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:50 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org (open list:S390 diag 288 wat...)
Subject: [RFC PATCH v3 73/78] hw/watchdog/wdt_diag288.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:41 +0300
Message-Id: <15fa0bc2e19e740d646b41d93ee39634978cb43c.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/watchdog/wdt_diag288.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/watchdog/wdt_diag288.c b/hw/watchdog/wdt_diag288.c
index 76d89fbf78..24fb7fcb62 100644
--- a/hw/watchdog/wdt_diag288.c
+++ b/hw/watchdog/wdt_diag288.c
@@ -69,7 +69,7 @@ static int wdt_diag288_handle_timer(DIAG288State *diag288,
     switch (func) {
     case WDT_DIAG288_INIT:
         diag288->enabled = true;
-        /* fall through */
+        fallthrough;
     case WDT_DIAG288_CHANGE:
         if (!diag288->enabled) {
             return -1;
-- 
2.39.2


