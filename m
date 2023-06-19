Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EF9734C81
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:42:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB9Wa-0006dL-5p; Mon, 19 Jun 2023 03:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qB9WX-0006cp-U4
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:42:05 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qB9WW-0004Lz-FG
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:42:05 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f8f3786f1dso34314315e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 00:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687160522; x=1689752522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KL2PYuIs1BVHjdvTGwm0sXveXI5cCApLPfoCdqJW9L8=;
 b=fWsyd2ggatUTsIkjcwt5g1ZFmfbEYT42HpkS7K9Vjb1M1J28yMN6FBZOUOdi44fhFg
 xS0RUZvl5bZWbYbk3m8JXNMo4W0Gu33O2eIg0Gct8lhXlmVOl3eHEgJjM5RhScMjqJU3
 cx5seoqpzZi3GyiSTavTvlu1xp0vWECE65z8xoBFESVRvWiJ8LL9cQwi2yd1+C0Di3PB
 2+JXhcWBfwI7somsJ3co4ABECoq9uGUHOZuK9prd29JPfYXri2IU/lfyYKPzzokD4Fdm
 UmirV6yTdr3aEUilCwlVaXC20kNAcghWzLCShHzAYjqxnBhnSD7kA+qMKQZQ9xloimgt
 Mi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687160522; x=1689752522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KL2PYuIs1BVHjdvTGwm0sXveXI5cCApLPfoCdqJW9L8=;
 b=EotKvcx/+lIa7IkL8ug9yb2nz33lJJiGMtRFwtMd9Ol0SeEsRbkly6LU2Pu37loLgM
 esRWX3D+GqW5bUaMm3Abvz2uE7sN1+50D1XqV06QTs+JjXuFp5PRc1tU1+1VGsmFeb3l
 bMd3to1j5mFy7FgPyW5OpY8+WNrBvdSmQqo3vtzWJY8s+sTJGaq7kH4fUJNOGlJxuaUc
 ZiopsXXnbQyIVqVjTOmmul1IxBpy5smNcFqHQLDC4Snneum7ACOxOlKZ+DBINwfFCKID
 fyYbbqMrQPakB68ACa8lAckPN7miikDSr4PvRZr3nJytahD0CN0a7Kkh1m0k1geriqH0
 hstQ==
X-Gm-Message-State: AC+VfDx3tswUQlrvgfe3erXbeXeeQ75CaDIQ5p9YnZihoDgXeUf7IU27
 uk0lVw+rZ4FjWMSPcyf3oo9CT0O72AgOkPBDWmPBAw==
X-Google-Smtp-Source: ACHHUZ7gX1n45U+7t5jyD0FLAsJQGp97z0VG30yfL07LGEFIFabAZA+C4XfZuySz3dX9WB5Bi8z/qw==
X-Received: by 2002:a7b:cb56:0:b0:3f7:e48b:974d with SMTP id
 v22-20020a7bcb56000000b003f7e48b974dmr10200835wmj.27.1687160522051; 
 Mon, 19 Jun 2023 00:42:02 -0700 (PDT)
Received: from localhost.localdomain (194.red-95-127-33.staticip.rima-tde.net.
 [95.127.33.194]) by smtp.gmail.com with ESMTPSA id
 e6-20020a05600c218600b003f9b3588192sm704769wme.8.2023.06.19.00.42.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 00:42:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] hw/net/i82596: Include missing 'exec/address-spaces.h'
 header
Date: Mon, 19 Jun 2023 09:41:50 +0200
Message-Id: <20230619074153.44268-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619074153.44268-1-philmd@linaro.org>
References: <20230619074153.44268-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

hw/net/i82596.c access the global 'address_space_memory'
calling the ld/st_phys() API. address_space_memory is
declared in "exec/address-spaces.h". Currently this header
is indirectly pulled in via another header. Explicitly include
it to avoid when refactoring unrelated headers:

  hw/net/i82596.c:91:23: error: use of undeclared identifier 'address_space_memory'; did you mean 'address_space_destroy'?
    return ldub_phys(&address_space_memory, addr);
                      ^~~~~~~~~~~~~~~~~~~~
                      address_space_destroy

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/i82596.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index ec21e2699a..9b9e3aa792 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -15,6 +15,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
+#include "exec/address-spaces.h"
 #include "qemu/module.h"
 #include "trace.h"
 #include "i82596.h"
-- 
2.38.1


