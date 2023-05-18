Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F192B708396
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:10:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdlM-0006Iz-Bz; Thu, 18 May 2023 09:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1pzbyl-0000CF-GU
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:39:32 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1pzbyi-0002WC-EJ
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:39:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f435658d23so18693145e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1684409967; x=1687001967; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7RMufLVcnImVuRlhef+rldQbtlOp58Wd3G7oPLW1EL4=;
 b=5FL+3CKXVELaXh/rt3PAA479sqtRGHpLQpOnkpGhygXawXKQ0LaN5tY7n8dU7CGJ2p
 c4PtKSc6vsC7zhalBqeKnwmr+CLHN4SKZ7EyZZToRBJP7ktDhhKbotuh043kIDbFglsY
 QgblbO6w6I8URschJpgpiAUxJP2Qknnh4l0+ksDc/ovyhSggS8Vksgzjx9X4ZhFNykcW
 /Y7nov8SNGCiiUQ2xDc7LQjCT8aFW0X7FnJ86eDstBQZTvV9enT1RHWv4AdedRj4hFg8
 fqb2QJ7j7vulgWGhEV1e6rdYO4iMo203BV2E7LKUMw+QyWYcwxr6feKPDq7kYzHxsHq+
 nY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684409967; x=1687001967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7RMufLVcnImVuRlhef+rldQbtlOp58Wd3G7oPLW1EL4=;
 b=U8K+w8vyvgYS8SWKD4+1v2xJ8aXakaD308hdD/2JHXMGPoXlGtBZ61gJ6bmzK4w+xB
 ldVIHlBxWZRAIbgiLtwEE7OEJbzMgDiU19TKgiOkXZTfL1ft9aksjDgFG89CWlqxWv5+
 J3uTM4ZO1OxRL76ItbGIsudu43UmJUiHIbpj9PZoYKXllggmNgLQvsQywriupvXx8mE5
 VVS6Wr6756GXS55+17rMX9X3YjyGxqXe6YzFi/Pz+l7vgVC8Xba94ppGeroaqKQ1Tzrw
 +uxf28QPjIHLOs3cexZjrWUahHb0mE8wL8D9XDj3dxatsQ81r8nH6v1kcqPgCCGUQSCp
 qp2A==
X-Gm-Message-State: AC+VfDw2gfi7+TOHTjcAgktm77h+LBYAGLzTE5ewo5MROR9T7ITvG5fq
 baaEN5zQVNq1c3nxbV/AvypWyA==
X-Google-Smtp-Source: ACHHUZ4h8FFljrzvKlb7zxoLglalw8mUA5mOXANmxjHo03HUKOdrUWOH+yQO74RgeV/fmMLQv6jBNw==
X-Received: by 2002:a05:600c:ad3:b0:3f5:e7f:5328 with SMTP id
 c19-20020a05600c0ad300b003f50e7f5328mr1506863wmr.3.1684409966976; 
 Thu, 18 May 2023 04:39:26 -0700 (PDT)
Received: from localhost.localdomain
 (cpc98982-watf12-2-0-cust57.15-2.cable.virginm.net. [82.26.13.58])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a1c7406000000b003f4272c2d10sm5083982wmc.1.2023.05.18.04.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:39:26 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Subject: [PATCH 2/6] target/riscv: Check for async flag in case of
 RISCV_EXCP_SEMIHOST.
Date: Thu, 18 May 2023 12:38:34 +0100
Message-Id: <20230518113838.130084-3-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518113838.130084-1-rkanwal@rivosinc.com>
References: <20230518113838.130084-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 May 2023 09:33:46 -0400
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

RISCV_EXCP_SEMIHOST is set to 0x10, which can also be a local
interrupt as well. This change adds a check for async flag
before invoking semihosting logic.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 target/riscv/cpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 57d04385f1..c78a2a9514 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1602,7 +1602,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     target_ulong htval = 0;
     target_ulong mtval2 = 0;
 
-    if  (cause == RISCV_EXCP_SEMIHOST) {
+    if  (!async && cause == RISCV_EXCP_SEMIHOST) {
         do_common_semihosting(cs);
         env->pc += 4;
         return;
-- 
2.25.1


