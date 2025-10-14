Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A48ECBDB492
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Oct 2025 22:39:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lie-0001Fi-Ef; Tue, 14 Oct 2025 16:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v8lic-0001Bf-BZ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:34:02 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v8liV-0000WA-AN
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=xlEDeraxq7wKf2ytDVKCxEkjtIApg/D923gIB3pDVHw=; b=nobNvilnnKEaSoA
 HEKjMRczLg0I+oyUt/OF6+wi5FIPKJT7b5pirsFG77VxRhzsjTFNgfAbaAAuBI+S8Ff9RjhdXs0dY
 e/TKlpwVbkSIK+6cBjDlUH93SNeOUTOa+F7KYrVrL5cVuwE4YeZ0OEMQJNg0IemyPUgG7dOf0GDDW
 SQ=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com
Subject: [PATCH v3 27/34] target/riscv: Replace target_ulong in
 riscv_cpu_get_trap_name()
Date: Tue, 14 Oct 2025 22:35:04 +0200
Message-ID: <20251014203512.26282-28-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-1-anjo@rev.ng>
References: <20251014203512.26282-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fix cause argument to 64 bit to match env->mcause.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.h | 2 +-
 target/riscv/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3072ee0005..09123f4373 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -600,7 +600,7 @@ extern const char * const riscv_int_regnamesh[];
 extern const char * const riscv_fpr_regnames[];
 extern const char * const riscv_rvv_regnames[];
 
-const char *riscv_cpu_get_trap_name(target_ulong cause, bool async);
+const char *riscv_cpu_get_trap_name(uint64_t cause, bool async);
 int riscv_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, DumpState *s);
 int riscv_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c86a64b727..f169eb4bba 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -348,7 +348,7 @@ static const char * const riscv_intr_names[] = {
     "reserved"
 };
 
-const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
+const char *riscv_cpu_get_trap_name(uint64_t cause, bool async)
 {
     if (async) {
         return (cause < ARRAY_SIZE(riscv_intr_names)) ?
-- 
2.51.0


