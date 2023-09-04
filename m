Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E81B791766
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:45:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8wj-0002DE-WB; Mon, 04 Sep 2023 08:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8w5-00024q-O3
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:44:11 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8w2-0004ge-Ao
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:44:08 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52a3ff5f0abso1860381a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693831443; x=1694436243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uvgb1mY0EmO5+OIh91wyTfD/dyJ0WPXCogU6akizjwQ=;
 b=SiHzq6iOllrj4sisDqppUQIXfwq88s9s2I40fOvl+t4FtBDz6QP0rFa1YHjVlH/kYe
 Nc2ipq7f9gOXJA14jcyhhD5iFZLk/SgXsUh5tT+2w4vjxwlFS/rdL+QKi930Aeov6ycn
 AV/JJkwUCByV0U5T+E33cWI7C41eQJ+ws8ggb/ZqEu7H0KyLzuPMWZTOMR1O+yXUj0wY
 ds8KmTKSB3rYTVHrKhiBHbcIjyFDVIcnYJ7Nj/6fABjOVTpwOFzPhM8nslb3VKkaQMmZ
 v0zV/JrmPfMp2+dzHiZfVOsdaYzBaz90Rod4MIVE5TNZP7bex+UNpPCUGrwjaGxYOu4W
 Vy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693831443; x=1694436243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uvgb1mY0EmO5+OIh91wyTfD/dyJ0WPXCogU6akizjwQ=;
 b=kTK+v7rpF3wPXOohtGlsChPbmjGWRbUnt5NY6jR3x+AEneqi8OfFQ97rqwAbc9OuMt
 t9K06cYHJTZZM4RCtVxenimbUDFJIhvzjqG9EGr35B6H2mqDP9MCvlKR2Ycfi1vrk6Mq
 YDG8jBz6hAnghwITK6kt+Jczjb3B2pgV/126DUcDeBFLxUmk9hFx9EsgTED4xHdipwpH
 CfXaVKD6HaebB6EOcbkToWle4Ka7VOIUXKRK1a0UfRWWbv5l9GFeA0ADZu35SwALrVEQ
 yg9ohgZE+bWlaQSyHqm03y5NZKnqMI1eq9PRxXW+R2MhDT6pKHfxFVRj1b70N+iHBreW
 9jGA==
X-Gm-Message-State: AOJu0YyxTOW7jNyrP/k9+wY81s/dVubd7/zfQAxjKIzoKhfpQXHzRHXQ
 bNJ6ysy0tmIMlN6/NsHF+Fz17TVNeAN5SekwT0Q=
X-Google-Smtp-Source: AGHT+IEKCW36+yHgpY2ZBNqNwkC4Vzs3gfJURNdlqSjhdC3qvST4PZ0o00mxq38nx3QQCXyG1+Hd8Q==
X-Received: by 2002:aa7:d699:0:b0:525:6588:b624 with SMTP id
 d25-20020aa7d699000000b005256588b624mr6061172edr.37.1693831443293; 
 Mon, 04 Sep 2023 05:44:03 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 b22-20020aa7d496000000b0051dd19d6d6esm5820773edr.73.2023.09.04.05.44.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 05:44:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 06/13] target/i386: Remove unused KVM stubs
Date: Mon,  4 Sep 2023 14:43:17 +0200
Message-ID: <20230904124325.79040-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904124325.79040-1-philmd@linaro.org>
References: <20230904124325.79040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

All these functions:

 - kvm_arch_get_supported_cpuid()
 - kvm_has_smm(()
 - kvm_hyperv_expand_features()
 - kvm_set_max_apic_id()

are called after checking for kvm_enabled(), which is
false when KVM is not built. Since the compiler elides
these functions, their stubs are not used and can be
removed.

Inspired-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/kvm/kvm-stub.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/target/i386/kvm/kvm-stub.c b/target/i386/kvm/kvm-stub.c
index e052f1c7b0..f985d9a1d3 100644
--- a/target/i386/kvm/kvm-stub.c
+++ b/target/i386/kvm/kvm-stub.c
@@ -10,42 +10,16 @@
  *
  */
 #include "qemu/osdep.h"
-#include "cpu.h"
 #include "kvm_i386.h"
 
 #ifndef __OPTIMIZE__
-bool kvm_has_smm(void)
-{
-    return 1;
-}
-
 bool kvm_enable_x2apic(void)
 {
     return false;
 }
-
-/* This function is only called inside conditionals which we
- * rely on the compiler to optimize out when CONFIG_KVM is not
- * defined.
- */
-uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
-                                      uint32_t index, int reg)
-{
-    abort();
-}
 #endif
 
 bool kvm_hv_vpindex_settable(void)
 {
     return false;
 }
-
-bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp)
-{
-    abort();
-}
-
-void kvm_set_max_apic_id(uint32_t max_apic_id)
-{
-    return;
-}
-- 
2.41.0


