Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CABE573CC33
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 19:43:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD7HR-0007NL-PY; Sat, 24 Jun 2023 13:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD7HP-0007LW-4S
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 13:42:35 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD7HN-00070x-I0
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 13:42:34 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51bee0c0acbso1695268a12.1
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687628551; x=1690220551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wDJq03Cy4udm0BY/tdQJBSn7cYSDg3Mije1czkKCJYY=;
 b=RO2avB+FoBAH/Di/V4kIhFyDQH7uIlgC0gwfCgQrD89bwE83AmBBFg0CcRlHBZjeo8
 xf712Qc9aR38nPiF+uDaf5yc8gD19WEsCR2svxAprxd1bFxGUA2r4lMmJIlwctgs7QkB
 EUtMNoLLcY3J6LBbohSpdImmOm/n5GLZ+fA8stYV9O4SnDoSh8DTgNabJ/O9qfxzX4AN
 5t1XZJvA/e/bJFTTAZaWg85tev9gNfCnctzxCTxdaNAK3TWI6g6FLKy1iSyDWwm7ICVw
 UkmuMgdFFe7lQAMN+uYaq3GLpkAMayp43PGSU3d6bHrT+2SGnuNJPvNFppg8VTyk9Otn
 2Akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687628551; x=1690220551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDJq03Cy4udm0BY/tdQJBSn7cYSDg3Mije1czkKCJYY=;
 b=V3rLE8K1sG81Uofrb9F54dHpbjLugaLQQ754YTVJ81epiaaXzhJAmE5hDQ7AdEDasv
 m1nXRfuvv0LaP3lDjRIFGW2wq4JvI6mBKbggnRnaXDso69Tw0INT+1khko/cDeoFAyhv
 uSk3GanpSjnqb9EUUDf10TrNwobU41uFOR0zermH/WRTMOp6X5c1a1pBtTBdFc3f6ssZ
 CQ89wxG1clUNoPExdjZ/UiPtZse/5Oa/NzTI/2/nhhPLv7Fyd6yEQ+73QFSKgTO4DA0P
 LJ9yhzR8XxK3YubYtpG6Kp8DBeTKIbCD5ryfkPX3egl9PQrZ5ikx7Xp5RRvUTFs3+gyC
 2UXQ==
X-Gm-Message-State: AC+VfDwPtxwW+XLXKFFj294uvexyXaYpKzak5Z6MsTaHyugtYoKKhpeV
 HdQopE2J3g1EWCel//WZJZVqqqE2dH0FUjRvwRE=
X-Google-Smtp-Source: ACHHUZ4FYM2a+yRGrt0ZR/p6B5z15VUL79T2BhspQcZnT7ZhY2JGOdCOYx1WSa4ydzRjjHwIT6bFeg==
X-Received: by 2002:aa7:cb47:0:b0:51d:9130:3c54 with SMTP id
 w7-20020aa7cb47000000b0051d91303c54mr196875edt.26.1687628551740; 
 Sat, 24 Jun 2023 10:42:31 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.150])
 by smtp.gmail.com with ESMTPSA id
 d15-20020a05640208cf00b0051a3e7d7996sm872902edz.83.2023.06.24.10.42.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 24 Jun 2023 10:42:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, xen-devel@lists.xenproject.org,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Reinoud Zandijk <reinoud@netbsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 09/16] accel: Remove NVMM unreachable error path
Date: Sat, 24 Jun 2023 19:41:14 +0200
Message-Id: <20230624174121.11508-10-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230624174121.11508-1-philmd@linaro.org>
References: <20230624174121.11508-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

g_malloc0() can not fail. Remove the unreachable error path.

https://developer-old.gnome.org/glib/stable/glib-Memory-Allocation.html#glib-Memory-Allocation.description

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/nvmm/nvmm-all.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index b3c3adc59a..90e9e0a5b2 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -943,10 +943,6 @@ nvmm_init_vcpu(CPUState *cpu)
     }
 
     qcpu = g_malloc0(sizeof(*qcpu));
-    if (qcpu == NULL) {
-        error_report("NVMM: Failed to allocate VCPU context.");
-        return -ENOMEM;
-    }
 
     ret = nvmm_vcpu_create(mach, cpu->cpu_index, &qcpu->vcpu);
     if (ret == -1) {
-- 
2.38.1


