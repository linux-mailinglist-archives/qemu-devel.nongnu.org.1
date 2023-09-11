Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D59279A3D4
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:48:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfaeE-0000An-7O; Mon, 11 Sep 2023 02:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfaeC-0000AY-4A
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:43:48 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfae9-0004Qs-Hn
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:43:47 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3a76d882080so3181681b6e.2
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414621; x=1695019421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hidEe0WK9qfQspdXyERizbv/cOtqOtrvyLGVTGCseA=;
 b=sY7tD6veAv+U4XCKMIoc1O9ZHWNkm0yScI1mAGlGuOS8O3jI+qH+sZlfNtzQ+Nysaz
 NfHBOy7YSnsuC1vwDjAvl1FfDs2RQcuOXP80R96N7mYl8Sp1mIHNUBTo9RWSQPXbrEHe
 ESYsWt6MtAQ4YGc+NuW2595X48PLxYZDui2ewXBw6cceKfTCYEjbqUBFmrx9hvQIPyTq
 kNuK3INhEcb3l5i43hdyDza00VYTD2tskdDpiZhmlw15pCfEiYSEKIIlxqxu9Wpn2Cy4
 dee27EQmKPRanEHMMW3fQnaV1Jg1p1dEevKWV+ykk5PkZ0kCqWPD1R/I62J28Fl0ElKb
 Xjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414621; x=1695019421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hidEe0WK9qfQspdXyERizbv/cOtqOtrvyLGVTGCseA=;
 b=rk5fNS3zGfh5/2GhnmamVg1/F390ExT+FhcX7RVqIJ7XYgOnAlgZfq3ucQif6o0s26
 yuJw9HoIO4yUG5WmdpyYnuTfEj45+TQv8GbZtBvRzTbR6kEyfimfh/pdlmCZVoc8BAz7
 81tzjiSz7RfqGzIzkBKgFM+njZzVJwaAksq6pm1P8/6j/XwlUhnNRORuQVqKd0An7EoU
 ACY9ooXsKhRuRyDzWysDg+/UblX/PVmCn5Cf5kVSEQLH18rz9j3HC5XEoL6Fdi2JOSuZ
 snTApFNEDsQ4fUF8UvUowacawNNBLLtLDwkit2+O7736MlQY/ldJItFG/ott34KlLcLi
 AULg==
X-Gm-Message-State: AOJu0YzSmZjm6+mSE2AzN8WMIzkNOwUYCpi8AnATWRO/mERQzMbeeO/t
 759lWXElNRmfWuqxaT7yw7ECUQDw3qXNnw==
X-Google-Smtp-Source: AGHT+IEqXBODj7T2Ze0wKrDTKCVIaT0E1RvEYMvQcwTHdGz1CyhAmd3AZHQOUjG3v6TAHFvUvubWnA==
X-Received: by 2002:a05:6870:818f:b0:1b0:db2:189e with SMTP id
 k15-20020a056870818f00b001b00db2189emr11051662oae.17.1694414621508; 
 Sun, 10 Sep 2023 23:43:41 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:43:40 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 01/45] target/riscv/cpu.c: do not run 'host' CPU with TCG
Date: Mon, 11 Sep 2023 16:42:36 +1000
Message-ID: <20230911064320.939791-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22e.google.com
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


