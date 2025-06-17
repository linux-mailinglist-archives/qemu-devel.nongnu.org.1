Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 080F0ADD380
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Jun 2025 17:59:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYeQ-0000ir-6K; Tue, 17 Jun 2025 11:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uRYQZ-0005KV-0Z
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uRYQO-0005Yi-1H
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750174823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZMNbAfMQjfPANHhO+btiyS6Mi7Z2tfSqrkWrXhYg8o=;
 b=fKERH4D8C1dFJ/84Prx/g7fgVMr48zVu8t140+CIilURWVJQSD4vpfx7qchsQBZKLNEiXA
 LKNS9m0tNSTz2j7XSYpwEEaZvHL+sWufsZe9jlPBkzoh7Q3VQpoDbIAKZzTrB+Nia+esCb
 8NDJFK8Yaqn7DAxiU9qAq0gRIs6qX+0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-hPOKNHmKOwmTUySeSkdFcg-1; Tue,
 17 Jun 2025 11:40:20 -0400
X-MC-Unique: hPOKNHmKOwmTUySeSkdFcg-1
X-Mimecast-MFC-AGG-ID: hPOKNHmKOwmTUySeSkdFcg_1750174816
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D6141800295; Tue, 17 Jun 2025 15:40:16 +0000 (UTC)
Received: from gondolin.str.redhat.com (pixel-6a.str.redhat.com
 [10.33.192.205])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCD2B180035C; Tue, 17 Jun 2025 15:40:10 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v8 05/14] arm/cpu: Store aa64mmfr0-3 into the idregs array
