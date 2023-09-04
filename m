Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2D0791761
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:44:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8w1-0001uk-Jd; Mon, 04 Sep 2023 08:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8vz-0001pc-Ex
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:44:03 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8vx-0004fj-1q
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:44:03 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2bd6611873aso20725161fa.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693831437; x=1694436237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J86j5mSNtE6sux8EpFhfC+5G/8PZx0ftCeNpTFb29eU=;
 b=rugoFjQY5QZTWmWx26g58vw+nqGgLXLA8xgvMQ4aeIwkgPrVrkMilAr1KJS1ytKHpB
 GK2tLEienrThJgUVPi2krz8sjY1GnSaAcwCX9PgMXcGEs0gBSaF3aMP6PR82R0H474ro
 8ALHjsLUVvQM4TvAd5+lmFWW4/ap4eAl5/Dk1glbToIMD3VQ0Ks/7aBfWD2ssWwHoi1t
 iW0kOqFrFnTJIdJSXfn+0A+sJGP6DAqhOeK2xnHNH0SNWQUrNJp+LSoi6ZclcgXqV0Xx
 T0rFu9CJWiKTMZiH8LJGBLdxgljGFE7AOYgPXyqBwqNRsCY6097Iu8UoMcuIAtO6Qc5W
 U5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693831437; x=1694436237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J86j5mSNtE6sux8EpFhfC+5G/8PZx0ftCeNpTFb29eU=;
 b=EjUVAvbCNi8tXCYRwk8NAaEoq05Xmt2zusZMA8hJXWO0iW6ujTRvmWpsQfIb9ZhG2c
 lqPCaXyqTgeRTH548QRDIMJmRkdW5Tp0PQ3WjcMuPtSb35wGYqww943Z6u9bAef0LX+N
 Fx+oj1X3I7sOWTkMZX77hOjzYNHFc9yrV19kKa2BUZs/R05e5+oLVwyOvEufOLd8ylZx
 iatyVTBq79hig3X/1PSTI8bbfUzrMEN8oTAvIXJo/SY8Of2ARmyYXiPKxCv1EZOUx/w4
 3lZwXsACJhAU+qfLZll1w8pqunvtLBeRW15ETb8vbUjS9TTPWphz5Yf45fQIstUCWm51
 nEXA==
X-Gm-Message-State: AOJu0YxVYnYhM77+aSUvanoyhJOvP0ZAUAqSt79+2FBYtaekMb3ywh+j
 VpiwDsFYeB5jaSGtw7wmTN5HmOZgw9zj26Iq+EQ=
X-Google-Smtp-Source: AGHT+IHTKfewe5UyKQ+3sAtZlufz27CBCCuRSsD4I35Lg5dnHNAx7JD/gpJfXGmmCvEgfuCO6tDe+g==
X-Received: by 2002:a19:ca4e:0:b0:4fb:9050:1d92 with SMTP id
 h14-20020a19ca4e000000b004fb90501d92mr5895100lfj.51.1693831437006; 
 Mon, 04 Sep 2023 05:43:57 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 qc8-20020a170906d8a800b009944e955e19sm6102288ejb.30.2023.09.04.05.43.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 05:43:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/13] target/i386/cpu-sysemu: Inline kvm_apic_in_kernel()
Date: Mon,  4 Sep 2023 14:43:16 +0200
Message-ID: <20230904124325.79040-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904124325.79040-1-philmd@linaro.org>
References: <20230904124325.79040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

In order to have cpu-sysemu.c become accelerator-agnostic,
inline kvm_apic_in_kernel() -- which is a simple wrapper
to kvm_irqchip_in_kernel() -- and use the generic "sysemu/kvm.h"
header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/kvm/kvm_i386.h | 2 --
 target/i386/cpu-sysemu.c   | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index e24753abfe..470627b750 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -13,8 +13,6 @@
 
 #include "sysemu/kvm.h"
 
-#define kvm_apic_in_kernel() (kvm_irqchip_in_kernel())
-
 #ifdef CONFIG_KVM
 
 #define kvm_pit_in_kernel() \
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 28115edf44..2375e48178 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -19,9 +19,9 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "sysemu/kvm.h"
 #include "sysemu/xen.h"
 #include "sysemu/whpx.h"
-#include "kvm/kvm_i386.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-run-state.h"
 #include "qapi/qmp/qdict.h"
@@ -253,7 +253,7 @@ APICCommonClass *apic_get_class(Error **errp)
 
     /* TODO: in-kernel irqchip for hvf */
     if (kvm_enabled()) {
-        if (!kvm_apic_in_kernel()) {
+        if (!kvm_irqchip_in_kernel()) {
             error_setg(errp, "KVM does not support userspace APIC");
             return NULL;
         }
-- 
2.41.0


