Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4862D8295AF
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:05:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUUH-0004yv-LB; Wed, 10 Jan 2024 04:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUT1-0003Tc-Q7
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:46 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSy-0005fk-S1
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:42 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6d9b5c4f332so2084043b3a.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877299; x=1705482099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3DZmZome8pfz6x3O6MtIJon1jDru9oEpFPjmaR3Dens=;
 b=UC1XQj93Sid3HSW3gor7X8Ee7H0Um0rHbmfgEWawovVmnULUDSMiz92fokZ/ssxHga
 4Ht4xFJg0rcCZy22JdVL2InNCr8Z6piZ6anas1UnuEGxAgKc/3yRk/nATvO6wckLI+ut
 O/O92sZ0L3AfUCgqad+H7XmunVrJqwZjJ4aVVWsmsrGrDqGsFxTKUsTRQXWZ66+aJ5z5
 Ghah2eeujgoBL1uQb8sLLCQDlclvko+s/wZr2P/cxzMgnqx16mzVbqQLV2dV9EfmQQww
 ayILTay2iQOBCZyngyikIFLBwuegns2ICx8+VjJVMm7LjpvxXfx6iiS9cNqpKRrPvH8G
 2Kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877299; x=1705482099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3DZmZome8pfz6x3O6MtIJon1jDru9oEpFPjmaR3Dens=;
 b=YSqj9Ht+wRVospcDSyvoz5UWoVIGyzg97nWbvGXJYI80UbO1qDul5DhA8PIJcFWl4K
 uW1JyYpyEu2jZgdX9y57vs9gDoAGf4W4xHxCq6mBMyFzzewvnKmA5LxmSv3MmS9E+0at
 yk39oUVGdg7RzLO0jAB60y3FaT3T2GLyvRXGRP7rEvkkvG95sYN9DdaFIRO5zN3JtX+6
 m8Hk1FbuJjH5hWSV4ZtR4MSE1fNAWKBEazKFW42KIi1CY8vJ2EdDlo6CNY5h02xzekge
 lqkUk9UfNr3LX9crzN93s3gZ7EHQy3MJc9YdeXQcWe4bBhTA5GQbf/fM1KWF0TqgYCVA
 385A==
X-Gm-Message-State: AOJu0YxhCgq6S3w/ySmlM2Z9S1oD9nsCdQl18S6SLaXxcfhZlLzh1lid
 Y+VNtOxCXS9IH9kYZrM7ZvGwk2ixqXxjUjLC
X-Google-Smtp-Source: AGHT+IEzC1kgCeYF96BlVUQUkvzbJGCuM8aPHqUX4HGFeNLOIkJwTXZ+PmJHZv0NCnNQT7fyNBThGw==
X-Received: by 2002:a05:6a00:23d4:b0:6d9:acc8:a326 with SMTP id
 g20-20020a056a0023d400b006d9acc8a326mr619891pfc.8.1704877298353; 
 Wed, 10 Jan 2024 01:01:38 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:01:37 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Ivan Klokov <ivan.klokov@syntacore.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 62/65] target/riscv: pmp: Ignore writes when RW=01 and MML=0
Date: Wed, 10 Jan 2024 18:57:30 +1000
Message-ID: <20240110085733.1607526-63-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Ivan Klokov <ivan.klokov@syntacore.com>

This patch changes behavior on writing RW=01 to pmpcfg with MML=0.
RWX filed is form of collective WARL with the combination of
pmpcfg.RW=01 remains reserved for future standard use.

According to definition of WARL writing the CSR has no other side
effect. But current implementation change architectural state and
change system behavior. After writing we will get unreadable-unwriteble
region regardless on the previous state.

On the other side WARL said that we should read legal value and nothing
says about what we should write. Current behavior change system state
regardless of whether we read this register or not.

Fixes: ac66f2f0 ("target/riscv: pmp: Ignore writes when RW=01")

Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231220153205.11072-1-ivan.klokov@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index dff9512c3f..2a76b611a0 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -126,7 +126,7 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
             /* If !mseccfg.MML then ignore writes with encoding RW=01 */
             if ((val & PMP_WRITE) && !(val & PMP_READ) &&
                 !MSECCFG_MML_ISSET(env)) {
-                val &= ~(PMP_WRITE | PMP_READ);
+                return false;
             }
             env->pmp_state.pmp[pmp_index].cfg_reg = val;
             pmp_update_rule_addr(env, pmp_index);
-- 
2.43.0


