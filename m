Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACE37C7F80
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:08:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCxv-0001Fx-KU; Fri, 13 Oct 2023 03:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxT-0007CS-HI
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxK-00057V-BA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:43 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-405505b07dfso18716705e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183486; x=1697788286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZTz17RhWxoUZ3hVHX7ypZhIj3NVSXDU2Rg89KVwrPE=;
 b=yo6QvDN5qXYK1qGQZg1y6wlvqPGS1mxdFEWQvR4KeVsQ8oW8pER0MQ1iXkI5Fe+nxU
 IsgL4MwWMKSWTf8QOxTXSbZ/rotGnn10szX9IUwx2H8jBbIajOTYPMBg4lKzZ3K5yMBz
 eHqfGlUFUhBGV7O8omOJ8SQ8sXjHmksLlNNc3SOfnZJWVfE8fJVS33uE3sr/MoOio3oH
 3nr9H/3vuAxhc9SuQT/I2b7+CaoFv9//l2TLKcFRB01+UOyNhmaRP1xx/jtlADqHgTsU
 A6oMsWTqUIO9OAakdqeJmkfPMbl/TXZcBq1TuFHLs51j+PgGBgV5rNMuh2oDoyfDcpsc
 Aitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183486; x=1697788286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZTz17RhWxoUZ3hVHX7ypZhIj3NVSXDU2Rg89KVwrPE=;
 b=nfmG+XYPLO4+uIYKqWmJzRMvAdub+h231P+wHdqjfbCa6+mwdckXt9YNP4kgzI6/cQ
 k25OYuok0VsjbnuXwWr1V10UhcSYyGNtvkSYhHSsQACJEsjBgwPh9PaqTdgFvbN/2SBX
 dasabh0X5o6FzInxAYK6s+Sh1IoLzyXlIQCnZXnKHYo9B0H8qeMS9raDI+zLtPwMQnwx
 zQhkVlIwjnl0a9S5is4z2rfjKGdCu28Ghi2n7BNy6q3/i8KYGZc/dftnVuLH9mEvr/SH
 4UsxvMSwiYgSXklDq+zw0+1sFOUXx5bNdww1vxQmYCWnuP2jemhk7djbIHDdpytR6dC3
 AVhw==
X-Gm-Message-State: AOJu0Yy6OmZOGO4jsoOqRFiYjbUIlgomjkJtL944b6c01WBSa8lrV8zV
 L7vD2y5THYXMHErD9+9aFt8Bt343aP9ojeBDMw0=
X-Google-Smtp-Source: AGHT+IEUCn7KSqKdc1unIhnQUcyVOMLBVNtCDBSl2brGR8U0iZXbYRwW2dmL4Pwq0DKH/uFZRVJYaQ==
X-Received: by 2002:adf:e288:0:b0:329:6d7c:ca71 with SMTP id
 v8-20020adfe288000000b003296d7cca71mr15995250wri.17.1697183486466; 
 Fri, 13 Oct 2023 00:51:26 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:51:25 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
Subject: [RFC PATCH 44/78] hw/m68k/mcf_intc.c: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:56 +0300
Message-Id: <afd58b7b36d587594754b695313ed01232f6735f.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/m68k/mcf_intc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index 4cd30188c0..9556a0ccb7 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -58,34 +58,34 @@ static void mcf_intc_update(mcf_intc_state *s)
 static uint64_t mcf_intc_read(void *opaque, hwaddr addr,
                               unsigned size)
 {
     int offset;
     mcf_intc_state *s = (mcf_intc_state *)opaque;
     offset = addr & 0xff;
     if (offset >= 0x40 && offset < 0x80) {
         return s->icr[offset - 0x40];
     }
     switch (offset) {
     case 0x00:
         return (uint32_t)(s->ipr >> 32);
     case 0x04:
         return (uint32_t)s->ipr;
     case 0x08:
         return (uint32_t)(s->imr >> 32);
     case 0x0c:
         return (uint32_t)s->imr;
     case 0x10:
         return (uint32_t)(s->ifr >> 32);
     case 0x14:
         return (uint32_t)s->ifr;
     case 0xe0: /* SWIACK.  */
         return s->active_vector;
     case 0xe1: case 0xe2: case 0xe3: case 0xe4:
     case 0xe5: case 0xe6: case 0xe7:
         /* LnIACK */
         qemu_log_mask(LOG_UNIMP, "%s: LnIACK not implemented (offset 0x%02x)\n",
                       __func__, offset);
-        /* fallthru */
+        fallthrough;
     default:
         return 0;
     }
 }
-- 
2.39.2


