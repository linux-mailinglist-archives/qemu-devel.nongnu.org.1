Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 247217BD7A0
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:51:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmsW-0001ui-K8; Mon, 09 Oct 2023 05:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmro-0001T6-Gn
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:48:03 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmrm-0005wb-Kx
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:48:00 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9ba081173a3so360539666b.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696844877; x=1697449677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vq0Txo18oKNgqgLa0NbVIIUbcU1WzhTxJcpN9pagyhs=;
 b=xIhzdOZ7cG7ZkZ1Po3OLADTikCBdSXQOS3cwnmJLv0eYQ8c4uXO0nWcAWrv0KuPUvV
 tg9WoSHZ2fTcHhXrpuhKg/41BUVm/gZHvpux9Uk7sklk+9sNFpHSvDlp5wzy/WcH1M40
 8fRPhP2G827i8tZfgvmPkWlXoDN48QHl1OGlAVl1ujFCyKB2eDHBJYcKy3HHciKX+ucE
 ijNs37drjC4mS0SPLntqT8rcrzES8AQluSNwGkG3bGyGYTMpuhlwNareouvl0GCrRtqb
 qqhpGist/NwqbuOC5uHvYU7NJD4Yx4AtaeyyG6tmvk6QbvWcEdUy8n2+lHUsomAYr7Qy
 l6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696844877; x=1697449677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vq0Txo18oKNgqgLa0NbVIIUbcU1WzhTxJcpN9pagyhs=;
 b=HLY3BDwIMtB3t32Irp2e6H1T60DHU7h07euD7oSIxpPC87nmQrzytGbGFDgDSf5wik
 o0So4afsgO2RS6wTZMMKCdomNLK0kem/BgzCdFG/LWA8r03FHMPhicCUlpwXj1Awx93V
 yJ7TQx4SsnTyvBv5RwhuohDMIjnqdjpmFqJnEFVdlmMjeFc6CAMpxE9fv07hn6JZfiQv
 kt5xcsqRgiGIjCbLsCGDasjWiqIT7vvGNjgsJswK9tXCEptN8O10W5Vi422stmaZbfMa
 KEIs+fylEOKGQldxVFLgpzxmprExVxPfX8Tq4lswelf+Cgo4kcfLaD/VUmhq8lrcqIPA
 iSKQ==
X-Gm-Message-State: AOJu0YwzfnxHayece5lPW+46N0ZIG3mx1nu4BtygXpbl1pYeERLtrgAl
 OihzRdXT0gI6FQ4+m3L1Kste2ViAGVwd27lMWKM=
X-Google-Smtp-Source: AGHT+IEP3uf9vpuxseig2Trwf7JOxN7naKWy+TwNEjaHHASsDBvJI8w/4be68ccQJydPn3IzqwtC/Q==
X-Received: by 2002:a17:906:1ba1:b0:9ba:2fe3:c97e with SMTP id
 r1-20020a1709061ba100b009ba2fe3c97emr377767ejg.11.1696844876878; 
 Mon, 09 Oct 2023 02:47:56 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 l7-20020a170906414700b009ae69c303aasm6506561ejk.137.2023.10.09.02.47.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 02:47:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, David Hildenbrand <david@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/6] hw/core/cpu: Clean up global variable shadowing
Date: Mon,  9 Oct 2023 11:47:41 +0200
Message-ID: <20231009094747.54240-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009094747.54240-1-philmd@linaro.org>
References: <20231009094747.54240-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

Fix:

  hw/core/machine.c:1302:22: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
      const CPUArchId *cpus = possible_cpus->cpus;
                       ^
  hw/core/numa.c:69:17: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
      uint16List *cpus = NULL;
                  ^
  hw/acpi/aml-build.c:2005:20: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
      CPUArchIdList *cpus = ms->possible_cpus;
                     ^
  hw/core/machine-smp.c:77:14: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
      unsigned cpus    = config->has_cpus ? config->cpus : 0;
               ^
  include/hw/core/cpu.h:589:17: note: previous declaration is here
  extern CPUTailQ cpus;
                  ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h     | 8 ++++----
 cpu-common.c              | 6 +++---
 target/s390x/cpu_models.c | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index e02bc5980f..d0dc0a1698 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -586,13 +586,13 @@ static inline CPUArchState *cpu_env(CPUState *cpu)
 }
 
 typedef QTAILQ_HEAD(CPUTailQ, CPUState) CPUTailQ;
-extern CPUTailQ cpus;
+extern CPUTailQ cpus_queue;
 
-#define first_cpu        QTAILQ_FIRST_RCU(&cpus)
+#define first_cpu        QTAILQ_FIRST_RCU(&cpus_queue)
 #define CPU_NEXT(cpu)    QTAILQ_NEXT_RCU(cpu, node)
-#define CPU_FOREACH(cpu) QTAILQ_FOREACH_RCU(cpu, &cpus, node)
+#define CPU_FOREACH(cpu) QTAILQ_FOREACH_RCU(cpu, &cpus_queue, node)
 #define CPU_FOREACH_SAFE(cpu, next_cpu) \
-    QTAILQ_FOREACH_SAFE_RCU(cpu, &cpus, node, next_cpu)
+    QTAILQ_FOREACH_SAFE_RCU(cpu, &cpus_queue, node, next_cpu)
 
 extern __thread CPUState *current_cpu;
 
diff --git a/cpu-common.c b/cpu-common.c
index 45c745ecf6..c81fd72d16 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -73,7 +73,7 @@ static int cpu_get_free_index(void)
     return max_cpu_index;
 }
 
-CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
+CPUTailQ cpus_queue = QTAILQ_HEAD_INITIALIZER(cpus_queue);
 static unsigned int cpu_list_generation_id;
 
 unsigned int cpu_list_generation_id_get(void)
@@ -90,7 +90,7 @@ void cpu_list_add(CPUState *cpu)
     } else {
         assert(!cpu_index_auto_assigned);
     }
-    QTAILQ_INSERT_TAIL_RCU(&cpus, cpu, node);
+    QTAILQ_INSERT_TAIL_RCU(&cpus_queue, cpu, node);
     cpu_list_generation_id++;
 }
 
@@ -102,7 +102,7 @@ void cpu_list_remove(CPUState *cpu)
         return;
     }
 
-    QTAILQ_REMOVE_RCU(&cpus, cpu, node);
+    QTAILQ_REMOVE_RCU(&cpus_queue, cpu, node);
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     cpu_list_generation_id++;
 }
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 98f14c09c2..b1e77b3a2b 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -756,7 +756,7 @@ void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
     const S390CPUDef *def = s390_find_cpu_def(type, gen, ec_ga, NULL);
 
     g_assert(def);
-    g_assert(QTAILQ_EMPTY_RCU(&cpus));
+    g_assert(QTAILQ_EMPTY_RCU(&cpus_queue));
 
     /* build the CPU model */
     s390_qemu_cpu_model.def = def;
-- 
2.41.0


