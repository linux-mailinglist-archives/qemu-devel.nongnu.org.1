Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE7478EDE8
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:00:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhHS-00052A-3U; Thu, 31 Aug 2023 09:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhEr-0002lA-90
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:34 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhEj-0005E5-UH
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:33 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-401b5516104so7023545e9.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693486644; x=1694091444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNsqCjIrn7zPEbmcPc2JoOkFxTFsvtPHpgJNrPfRe3k=;
 b=Dy2Oa8eUvBjrN+Piny9LuZZhv32bc7Pj6pUUp0rhZWO3ZSKp28fzJdyvxh16mvaWFQ
 olI5o134o2gavn3ocyvuFWordWMIKkYfMzaAPz4lI2XxkH5GXdPe9lnjrN2hVxHLJz23
 Mz+25Ksl2qAiJUMSoBibg1AjA+5oMLlKS3Cy0BA4VByJOmnPNqEgPjSuXywvyAp2Pgv0
 SYfPgwyymGV7vNHJhDEA5HTfV2gPOoRMfvE8TarEhJLW91a+LLr5FrAgW7O/xeRd18sO
 82J0lW2/63Qmlr7n9tkd9Vv+bODoJojUiNi/iTYghbt557sAobdbiKbOz36zpq0Xl5lr
 4Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486644; x=1694091444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bNsqCjIrn7zPEbmcPc2JoOkFxTFsvtPHpgJNrPfRe3k=;
 b=TkJJeLVri5P2wbDTKYSRQJSrNcf+yVcKr691na2pt8Na2r7E5mWdjex7SVoZiFuEKS
 /X8e+lDnFoTFjactzZSeGXQ60O+72xTJhllrBJyZmW/49tcZxYFZvMvE8WA/7unw1S3w
 7I+joZN5IMh5C2V6Roo+7Ek/lVNPtP7B4mG1e8Vjm4QKoOpuFHCaaQGHjgoRD0D6Db95
 jFgKcBh4ZBdmvQqhWaRwkgFsiO0T0BhOVYe32lNkKnQa0LLMokmSerZRheNhzvWq2dEM
 SbWKjnOUOZJ3Wj34qfBzIlkp4tJRaxAJ30oTk98AIZRKCsLSDRpgxm9trHqqjC0ffUvM
 5tNQ==
X-Gm-Message-State: AOJu0Ywpw+hepTE7CsJt0/SHM92DvFpRVqZqlmMHPyKJ/O0DthAhlXuH
 F8L2+4OJDI0LuAbGxs/CZXOUa+sGDvJ1iGygEOg=
X-Google-Smtp-Source: AGHT+IG9JXS8zKS+njnm6ZrK4HS2Td/52k9bRc5OwER3l9a0ZyaQp8YjIaEZrq4e//IpPM3IKYyRcA==
X-Received: by 2002:a1c:4b14:0:b0:401:dc7c:2488 with SMTP id
 y20-20020a1c4b14000000b00401dc7c2488mr3945207wma.11.1693486644318; 
 Thu, 31 Aug 2023 05:57:24 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a7bcd09000000b003fe0a0e03fcsm5059538wmj.12.2023.08.31.05.57.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 05:57:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PULL 06/41] hw/dma/etraxfs: Include missing 'exec/memory.h' header
Date: Thu, 31 Aug 2023 14:56:08 +0200
Message-ID: <20230831125646.67855-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831125646.67855-1-philmd@linaro.org>
References: <20230831125646.67855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The 'fs_dma_ctrl' structure has a MemoryRegion 'mmio' field
which is initialized in etraxfs_dmac_init() calling
memory_region_init_io() and memory_region_add_subregion().

These functions are declared in "exec/memory.h", along with
the MemoryRegion structure. Include the missing header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230619074153.44268-3-philmd@linaro.org>
---
 hw/dma/etraxfs_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/dma/etraxfs_dma.c b/hw/dma/etraxfs_dma.c
index a1068b19ea..9c0003de51 100644
--- a/hw/dma/etraxfs_dma.c
+++ b/hw/dma/etraxfs_dma.c
@@ -28,6 +28,7 @@
 #include "qemu/main-loop.h"
 #include "sysemu/runstate.h"
 #include "exec/address-spaces.h"
+#include "exec/memory.h"
 
 #include "hw/cris/etraxfs_dma.h"
 
-- 
2.41.0


