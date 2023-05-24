Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D549670F98A
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:01:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1py1-0006kc-MG; Wed, 24 May 2023 10:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pxz-0006eF-QO
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:55 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pxy-0006XJ-CF
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:55 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3094871953bso697798f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940393; x=1687532393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vXln/1eI6qFBBphN0wAdNEHB1hgU4t96Zx44NnYHfMg=;
 b=aUQOiuM8khuFhFB5866CK13bpsMuZVoiPDRsMlOHnDSlH98FUuOS09p5oU4QKvF2IU
 mbWDVtEZVE2s9Qm4F9+TWAT/bvYgsVFJCc9WBLa5vPfefuYDORL4lWIOL5dcCpbnNEPq
 ggoHcFI/LvKSBIL6j27y0bOqACrdGDc8RXyW2F+KBCrd7wxFKB9ly4xNNtpjf6GyFXuj
 +uKBjNfWK3epULafF2V4W+8vS+DKZ/aIXEXQECV5iy36hoLZQIyZgx//insbriqiS6y6
 As0ze+lawE0xLzKNWL332NFe3hQSCPQLbnDEVrufD408INHNjio9EzOoa39ytYw960sY
 tn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940393; x=1687532393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vXln/1eI6qFBBphN0wAdNEHB1hgU4t96Zx44NnYHfMg=;
 b=YPH40rt52bgMwt9cCpX+9fFbGZgJOuOo03bRoFi6yX+xWuTVcXXw2zlyiAn1Y5Ql7W
 eHz9BgBfbirNtMX4YYmEgxLISqsiBXN8Pgos+oQUdFyy9hCDfjcOpt7S0hzXcntopvmM
 yvfmw8nFAQjkfTxTsBdaytpu3bWiYl9qdOP+0m+oCw/OW1r+MUyNCdKzAL0Z+ZttbeE7
 1Tv7ZsxgFxYnnlTVqCh5trIScLFdGykvf7Kj7dFgwS78AVCkPP6pG0y+s1M7HB8KZRpQ
 fufrTpsSsBrAUimiHDHcps90/vdyUadGpXQmutaoZbHCZiOYeEkJAJlwcA/D6dx70zjK
 r5Xw==
X-Gm-Message-State: AC+VfDxSbAk+C2OJHUS+Qi5WsYHF4DxsvOHk9MxXtcudtKeu9rUeQoIJ
 Z9Ue52bkU74VqcJReS3lXncN9vgMqKpOBeDKmJURHQ==
X-Google-Smtp-Source: ACHHUZ5Q95UapRkUXIxR7O9qLz+ijPGfqEAaDifNHCvwjFPaeMS3/gir70Nl0h+2zkzqu0tImhGFWA==
X-Received: by 2002:a5d:6889:0:b0:306:30ea:a072 with SMTP id
 h9-20020a5d6889000000b0030630eaa072mr29449wru.53.1684940392785; 
 Wed, 24 May 2023 07:59:52 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-193.dsl.sta.abo.bbox.fr. [176.184.31.193])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a056000124100b003047ea78b42sm14758972wrx.43.2023.05.24.07.59.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 07:59:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/10] hw/arm/realview: Move 'loader_start' to
 RealviewMachineClass
Date: Wed, 24 May 2023 16:59:04 +0200
Message-Id: <20230524145906.33156-9-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524145906.33156-1-philmd@linaro.org>
References: <20230524145906.33156-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Instead of having each machine instance resolve its loader
start address, set it once in their class_init() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/realview.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 8a3b5a48b1..917a1b22df 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -36,6 +36,7 @@ struct RealviewMachineClass {
     int board_id;
     bool is_pb;
     hwaddr mpcore_periphbase;
+    hwaddr loader_start;
 };
 typedef struct RealviewMachineClass RealviewMachineClass;
 
@@ -376,7 +377,7 @@ static void realview_init(MachineState *machine,
 
     realview_binfo.ram_size = ram_size;
     realview_binfo.board_id = rmc->board_id;
-    realview_binfo.loader_start = (board_type == BOARD_PB_A8 ? 0x70000000 : 0);
+    realview_binfo.loader_start = rmc->loader_start;
     arm_load_kernel(ARM_CPU(first_cpu), machine, &realview_binfo);
 }
 
@@ -443,6 +444,7 @@ static void realview_pb_a8_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a8");
     rmc->board_id = 0x769;
     rmc->is_pb = true;
+    rmc->loader_start = 0x70000000;
 }
 
 static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
-- 
2.38.1


