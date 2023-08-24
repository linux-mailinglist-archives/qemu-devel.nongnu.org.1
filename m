Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A060786BFD
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:32:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6em-0007UB-M5; Thu, 24 Aug 2023 05:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eC-0004HX-It
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:00 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e9-0004yH-5f
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:00 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31c5327e5e8so412926f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869322; x=1693474122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Fvo37lHKSY4gbS092X7jXMhMWoKtNHO/9H2RjswZUW4=;
 b=V7P8LD+WS3+dYbcNuFQjUoWIIZs1+kLqUpvenkhb7EV6Jwlklm9oz+VRnWp0478iiZ
 QFVoGXFhgiXpavalkKZ983vNxHwzhyXfGSql3h0ijbAVnUCMOPfgbdSUtDmjy8tPjZRs
 094Cn8UfEQr/3tRWEcC6fuuRqwOoR6+fdyPeaF3lypMLNOkn9F/aaofV/yT3MMfNdNY0
 POSb/2LXhbXqI8xEfpMm6RKHZALR+WPGNXbBgStE8zv5jIW2VsejY9FNck/x2VuxXi7K
 6W5hKc2k7gEsiNKfI0A6WY2GPDfp3FsrYcvMMxzm0wc+SVOy2rXiOGXtBs8lwwgD1ZWz
 JpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869322; x=1693474122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fvo37lHKSY4gbS092X7jXMhMWoKtNHO/9H2RjswZUW4=;
 b=D3ExfKRlHoR8PNPThLAaA1WHa0ceVoWcPt0e1Vhu7i6fGimC7EWVKEOJ5srxO9Ra6W
 N/SvkSj2JXgtCrBqgs8pLUPttl61S/JhhyQ+g/jrVs3q/DbCeDwAeuy5/x0ahc8xqnzj
 6Z/8ev39MxD61G96aBD/+69xl7AmQjB5zE8PRImCWYKZR0dudOfuB9vLnNXc8kfBkeYK
 sTppt7qgT1hVG3iQbH7ZZf3HyoBF9iWK6Y2/uefTadTvTstXnIbJfe/sDpysv6rB4iHm
 wVyVvQaclz/Oja9KkPVSTe6Q14pEfsFU+91tyJyH+RDChBuJn4rYJfFs6FRiXzdOE70/
 U8nA==
X-Gm-Message-State: AOJu0YyG95TXm2SsibgDxQIaL+PRm5wboYomvnA5k8U3+77qh9DPWSWf
 WeLUdLRADqk3NYlrYaNMhLgeLMvdZ6wFvpw+0lo=
X-Google-Smtp-Source: AGHT+IGOkRXvoWjzfnxljjAF39JVGnOoeX+GlAaHiUwjJd0Hru97rzGnchFrtxpfmgr8hcNIGh6Cyg==
X-Received: by 2002:adf:ff87:0:b0:319:747f:4eb7 with SMTP id
 j7-20020adfff87000000b00319747f4eb7mr13237704wrr.22.1692869322344; 
 Thu, 24 Aug 2023 02:28:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/35] accel/kvm: Use negative KVM type for error propagation
Date: Thu, 24 Aug 2023 10:28:11 +0100
Message-Id: <20230824092836.2239644-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

On MIPS, kvm_arch_get_default_type() returns a negative value when an
error occurred so handle the case. Also, let other machines return
negative values when errors occur and declare returning a negative
value as the correct way to propagate an error that happened when
determining KVM type.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-id: 20230727073134.134102-5-akihiko.odaki@daynix.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/kvm/kvm-all.c | 5 +++++
 hw/arm/virt.c       | 2 +-
 hw/ppc/spapr.c      | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b4723016379..3bac5aa678b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2527,6 +2527,11 @@ static int kvm_init(MachineState *ms)
         type = kvm_arch_get_default_type(ms);
     }
 
+    if (type < 0) {
+        ret = -EINVAL;
+        goto err;
+    }
+
     do {
         ret = kvm_ioctl(s, KVM_CREATE_VM, type);
     } while (ret == -EINTR);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7d9dbc26633..83c05f1b9f6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2913,7 +2913,7 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
                      "require an IPA range (%d bits) larger than "
                      "the one supported by the host (%d bits)",
                      requested_pa_size, max_vm_pa_size);
-        exit(1);
+        return -1;
     }
     /*
      * We return the requested PA log size, unless KVM only supports
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1c8b8d57a70..e851f609198 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3105,7 +3105,7 @@ static int spapr_kvm_type(MachineState *machine, const char *vm_type)
     }
 
     error_report("Unknown kvm-type specified '%s'", vm_type);
-    exit(1);
+    return -1;
 }
 
 /*
-- 
2.34.1


