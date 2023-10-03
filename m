Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 545837B6905
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:31:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qneYx-0000w5-H3; Tue, 03 Oct 2023 08:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qneYU-0000h1-8i
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:31:21 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qneYR-0007lj-TL
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:31:14 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40535597f01so8130735e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696336268; x=1696941068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0sreXSXDLh+LVLoU4Gk2cAKXN1sJ3KmjKke0mZhMO3w=;
 b=BciUNqpKg1fINjzTizXAT+b99177xF6x6znlmyjXBHM6bfPlk64uqRXLK8tVzrbv6l
 umySx/S//X+PbQSkJUrn/ViFXUWpNH4aeKOqs7d4l2Iq4xZKjY4ZMqYcolowWKtXosVB
 wqeQHT0Sz5vi0qBIfqFO3XTNLequ5F6KSdt7xIpLG8CnndhRTurf4tVZkzMtxmYwcR4U
 lOIuct1VETkZukon8I4+Aup7yW41gTg5nbmgS/XfMVTynBhWiMHbRzc+c9J62bJc9dAs
 LfTMcMq4l5q7jmDo3RXtpWWtsUZrG62TfQ5ecZ+IStUZtR2TYr7nx5uzUJmXHZDVjY2y
 sVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696336268; x=1696941068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0sreXSXDLh+LVLoU4Gk2cAKXN1sJ3KmjKke0mZhMO3w=;
 b=voUQ5B7TVEYphmxMzFnljTavF91AxO7RZy1BltPVKZt2aAdDG4Jkd4zht13F5z42Ft
 1YODOSZEhLf43T7j2rukdX4GGhNv3D4NueQfmMX5Q8CzXTCH4elBq2/wJM5lvar3U6et
 +ZrvF99CMrawyJNrbe8npuKvWkrUNzo0gS7dmPzClNBxv0zR0s2nRDobS2dzc1F52nWR
 Md8DwasyXTTOShFYdDftWsqTEzup0vxtBwCJZh81r9uRdokEyqXaIjTQ+uE7x4bwsYEY
 Pkz6CWsFux4VRu+4rCgoJvR+w2vIy0PyYqFGNG0gzSA1iics9HOnARFv3Mx9Hs2tkjH5
 Rwuw==
X-Gm-Message-State: AOJu0YyOkOPmKqUBFUB7XKK9bxUEQULjS2vpjLLtWBil5+QLbTBINrfb
 wA5sNMBQ+Sq4WbJifvDEyIQdwd/ObVvoRdaWpTM+RA==
X-Google-Smtp-Source: AGHT+IGgHu14QLaTZHtaqcvyhvqRXWFUFqZQ+U9E3BYtwlGQ+0F6OAn0a/YOhlJcZqr8dsHhPOyqvg==
X-Received: by 2002:a7b:c858:0:b0:405:40c6:2ba4 with SMTP id
 c24-20020a7bc858000000b0040540c62ba4mr12060645wml.5.1696336268240; 
 Tue, 03 Oct 2023 05:31:08 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 f20-20020a7bcd14000000b003fc16ee2864sm1183607wmj.48.2023.10.03.05.31.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Oct 2023 05:31:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 6/7] accel/tcg: Have tcg_exec_realizefn() return a boolean
Date: Tue,  3 Oct 2023 14:30:24 +0200
Message-ID: <20231003123026.99229-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003123026.99229-1-philmd@linaro.org>
References: <20231003123026.99229-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Following the example documented since commit e3fe3988d7 ("error:
Document Error API usage rules"), have tcg_exec_realizefn() return
a boolean indicating whether an error is set or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Claudio Fontana <cfontana@suse.de>
---
 include/exec/cpu-all.h | 2 +-
 accel/tcg/cpu-exec.c   | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index c2c62160c6..1e5c530ee1 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -422,7 +422,7 @@ void dump_exec_info(GString *buf);
 
 /* accel/tcg/cpu-exec.c */
 int cpu_exec(CPUState *cpu);
-void tcg_exec_realizefn(CPUState *cpu, Error **errp);
+bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
 void tcg_exec_unrealizefn(CPUState *cpu);
 
 /**
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c724e8b6f1..60f1986b85 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1088,7 +1088,7 @@ int cpu_exec(CPUState *cpu)
     return ret;
 }
 
-void tcg_exec_realizefn(CPUState *cpu, Error **errp)
+bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 {
     static bool tcg_target_initialized;
     CPUClass *cc = CPU_GET_CLASS(cpu);
@@ -1104,6 +1104,8 @@ void tcg_exec_realizefn(CPUState *cpu, Error **errp)
     tcg_iommu_init_notifier_list(cpu);
 #endif /* !CONFIG_USER_ONLY */
     /* qemu_plugin_vcpu_init_hook delayed until cpu_index assigned. */
+
+    return true;
 }
 
 /* undo the initializations in reverse order */
-- 
2.41.0


