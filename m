Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F14770BB6
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:04:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2rP-00054R-Lg; Fri, 04 Aug 2023 18:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qx-0004mx-Ba
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:59 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qv-0001wK-2A
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:59 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bbf8cb61aeso18851105ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186454; x=1691791254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33FWwcFvaizWH4t629x3Vf1EkBPMJLEp9WeUHM35B6g=;
 b=n2P9/gib7RFga7fGmkdai246rrDfCSpYy88tyBEHZeh9vgWCf9wV5Lkd4k91znDhbK
 Ly2OrFHrpNjNUx9qMZRcsRj+nk+Eeb1/wDvSaaPzSnWrgV3tUPP6eo3Xj0Z3XCAIqAra
 dZz8ftO9uKPiYSIuAZfukfyOaYhNHfZDDKtfex5go0b+lobCs92KilpePOkTMhCSg8q0
 iXOV0R9Bf3VGPQzI6a3CctlrhX12VxWOKZnhk58vOHcFU6xBbrN/hXgIiDSbEZN80uCT
 fmnUjb5H95COcT25J5xAhBjbwiKeRhA15gSWzFxoCGBYnflt/aEDqTRWSxOH5UKwuiqF
 Se+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186454; x=1691791254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33FWwcFvaizWH4t629x3Vf1EkBPMJLEp9WeUHM35B6g=;
 b=GBuVBkk/Osi4WguuJI4S5GCNMbKKUTtvwbYYakKehFosnswWUeWs7UYAt8sEP37BCq
 GtcVLu4bJf7bjWCc1VVcDBXK/uaIJV7LeLyF8Sq3Dx8XkV/ja7XFCLw4wEgV8pWcjU6s
 YPy5XUopDWwreLQBMzBr19fB/ieh6aNDMJl0Lb71Syt2HfDu+ei83oWG1S6mNBj8KqDs
 yl8SYopHLQwaXqYIRLHj7hxRbdfP7IPZ9oHKnJnDcLfA67KaiYLSlLtWO3KheFc/frI9
 Nm0JKWuuKm7Lk/3nQCHoCaR7jLGdNNAmC1EZ/yWxHYCXmuzsJ8AiDmg63BP9gVnJk5f7
 Ls7w==
X-Gm-Message-State: AOJu0YwyjP4QIx3waNg/YBxbHYHrVFPCeLpuPn/ZNOGiOzkyRPyklUjQ
 exwyP+rM/OQeuHGKSnuxYxBaHKSg9ljSi4wOofE=
X-Google-Smtp-Source: AGHT+IGcWin8c2lUmCbJVcUQ+PTXDvnThAV0oGDhFUEyYh4ktAu3oBpXLn0x5+JVHDVG4abDX3Przw==
X-Received: by 2002:a17:902:ce8c:b0:1b9:e913:b585 with SMTP id
 f12-20020a170902ce8c00b001b9e913b585mr2556383plg.13.1691186454267; 
 Fri, 04 Aug 2023 15:00:54 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nathan Egge <negge@xiph.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 24/24] linux-user/elfload: Set V in ELF_HWCAP for RISC-V
Date: Fri,  4 Aug 2023 15:00:32 -0700
Message-Id: <20230804220032.295411-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

From: Nathan Egge <negge@xiph.org>

Set V bit for hwcap if misa is set.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1793
Signed-off-by: Nathan Egge <negge@xiph.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Tested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20230803131424.40744-1-negge@xiph.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 51591a1d94..c9e176a9f6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1710,7 +1710,8 @@ static uint32_t get_elf_hwcap(void)
 #define MISA_BIT(EXT) (1 << (EXT - 'A'))
     RISCVCPU *cpu = RISCV_CPU(thread_cpu);
     uint32_t mask = MISA_BIT('I') | MISA_BIT('M') | MISA_BIT('A')
-                    | MISA_BIT('F') | MISA_BIT('D') | MISA_BIT('C');
+                    | MISA_BIT('F') | MISA_BIT('D') | MISA_BIT('C')
+                    | MISA_BIT('V');
 
     return cpu->env.misa_ext & mask;
 #undef MISA_BIT
-- 
2.34.1


