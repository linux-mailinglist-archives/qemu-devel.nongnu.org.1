Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E267B640C
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:29:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnalD-0005Up-9j; Tue, 03 Oct 2023 04:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnal9-0005UZ-Kd
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:28:03 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnal7-00087R-Vr
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:28:03 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3248e90f032so701773f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696321680; x=1696926480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6tbksfbbfGHxqsqPubKWDwtMEoe2M3iP09KnCYcyqbI=;
 b=QlI/w7/9VF9W1oVHpKcJrO+RcWbgAxwSQPIpT3/JVJVzRwnVsiQfmgdLrZ6SZo2W0v
 T96fmPq//uMRFIgRLv9cbnAuWsqu2WzoV4+FBD5kEdVe1MSlhBCxwQXRa+rdSfn50xSu
 /wTvNFCV0qxkFf+Qh6VQo646h6a0OksrFVHotzZoJb85/VbTKilRh64dJd8KVkmv08jy
 PM3VvE7DGPb9XDm38ia0xi7K5XQyQQBbI2DlzadDTXvhvoVxyFoSqfEX9p4R7bVhSf9o
 Xxy3uOLHE0AvrWQc92mBBDAICpgaWCYgHTO/31RUelOkYSX+h+y4gS6TTJm3uKW+UXfL
 tUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321680; x=1696926480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6tbksfbbfGHxqsqPubKWDwtMEoe2M3iP09KnCYcyqbI=;
 b=YSsKPjCsfzaaVJaH41l4QHbtRnDpvTrfTR3K73hK9mM/K1RxaEr4T7FWS1nwVmL2+M
 n1HIpeGW9KgfwCQK9oMl1ODtL9Bol9xEx0Gmv9fUsgwaZpwfO4VjruD6/yN3AYxpx9Bn
 D+zE82HwxNiULe0ovDaJDHy7SWi8ulqqGArU8iUh4H8n1xthVuTVbhD4e3NgOKo674Y3
 iMdpfkCrobo6NwVj9XftW11dd6YFPtubGICHoBNQ/A01P6Tv9I7oFXGtrLwANvBbS0P7
 Jmbw0/1sJ5YaBUfCLIElxylnY5ryWlLKFAXBnxC3iMV3uqbDKlCtsJrjHkwTi9XO+aSq
 GiFQ==
X-Gm-Message-State: AOJu0YzFe8SgwcTjlHVkewUTmPosLiKvU/bhOOJkvLhEXroCLDpIXpH8
 Z8orbo/Jc2K9uDBcU7SaBzblh2nLy1CAMh6+oLfpNQ==
X-Google-Smtp-Source: AGHT+IEu9GaTF6lrkWwrIhzB2D9XTmxaKBXcRGVplcyqWREEL7G9ffBf8HsP1Dj28gN+39GrfYPTcw==
X-Received: by 2002:a5d:5a17:0:b0:319:8bd0:d18c with SMTP id
 bq23-20020a5d5a17000000b003198bd0d18cmr7681537wrb.52.1696321680014; 
 Tue, 03 Oct 2023 01:28:00 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a5d6843000000b003143867d2ebsm989890wrw.63.2023.10.03.01.27.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Oct 2023 01:27:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/5] hw/intc/apic: Rename x86_cpu_apic_create() ->
 x86_cpu_apic_new()
Date: Tue,  3 Oct 2023 10:27:27 +0200
Message-ID: <20231003082728.83496-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003082728.83496-1-philmd@linaro.org>
References: <20231003082728.83496-1-philmd@linaro.org>
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

x86_cpu_apic_create()'s Error** parameter is unused, drop it.

While there is no convention, QDev methods are usually named
with _new() / _realize() suffixes. Rename as appropriate.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu-internal.h | 2 +-
 hw/intc/apic_common.c      | 2 +-
 target/i386/cpu-sysemu.c   | 2 +-
 target/i386/cpu.c          | 5 +----
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu-internal.h b/target/i386/cpu-internal.h
index 9baac5c0b4..8299b347f7 100644
--- a/target/i386/cpu-internal.h
+++ b/target/i386/cpu-internal.h
@@ -62,7 +62,7 @@ GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs);
 void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
                                 const char *name, void *opaque, Error **errp);
 
-void x86_cpu_apic_create(X86CPU *cpu, Error **errp);
+void x86_cpu_apic_new(X86CPU *cpu);
 void x86_cpu_apic_realize(X86CPU *cpu, Error **errp);
 void x86_cpu_machine_reset_cb(void *opaque);
 #endif /* !CONFIG_USER_ONLY */
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index bccb4241c2..8a79eacdb0 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -451,7 +451,7 @@ static void apic_common_class_init(ObjectClass *klass, void *data)
     dc->unrealize = apic_common_unrealize;
     /*
      * Reason: APIC and CPU need to be wired up by
-     * x86_cpu_apic_create()
+     * x86_cpu_apic_new()
      */
     dc->user_creatable = false;
 }
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 9038c65267..373dc6b1c7 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -263,7 +263,7 @@ APICCommonClass *apic_get_class(void)
     return APIC_COMMON_CLASS(object_class_by_name(apic_type));
 }
 
-void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
+void x86_cpu_apic_new(X86CPU *cpu)
 {
     APICCommonState *apic;
     APICCommonClass *apic_class = apic_get_class();
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ed72883bf3..69d56bae91 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7418,10 +7418,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     qemu_register_reset(x86_cpu_machine_reset_cb, cpu);
 
     if (cpu->env.features[FEAT_1_EDX] & CPUID_APIC || ms->smp.cpus > 1) {
-        x86_cpu_apic_create(cpu, &local_err);
-        if (local_err != NULL) {
-            goto out;
-        }
+        x86_cpu_apic_new(cpu);
     }
 #endif
 
-- 
2.41.0