Date: Tue, 17 Jun 2025 17:39:22 +0200
Message-ID: <20250617153931.1330449-6-cohuck@redhat.com>
In-Reply-To: <20250617153931.1330449-1-cohuck@redhat.com>
References: <20250617153931.1330449-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/arm/cpu-features.h | 74 +++++++++++++++++++--------------------
 target/arm/cpu.h          |  4 ---
 target/arm/cpu64.c        |  8 ++---
 target/arm/helper.c       |  8 ++---
 target/arm/hvf/hvf.c      | 21 ++++++-----
 target/arm/kvm.c          | 12 +++----
 target/arm/ptw.c          |  6 ++--
 target/arm/tcg/cpu64.c    | 64 ++++++++++++++++-----------------
 8 files changed, 95 insertions(+), 102 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 3adea85b79b7..89c9278639bf 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -711,192 +711,192 @@ static inline bool isar_feature_aa64_nmi(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa64_tgran4_lpa2(const ARMISARegisters *id)
 {
-    return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4) >= 1;
+    return FIELD_SEX64_IDREG(id, ID_AA64MMFR0, TGRAN4) >= 1;
 }
 
 static inline bool isar_feature_aa64_tgran4_2_lpa2(const ARMISARegisters *id)
 {
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4_2);
+    unsigned t = FIELD_EX64_IDREG(id, ID_AA64MMFR0, TGRAN4_2);
     return t >= 3 || (t == 0 && isar_feature_aa64_tgran4_lpa2(id));
 }
 
 static inline bool isar_feature_aa64_tgran16_lpa2(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16) >= 2;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR0, TGRAN16) >= 2;
 }
 
 static inline bool isar_feature_aa64_tgran16_2_lpa2(const ARMISARegisters *id)
 {
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16_2);
+    unsigned t = FIELD_EX64_IDREG(id, ID_AA64MMFR0, TGRAN16_2);
     return t >= 3 || (t == 0 && isar_feature_aa64_tgran16_lpa2(id));
 }
 
 static inline bool isar_feature_aa64_tgran4(const ARMISARegisters *id)
 {
-    return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4) >= 0;
+    return FIELD_SEX64_IDREG(id, ID_AA64MMFR0, TGRAN4) >= 0;
 }
 
 static inline bool isar_feature_aa64_tgran16(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16) >= 1;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR0, TGRAN16) >= 1;
 }
 
 static inline bool isar_feature_aa64_tgran64(const ARMISARegisters *id)
 {
-    return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN64) >= 0;
+    return FIELD_SEX64_IDREG(id, ID_AA64MMFR0, TGRAN64) >= 0;
 }
 
 static inline bool isar_feature_aa64_tgran4_2(const ARMISARegisters *id)
 {
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4_2);
+    unsigned t = FIELD_EX64_IDREG(id, ID_AA64MMFR0, TGRAN4_2);
     return t >= 2 || (t == 0 && isar_feature_aa64_tgran4(id));
 }
 
 static inline bool isar_feature_aa64_tgran16_2(const ARMISARegisters *id)
 {
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16_2);
+    unsigned t = FIELD_EX64_IDREG(id, ID_AA64MMFR0, TGRAN16_2);
     return t >= 2 || (t == 0 && isar_feature_aa64_tgran16(id));
 }
 
 static inline bool isar_feature_aa64_tgran64_2(const ARMISARegisters *id)
 {
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN64_2);
+    unsigned t = FIELD_EX64_IDREG(id, ID_AA64MMFR0, TGRAN64_2);
     return t >= 2 || (t == 0 && isar_feature_aa64_tgran64(id));
 }
 
 static inline bool isar_feature_aa64_fgt(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, FGT) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR0, FGT) != 0;
 }
 
 static inline bool isar_feature_aa64_ecv_traps(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, ECV) > 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR0, ECV) > 0;
 }
 
 static inline bool isar_feature_aa64_ecv(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, ECV) > 1;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR0, ECV) > 1;
 }
 
 static inline bool isar_feature_aa64_vh(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, VH) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR1, VH) != 0;
 }
 
 static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, LO) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR1, LO) != 0;
 }
 
 static inline bool isar_feature_aa64_pan(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR1, PAN) != 0;
 }
 
 static inline bool isar_feature_aa64_ats1e1(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) >= 2;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR1, PAN) >= 2;
 }
 
 static inline bool isar_feature_aa64_pan3(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) >= 3;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR1, PAN) >= 3;
 }
 
 static inline bool isar_feature_aa64_hcx(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HCX) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR1, HCX) != 0;
 }
 
 static inline bool isar_feature_aa64_afp(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, AFP) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR1, AFP) != 0;
 }
 
 static inline bool isar_feature_aa64_tidcp1(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, TIDCP1) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR1, TIDCP1) != 0;
 }
 
 static inline bool isar_feature_aa64_cmow(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, CMOW) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR1, CMOW) != 0;
 }
 
 static inline bool isar_feature_aa64_hafs(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR1, HAFDBS) != 0;
 }
 
 static inline bool isar_feature_aa64_hdbs(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) >= 2;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR1, HAFDBS) >= 2;
 }
 
 static inline bool isar_feature_aa64_tts2uxn(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, XNX) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR1, XNX) != 0;
 }
 
 static inline bool isar_feature_aa64_uao(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, UAO) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR2, UAO) != 0;
 }
 
 static inline bool isar_feature_aa64_st(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, ST) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR2, ST) != 0;
 }
 
 static inline bool isar_feature_aa64_lse2(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, AT) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR2, AT) != 0;
 }
 
 static inline bool isar_feature_aa64_fwb(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, FWB) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR2, FWB) != 0;
 }
 
 static inline bool isar_feature_aa64_ids(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, IDS) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR2, IDS) != 0;
 }
 
 static inline bool isar_feature_aa64_half_evt(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, EVT) >= 1;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR2, EVT) >= 1;
 }
 
 static inline bool isar_feature_aa64_evt(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, EVT) >= 2;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR2, EVT) >= 2;
 }
 
 static inline bool isar_feature_aa64_ccidx(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, CCIDX) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR2, CCIDX) != 0;
 }
 
 static inline bool isar_feature_aa64_lva(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, VARANGE) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR2, VARANGE) != 0;
 }
 
 static inline bool isar_feature_aa64_e0pd(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, E0PD) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR2, E0PD) != 0;
 }
 
 static inline bool isar_feature_aa64_nv(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, NV) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR2, NV) != 0;
 }
 
 static inline bool isar_feature_aa64_nv2(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, NV) >= 2;
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR2, NV) >= 2;
 }
 
 static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 05157a49d75c..df9b7cc8c84c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1074,10 +1074,6 @@ struct ArchCPU {
         uint32_t dbgdidr;
         uint32_t dbgdevid;
         uint32_t dbgdevid1;
-        uint64_t id_aa64mmfr0;
-        uint64_t id_aa64mmfr1;
-        uint64_t id_aa64mmfr2;
-        uint64_t id_aa64mmfr3;
         uint64_t id_aa64dfr0;
         uint64_t id_aa64dfr1;
         uint64_t id_aa64smfr0;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 502aac91730d..500f3646bfad 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -623,12 +623,12 @@ void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
         return;
     }
 
