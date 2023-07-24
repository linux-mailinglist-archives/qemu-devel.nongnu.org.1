Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFE575FCB0
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 18:55:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNypG-0001O6-N4; Mon, 24 Jul 2023 12:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNypE-0001Nl-QJ
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNypD-0006yS-AJ
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690217662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YiWtFAUzA2SuCKiDe2sa0GXcXSqiDxu6vVONDFunCJE=;
 b=FWluOWDvyGinbwvOCm3oncXXASh6/Kgq82uwuzLRE4TVj0IRGU7NcHxfHeMzb7aqmVxu1c
 U97IYSvAoP0Y/WzzPa7fkpFMSJh610kHesfAjsMsVo8Kvz4mEIn34P34pou3VJWio0jU90
 xkfNRyt2OQ5KMoAscyT2/dWnByMSd4I=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-d9K8TNP_OomqOCqcVZWbcg-1; Mon, 24 Jul 2023 12:54:15 -0400
X-MC-Unique: d9K8TNP_OomqOCqcVZWbcg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 305B3280BC54;
 Mon, 24 Jul 2023 16:54:12 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C7EA492CAC;
 Mon, 24 Jul 2023 16:54:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Song Gao <gaosong@loongson.cn>
Subject: [PULL 15/16] target/loongarch: Fix the CSRRD CPUID instruction on big
 endian hosts
Date: Mon, 24 Jul 2023 18:53:48 +0200
Message-Id: <20230724165349.55714-16-thuth@redhat.com>
In-Reply-To: <20230724165349.55714-1-thuth@redhat.com>
References: <20230724165349.55714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The test in tests/avocado/machine_loongarch.py is currently failing
on big endian hosts like s390x. By comparing the traces between running
the QEMU_EFI.fd bios on a s390x and on a x86 host, it's quickly obvious
that the CSRRD instruction for the CPUID is behaving differently. And
indeed: The code currently does a long read (i.e. 64 bit) from the
address that points to the CPUState->cpu_index field (with tcg_gen_ld_tl()
in the trans_csrrd() function). But this cpu_index field is only an "int"
(i.e. 32 bit). While this dirty pointer magic works on little endian hosts,
it of course fails on big endian hosts. Fix it by using a proper helper
function instead.

Cc: qemu-stable@nongnu.org
Message-Id: <20230720175307.854460-1-thuth@redhat.com>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/loongarch/cpu.h                             | 1 +
 target/loongarch/helper.h                          | 1 +
 target/loongarch/csr_helper.c                      | 9 +++++++++
 target/loongarch/insn_trans/trans_privileged.c.inc | 8 +-------
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ed04027af1..fa371ca8ba 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -342,6 +342,7 @@ typedef struct CPUArchState {
     uint64_t CSR_DBG;
     uint64_t CSR_DERA;
     uint64_t CSR_DSAVE;
+    uint64_t CSR_CPUID;
 
 #ifndef CONFIG_USER_ONLY
     LoongArchTLB  tlb[LOONGARCH_TLB_MAX];
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index b9de77d926..ffb1e0b0bf 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -98,6 +98,7 @@ DEF_HELPER_1(rdtime_d, i64, env)
 #ifndef CONFIG_USER_ONLY
 /* CSRs helper */
 DEF_HELPER_1(csrrd_pgd, i64, env)
+DEF_HELPER_1(csrrd_cpuid, i64, env)
 DEF_HELPER_1(csrrd_tval, i64, env)
 DEF_HELPER_2(csrwr_estat, i64, env, tl)
 DEF_HELPER_2(csrwr_asid, i64, env, tl)
diff --git a/target/loongarch/csr_helper.c b/target/loongarch/csr_helper.c
index 6526367946..55341551a5 100644
--- a/target/loongarch/csr_helper.c
+++ b/target/loongarch/csr_helper.c
@@ -35,6 +35,15 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *env)
     return v;
 }
 
+target_ulong helper_csrrd_cpuid(CPULoongArchState *env)
+{
+    LoongArchCPU *lac = env_archcpu(env);
+
+    env->CSR_CPUID = CPU(lac)->cpu_index;
+
+    return env->CSR_CPUID;
+}
+
 target_ulong helper_csrrd_tval(CPULoongArchState *env)
 {
     LoongArchCPU *cpu = env_archcpu(env);
diff --git a/target/loongarch/insn_trans/trans_privileged.c.inc b/target/loongarch/insn_trans/trans_privileged.c.inc
index 02bca7ca23..9c9de090f0 100644
--- a/target/loongarch/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/insn_trans/trans_privileged.c.inc
@@ -99,13 +99,7 @@ static const CSRInfo csr_info[] = {
     CSR_OFF(PWCH),
     CSR_OFF(STLBPS),
     CSR_OFF(RVACFG),
-    [LOONGARCH_CSR_CPUID] = {
-        .offset = (int)offsetof(CPUState, cpu_index)
-                  - (int)offsetof(LoongArchCPU, env),
-        .flags = CSRFL_READONLY,
-        .readfn = NULL,
-        .writefn = NULL
-    },
+    CSR_OFF_FUNCS(CPUID, CSRFL_READONLY, gen_helper_csrrd_cpuid, NULL),
     CSR_OFF_FLAGS(PRCFG1, CSRFL_READONLY),
     CSR_OFF_FLAGS(PRCFG2, CSRFL_READONLY),
     CSR_OFF_FLAGS(PRCFG3, CSRFL_READONLY),
-- 
2.39.3


