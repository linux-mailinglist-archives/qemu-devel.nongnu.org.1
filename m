Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D60975C7E9
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 15:35:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMqHJ-00009i-Ab; Fri, 21 Jul 2023 09:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMqH0-00007w-Ez
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 09:34:22 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMqGx-0000Ef-5Z
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 09:34:20 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3a04e5baffcso1346469b6e.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 06:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689946457; x=1690551257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JALTysngirI9WWGONOD2vSVPmQgQOUhlUq5WZ5H9fSc=;
 b=AejBhJRKWlqKn8YfUaJkYPpBFa8sVUM16iYh4eXp5FEEYMuKmcA0lpUr3kCVdbdbax
 cs6006M4x6ssvgpdQW4tqmIlkiYNXfzCx+zNio/bBBBphjb4Al+o7rgoWkarYzswgyDo
 dzEQkERURqg70Ofp6s7GV/WwCuPe0SikwquXJl0skgTyjJZPUc1l0s8056AU/YekPE12
 AWoHLY1+ILhLxFBBlmwEezr/xUCPIkXEYupKQfSqQ/ZeoapGkIaqMgTh47PcKMQymx56
 9mOLi34uw14dN4q2LbRcTV8h3KPhZ/zf1BPFnAmwwa05bmQhYValJ8I2poGQeY8Klay3
 woNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689946457; x=1690551257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JALTysngirI9WWGONOD2vSVPmQgQOUhlUq5WZ5H9fSc=;
 b=Hq1j67mPIxhV/y/YPv0LR8rkG838Ef3XrhzvIAupgIzbBTiIGFHXkgBvy2B96Jf3A6
 eVHS4jPjwsjk+HfwP1lP1ODJlvt32jYW9ALa0jXOBcsU2f8D2kyb9hEx3CS9I/EaR6Jl
 jyFzoQE1jCq6Pvp+4S/KqMLJXK5DY/+6vgLlN6vzrsR3ebkxXTvUL0M9+UZliSwWEV9t
 6JWcL3f8HtrD+y3L0awo0mqtUqI7vFeRytiye3mUERk6BfefDTiCj17A/IZLzzvhdR3I
 Nf3qrMZNrwfmTI1V732tnTLiBrJV8EpUl48PqWNKNwvpun6nCnMR0yzoes9YvB37chJc
 afRQ==
X-Gm-Message-State: ABy/qLYtxp1FXXlcy4CZxauaEuUS0W7o23LwNvyB1smt6Fo9gvJJ7BhD
 CoItJBHKGoiT2vf2CSgJ2ISi5a4Gh8baQQBvWYwxQw==
X-Google-Smtp-Source: APBJJlFpRrC+OEvvM29KipvNtjmI/V5wS0D8NrAuWKmIAlZw7ToyHrB6m4opH75Jivppg9HgBMFzHw==
X-Received: by 2002:a05:6808:8d:b0:3a5:9363:ef1 with SMTP id
 s13-20020a056808008d00b003a593630ef1mr2158793oic.55.1689946457357; 
 Fri, 21 Jul 2023 06:34:17 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 bc13-20020a056808170d00b003a3ff661368sm1394714oib.54.2023.07.21.06.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jul 2023 06:34:17 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH] target/riscv/cpu.c: do not run 'host' CPU with TCG
Date: Fri, 21 Jul 2023 10:34:11 -0300
Message-ID: <20230721133411.474105-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


