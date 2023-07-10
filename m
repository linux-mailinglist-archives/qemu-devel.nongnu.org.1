Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AED74D5CB
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:38:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq5x-0004EW-5S; Mon, 10 Jul 2023 08:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5k-0003v3-Ni
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:13 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5h-0004oZ-Bz
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:11 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-666eec46206so3837039b3a.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992444; x=1691584444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrfkBDzcMUty/KLuCtR0skxsGx6BQyMYwwWgOWI1zSw=;
 b=f6z90RTXUVAe+61G6AB6V1qSvJwlPuPpM/gGdNMTZGZ+dPNMFq4fStu1Q/VsFPQ01z
 Z3PqtlR/zqYUScEABC8ZLmreWwvcY16cO6WkkD1AD9lu/GySVA36hCSGPHlZyPwXU1di
 GmRzuniv1qL1R2x6/4mwWdG8wmVVuSdTiOtaylxm7XmU47kT0h4Qw65Gc2FFs4iriNRM
 hkfgZkSGzDtuqVPU/SWpMO3vgq1B+UeyVHT424r0+JVwxlv2OPEuIsTmVFqsObOnvEA+
 YTLP7KSaVHTC5Tuftf0x1ZjJr3+Jb709I08UYaExdVtmQe6peZp75NfA7zYHjan1a9eg
 MJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992444; x=1691584444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jrfkBDzcMUty/KLuCtR0skxsGx6BQyMYwwWgOWI1zSw=;
 b=PniOWKyEnpzIQg5wRaFI7vHrs0OOlIusWYkPqLVeQcREGpwh6eWo9gZ48R0ZWA/0ic
 SucL5gHXK4b8WNXTLHcBcLA5v+GaqJhxvpTE5bDVnNtoeOjZzPyhU+GX43tK0avJtwmg
 p4cr34pftAlQ/9zlUya9M7v5m8DPb2tpDoilwG/ljCN8miN10jMSCckqctRZ0Sv4txwq
 UKAJA4C6k9dzsTJfbwqKboLmOcxFlJyWWnjYuVBBmE02sx2VH975nxdQSiZJQJYp+v+K
 xlCbj04vLogKtInuPEwqldgv85dvuLM7BnzLDSbn8OzDi2kYmEIeQOQ0KNq3sFQsykyD
 JWGA==
X-Gm-Message-State: ABy/qLa8FqicpMqJsh/GgBWs95V05pmgXqb6AlDVK0FkRG+ltJXEQ1RR
 Xyw5W5QoxmaDN0reqnMGIiYmvz6KiCk1WQ==
X-Google-Smtp-Source: APBJJlFDwfAo5LhZdLf2b87sBUwrE2KFiiV2JPgNxpYclfmpGjwo7100ypWZk/y02NadS2yUB/I6FA==
X-Received: by 2002:a05:6a20:9719:b0:129:f3e5:98a4 with SMTP id
 hr25-20020a056a20971900b00129f3e598a4mr11667331pzc.17.1688992444259; 
 Mon, 10 Jul 2023 05:34:04 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:34:03 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 30/54] target/riscv: Set the correct exception for implict
 G-stage translation fail
Date: Mon, 10 Jul 2023 22:31:41 +1000
Message-Id: <20230710123205.2441106-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
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

From: Jason Chien <jason.chien@sifive.com>

The privileged spec states:
For a memory access made to support VS-stage address translation (such as
to read/write a VS-level page table), permissions are checked as though
for a load or store, not for the original access type. However, any
exception is always reported for the original access type (instruction,
load, or store/AMO).

The current implementation converts the access type to LOAD if implicit
G-stage translation fails which results in only reporting "Load guest-page
fault". This commit removes the convertion of access type, so the reported
exception conforms to the spec.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230627074915.7686-1-jason.chien@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index bb9d923818..9f611d89bb 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1282,7 +1282,6 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         if (ret == TRANSLATE_G_STAGE_FAIL) {
             first_stage_error = false;
             two_stage_indirect_error = true;
-            access_type = MMU_DATA_LOAD;
         }
 
         qemu_log_mask(CPU_LOG_MMU,
-- 
2.40.1


