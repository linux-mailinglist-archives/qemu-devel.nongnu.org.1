Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4BA7EA1F0
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:35:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ao6-0001Y7-1T; Mon, 13 Nov 2023 12:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2anw-0001Ty-66
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:57 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2anp-0000vz-0Q
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:55 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc3bb32b5dso41264935ad.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699896767; x=1700501567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ytq0IIHpazsl5UjhPmhAtXj995J/fJBp7XbPZWfrRQQ=;
 b=VpeQYn+hUR+pd2LYltCQzR0109aNJ7mrbLImrQAoTcECl+P4FxGnjixnySgjYu2ZNu
 uVtXuAIXbz+tGlHhF4dwJvFvFPHqKGQ7I5InJVj+IzaI/gHDTlI+mQbi945PLgiKakEP
 p+GWksI7Skl8yhhXrWid74pgSHeb9EIheF24Tpctu77hF28htcedBHegVr1LuwdKvwF1
 w27YoLrYTSRrAyEKMwyR5QhsYBqqc0G5YyHeCAY1jvk6D2jhAOF9IqppRfvHWvz704YU
 n7m6+mpUEBaQwwlP+gezGU4xhuYlonvAnuQ7gp5HgE4h+prnCGZnA+4jwmswoxmXcdb3
 MwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699896767; x=1700501567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ytq0IIHpazsl5UjhPmhAtXj995J/fJBp7XbPZWfrRQQ=;
 b=QrtrDi7LIkNyWtG6ykAt66SXPBGwFjG9zYKM6kvDCpWGWJxcuORGgjyLp738nJFMS9
 PW3oTqnpfgAnNAv7+u+ayGDOAV7YZ+cgXEI30MEzH6CLF5QbPumK/xv7NcFSqrKrksMl
 FQ6ORlpkxNIYPfV5Y8tVxJOdi9yWgP6nLLAjOkTfSxsRRehifztlgUtrjCBd4UCiAmxB
 NAP8RZ0b0TLiArE5YRJ7OoMTR4EJ46HNUpQ6qdDMp7kHGmpr5N5WH+6FX31Be+sK66ZP
 8Qo7wmVoaN4Gpr4HiSKIcoCLMNIxpndZjwT5XPw/2iED+I8Di6wT2DtyhPwGpsZVfh4K
 d4Dg==
X-Gm-Message-State: AOJu0YwGbSiKjNYcE884vo3ZQVG3BERoWwK214j1uQyUcwZqq7ujCuLe
 74g4MYz9gPLqAOuGa7CuUN7Ye5HbpP/yPKZdNEk=
X-Google-Smtp-Source: AGHT+IHOVZgzdF+SKWsVZa6E1T/HwMQk5aImb0OfxtW8uButgWJfco+FBl7KsbW4brW4a/aLhBeDaQ==
X-Received: by 2002:a17:903:2647:b0:1cc:511d:eb43 with SMTP id
 je7-20020a170903264700b001cc511deb43mr215015plb.61.1699896766812; 
 Mon, 13 Nov 2023 09:32:46 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 e6-20020a170902d38600b001c731b62403sm4271910pld.218.2023.11.13.09.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:32:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 10/12] hw/hppa: Move software power button address to page zero
Date: Mon, 13 Nov 2023 09:32:35 -0800
Message-Id: <20231113173237.48233-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113173237.48233-1-richard.henderson@linaro.org>
References: <20231113173237.48233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

From: Helge Deller <deller@gmx.de>

Something appears to be off between the 64-bit CPU, the 32-bit PDC
(SeaBIOS-hppa firmware), and the 64-bit kernel in addressing the
power button address in high-mapped firmware memory.

Use a 32-bit value at PAGE0->pad0[4] instead.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index a3222d3a96..f7d9ce9b46 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -36,7 +36,8 @@
 
 #define MIN_SEABIOS_HPPA_VERSION 10 /* require at least this fw version */
 
-#define HPA_POWER_BUTTON (FIRMWARE_END - 0x10)
+/* Power button address at &PAGE0->pad[4] */
+#define HPA_POWER_BUTTON (0x40 + 4 * sizeof(uint32_t))
 
 #define enable_lasi_lan()       0
 
-- 
2.34.1


