Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C1D7D6308
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:33:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIp-0000Mg-At; Wed, 25 Oct 2023 03:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIj-0000L1-2n
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:37 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIh-0004k9-K8
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:36 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cace3e142eso34980215ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218854; x=1698823654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEO6SLhS+OilG+TaX+qmXlK9OgBRNvjKZJDuVMclfD4=;
 b=J4obVAGFfuuOAswvsJKTlWiP/udBJARqnjiUqJNMsGNukDzqMsK7693jIlDq22iN7q
 EhBGF1RSZqO1cx7fo7g+kpXDhUaJ7fysgtMqMM8ZGIgMNlQGRQXl8jtxE+/5J3cRI+c+
 8P0L3PMJ/KUr6OXDI+nKF+ERDcobdTHnQixULgpgmAQmoG6icMnYe6QO//TSK5+EMhOp
 4sKUZ1oSQ3Kj4mAPDWAaysaCd940TcZX5g+GXRLUAw/oxRLFy/zvb8sIu5LAmOF7Wv2T
 uEIM0bogiQFjuT439DCRjFyrvEON22RmrDANuT+rUmKexw0wrVOKZHx9PS/l/VvAmJyJ
 3/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218854; x=1698823654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEO6SLhS+OilG+TaX+qmXlK9OgBRNvjKZJDuVMclfD4=;
 b=PJoamALbSQJAr0dbbRuzio4+CoNVICydH9BP90otjeNdVby/XgQ7tfaPC/V7hum6nv
 x5//iOvyc+O8QmQmTWnsiHkNP+wgqeIW0t3trirHCUciwQDzbTt13Tdx6DJCKsyjoIl0
 4T88LUNmumBIA/DqJo3KI0QH0+QikQ6K1U6RqorIdcFV/ydLh/AqEVMJlJFuWpbH+02n
 J01dPxatUbMop/31eTJGhQQSWFua/DBuB82LXo7/cSWo+Me8B/mNbUA5UlWnwZCFRX1F
 hStxumJK4U8sLStQknvBuy12wI1Wi+LE1B0HHY0E/nCZ/8iF1Nb/+bSKn3HwAqyfjn2j
 xJ+w==
X-Gm-Message-State: AOJu0Yyn0rHTh1bZaz1aNDo785Cta4lZ7WTQW550Mh9vBoo5FT7yRnH8
 mwOVmMwcuDsTyGc4ocEnUILeDX33LMyET33sdOk=
X-Google-Smtp-Source: AGHT+IHNq0Fjho/HoGmvndzrul3BUzS96XqtT6q0MUHQhfi9JVy2nxtYaEPgH5j2e/pqtTcZVljuew==
X-Received: by 2002:a17:903:2348:b0:1c9:bfd3:1f4a with SMTP id
 c8-20020a170903234800b001c9bfd31f4amr12212434plh.66.1698218853730; 
 Wed, 25 Oct 2023 00:27:33 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 26/29] tcg/tci: Support TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 00:27:04 -0700
Message-Id: <20231025072707.833943-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tcg/tci.c b/tcg/tci.c
index 4640902c88..5e1c4a491d 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -228,6 +228,12 @@ static bool tci_compare32(uint32_t u0, uint32_t u1, TCGCond condition)
     case TCG_COND_GTU:
         result = (u0 > u1);
         break;
+    case TCG_COND_TSTEQ:
+        result = (u0 & u1) == 0;
+        break;
+    case TCG_COND_TSTNE:
+        result = (u0 & u1) != 0;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -270,6 +276,12 @@ static bool tci_compare64(uint64_t u0, uint64_t u1, TCGCond condition)
     case TCG_COND_GTU:
         result = (u0 > u1);
         break;
+    case TCG_COND_TSTEQ:
+        result = (u0 & u1) == 0;
+        break;
+    case TCG_COND_TSTNE:
+        result = (u0 & u1) != 0;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -1043,6 +1055,8 @@ static const char *str_c(TCGCond c)
         [TCG_COND_GEU] = "geu",
         [TCG_COND_LEU] = "leu",
         [TCG_COND_GTU] = "gtu",
+        [TCG_COND_TSTEQ] = "tsteq",
+        [TCG_COND_TSTNE] = "tstne",
     };
 
     assert((unsigned)c < ARRAY_SIZE(cond));
-- 
2.34.1