-    t = cpu->isar.id_aa64mmfr0;
+    t = GET_IDREG(&cpu->isar, ID_AA64MMFR0);
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 2);   /* 16k pages w/ LPA2 */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN4, 1);    /*  4k pages w/ LPA2 */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16_2, 3); /* 16k stage2 w/ LPA2 */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN4_2, 3);  /*  4k stage2 w/ LPA2 */
-    cpu->isar.id_aa64mmfr0 = t;
+    SET_IDREG(&cpu->isar, ID_AA64MMFR0, t);
 }
 
 static void aarch64_a57_initfn(Object *obj)
@@ -673,7 +673,7 @@ static void aarch64_a57_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
     cpu->isar.id_aa64dfr0 = 0x10305106;
     SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
-    cpu->isar.id_aa64mmfr0 = 0x00001124;
+    SET_IDREG(isar, ID_AA64MMFR0, 0x00001124);
     cpu->isar.dbgdidr = 0x3516d000;
     cpu->isar.dbgdevid = 0x01110f13;
     cpu->isar.dbgdevid1 = 0x2;
@@ -735,7 +735,7 @@ static void aarch64_a53_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
     cpu->isar.id_aa64dfr0 = 0x10305106;
     SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
-    cpu->isar.id_aa64mmfr0 = 0x00001122; /* 40 bit physical addr */
+    SET_IDREG(isar, ID_AA64MMFR0, 0x00001122); /* 40 bit physical addr */
     cpu->isar.dbgdidr = 0x3516d000;
     cpu->isar.dbgdevid = 0x00110f13;
     cpu->isar.dbgdevid1 = 0x1;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2b7c963e026c..48fcd755dcdb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8043,22 +8043,22 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64mmfr0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64MMFR0)},
             { .name = "ID_AA64MMFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64mmfr1 },
+              .resetvalue = GET_IDREG(isar, ID_AA64MMFR1) },
             { .name = "ID_AA64MMFR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64mmfr2 },
+              .resetvalue = GET_IDREG(isar, ID_AA64MMFR2) },
             { .name = "ID_AA64MMFR3_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64mmfr3 },
+              .resetvalue = GET_IDREG(isar, ID_AA64MMFR3) },
             { .name = "ID_AA64MMFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index e1bfca5947c1..37a6303ec2a4 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -846,14 +846,17 @@ static uint64_t hvf_get_reg(CPUState *cpu, int rt)
     return val;
 }
 
-static void clamp_id_aa64mmfr0_parange_to_ipa_size(uint64_t *id_aa64mmfr0)
+static void clamp_id_aa64mmfr0_parange_to_ipa_size(ARMISARegisters *isar)
 {
     uint32_t ipa_size = chosen_ipa_bit_size ?
             chosen_ipa_bit_size : hvf_arm_get_max_ipa_bit_size();
+    uint64_t id_aa64mmfr0;
 
     /* Clamp down the PARange to the IPA size the kernel supports. */
     uint8_t index = round_down_to_parange_index(ipa_size);
-    *id_aa64mmfr0 = (*id_aa64mmfr0 & ~R_ID_AA64MMFR0_PARANGE_MASK) | index;
+    id_aa64mmfr0 = GET_IDREG(isar, ID_AA64MMFR0);
+    id_aa64mmfr0 = (id_aa64mmfr0 & ~R_ID_AA64MMFR0_PARANGE_MASK) | index;
+    SET_IDREG(isar, ID_AA64MMFR0, id_aa64mmfr0);
 }
 
 static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
@@ -870,9 +873,9 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         { HV_SYS_REG_ID_AA64ISAR0_EL1, &host_isar.idregs[ID_AA64ISAR0_EL1_IDX] },
         { HV_SYS_REG_ID_AA64ISAR1_EL1, &host_isar.idregs[ID_AA64ISAR1_EL1_IDX] },
         /* Add ID_AA64ISAR2_EL1 here when HVF supports it */
-        { HV_SYS_REG_ID_AA64MMFR0_EL1, &host_isar.id_aa64mmfr0 },
-        { HV_SYS_REG_ID_AA64MMFR1_EL1, &host_isar.id_aa64mmfr1 },
-        { HV_SYS_REG_ID_AA64MMFR2_EL1, &host_isar.id_aa64mmfr2 },
+        { HV_SYS_REG_ID_AA64MMFR0_EL1, &host_isar.idregs[ID_AA64MMFR0_EL1_IDX] },
+        { HV_SYS_REG_ID_AA64MMFR1_EL1, &host_isar.idregs[ID_AA64MMFR1_EL1_IDX] },
+        { HV_SYS_REG_ID_AA64MMFR2_EL1, &host_isar.idregs[ID_AA64MMFR2_EL1_IDX] },
         /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
     };
     hv_vcpu_t fd;
