Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1AB7A4E32
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:08:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGiN-00065H-AC; Mon, 18 Sep 2023 12:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGiK-00062t-CG
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:03:08 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGiI-0003uv-Kk
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:03:08 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2bfb17435e4so75837221fa.0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 09:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695052984; x=1695657784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YY2zRc5UQ1ttBDAhQdzUYI1/2Fa0E28wpiBNWWnnf1g=;
 b=FnnUy8p3UJEhNf0ABVOTbmAvW/NjVrDPuQRIETuh6xi+sd7KoJnS0V0fmh350uZ8j3
 e+YCFUHELkYRTAQMXhJJsfCtqeiAKHxf2xvQg1yb94SdFqwcNfPv4Rv51gTwsUr/bz/J
 kmlWAvlcV0xx5Ox2tlB8agxLfS/Peh7dFqvjYRr3mldvEWrObHza9AB09fpObl0wMPT+
 kBm0OLzyjM0aDrxn7lKF4P4tranS5iM5CjJsg643qrPk5aOgxzdAcbmK0b1/1OPNYnrO
 a5J8loslnssAjGn2PU4SvQZ4BJUZcLMZyPrbtn5yJklISX+MhmIntiyVgI2DA4ZowckQ
 TBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695052984; x=1695657784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YY2zRc5UQ1ttBDAhQdzUYI1/2Fa0E28wpiBNWWnnf1g=;
 b=EsrSt1Nj01xLfPxdjyy+Q6keN93imahCmn9HGRXQBnC5yI59LqvSvoro+NIHbMN/bw
 mb1cFlBFeSXa/i5nV50NpkzbPDdOuEwtEkOsh+41RZUHYuRhWVihBb3+nagz8giRerRS
 xhmiQZTcqL0CjfPeMLCFshgBNFaGZ6UCb1sJAvDWd9cycXvs97fwkwmxk+5vLQA6V7me
 C2kkkzkgjD6YMLTt+xC++hLdofoTkIGboJ0wqAH9PEMGfMrXP7xGYyFEeLk9siFCf15R
 yktYj/n0ZdSUJwYMFzJii3EE+Qd1qEC9OSnrcQE+ZF7zKR+BZpoXiwOeRttO1vYsLRc9
 mQyg==
X-Gm-Message-State: AOJu0Yz/BxnLW+63+3mnoUJ9wK5R4ToxIeDu1XOhwaaQ9ReN+uY0mzrw
 jxc1itLnTunzV5/vXdSIm1ldxlnI95061iIAYjWWOBqb
X-Google-Smtp-Source: AGHT+IFFWaHmceQaMQCtP1tx1U1BqdKcHKrYFUd0/PUiwjaiOXpmM2RbiU2HoQiVRUd/I863ShUWOQ==
X-Received: by 2002:a2e:3614:0:b0:2b9:f27f:e491 with SMTP id
 d20-20020a2e3614000000b002b9f27fe491mr9068179lja.42.1695052984526; 
 Mon, 18 Sep 2023 09:03:04 -0700 (PDT)
Received: from localhost.localdomain
 (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a1709065ac500b00993664a9987sm6574017ejs.103.2023.09.18.09.03.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Sep 2023 09:03:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand <david@redhat.com>,
 Peter Xu <peterx@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Marek Vasut <marex@denx.de>, David Gibson <david@gibson.dropbear.id.au>,
 Brian Cain <bcain@quicinc.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Claudio Fontana <cfontana@suse.de>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-ppc@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alessandro Di Federico <ale@rev.ng>, Song Gao <gaosong@loongson.cn>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Chris Wulff <crwulff@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>,
 qemu-s390x@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Luc Michel <luc@lmichel.fr>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Bin Meng <bin.meng@windriver.com>, Stafford Horne <shorne@gmail.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 Michael Rolnik <mrolnik@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 01/22] target/i386: Only realize existing APIC device
Date: Mon, 18 Sep 2023 18:02:34 +0200
Message-ID: <20230918160257.30127-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918160257.30127-1-philmd@linaro.org>
References: <20230918160257.30127-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

APIC state is created under a certain condition,
use the same condition to realize it.
Having a NULL APIC state is a bug: use assert().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu-sysemu.c | 9 +++------
 target/i386/cpu.c        | 8 +++++---
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 2375e48178..6a164d3769 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -272,9 +272,7 @@ void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
     APICCommonState *apic;
     APICCommonClass *apic_class = apic_get_class(errp);
 
-    if (!apic_class) {
-        return;
-    }
+    assert(apic_class);
 
     cpu->apic_state = DEVICE(object_new_with_class(OBJECT_CLASS(apic_class)));
     object_property_add_child(OBJECT(cpu), "lapic",
@@ -293,9 +291,8 @@ void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)
     APICCommonState *apic;
     static bool apic_mmio_map_once;
 
-    if (cpu->apic_state == NULL) {
-        return;
-    }
+    assert(cpu->apic_state);
+
     qdev_realize(DEVICE(cpu->apic_state), NULL, errp);
 
     /* Map APIC MMIO area */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b2a20365e1..a23d4795e0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7448,9 +7448,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
-    x86_cpu_apic_realize(cpu, &local_err);
-    if (local_err != NULL) {
-        goto out;
+    if (cpu->env.features[FEAT_1_EDX] & CPUID_APIC || ms->smp.cpus > 1) {
+        x86_cpu_apic_realize(cpu, &local_err);
+        if (local_err != NULL) {
+            goto out;
+        }
     }
 #endif /* !CONFIG_USER_ONLY */
     cpu_reset(cs);
-- 
2.41.0


