Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A43E832916
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:42:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQn9r-0001ei-Hj; Fri, 19 Jan 2024 06:35:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQn9o-0001bV-48
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:35:32 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQn9k-0007Yy-U7
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:35:31 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e9fd483e2so2598895e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705664127; x=1706268927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H2zlYB8RHgO8CCP+jqoBT970ZAV+LbSEyEbXoFvRXkI=;
 b=Qzs905oIjX9Qx/rZ4OLyTlFAdU3S0idZTECKM5QQeqQ4mnEFy90b9MGigdj4sXi43i
 9HREvQuj6izbvH9HsQrq29JQtna9OIBqTTq/IrXDsF606VgwnbufiMCR1m3rC8yH7jsR
 c4hX3ImLNFRJX/hlube2Teo+GlQ4FiP30x9uQWI+7tf9SZCrnIloyz4OOrU94vvD0Hih
 cY/d3Ls9XFMgSjiLC4aqfNmI7rk2tJyue3QSrvBuXfDifYHHsslI51hXa25f6SePUR3E
 e9oszdUp7edo7ebOb+T/vOtjyJ7TC8Fc+32tn2zZ8wo1WuWujlmyVDnkfNK3ip38d5SU
 QhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705664127; x=1706268927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H2zlYB8RHgO8CCP+jqoBT970ZAV+LbSEyEbXoFvRXkI=;
 b=dzG748B/h98Kr8guV/FDdoChRABgb0F9zXhnxLZETE5vBpWRx1XxsIoVCCAFDFUkai
 mPqZobz6Wnfryyq4Zvb8DsA9FlGr091JtsrieoDRZpYvrJ/aMGzGBigviVycXoJfTH4y
 nKmPKieocOwC8+NjSX8/WYyv32rG7n4Q2inA8RiCb9dxLCWFmoj0hJDUzq0NxIuzFSWB
 4eSnmqY54V6Dinsv+iu9z9qyHJotLsjEzK2r/XDhiJtxZfStY/etUyyqqoGeJAJ5Juk4
 dR4UJn67Nu5mU+jZJ4Xw7qmeBX80KhCaMH+p6IYskmGiEWeNnXWQ/zJPBQle5zVcwkjp
 y6rw==
X-Gm-Message-State: AOJu0Yw0KVS/oe8pGn4Tg8ZlTJNOPcmlu+QFf+X11Lv5+CaEgmLMrDM1
 bUe4jp3OVbdaFqEzIIckuPOXwLYv+A4oG0e2PLFvg1FiZrJl5tLBCseJcAXBoja8OAtJyONPmeo
 00iVavw==
X-Google-Smtp-Source: AGHT+IGXU2gL8oAHDVoYCWzkuB2wKuhhJqWN9FvsoGiKo9WKC58O5rIAZisM3Bq3Tpucyvg8fXp3yg==
X-Received: by 2002:a05:600c:46cf:b0:40e:5118:5046 with SMTP id
 q15-20020a05600c46cf00b0040e51185046mr1365481wmo.21.1705664127043; 
 Fri, 19 Jan 2024 03:35:27 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 p10-20020a05600c358a00b0040e559e0ba7sm32395502wmq.26.2024.01.19.03.35.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 03:35:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PULL 04/36] accel: Do not set CPUState::can_do_io in non-TCG accels
Date: Fri, 19 Jan 2024 12:34:33 +0100
Message-ID: <20240119113507.31951-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119113507.31951-1-philmd@linaro.org>
References: <20240119113507.31951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

'can_do_io' is specific to TCG. It was added to other
accelerators in 626cf8f4c6 ("icount: set can_do_io outside
TB execution"), then likely copy/pasted in commit c97d6d2cdf
("i386: hvf: add code base from Google's QEMU repository").
Having it set in non-TCG code is confusing, so remove it from
QTest / HVF / KVM.

Fixes: 626cf8f4c6 ("icount: set can_do_io outside TB execution")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231129205037.16849-1-philmd@linaro.org>
---
 accel/dummy-cpus.c        | 1 -
 accel/hvf/hvf-accel-ops.c | 1 -
 accel/kvm/kvm-accel-ops.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index f4b0ec5890..20519f1ea4 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -27,7 +27,6 @@ static void *dummy_cpu_thread_fn(void *arg)
     bql_lock();
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
-    cpu->neg.can_do_io = true;
     current_cpu = cpu;
 
 #ifndef _WIN32
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 8eabb696fa..d94d41ab6d 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -428,7 +428,6 @@ static void *hvf_cpu_thread_fn(void *arg)
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
-    cpu->neg.can_do_io = true;
     current_cpu = cpu;
 
     hvf_init_vcpu(cpu);
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 45ff06e953..b3c946dc4b 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -36,7 +36,6 @@ static void *kvm_vcpu_thread_fn(void *arg)
     bql_lock();
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
-    cpu->neg.can_do_io = true;
     current_cpu = cpu;
 
     r = kvm_init_vcpu(cpu, &error_fatal);
-- 
2.41.0


