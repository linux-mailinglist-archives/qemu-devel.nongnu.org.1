Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A64C6819073
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:15:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfWx-0001vy-Em; Tue, 19 Dec 2023 14:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWt-0001tg-9x
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:23 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWr-0001om-Co
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:23 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-336746a545fso79f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013200; x=1703618000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RDIBMPpY2c044rUIduHvSX5HNjBWclM55GKfwRyQOZQ=;
 b=XIR+c8UqhbqOFn5NKN50+nstIfg5qY2FTd4bxZid6v2MxI1IB05+nF+CoN4KLHfMep
 yhhCOQQWbelcvXdK/0TpL0wtmHfUR2Hj2JQHupopEmvZKvdBFrCJqH4osF9jcTSTMVmF
 NeAfBCtQu4qWgssxVt9L3UDe9RDnQBLtDzF/U8paC/2eW7W8+P+Dvj997xv5jMvJSFsf
 5R871pkjXmDMCh6Y8hWV7V7qnT0nF7XJWMTqoX5G2jgUudBENPHt6KTmvFBJQiOMXPEL
 KMM5uliipjQD87hi0lk242FDx/f6NG5PY0729kVZ4KPbsctlNOdkLVhUbPt07hPQzco4
 uJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013200; x=1703618000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RDIBMPpY2c044rUIduHvSX5HNjBWclM55GKfwRyQOZQ=;
 b=Y3R+ok02r3QfpczhYdH0E0a0HuXJGHNyDMPbnyj253bxgATiuKi1pomOyEOmudgnzS
 O1qMS4P1rFHySkUjYLaRXOneFYFszGVHqXYRkz412qyNvTB0+EAE+5v6XlJ7yv9dEWYQ
 D2fyjQWn+E1lTy0WQpvmisrPkLSF5Ip9tfh87AV5kgLKEnMrsrwkB4uQdjf2r+TzOp+2
 qy8K04IQUyLsnmzQmJPB1XSKiV3S9OqivluobQ8Zu8f//5CUBcFFSA0AHaulvsTLBfos
 XxwsFWCOVvx41XASRj9DCoaAVYLGJZ1XiMHmoggnrOUbEkK23Qb+By3OBKvgEdARIJMM
 U4ZA==
X-Gm-Message-State: AOJu0YzzmHmFoB+ji5/N1CfwkyHG7lN0203dQZ0ADsd+fJ4TZ75b08Ex
 HDo+MOgeXRvQuYcNIWW4S0Kr+JuS1xAACYGNVGQ=
X-Google-Smtp-Source: AGHT+IG0+Hd+7RaxCfbrcKoVJDoFJJJ//x7SeyrJ0+ZDuaFqz9hWv9uznHTxmTR6RFmYLmYJCZkluA==
X-Received: by 2002:adf:ee0c:0:b0:336:7686:d5e2 with SMTP id
 y12-20020adfee0c000000b003367686d5e2mr479349wrn.53.1703013199985; 
 Tue, 19 Dec 2023 11:13:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/43] target/arm/kvm: Remove unused includes
Date: Tue, 19 Dec 2023 19:12:47 +0000
Message-Id: <20231219191307.2895919-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Both MemoryRegion and Error types are forward declared
in "qemu/typedefs.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-id: 20231123183518.64569-3-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 2037b2d7ea8..50967f4ae9c 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -12,8 +12,6 @@
 #define QEMU_KVM_ARM_H
 
 #include "sysemu/kvm.h"
-#include "exec/memory.h"
-#include "qemu/error-report.h"
 
 #define KVM_ARM_VGIC_V2   (1 << 0)
 #define KVM_ARM_VGIC_V3   (1 << 1)
-- 
2.34.1


