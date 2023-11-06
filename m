Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EEC7E1F95
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:09:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxR8-0001S0-9U; Mon, 06 Nov 2023 06:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxQa-0001Br-6V
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:05:57 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxQX-0004Lq-Gj
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:05:55 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40907b82ab9so31032475e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268752; x=1699873552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZ4xqFJalLvpzsW1bcHeUL/13mhLi/mzZSAy+mux2v0=;
 b=QrGpKoJ+ZHnculWUTSEqv2x+dQvx34HmqcAoNg3rnaUvJfSUNSKNMsl2+ESXeRFx4N
 ZyiaT54qEsy0P3/cvO+2GAIE0v9/gQLuEqjFaVbqo/0rqHy/WEmZuWg+/Gc6tXjOs/3f
 0FyOsiOEqK4NFBIia5GdVxUxu9c9doDre+aVRops+lgQEEDo4XnQ5/fCCvJ4Exjn5PdW
 uZFol2pzW1HKx0aE2QVsPJLl8EDNmBCkPlwua47ANoRR8zfXOunTAtaOd8Cbi1o4hm9o
 92dp88kXn7FCcaTwpu+LasrqUtqTq+yOAjZW9opJeh+Mynv9Wa1Si3quKUV+gK0COdr5
 YLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268752; x=1699873552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZ4xqFJalLvpzsW1bcHeUL/13mhLi/mzZSAy+mux2v0=;
 b=ETFKS/GtUaXXkodbZNXqdKu35E4hyaNhg8wyAUjI0wE1Plgzaw96hbFHB9aenmvxlL
 PKYOYQhDngb7HiH3dH3TZG9iB+yMMm33JX/5P23tojwf3TgFk/fu1xEZEE4gP6Is3Mrb
 vXbKvoEuKYR7SBfN7ECWmKTgZve9EEMeTanAKsrshDZWS6wxtcEuEJgzm8PDKd061XEr
 qJ6k5DbdzLGc4ke7UOJSTTKkx9STvpxkx5aOiIgEweT6rxZqFl5h1Q9/0hKH6zUT+emn
 k3IBlB/Oe8wZVyH8aQT9v6tXj4UCgh6fkJ8FIwcskGJ705N9JHdYc6btCyiO+yS5IbRq
 Oohg==
X-Gm-Message-State: AOJu0YyPATaox5GI7IAkAEB80c+W1gngzHM70RO+Y+OVSmfhnLU22vxe
 KPs7QYEUcUiggCH3otfIetsJiPZpHkj4o/sN2Ng=
X-Google-Smtp-Source: AGHT+IG9mJw0F90hy4Uu6xuSpQrJC5TM2lMXtp6Q5jTJMspVFVuvMPHpaiGipu7vhxIPNtgi1AXh6Q==
X-Received: by 2002:a7b:c7c9:0:b0:406:45c1:4dd with SMTP id
 z9-20020a7bc7c9000000b0040645c104ddmr10153754wmk.14.1699268751703; 
 Mon, 06 Nov 2023 03:05:51 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 bh5-20020a05600c3d0500b004094e565e71sm12164949wmb.23.2023.11.06.03.05.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:05:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 19/60] target/ppc: Use env_archcpu() in helper_book3s_msgsndp()
Date: Mon,  6 Nov 2023 12:02:51 +0100
Message-ID: <20231106110336.358-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

When CPUArchState* is available (here CPUPPCState*), we
can use the fast env_archcpu() macro to get ArchCPU* (here
PowerPCCPU*). The QOM cast POWERPC_CPU() macro will be
slower when building with --enable-qom-cast-debug.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20231009110239.66778-2-philmd@linaro.org>
---
 target/ppc/excp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 7926114d5c..a42743a3e0 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3136,7 +3136,7 @@ void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
 void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
 {
     CPUState *cs = env_cpu(env);
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    PowerPCCPU *cpu = env_archcpu(env);
     CPUState *ccs;
     uint32_t nr_threads = cs->nr_threads;
     int ttir = rb & PPC_BITMASK(57, 63);
-- 
2.41.0


