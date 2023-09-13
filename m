Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4570E79E3C6
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 11:31:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgMCe-0000zU-Nl; Wed, 13 Sep 2023 05:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgMCX-0000ye-Gm
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:30:29 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgMCT-0002Bm-UP
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:30:24 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31c8321c48fso438230f8f.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 02:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694597419; x=1695202219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Ef+xjoTCq+y/8i7W8/XmeY8Z3xpQKPoxBTn9z9VDh0=;
 b=tuF0bLHId2aSIh0qNoo3tim8zY74YWgI8OCmYHv19N4VnvSMyLO8pd2NB8PGRmCKuD
 +7KKj5OkbovZ+JB+a4zBoI4Z/Nwavyo/qSJIWTzcMyvUptDqSsKfqRzVUPnz8EhmOgiO
 SYj59PrXMeegnm+alXBEpdHM/w2u06JSeu2ro2wOpSuuvXOWXJRDPfp0omf/x2jjThD7
 DoUwUDxWe8fQeXYHmZPZOskO0sI6mL0wwxlUgx/qdltEE2mzMeHayeDAbZ9rcRgPjOd8
 yZK3VN9YRCNJ39/TSmMzrYflJRivKa9D7RfEJKr6okFEAVk5dSSzFMdmAG+Rfvl/oJe6
 cPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694597419; x=1695202219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Ef+xjoTCq+y/8i7W8/XmeY8Z3xpQKPoxBTn9z9VDh0=;
 b=CKxItQSXtWZFc9LC+5Uz0+yZtengnCsUTomy1VHIKQrKgKaiFw4V0kP7RSY4AIX/DE
 OU35ZwB5SdtUs0wQrBE9wllA0tNkV8UvWsAl8dXuiuJOkJZFx2uQPS7N8WYXPZG4ipmZ
 QT00JUj9kYZy0JpqQFWnosVeHyLpPqzD0QjNP7PUAEbTFUOnwbOIHe2Vw7GBowRNnHs5
 5FFAo7x2u300Ey3NhOqHrJBaOQb78L6RMDk9iOM96lxTamUnVpaLqICGlCkumExdGFiT
 NEaWcndyWFU8YVaEyVsXK7QpF506Aq6bYf6ksMYts2R1A4BTgPdM0g38kY4LnSkvVOC4
 /7Dw==
X-Gm-Message-State: AOJu0YwxldPrtiqVWBMVAsyPnDcIyBWozWW9iaAWLZTTDvE7ru7qIjq/
 ZydUFVPLUHqW2UMlE/mAA5dJs8EkXZDxkZ3xhkE=
X-Google-Smtp-Source: AGHT+IF81qLWQLTZIurHyfB6n9nBdI6JMAN0Bl+M0T/v9Rb/vaARKtVVv7S5cMZos75Ep62Qy+3cVg==
X-Received: by 2002:adf:e403:0:b0:31f:7324:d47d with SMTP id
 g3-20020adfe403000000b0031f7324d47dmr3941318wrm.1.1694597419050; 
 Wed, 13 Sep 2023 02:30:19 -0700 (PDT)
Received: from m1x-phil.lan (176-131-211-241.abo.bbox.fr. [176.131.211.241])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a5d4bc9000000b003180027d67asm14946210wrt.19.2023.09.13.02.30.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Sep 2023 02:30:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 1/6] target/i386: Check kvm_hyperv_expand_features() return
 value
Date: Wed, 13 Sep 2023 11:30:03 +0200
Message-ID: <20230913093009.83520-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913093009.83520-1-philmd@linaro.org>
References: <20230913093009.83520-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

In case more code is added after the kvm_hyperv_expand_features()
call, check its return value (since it can fail).

Fixes: 071ce4b03b ("i386: expand Hyper-V features during CPU feature expansion time")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 24ee67b42d..bd6a932d08 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7121,8 +7121,8 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         env->cpuid_xlevel2 = env->cpuid_min_xlevel2;
     }
 
-    if (kvm_enabled()) {
-        kvm_hyperv_expand_features(cpu, errp);
+    if (kvm_enabled() && !kvm_hyperv_expand_features(cpu, errp)) {
+        return;
     }
 }
 
-- 
2.41.0