@@ -899,7 +902,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     r |= hv_vcpu_get_sys_reg(fd, HV_SYS_REG_MIDR_EL1, &ahcf->midr);
     r |= hv_vcpu_destroy(fd);
 
-    clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar.id_aa64mmfr0);
+    clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
 
     /*
      * Disable SME, which is not properly handled by QEMU hvf yet.
@@ -1067,12 +1070,12 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
     /* We're limited to underlying hardware caps, override internal versions */
     ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64MMFR0_EL1,
-                              &arm_cpu->isar.id_aa64mmfr0);
+                              &arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
     assert_hvf_ok(ret);
 
-    clamp_id_aa64mmfr0_parange_to_ipa_size(&arm_cpu->isar.id_aa64mmfr0);
+    clamp_id_aa64mmfr0_parange_to_ipa_size(&arm_cpu->isar);
     ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64MMFR0_EL1,
-                              arm_cpu->isar.id_aa64mmfr0);
+                              arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
     assert_hvf_ok(ret);
 
     return 0;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 1e19dba4cb07..1dde96fbbda7 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -323,14 +323,10 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err |= get_host_cpu_reg(fd, ahcf, ID_AA64ISAR0_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_AA64ISAR1_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_AA64ISAR2_EL1_IDX);
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr0,
-                              ARM64_SYS_REG(3, 0, 0, 7, 0));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr1,
-                              ARM64_SYS_REG(3, 0, 0, 7, 1));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr2,
-                              ARM64_SYS_REG(3, 0, 0, 7, 2));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr3,
-                              ARM64_SYS_REG(3, 0, 0, 7, 3));
+        err |= get_host_cpu_reg(fd, ahcf, ID_AA64MMFR0_EL1_IDX);
+        err |= get_host_cpu_reg(fd, ahcf, ID_AA64MMFR1_EL1_IDX);
+        err |= get_host_cpu_reg(fd, ahcf, ID_AA64MMFR2_EL1_IDX);
+        err |= get_host_cpu_reg(fd, ahcf, ID_AA64MMFR3_EL1_IDX);
 
         /*
          * Note that if AArch32 support is not present in the host,
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 44170d831cca..561bf2678e5a 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -122,7 +122,7 @@ unsigned int arm_pamax(ARMCPU *cpu)
 {
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         unsigned int parange =
-            FIELD_EX64(cpu->isar.id_aa64mmfr0, ID_AA64MMFR0, PARANGE);
+            FIELD_EX64_IDREG(&cpu->isar, ID_AA64MMFR0, PARANGE);
 
         /*
          * id_aa64mmfr0 is a read-only register so values outside of the
@@ -332,7 +332,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
      * physical address size is invalid.
      */
     pps = FIELD_EX64(gpccr, GPCCR, PPS);
-    if (pps > FIELD_EX64(cpu->isar.id_aa64mmfr0, ID_AA64MMFR0, PARANGE)) {
+    if (pps > FIELD_EX64_IDREG(&cpu->isar, ID_AA64MMFR0, PARANGE)) {
         goto fault_walk;
     }
     pps = pamax_map[pps];
@@ -1703,7 +1703,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
          * ID_AA64MMFR0 is a read-only register so values outside of the
          * supported mappings can be considered an implementation error.
          */
-        ps = FIELD_EX64(cpu->isar.id_aa64mmfr0, ID_AA64MMFR0, PARANGE);
+        ps = FIELD_EX64_IDREG(&cpu->isar, ID_AA64MMFR0, PARANGE);
         ps = MIN(ps, param.ps);
         assert(ps < ARRAY_SIZE(pamax_map));
         outputsize = pamax_map[ps];
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 7a730c7974f0..9efb7f0ce800 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -69,8 +69,8 @@ static void aarch64_a35_initfn(Object *obj)
     cpu->isar.id_aa64dfr1 = 0;
     SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
     SET_IDREG(isar, ID_AA64ISAR1, 0);
-    cpu->isar.id_aa64mmfr0 = 0x00101122;
-    cpu->isar.id_aa64mmfr1 = 0;
+    SET_IDREG(isar, ID_AA64MMFR0, 0x00101122);
+    SET_IDREG(isar, ID_AA64MMFR1, 0);
     cpu->clidr = 0x0a200023;
     cpu->dcz_blocksize = 4;
 
@@ -222,9 +222,9 @@ static void aarch64_a55_initfn(Object *obj)
     cpu->isar.id_aa64dfr0  = 0x0000000010305408ull;
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
-    cpu->isar.id_aa64mmfr0 = 0x0000000000101122ull;
-    cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
-    cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
+    SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000101122ull);
+    SET_IDREG(isar, ID_AA64MMFR1, 0x0000000010212122ull);
+    SET_IDREG(isar, ID_AA64MMFR2, 0x0000000000001011ull);
     SET_IDREG(isar, ID_AA64PFR0, 0x0000000010112222ull);
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
     cpu->id_afr0       = 0x00000000;
