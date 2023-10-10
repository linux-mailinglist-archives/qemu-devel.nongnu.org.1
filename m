Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9942F7BF771
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 11:34:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq95I-0002Rs-GX; Tue, 10 Oct 2023 05:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq94U-0000sd-51
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:30:45 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq94O-00084t-3p
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:30:33 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5334d78c5f6so9354775a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 02:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696930219; x=1697535019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FCZsPKk2jjgL5uslZNHqLJ2r1o7NzsXUetagm0hbuBc=;
 b=Ilr/f8eYdXSnsRvSzMA9kNkxqDTVFL8mi9YQlm828cGS+zN00CzZi7R2U6QjbyRS11
 Oi7l8dL3yLqqPJfYBci8ABAkziFiY4MV4JsLQCOQ6fRj4QlXBd2Z4jrsaJAz5PYufaNy
 NaoZyXtgZaPKapbDa5HMPsli+jDnFR6HomqbNo30tNrZ3KJ5owFnAKD0su3OR2KeRJ9D
 A9BfmvantnBo2+Cuc7+rucVM26wPhTK7CGYXxqPThAg/chsw+28aRQa6WM+A7oT3Hr+1
 o6y2VqyYrRKNFfIda0khDxEaJEhzceUu69HlSc58jtmiTRM6gl24jzLGm8fUIL34Hq3x
 Z5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696930219; x=1697535019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FCZsPKk2jjgL5uslZNHqLJ2r1o7NzsXUetagm0hbuBc=;
 b=lNpquJ1L3uc+W+mprBPGzDWMnnqfPqez4PBk1b5eMatpNOPZUa5zcgP6lFg0nQPa46
 Ll6BmP+wlG166epsx6SlB3y54INytWBGtXQYSbjE+fkFvqEMIO91ZB03wneOxcKRuh64
 9kI3KIgH6s9FlyJ4JnYsxRafQMJC9JzpDgt3B9EXmUpTIQ/jGd20gvCYEQC9GQJqXijT
 EfAFUDV3I7c5K//VfbB9znLZCnabR9HXKIY6ulGZzyK2pXx63kYyTDgjSsB6BQvkVTes
 pXPZvAnReaD8kfm3AT890zcfmJMjq/iSxsu8BRE2o+lMjO3A73vLLaX20QtKypiHiXVT
 f5PQ==
X-Gm-Message-State: AOJu0YyDbYZDSjcxzzxy183nQf7fVVREuFdW4jJvp0YBGf5vBWm9okzx
 YM6W7x/paPQZ3kc8BNzcaTxAD4lblJINlVEmVxBwQg==
X-Google-Smtp-Source: AGHT+IF3bVucj6ztU9rQD2nKNlkxtg71QbAAxgtt2247HQDS7f7j2dfYOgPItK6K//guyIm4xjMFXQ==
X-Received: by 2002:a50:ee87:0:b0:514:9ab4:3524 with SMTP id
 f7-20020a50ee87000000b005149ab43524mr16259823edr.7.1696930219293; 
 Tue, 10 Oct 2023 02:30:19 -0700 (PDT)
Received: from m1x-phil.lan (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr.
 [176.172.113.148]) by smtp.gmail.com with ESMTPSA id
 u25-20020aa7db99000000b0053116e45317sm7298755edt.44.2023.10.10.02.30.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Oct 2023 02:30:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-arm@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Yanan Wang <wangyanan55@huawei.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Eduardo Habkost <eduardo@habkost.net>, Brian Cain <bcain@quicinc.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-s390x@nongnu.org
Subject: [PATCH 09/18] target/i386: Inline target specific
 TARGET_DEFAULT_CPU_TYPE definition
Date: Tue, 10 Oct 2023 11:28:51 +0200
Message-ID: <20231010092901.99189-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010092901.99189-1-philmd@linaro.org>
References: <20231010092901.99189-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

TARGET_DEFAULT_CPU_TYPE depends on the TARGET_X86_64 definition
which is target specific. Such target specific definition taint
"cpu-qom.h".

Since "cpu-qom.h" must be target agnostic, remove this target
specific definition uses by inlining TARGET_DEFAULT_CPU_TYPE in
the two machines using it.

"target/i386/cpu-qom.h" is now fully target agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h | 6 ------
 hw/i386/microvm.c | 6 +++++-
 hw/i386/pc.c      | 6 +++++-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 862e4f1ff5..7c976971c7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2243,12 +2243,6 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 
 #define CPU_RESOLVING_TYPE TYPE_X86_CPU
 
-#ifdef TARGET_X86_64
-#define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu64")
-#else
-#define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu32")
-#endif
-
 #define cpu_list x86_cpu_list
 
 /* MMU modes definitions */
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index b9c93039e2..281bf0c364 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -650,7 +650,11 @@ static void microvm_class_init(ObjectClass *oc, void *data)
     mc->has_hotpluggable_cpus = false;
     mc->auto_enable_numa_with_memhp = false;
     mc->auto_enable_numa_with_memdev = false;
-    mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
+#ifdef TARGET_X86_64
+    mc->default_cpu_type = X86_CPU_TYPE_NAME("qemu64");
+#else
+    mc->default_cpu_type = X86_CPU_TYPE_NAME("qemu32");
+#endif
     mc->nvdimm_supported = false;
     mc->default_ram_id = "microvm.ram";
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index aad7e8ccd1..2f7c0c1bdb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1818,7 +1818,11 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     hc->plug = pc_machine_device_plug_cb;
     hc->unplug_request = pc_machine_device_unplug_request_cb;
     hc->unplug = pc_machine_device_unplug_cb;
-    mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
+#ifdef TARGET_X86_64
+    mc->default_cpu_type = X86_CPU_TYPE_NAME("qemu64");
+#else
+    mc->default_cpu_type = X86_CPU_TYPE_NAME("qemu32");
+#endif
     mc->nvdimm_supported = true;
     mc->smp_props.dies_supported = true;
     mc->default_ram_id = "pc.ram";
-- 
2.41.0


