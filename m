Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 999AF8201D8
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:32:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKPb-0006GK-Ns; Fri, 29 Dec 2023 16:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPS-0005VH-T3
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:51 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPQ-0000Kt-Qi
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:50 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5cd68a0de49so5228422a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885327; x=1704490127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6UWy5Kz/mx3PpYWESm1flcywcYJB9sUPeJQepdOHfY=;
 b=GEIL1ShM+rwndJMRIa+AmGCPLf6DhneoUM5LzqYD3UGxqEZkgcC+8QgvQwQUQrSe1N
 vp3M08MvzCter6LYFRKgwyj/8I8Y5WEI2tboM3oTnMzU7xSGGavzDduy6COnb7wrZNWz
 W2RrBa3CG1PqRTd/vnNuMzLrLaaW5SuW4u16QmfV0n18MsaykOzZlawy8dGpTC76tRmM
 LAPc8qFF9LRQVyOXIWSSTlKBpdE5zi80FC3sa4vVignLEFCZzsIn1A3zp5ngS0HktEpP
 0sNvpD3yT4ZXPh4mG9iyba3o+puqnuqCRy1Rh2DITyQgQ1TprTOAQdH8AGdgq2TLLk+l
 kMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885327; x=1704490127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v6UWy5Kz/mx3PpYWESm1flcywcYJB9sUPeJQepdOHfY=;
 b=j5sGK0CqgCtEz8TvE0oIyfxSle2tTaTDutrqtV20t3txQRJNpzkcH4fOOcrfH2IAek
 wjOeUroXrqNeAsWcLsoDeM4EpYvu8ocHh6VbzT77oM291DStten7YtPfx4d1WwAGfOtN
 vGT1uV4rWRYRV8YVTDT3i3XPum1xvtQ5on70tU2hphtaKrLVT2BNwkRO+j6ZZZm4tr3M
 I5LGUs4/VqPuIva49iMGqx8KpgnzURLoIA3E2P/5xXMhDvfuzUcHYrEh0Y+kkdivtT7q
 UlLn1p6QbPOeN09/0UI2ofqFMi48RS+oBmcWKc7UZTf/1RpvEf4GGzsTGE+DUy87oP+Z
 4YVg==
X-Gm-Message-State: AOJu0Yw10sCDLsYuNVn5OSqz5UUzolsmJzVVZs5pDTfF+pqCsLsPWurv
 TuQfvYYI0MDdl8PScuP5s7+Mb78hmnB9FN8daUb0w5iccA0QLg==
X-Google-Smtp-Source: AGHT+IGK9dm6oUy4QwgL/LjAsN6mx7Crx1uPg6NMA2gzfHF1ciYjcWa8i1wQkMaO4aJmRigh0q4iFA==
X-Received: by 2002:a05:6a20:748b:b0:196:6b10:f3f4 with SMTP id
 p11-20020a056a20748b00b001966b10f3f4mr2830626pzd.74.1703885327542; 
 Fri, 29 Dec 2023 13:28:47 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:28:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 48/71] hw/riscv: Constify VMState
Date: Sat, 30 Dec 2023 08:23:23 +1100
Message-Id: <20231229212346.147149-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-49-richard.henderson@linaro.org>
---
 hw/riscv/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 7331248f59..d3bfaf502e 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -374,7 +374,7 @@ static const VMStateDescription vmstate_virt_acpi_build = {
     .name = "virt_acpi_build",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(patched, AcpiBuildState),
         VMSTATE_END_OF_LIST()
     },
-- 
2.34.1