@@ -312,7 +312,7 @@ static void aarch64_a72_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
     cpu->isar.id_aa64dfr0 = 0x10305106;
     SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
-    cpu->isar.id_aa64mmfr0 = 0x00001124;
+    SET_IDREG(isar, ID_AA64MMFR0, 0x00001124);
     cpu->isar.dbgdidr = 0x3516d000;
     cpu->isar.dbgdevid = 0x01110f13;
     cpu->isar.dbgdevid1 = 0x2;
@@ -355,9 +355,9 @@ static void aarch64_a76_initfn(Object *obj)
     cpu->isar.id_aa64dfr0  = 0x0000000010305408ull;
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
-    cpu->isar.id_aa64mmfr0 = 0x0000000000101122ull;
-    cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
-    cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
+    SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000101122ull);
+    SET_IDREG(isar, ID_AA64MMFR1, 0x0000000010212122ull);
+    SET_IDREG(isar, ID_AA64MMFR2, 0x0000000000001011ull);
     SET_IDREG(isar, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
     cpu->id_afr0       = 0x00000000;
@@ -430,9 +430,9 @@ static void aarch64_a64fx_initfn(Object *obj)
     cpu->isar.id_aa64dfr1 = 0x0000000000000000;
     cpu->id_aa64afr0 = 0x0000000000000000;
     cpu->id_aa64afr1 = 0x0000000000000000;
-    cpu->isar.id_aa64mmfr0 = 0x0000000000001122;
-    cpu->isar.id_aa64mmfr1 = 0x0000000011212100;
-    cpu->isar.id_aa64mmfr2 = 0x0000000000001011;
+    SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000001122);
+    SET_IDREG(isar, ID_AA64MMFR1, 0x0000000011212100);
+    SET_IDREG(isar, ID_AA64MMFR2, 0x0000000000001011);
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000000010211120);
     SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000010001);
     SET_IDREG(isar, ID_AA64ZFR0, 0x0000000000000000);
@@ -603,9 +603,9 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     cpu->isar.id_aa64dfr0  = 0x0000000110305408ull;
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
-    cpu->isar.id_aa64mmfr0 = 0x0000000000101125ull;
-    cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
-    cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
+    SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000101125ull);
+    SET_IDREG(isar, ID_AA64MMFR1, 0x0000000010212122ull);
+    SET_IDREG(isar, ID_AA64MMFR2, 0x0000000000001011ull);
     SET_IDREG(isar, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000020ull);
     cpu->id_afr0       = 0x00000000;
@@ -682,9 +682,9 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     cpu->isar.id_aa64dfr1 = 0x00000000;
     SET_IDREG(isar, ID_AA64ISAR0, 0x1011111110212120ull); /* with FEAT_RNG */
     SET_IDREG(isar, ID_AA64ISAR1, 0x0011000001211032ull);
-    cpu->isar.id_aa64mmfr0 = 0x0000000000101125ull;
-    cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
-    cpu->isar.id_aa64mmfr2 = 0x0220011102101011ull;
+    SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000101125ull);
+    SET_IDREG(isar, ID_AA64MMFR1, 0x0000000010212122ull),
+    SET_IDREG(isar, ID_AA64MMFR2, 0x0220011102101011ull),
     SET_IDREG(isar, ID_AA64PFR0, 0x1101110120111112ull); /* GIC filled in later */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000020ull);
     cpu->id_afr0       = 0x00000000;
@@ -931,9 +931,9 @@ static void aarch64_a710_initfn(Object *obj)
     cpu->id_aa64afr1       = 0;
     SET_IDREG(isar, ID_AA64ISAR0, 0x0221111110212120ull); /* with Crypto */
     SET_IDREG(isar, ID_AA64ISAR1, 0x0010111101211052ull);
