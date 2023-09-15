Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2A87A26CF
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 21:01:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhE3c-0006BB-VZ; Fri, 15 Sep 2023 15:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhE3Z-0005vO-9e
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 15:00:45 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhE3V-0007aa-6r
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 15:00:44 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2bce552508fso38491171fa.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 12:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694804439; x=1695409239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YgOXTjMw7CegRZgzm9gZgaFqpfOBfIJY+75/jhEK298=;
 b=JWx2AxDeZ3UH9Iq0gpA8RIRY8gMaBrdwU6/Xx8/b8xL1/dwSfJ9eLvsMucVCx54fiA
 RJLSgkRWl3qODJ7vDHw/C+8dcZiGw836fwSXeJbHRk5pfu89OlrZ9HWW2n6kYlp7IEYd
 3oNxN8Y2ygWTmZeJ2vU1TbjwR82gqZWwksmWwl+kFgIGhQLNQdBoq2c7k8nPKmakJXvo
 MXxE1zsgiS1PL1A/4RGVXbfGPOiUlHFMeBHlmOwxCwENh8BPEHYS90cnO6pvOpgrijf4
 IqOJaalDnfM7BUGy1IAZ+hZH++eM+HcfDc+R5L3a9BLaMMywtuH4zscU98jlvZrLSOLV
 5r+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694804439; x=1695409239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgOXTjMw7CegRZgzm9gZgaFqpfOBfIJY+75/jhEK298=;
 b=Ii/w0Ddlv3pWmz6m2Odb8KVF/+sVYJiWX/T9RCpVUE/wdohQGgS7/SZXAqgLByNkHy
 VUu7VPRYUzAqGW56kGjOqRpkqKKrNoMudFNMzVp6j+RAFP/1h13iAY+NVgdYo+EpqQjJ
 0jLuZABsvUzBuAKyTXo1u/9Tdp6BnkjZWl36qqcuv7O155cLFyqBLy2DzctlBTVai+TG
 437J3rDnfy9QmWZbO0P9QxgeKn6s4l8pUFOUiHbJTki3gLlvQK06kGPbIpqs8RijBobR
 DLZTgId945VSqwwA/4iQE6PhiB/SRU9BdKHwhJu4ljMFvRFYkY0oFowZ5J7SrXp2WHeX
 My4w==
X-Gm-Message-State: AOJu0YwJjisL7fTmuB41CQme/cpCqLsyKYmODy7dQGfpGdckODR/M1Cj
 yi7rKRPzGp7tOXb0Ow4M4EFIjxbx3/JPuUK4EsU=
X-Google-Smtp-Source: AGHT+IFb62BREUPfjWbOVNIJ5iUEG9onYwiuiWAr/WJWgO5E/Rw3dRu3NysvQrmCzHvFT+lowhetpw==
X-Received: by 2002:a2e:b001:0:b0:2bc:b46b:686b with SMTP id
 y1-20020a2eb001000000b002bcb46b686bmr2330235ljk.34.1694804438711; 
 Fri, 15 Sep 2023 12:00:38 -0700 (PDT)
Received: from m1x-phil.lan (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr.
 [176.171.209.234]) by smtp.gmail.com with ESMTPSA id
 l21-20020a1709061c5500b009ad89697c86sm2771684ejg.144.2023.09.15.12.00.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Sep 2023 12:00:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Marcelo Tosatti <mtosatti@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 4/5] accel/tcg: Have tcg_exec_realizefn() return a boolean
Date: Fri, 15 Sep 2023 21:00:07 +0200
Message-ID: <20230915190009.68404-5-philmd@linaro.org>
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

Following the example documented since commit e3fe3988d7 ("error:
Document Error API usage rules"), have tcg_exec_realizefn() return
a boolean indicating whether an error is set or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index e2c494e75e..fa97e9f191 100644
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


