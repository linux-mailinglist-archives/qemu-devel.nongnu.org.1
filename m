Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F1283662E
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 15:59:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRvio-0006z3-Pg; Mon, 22 Jan 2024 09:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRvim-0006xd-Im
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 09:56:20 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRvig-0008Fx-8L
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 09:56:20 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e9101b5f9so37283355e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 06:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705935371; x=1706540171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRv4SBF4SdvyJZdy4aQdPUfxtEWcXSgRKnlpZ6CRBD8=;
 b=VCffJuHqxJmMC8VR5DqKbw9DuwX7LJ41QRywkRqf4N1fBi8RMieJH9JrBOFxEiqPQw
 zzTkD372cTW2KtRj5P1Wzp/mC4oKVuZo7nhEzDUcJzIFNiDT11qKfJKNTQVveYPqyVFh
 MkepSMKJwKzFA9jglU3Vv6vicfy+QO7IrYL8Dl7Sotw50Di5Lbc7lws+wxFIpy/x1wqi
 OMnvjRZzUmt2c8kaQa9kxwr4uQ4w8axQMjQCt2lWpkfKgsB11PTLYjYjZNq5tZEjVqps
 YTKC6CJvVkcyiXOt7VErtTaFhTpNqdFv7XWN9rLambva5OQ4Fqsx1mCskt8+xB9dSyE1
 6/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705935371; x=1706540171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IRv4SBF4SdvyJZdy4aQdPUfxtEWcXSgRKnlpZ6CRBD8=;
 b=S6HSu/D7f3lhnKKPgrNGI3DC4Mk6/VXCObunDCXRRA4g01eK/MmKn1pbxJpd+fZpyU
 IEQ9vkRmNv8DVMAWNw6Xf6nV5FkLlFriGwawU/k3WgGNkIWRHxyxT799qgKnHBrYLmIa
 7zUD1ExDlWTuzJYGyW3Jh6X9abhEoQB6s/wH0iqgnKcf3Y5m+rZeuWwFWb/xH6R0Y+JM
 HUW9qjext1rSJV83y5Q7l9InScTQ7C/ygqhs0o3kTyexSl8KD2+73/DbGppE+mtcodEy
 oBTENeCDjkCs0T9a1525CbAOG88SkFgEt7ilcJg9R0fo0s36wjlm2ZydKVvIqrddmaRw
 kH+w==
X-Gm-Message-State: AOJu0YzNRKUkN2pQhFGTFQ9/FYwp82M7kE3Iqgc63p2Cfl9BX3YWGU59
 aw5jShMMpdYq9VB2VXUNEs1AQmHtRukBZ5duNAG9+Q2fpiSpFiDRibOhusQPiv4=
X-Google-Smtp-Source: AGHT+IEI/8OQuTgWAAtHYY/RGBmmrjbYNv2PqtIPslS/7kIEuhat1NwmamoxH19fkcYhs5XBsdqGHA==
X-Received: by 2002:a7b:ce8f:0:b0:40e:4db4:9c4a with SMTP id
 q15-20020a7bce8f000000b0040e4db49c4amr2500364wmj.50.1705935371725; 
 Mon, 22 Jan 2024 06:56:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 r7-20020a05600c35c700b0040d1bd0e716sm39720140wmq.9.2024.01.22.06.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 06:56:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F37E45F8F7;
 Mon, 22 Jan 2024 14:56:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, kvm@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Laurent Vivier <laurent@vivier.eu>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, John Snow <jsnow@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 David Woodhouse <dwmw2@infradead.org>, Cleber Rosa <crosa@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Nicholas Piggin <npiggin@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Eduardo Habkost <eduardo@habkost.net>, Brian Cain <bcain@quicinc.com>,
 Paul Durrant <paul@xen.org>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 02/21] target/riscv: Remove misa_mxl validation
Date: Mon, 22 Jan 2024 14:55:51 +0000
Message-Id: <20240122145610.413836-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122145610.413836-1-alex.bennee@linaro.org>
References: <20240122145610.413836-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

It is initialized with a simple assignment and there is little room for
error. In fact, the validation is even more complex.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20240103173349.398526-24-alex.bennee@linaro.org>
Message-Id: <20231213-riscv-v7-2-a760156a337f@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/riscv/tcg/tcg-cpu.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 994ca1cdf9f..635b5fae576 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -268,7 +268,7 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
     }
 }
 
-static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
+static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
     CPUClass *cc = CPU_CLASS(mcc);
@@ -288,11 +288,6 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
     default:
         g_assert_not_reached();
     }
-
-    if (env->misa_mxl_max != env->misa_mxl) {
-        error_setg(errp, "misa_mxl_max must be equal to misa_mxl");
-        return;
-    }
 }
 
 static void riscv_cpu_validate_priv_spec(RISCVCPU *cpu, Error **errp)
@@ -932,7 +927,6 @@ static bool riscv_cpu_is_vendor(Object *cpu_obj)
 static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
-    Error *local_err = NULL;
 
     if (!riscv_cpu_tcg_compatible(cpu)) {
         g_autofree char *name = riscv_cpu_get_name(cpu);
@@ -941,14 +935,11 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
-    riscv_cpu_validate_misa_mxl(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return false;
-    }
+    riscv_cpu_validate_misa_mxl(cpu);
 
 #ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
+    Error *local_err = NULL;
 
     CPU(cs)->tcg_cflags |= CF_PCREL;
 
-- 
2.39.2