-    cpu->isar.id_aa64mmfr0 = 0x0000022200101122ull;
-    cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
-    cpu->isar.id_aa64mmfr2 = 0x1221011110101011ull;
+    SET_IDREG(isar, ID_AA64MMFR0, 0x0000022200101122ull);
+    SET_IDREG(isar, ID_AA64MMFR1, 0x0000000010212122ull);
+    SET_IDREG(isar, ID_AA64MMFR2, 0x1221011110101011ull);
     cpu->clidr             = 0x0000001482000023ull;
     cpu->gm_blocksize      = 4;
     cpu->ctr               = 0x000000049444c004ull;
@@ -1033,9 +1033,9 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     cpu->id_aa64afr1       = 0;
     SET_IDREG(isar, ID_AA64ISAR0, 0x1221111110212120ull); /* with Crypto and FEAT_RNG */
     SET_IDREG(isar, ID_AA64ISAR1, 0x0011111101211052ull);
-    cpu->isar.id_aa64mmfr0 = 0x0000022200101125ull;
-    cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
-    cpu->isar.id_aa64mmfr2 = 0x1221011112101011ull;
+    SET_IDREG(isar, ID_AA64MMFR0, 0x0000022200101125ull);
+    SET_IDREG(isar, ID_AA64MMFR1, 0x0000000010212122ull);
+    SET_IDREG(isar, ID_AA64MMFR2, 0x1221011112101011ull);
     cpu->clidr             = 0x0000001482000023ull;
     cpu->gm_blocksize      = 4;
     cpu->ctr               = 0x00000004b444c004ull;
@@ -1206,7 +1206,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
-    t = cpu->isar.id_aa64mmfr0;
+    t = GET_IDREG(isar, ID_AA64MMFR0);
     t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* 16k pages supported */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16_2, 2); /* 16k stage2 supported */
@@ -1214,9 +1214,9 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN4_2, 2);  /*  4k stage2 supported */
     t = FIELD_DP64(t, ID_AA64MMFR0, FGT, 1);       /* FEAT_FGT */
     t = FIELD_DP64(t, ID_AA64MMFR0, ECV, 2);       /* FEAT_ECV */
-    cpu->isar.id_aa64mmfr0 = t;
+    SET_IDREG(isar, ID_AA64MMFR0, t);
 
-    t = cpu->isar.id_aa64mmfr1;
+    t = GET_IDREG(isar, ID_AA64MMFR1);
     t = FIELD_DP64(t, ID_AA64MMFR1, HAFDBS, 2);   /* FEAT_HAFDBS */
     t = FIELD_DP64(t, ID_AA64MMFR1, VMIDBITS, 2); /* FEAT_VMID16 */
     t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);       /* FEAT_VHE */
@@ -1229,9 +1229,9 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR1, AFP, 1);      /* FEAT_AFP */
     t = FIELD_DP64(t, ID_AA64MMFR1, TIDCP1, 1);   /* FEAT_TIDCP1 */
     t = FIELD_DP64(t, ID_AA64MMFR1, CMOW, 1);     /* FEAT_CMOW */
-    cpu->isar.id_aa64mmfr1 = t;
+    SET_IDREG(isar, ID_AA64MMFR1, t);
 
-    t = cpu->isar.id_aa64mmfr2;
+    t = GET_IDREG(isar, ID_AA64MMFR2);
     t = FIELD_DP64(t, ID_AA64MMFR2, CNP, 1);      /* FEAT_TTCNP */
     t = FIELD_DP64(t, ID_AA64MMFR2, UAO, 1);      /* FEAT_UAO */
     t = FIELD_DP64(t, ID_AA64MMFR2, IESB, 1);     /* FEAT_IESB */
@@ -1245,11 +1245,9 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR2, BBM, 2);      /* FEAT_BBM at level 2 */
     t = FIELD_DP64(t, ID_AA64MMFR2, EVT, 2);      /* FEAT_EVT */
     t = FIELD_DP64(t, ID_AA64MMFR2, E0PD, 1);     /* FEAT_E0PD */
-    cpu->isar.id_aa64mmfr2 = t;
+    SET_IDREG(isar, ID_AA64MMFR2, t);
 
-    t = cpu->isar.id_aa64mmfr3;
-    t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
-    cpu->isar.id_aa64mmfr3 = t;
+    FIELD_DP64_IDREG(isar, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
     t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 1);
-- 
2.49.0


