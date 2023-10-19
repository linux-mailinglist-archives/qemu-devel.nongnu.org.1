Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 824697CFAAA
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:15:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSrT-0001lR-Pt; Thu, 19 Oct 2023 09:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSqS-0007nB-G0
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:13:51 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSqL-0002Ws-V0
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:13:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-407c3adef8eso23648355e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697721219; x=1698326019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Be57N8xZeT1c4/L41PlRl8GZmps32g61PsDN8JovFx4=;
 b=zC0Lta4A/5ZMidXyHUzFprlnGVS4yNg01aKZF+5PyicoV/PSrVN2Pn5yJQPuw3JCVl
 6A1T0YmEVxDFem/Lh9kegBZpa1wtJ7dgoHCxE4Hu9oAt4b/lLG3nzz4DP+rEuO+qZYIf
 BQbox6OajUpbLhdra05kIrMO1uN4N+0rOj3LdLdphc36kBFDA4FzIImiyyL2UULBKNzv
 QWfXwUix63DqwrD4Cow6ThkjzwrIXiRvtvp8qMvV/6VIh16l4br4iIDiMhSctfP4lgw3
 23PM6mGwJaKgoXBWF6G7+w0FL/eM9YEV9OMTogonVH9lpkB2ekraBn6vWCQNxnK3j1T6
 JTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697721219; x=1698326019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Be57N8xZeT1c4/L41PlRl8GZmps32g61PsDN8JovFx4=;
 b=MUzetiibfkfQwR7I9CmnbfRovk8RveNangLMDEP8CWz0VyOKIPcFtEw6x5OosWd/iU
 9wGdzHfXDO60fAEcxnE6COAlgNqXKdlfzGhoTMnZMkATdPrHZWUX6se1rrYXV3Tl9Tft
 X4dIM4wQTgr983MFjgDAyYGvN4eDkzjolgz51iRnwfupUyLU7heUEVkaeKxlkeweFvFh
 UqgVg8EeL0LjP9bo99AaCfKA8zAzKOCVwaMO/5/6BjRh7g+WeD9M+LZTgy6jyAphqd6a
 owuaJ3Ne4tVXt+XDnnkvffAA7DFKEq/xNGFrDzv8bqP7z7cTFNG9GqR6UgzOrHU8bDPa
 QPhA==
X-Gm-Message-State: AOJu0YwOL8QtfS2X7P0o+euUb/CSafFftquzJBGxzbTrqrKgXVLlJYdI
 sZLHjBFGRCo+1NGBHNbaXs+mKWTQbYE9y7dVgGtx5g==
X-Google-Smtp-Source: AGHT+IEfEoHNh/Sd/k1fvpeN5XgBP/L133U3pJV1rKCJlNOa7atRBbglaCzXMrwXZgviZISd48gavQ==
X-Received: by 2002:a05:600c:1389:b0:404:7659:ba39 with SMTP id
 u9-20020a05600c138900b004047659ba39mr1743426wmf.16.1697721218949; 
 Thu, 19 Oct 2023 06:13:38 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 f17-20020a05600c155100b00405959bbf4fsm4497832wmg.19.2023.10.19.06.13.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:13:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/7] hw/ppc/pnv: Do not use SysBus API to map local MMIO
 region
Date: Thu, 19 Oct 2023 15:13:03 +0200
Message-ID: <20231019131305.19157-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019131305.19157-1-philmd@linaro.org>
References: <20231019131305.19157-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

There is no point in exposing an internal MMIO region via
SysBus and directly mapping it in the very same device.

Just map it without using the SysBus API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 hw/ppc/pnv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 10158f7684..c0e34fffbc 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1217,10 +1217,9 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip8, Error **errp)
 
     name = g_strdup_printf("icp-%x", chip->chip_id);
     memory_region_init(&chip8->icp_mmio, OBJECT(chip), name, PNV_ICP_SIZE);
-    sysbus_init_mmio(SYS_BUS_DEVICE(chip), &chip8->icp_mmio);
     g_free(name);
-
-    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 1, PNV_ICP_BASE(chip));
+    memory_region_add_subregion(get_system_memory(), PNV_ICP_BASE(chip),
+                                &chip8->icp_mmio);
 
     /* Map the ICP registers for each thread */
     for (i = 0; i < chip->nr_cores; i++) {
-- 
2.41.0


