Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C14007A26D6
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 21:01:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhE3S-0005n1-0s; Fri, 15 Sep 2023 15:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhE3N-0005ml-Sa
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 15:00:33 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhE3H-0007YG-2O
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 15:00:33 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2bfbbd55158so39985661fa.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 12:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694804425; x=1695409225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yj/VmI3CWTgvZ6wzrxeZ+28cs5rrw6eKGcMTnrAf39k=;
 b=xUHo19+vptao8kqSuuUWv/Q39lEv+7Htw0FWGKlTZGLOuXPgNKFgtFmJ5VhU89TVDD
 UgSBqWuFWP1vpwH2Ew0HcQ9jY/7o7FgP2p1F4ZOiA4U+N9RT3olu50mAmAT3gmHFsXVg
 Wa9OxnS9upj/4r+qNkS6Bw0yEKwweBRkH1hfsr0/22H54na1maPE3pO6SkdsiYiDqeB9
 9ZrBrNZg6PsLUrKf2Bq96Bji1erzBmAbwXhrSPqF57ok13WKdVutV+Gkw3HYZKjWN1Bv
 IKa2nMPKz1xWS04Qo4DJ/txBgBa3AjEBC70y5+zyhBS3RZ0eXz7C1mmDs/4TPSYi5g3M
 PSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694804425; x=1695409225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yj/VmI3CWTgvZ6wzrxeZ+28cs5rrw6eKGcMTnrAf39k=;
 b=Q9bFmnSO6+YwlqxM5zP1qanSXm1dqGGmAoucw4t/u8zwFeP8jiNVeR6Zqkiog779Fd
 WAGW37OX5u3WCGJT9EMkwdHFqIRhH2iP7kiHLSjyksH4gfhZXlxgEhC6D7e+udYhxYQW
 dvouDytbFxaYyvATXVtVF1fXDvRAPookvMSJIUVv5hvIRLni5+RZ7aOExDRayXcXfiFB
 EBZpnLNqpw4Zr24WFi/j9bhIbUtmlOc2OyustNW90mJ94BtlemC5b4KJM6c7Vw3r8tdW
 ysDsty2UDBuToaj1/rMFLPC3LyXppY0TEe5z77U7GzdQqWhKZoDY8C+AI8ctSTRBgp+u
 fDgQ==
X-Gm-Message-State: AOJu0Yzy4wsNP6qFJNo99Np73alNdsWaonJMlbRS+wLUhQLVCu9ExXSt
 4j+DlJoTCVX2cggl7xZZ7202qMdEfOvAn2ta+Gs=
X-Google-Smtp-Source: AGHT+IFqQLY3Tj7eqeOV4Qk/KF83QEwxNZjoYa3bqymzIJPp2j/TFg6tNe+VoWlEZLh1FUBo2pLong==
X-Received: by 2002:a2e:3e0e:0:b0:2b6:bc30:7254 with SMTP id
 l14-20020a2e3e0e000000b002b6bc307254mr2206820lja.13.1694804424824; 
 Fri, 15 Sep 2023 12:00:24 -0700 (PDT)
Received: from m1x-phil.lan (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr.
 [176.171.209.234]) by smtp.gmail.com with ESMTPSA id
 lc25-20020a170906dff900b0099bd86f9248sm2776714ejc.63.2023.09.15.12.00.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Sep 2023 12:00:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Marcelo Tosatti <mtosatti@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 2/5] accel: Introduce accel_cpu_unrealize() stub
Date: Fri, 15 Sep 2023 21:00:05 +0200
Message-ID: <20230915190009.68404-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915190009.68404-1-philmd@linaro.org>
References: <20230915190009.68404-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

Prepare the stub for parity with accel_cpu_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/accel.h | 6 ++++++
 accel/accel-common.c | 4 ++++
 cpu.c                | 3 ++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index cb64a07b84..23254c6c9c 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -96,6 +96,12 @@ void accel_cpu_instance_init(CPUState *cpu);
  */
 bool accel_cpu_realize(CPUState *cpu, Error **errp);
 
+/**
+ * accel_cpu_unrealizefn:
+ * @cpu: The CPU that needs to call accel-specific cpu unrealization.
+ */
+void accel_cpu_unrealize(CPUState *cpu);
+
 /**
  * accel_supported_gdbstub_sstep_flags:
  *
diff --git a/accel/accel-common.c b/accel/accel-common.c
index b953855e8b..cc3a45e663 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -129,6 +129,10 @@ bool accel_cpu_realize(CPUState *cpu, Error **errp)
     return true;
 }
 
+void accel_cpu_unrealize(CPUState *cpu)
+{
+}
+
 int accel_supported_gdbstub_sstep_flags(void)
 {
     AccelState *accel = current_accel();
diff --git a/cpu.c b/cpu.c
index 61c9760e62..b928bbed50 100644
--- a/cpu.c
+++ b/cpu.c
@@ -187,8 +187,9 @@ void cpu_exec_unrealizefn(CPUState *cpu)
     cpu_list_remove(cpu);
     /*
      * Now that the vCPU has been removed from the RCU list, we can call
-     * tcg_exec_unrealizefn, which may free fields using call_rcu.
+     * accel_cpu_unrealize, which may free fields using call_rcu.
      */
+    accel_cpu_unrealize(cpu);
     if (tcg_enabled()) {
         tcg_exec_unrealizefn(cpu);
     }
-- 
2.41.0


