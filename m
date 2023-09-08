Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDFB7981C2
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:06:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUc6-0008Th-QW; Fri, 08 Sep 2023 02:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUc3-0008TP-6h
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:05:03 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUc0-0005Bq-RJ
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:05:02 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bdc19b782aso13611965ad.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153098; x=1694757898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hidEe0WK9qfQspdXyERizbv/cOtqOtrvyLGVTGCseA=;
 b=fj+4PRe0FU3iPcgsCfEtjudlUPvk+gWUgVr9Qz6rIaH9zEWM9NUKrEjg0wZGYoqLYD
 gsrA+NEtt55FN3Ov/xV2bTO1y7FxYb2BZlm5r8KsDczSggOkv/6RzBAIP4OiJGGGu/LH
 3srHh1S1My5ZYude/sEh0cdME7fpbtZU3+S7B8NLYyWHDBZ/OUkyhyZ/Joaso4ixizxi
 +D7VJDRNigPEC4KzTL78nRH+AEBToa8NWrfwkLX+azSofWoD2f+N8BhiUxPoEqPxq6W/
 md+7Ox8SLcVJb691C/of5QRGtI7QjQFXfzPAn5yIghSuiHxt+nslleWld0/EixzBAG7r
 Ba7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153098; x=1694757898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hidEe0WK9qfQspdXyERizbv/cOtqOtrvyLGVTGCseA=;
 b=ZISVXjvVZCWc2D0bF4AxDb/7IYhRROGfzTKXr+NEU9H0ConqVDESfhSbrmoFVwajzP
 PwwH85vNfRLvXozdNmNeHkS8ZJnklbIM/Q+qnz84P/BvAKp9hxTp6ujE6M1Zm28xRld0
 YwcKkBVmd/FCEHlbp6f7XuYlqAWL49+yoyMz7pOkPxWTDOGQZjGQfAzvrA1geMocgmCz
 LZqh1yti5nANivYfMJ3RNnJXab86fyI7VHu7F3qUyHdetu9nBZBUjHs9wy0yJFzIFx3X
 89KGGdsYhII7sfSq+zogQgeWV5bg4hIZIfPtQz5x9L6CH44OlDAdpd/hh+nB146F2bS4
 dtGA==
X-Gm-Message-State: AOJu0YzXVVT0z39zjtJdEwvyX6I1gAp1X3MexgBHw6x8pp/0Q5LSZl5h
 r4ruysNvjFVecm9viFZqqUlIOxaGCDQaxb59
X-Google-Smtp-Source: AGHT+IHwGvUfBUdMRFfhdkEpK8o54jeDQaliV7/D4GV5bzoNhnW6PrRbsi1Jhhl9CJ1i0Vbxt9tKDg==
X-Received: by 2002:a17:903:1cf:b0:1b9:e8a5:3699 with SMTP id
 e15-20020a17090301cf00b001b9e8a53699mr1744875plh.21.1694153098545; 
 Thu, 07 Sep 2023 23:04:58 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:04:57 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/65] target/riscv/cpu.c: do not run 'host' CPU with TCG
Date: Fri,  8 Sep 2023 16:03:27 +1000
Message-ID: <20230908060431.1903919-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The 'host' CPU is available in a CONFIG_KVM build and it's currently
available for all accels, but is a KVM only CPU. This means that in a
RISC-V KVM capable host we can do things like this:

$ ./build/qemu-system-riscv64 -M virt,accel=tcg -cpu host --nographic
qemu-system-riscv64: H extension requires priv spec 1.12.0

This CPU does not have a priv spec because we don't filter its extensions
via priv spec. We shouldn't be reaching riscv_cpu_realize_tcg() at all
with the 'host' CPU.

We don't have a way to filter the 'host' CPU out of the available CPU
options (-cpu help) if the build includes both KVM and TCG. What we can
do is to error out during riscv_cpu_realize_tcg() if the user chooses
the 'host' CPU with accel=tcg:

$ ./build/qemu-system-riscv64 -M virt,accel=tcg -cpu host --nographic
qemu-system-riscv64: 'host' CPU is not compatible with TCG acceleration

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230721133411.474105-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6b93b04453..08db3d613f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1395,6 +1395,11 @@ static void riscv_cpu_realize_tcg(DeviceState *dev, Error **errp)
     CPURISCVState *env = &cpu->env;
     Error *local_err = NULL;
 
+    if (object_dynamic_cast(OBJECT(dev), TYPE_RISCV_CPU_HOST)) {
+        error_setg(errp, "'host' CPU is not compatible with TCG acceleration");
+        return;
+    }
+
     riscv_cpu_validate_misa_mxl(cpu, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
-- 
2.41.0


