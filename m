Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBD9734C83
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:42:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB9Wf-0006eC-ST; Mon, 19 Jun 2023 03:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qB9Wc-0006df-VY
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:42:10 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qB9Wb-0004OS-HS
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:42:10 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3110ab7110aso3084111f8f.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 00:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687160527; x=1689752527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YkXthOPn4E1631VSOfPiqw4sZJp9rt3aVw83F1yxbyc=;
 b=mzlfo3m5LYpvP4ytqd3u+umd3HUv3UoWTWvc+meiDxyIoj/bv6hlN6Se8YNnUVIEhR
 mx8ASvJWiAsEUqzZy5j+O4JwN+S+kRZU9g5SsK3aCw7Tw70pTYHokfMArDu79E8TQYBY
 hWNke8QI58l9K/UoHtT1hk89d1oFLoqQNrqL3k5x8no9HpYcrFSDB2d/ipK9wZN1pjxz
 /Nmex6QU/WLFXdmahMWe2jdHg2jhJNDeCdfAHITmr5kTSY7FUMJzmPkQYv6pCO8Cyolx
 VU+yfzB0KOuy5S5JplBAs09oZ/INK9XJrtiycK8Yb72XlTNLkSwNLC+qGZcWZs0FQVra
 2Gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687160527; x=1689752527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YkXthOPn4E1631VSOfPiqw4sZJp9rt3aVw83F1yxbyc=;
 b=hmwF/LsL8veD5PUbkpw0lmu/aqN4AqIUQ3QfVWW/ILVimcPGNf2eDUFLhqsGCSr9Ea
 BdpgUH0Ob+N43nPA5H8pR8V4GPwhFx41HsuwFFQk4FFDvBxdaNGQOJKFjYo02s5S9nuT
 SkHVMDSj6499tkVhfXt2igw0e5NHcJ1+58vCjGmZgVg7+m5+1DJpm8edW/V5oHepXdgY
 3F3cdnjy7tAzFgeBBwxsf7yoMFXp6groljRaQAWl4koDpUV5DJn39s8oJOO09woSh8Ql
 12AQKrR+XVSf7UEW+fjNeD/q0KqjNEHZOTURtvUqqPtky8RT274Pb4W90byXQmRgHcS9
 4O3Q==
X-Gm-Message-State: AC+VfDzahCoOt0lMVJyhXvy+h6CuCQJWFHFq4xOjrDCubyedUZRnYHty
 KxhWRZGFjLKDuas7kV5lvIYguKMxMXUIje7Mg/tFJw==
X-Google-Smtp-Source: ACHHUZ47L7Xp2XRwbbnqOyPJdjdKWRKBBPrC1VaKIqRJhlqW5dHNQfb6Saq9edGPaTKEkzx7KWMvfg==
X-Received: by 2002:adf:f04c:0:b0:30f:c2a3:6281 with SMTP id
 t12-20020adff04c000000b0030fc2a36281mr7297532wro.64.1687160527690; 
 Mon, 19 Jun 2023 00:42:07 -0700 (PDT)
Received: from localhost.localdomain (194.red-95-127-33.staticip.rima-tde.net.
 [95.127.33.194]) by smtp.gmail.com with ESMTPSA id
 n6-20020a5d6b86000000b003111cbd8009sm9334752wrx.97.2023.06.19.00.42.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 00:42:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] hw/dma/etraxfs: Include missing 'exec/memory.h' header
Date: Mon, 19 Jun 2023 09:41:51 +0200
Message-Id: <20230619074153.44268-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619074153.44268-1-philmd@linaro.org>
References: <20230619074153.44268-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
2.38.1


