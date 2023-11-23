Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 844617F665F
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:37:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EY8-0007sF-TD; Thu, 23 Nov 2023 13:35:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EY3-0007eT-VA
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:35:36 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EY1-0002x0-M2
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:35:35 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40b38a1351fso3007005e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700764532; x=1701369332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BmQzUMP7VYVa7fjT/YSlrE9ib44vaPa3uhyPvwmHEck=;
 b=oqT1lGyRCH4nIrs1nYlqwoTtl6g3qeWqyG6kyJveApboSFe+cfSbuvpoXTFLK0/CcL
 5TEzgEaQdk526HtmNDoidfNawSL0Y0gB8TysOV4q3NibkqZPqFgbNW3j5siGZhjiSa06
 hPVhlV+awnjOimhxhAuyf9BPZsDhiMPSPMPq945qnkzZLb7PPhf1Tgg5yAaDRajOqBKL
 Z74j4r56xpGOvwDtM0UhxKUFJGJXWgg5qbsj48RLj2xNbH8EX1wJs7+mO8jai13WQAUK
 jB8czHxqRtMr0pf8EiPhN5J74obSbQEurO1r6kaZTPnsyDzD3qu68QnkzCI7kdGWR70C
 ReCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700764532; x=1701369332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BmQzUMP7VYVa7fjT/YSlrE9ib44vaPa3uhyPvwmHEck=;
 b=jW3ITXBhg0XtIlwBT8d8kkqVvZfQrDphJkZiFiyMJMm8oIokQoWnq8Hbk5Ajc9Zbvx
 sAsMB+jFwKQFuukUdwwQvZ0fImVNUcJLplnDYlrJC3+ul8rtNhYGXHsa2mVqBottfaFY
 wDKmyBmgUnp92jtJksQ44lludnbs9VgSeIWI6djgTlkkn07CZakq1OIRmR2rxlObtvcc
 xzWdT7XlhQfnmNQaIcCYV64coMMc0tydpKGF6d27OTpqTsO6Hv5fnxzTntCVdNXbkTxw
 gUTVbxkfZJoKXe5ouMni8BkndZHrUGvvRjTt37TYdJ8RcO1EsTu7lgXx01H8ieKw5Af9
 qJ/g==
X-Gm-Message-State: AOJu0YxHcIS2IZoEmQ8sDvrjqfIA3HYVZ/QgCbLGHoYIyHphA8GP2S+t
 X6h/kvoqKM9bbjBCflG65HpAUhJmxMXiFqthekg=
X-Google-Smtp-Source: AGHT+IHUaninjtMft4ooDyc4hnH3umDC4N+Bf3mITGO5bL3XKGyp7f1b/sTY697AHiIj2YfXI4zDtg==
X-Received: by 2002:adf:ec03:0:b0:332:c723:12ad with SMTP id
 x3-20020adfec03000000b00332c72312admr176313wrn.66.1700764532048; 
 Thu, 23 Nov 2023 10:35:32 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 o10-20020adfcf0a000000b00332cda91c85sm2327141wrj.12.2023.11.23.10.35.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 10:35:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 02/16] target/arm/kvm: Remove unused includes
Date: Thu, 23 Nov 2023 19:35:03 +0100
Message-ID: <20231123183518.64569-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123183518.64569-1-philmd@linaro.org>
References: <20231123183518.64569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Both MemoryRegion and Error types are forward declared
in "qemu/typedefs.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/kvm_arm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 2037b2d7ea..50967f4ae9 100644
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
2.41.0


