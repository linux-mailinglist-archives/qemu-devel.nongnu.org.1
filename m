Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E242D7174CD
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:08:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D7Q-0003n8-Sr; Wed, 31 May 2023 00:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D7B-0003CB-3O
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:07:14 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D78-0006vv-PE
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:07:12 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1b039168ba0so29119945ad.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685506028; x=1688098028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bVDQIGY4qsUIGLjKLkOyu6DlKk1Y53Q32bQuvC8FPMo=;
 b=lXDq7q9HTKXuuF3AFEM/PVYLFyympLJsHXIt/oNpN2jsLPOfINHm1w4lWwRYBMDwxH
 e/zrU2mih7OX016uFZEmuqXBtMprFeZeyB2kcpHfCr5UCJwFY55u05R4QC1Yi2O0Uc9n
 vmXE+pcZ4mNSyBZ17honjjVHN8upxrvcohHVFJKA01v/IUebyPz6XM/Kmo8KMQzAxxRI
 s7vukjXEdnJMahp17e30AuBiRlH17xT/VPRjV7dsV8PSCUSSCH11FqO3i2nMG8taFL1e
 Wn8xCnMHj+Ecg4Q3X8vT2p06b9EO0+QPN6GrJyhhCaASzx1Jpn7fYQb5lROZj+Y/46MN
 JlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685506028; x=1688098028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bVDQIGY4qsUIGLjKLkOyu6DlKk1Y53Q32bQuvC8FPMo=;
 b=P2I04FBLOhEu4vvDexGGq1RLyRilDT9waBVDk9kz40E7p5HiuEFBrdMvnI0gXwdZLt
 mlgYmPhVrQahMaUWdljaCter1m5C+FSM3tCllV0tT7NGHLkFYheBfbStjz94xmYp+/bc
 2KaPTCx3hENCWZrVGr9/lCJ+EdqDWx4Zqdl6t6vvvTqNlWb8svKCpAiiqPvYzJW8m/Oq
 KAayzsUfN8s1bXtKofdnBZf6mxG+Q35df/qMWmAri3WxoXSATNwgCHJgKrQGBlq6O08f
 GoSV4y+ZFClt5nWKwYiBZJctlRZL8Ej8CyBs/6v3VVZKg/mEYcZZzJtBayXY7/w3LeiW
 V9oA==
X-Gm-Message-State: AC+VfDzBj1IPrQHVbbIFdFq8gnf5QN+jvCBQE1SM0kNWhuy2VMZ3fbAd
 c6f6OzDy8J0N0o4q2ncyB2JH0//k443CsDdh6nE=
X-Google-Smtp-Source: ACHHUZ7v0gKYS1zEeQSNgBUf7A1Ung0b269GmNtoeM+rjuQdm3cU+5ccpf1DCCOucSuPUWTLCoFA/A==
X-Received: by 2002:a17:902:e74c:b0:1b0:3df1:c293 with SMTP id
 p12-20020a170902e74c00b001b03df1c293mr5255221plf.45.1685506028231; 
 Tue, 30 May 2023 21:07:08 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a170902f7cd00b001aadd0d7364sm151797plw.83.2023.05.30.21.07.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:07:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 46/48] plugins: Drop unused headers from exec/plugin-gen.h
Date: Tue, 30 May 2023 21:03:28 -0700
Message-Id: <20230531040330.8950-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Two headers are not required for the rest of the
contents of plugin-gen.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/plugin-gen.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
index e9a976f815..52828781bc 100644
--- a/include/exec/plugin-gen.h
+++ b/include/exec/plugin-gen.h
@@ -12,8 +12,6 @@
 #ifndef QEMU_PLUGIN_GEN_H
 #define QEMU_PLUGIN_GEN_H
 
-#include "exec/cpu_ldst.h"
-#include "qemu/plugin.h"
 #include "tcg/tcg.h"
 
 struct DisasContextBase;
-- 
2.34.1


