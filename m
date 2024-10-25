Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3409B0010
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Oct 2024 12:24:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4HST-00041c-T7; Fri, 25 Oct 2024 06:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t4HSQ-00040i-Sd
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 06:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t4HSO-0000Tt-7a
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 06:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729851731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HN4Ss36YijvUf21dciqauRTxmHa4LrFufRGDFaLoFys=;
 b=Ya4TcxOeNT0WzKozvi7fayC3ategenTElHasrBIC0u4AKIjsPA/gMr2H3dl/ozFnRbQzr/
 SCN8XQv5t/XZK254ggC9ZzX+dpQLzefFNryfpWMfgreFF1vyr7rKD8N+YkJr7g2htWA6SW
 VMAp2yvxFXkl0jl6LyJgKU4KvogR01A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-sp7ST7OsNUi803pU5La1qw-1; Fri,
 25 Oct 2024 06:20:58 -0400
X-MC-Unique: sp7ST7OsNUi803pU5La1qw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04BA619560B5; Fri, 25 Oct 2024 10:20:57 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.194.5])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4916E196BB7D; Fri, 25 Oct 2024 10:20:51 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [RFC 06/21] arm/cpu: Store aa64mmfr0-3 into the idregs array
Date: Fri, 25 Oct 2024 12:17:25 +0200
Message-ID: <20241025101959.601048-7-eric.auger@redhat.com>
In-Reply-To: <20241025101959.601048-1-eric.auger@redhat.com>
References: <20241025101959.601048-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/cpu-features.h | 70 +++++++++++++++++++--------------------
 target/arm/cpu.h          |  7 ++--
 target/arm/cpu64.c        |  8 ++---
 target/arm/helper.c       |  8 ++---
 target/arm/kvm.c          | 12 +++----
 target/arm/ptw.c          |  6 ++--
 target/arm/tcg/cpu64.c    | 64 +++++++++++++++++------------------
 7 files changed, 84 insertions(+), 91 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 5e195f117d..45f315df7b 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -694,182 +694,182 @@ static inline bool isar_feature_aa64_nmi(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa64_tgran4_lpa2(const ARMISARegisters *id)
 {
-    return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4) >= 1;
+    return FIELD_SEX64_IDREG(&id->idregs, ID_AA64MMFR0, TGRAN4) >= 1;
 }
 
 static inline bool isar_feature_aa64_tgran4_2_lpa2(const ARMISARegisters *id)
 {
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4_2);
+    unsigned t = FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR0, TGRAN4_2);
     return t >= 3 || (t == 0 && isar_feature_aa64_tgran4_lpa2(id));
 }
 
 static inline bool isar_feature_aa64_tgran16_lpa2(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16) >= 2;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR0, TGRAN16) >= 2;
 }
 
 static inline bool isar_feature_aa64_tgran16_2_lpa2(const ARMISARegisters *id)
 {
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16_2);
+    unsigned t = FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR0, TGRAN16_2);
     return t >= 3 || (t == 0 && isar_feature_aa64_tgran16_lpa2(id));
 }
 
 static inline bool isar_feature_aa64_tgran4(const ARMISARegisters *id)
 {
-    return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4) >= 0;
+    return FIELD_SEX64_IDREG(&id->idregs, ID_AA64MMFR0, TGRAN4) >= 0;
 }
 
 static inline bool isar_feature_aa64_tgran16(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16) >= 1;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR0, TGRAN16) >= 1;
 }
 
 static inline bool isar_feature_aa64_tgran64(const ARMISARegisters *id)
 {
-    return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN64) >= 0;
+    return FIELD_SEX64_IDREG(&id->idregs, ID_AA64MMFR0, TGRAN64) >= 0;
 }
 
 static inline bool isar_feature_aa64_tgran4_2(const ARMISARegisters *id)
 {
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4_2);
+    unsigned t = FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR0, TGRAN4_2);
     return t >= 2 || (t == 0 && isar_feature_aa64_tgran4(id));
 }
 
 static inline bool isar_feature_aa64_tgran16_2(const ARMISARegisters *id)
 {
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16_2);
+    unsigned t = FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR0, TGRAN16_2);
     return t >= 2 || (t == 0 && isar_feature_aa64_tgran16(id));
 }
 
 static inline bool isar_feature_aa64_tgran64_2(const ARMISARegisters *id)
 {
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN64_2);
+    unsigned t = FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR0, TGRAN64_2);
     return t >= 2 || (t == 0 && isar_feature_aa64_tgran64(id));
 }
 
 static inline bool isar_feature_aa64_fgt(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, FGT) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR0, FGT) != 0;
 }
 
 static inline bool isar_feature_aa64_ecv_traps(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, ECV) > 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR0, ECV) > 0;
 }
 
 static inline bool isar_feature_aa64_ecv(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, ECV) > 1;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR0, ECV) > 1;
 }
 
 static inline bool isar_feature_aa64_vh(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, VH) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR1, VH) != 0;
 }
 
 static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, LO) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR1, LO) != 0;
 }
 
 static inline bool isar_feature_aa64_pan(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR1, PAN) != 0;
 }
 
 static inline bool isar_feature_aa64_ats1e1(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) >= 2;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR1, PAN) >= 2;
 }
 
 static inline bool isar_feature_aa64_pan3(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) >= 3;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR1, PAN) >= 3;
 }
 
 static inline bool isar_feature_aa64_hcx(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HCX) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR1, HCX) != 0;
 }
 
 static inline bool isar_feature_aa64_tidcp1(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, TIDCP1) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR1, TIDCP1) != 0;
 }
 
 static inline bool isar_feature_aa64_hafs(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR1, HAFDBS) != 0;
 }
 
 static inline bool isar_feature_aa64_hdbs(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) >= 2;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR1, HAFDBS) >= 2;
 }
 
 static inline bool isar_feature_aa64_tts2uxn(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, XNX) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR1, XNX) != 0;
 }
 
 static inline bool isar_feature_aa64_uao(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, UAO) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR2, UAO) != 0;
 }
 
 static inline bool isar_feature_aa64_st(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, ST) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR2, ST) != 0;
 }
 
 static inline bool isar_feature_aa64_lse2(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, AT) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR2, AT) != 0;
 }
 
 static inline bool isar_feature_aa64_fwb(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, FWB) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR2, FWB) != 0;
 }
 
 static inline bool isar_feature_aa64_ids(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, IDS) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR2, IDS) != 0;
 }
 
 static inline bool isar_feature_aa64_half_evt(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, EVT) >= 1;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR2, EVT) >= 1;
 }
 
 static inline bool isar_feature_aa64_evt(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, EVT) >= 2;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR2, EVT) >= 2;
 }
 
 static inline bool isar_feature_aa64_ccidx(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, CCIDX) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR2, CCIDX) != 0;
 }
 
 static inline bool isar_feature_aa64_lva(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, VARANGE) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR2, VARANGE) != 0;
 }
 
 static inline bool isar_feature_aa64_e0pd(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, E0PD) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR2, E0PD) != 0;
 }
 
 static inline bool isar_feature_aa64_nv(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, NV) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR2, NV) != 0;
 }
 
 static inline bool isar_feature_aa64_nv2(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, NV) >= 2;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64MMFR2, NV) >= 2;
 }
 
 static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bebee2e694..419dfde638 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -874,6 +874,9 @@ _set_idreg(MAP, SYS_ ## REG ## _EL1, regval);                 \
 #define FIELD_EX64_IDREG(MAP, REG, FIELD)                     \
 FIELD_EX64(_get_idreg(MAP, SYS_ ## REG ## _EL1), REG, FIELD)  \
 
+#define FIELD_SEX64_IDREG(MAP, REG, FIELD)                     \
+FIELD_SEX64(_get_idreg(MAP, SYS_ ## REG ## _EL1), REG, FIELD)  \
+
 #define FIELD_EX32_IDREG(MAP, REG, FIELD)                     \
 FIELD_EX32(_get_idreg(MAP, SYS_ ## REG ## _EL1), REG, FIELD)  \
 
@@ -1085,10 +1088,6 @@ struct ArchCPU {
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
index 7dd458012a..594778a031 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -582,12 +582,12 @@ void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
         return;
     }
 
-    t = cpu->isar.id_aa64mmfr0;
+    t = GET_IDREG(&cpu->isar.idregs, ID_AA64MMFR0);
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 2);   /* 16k pages w/ LPA2 */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN4, 1);    /*  4k pages w/ LPA2 */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16_2, 3); /* 16k stage2 w/ LPA2 */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN4_2, 3);  /*  4k stage2 w/ LPA2 */
-    cpu->isar.id_aa64mmfr0 = t;
+    SET_IDREG(&cpu->isar.idregs, ID_AA64MMFR0, t);
 }
 
 static void aarch64_a57_initfn(Object *obj)
@@ -632,7 +632,7 @@ static void aarch64_a57_initfn(Object *obj)
     SET_IDREG(idregs, ID_AA64PFR0, 0x00002222);
     cpu->isar.id_aa64dfr0 = 0x10305106;
     SET_IDREG(idregs, ID_AA64ISAR0, 0x00011120);
-    cpu->isar.id_aa64mmfr0 = 0x00001124;
+    SET_IDREG(idregs, ID_AA64MMFR0, 0x00001124);
     cpu->isar.dbgdidr = 0x3516d000;
     cpu->isar.dbgdevid = 0x01110f13;
     cpu->isar.dbgdevid1 = 0x2;
@@ -691,7 +691,7 @@ static void aarch64_a53_initfn(Object *obj)
     SET_IDREG(idregs, ID_AA64PFR0, 0x00002222);
     cpu->isar.id_aa64dfr0 = 0x10305106;
     SET_IDREG(idregs, ID_AA64ISAR0, 0x00011120);
-    cpu->isar.id_aa64mmfr0 = 0x00001122; /* 40 bit physical addr */
+    SET_IDREG(idregs, ID_AA64MMFR0, 0x00001122); /* 40 bit physical addr */
     cpu->isar.dbgdidr = 0x3516d000;
     cpu->isar.dbgdevid = 0x00110f13;
     cpu->isar.dbgdevid1 = 0x1;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 541bc27587..fa04383921 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8995,22 +8995,22 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64mmfr0 },
+              .resetvalue = GET_IDREG(idregs, ID_AA64MMFR0)},
             { .name = "ID_AA64MMFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64mmfr1 },
+              .resetvalue = GET_IDREG(idregs, ID_AA64MMFR1) },
             { .name = "ID_AA64MMFR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64mmfr2 },
+              .resetvalue = GET_IDREG(idregs, ID_AA64MMFR2) },
             { .name = "ID_AA64MMFR3_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64mmfr3 },
+              .resetvalue = GET_IDREG(idregs, ID_AA64MMFR3) },
             { .name = "ID_AA64MMFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 888b10213c..c9b99bf5ee 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -335,14 +335,10 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err |= get_host_cpu_reg64(fd, ahcf, SYS_ID_AA64ISAR0_EL1);
         err |= get_host_cpu_reg64(fd, ahcf, SYS_ID_AA64ISAR1_EL1);
         err |= get_host_cpu_reg64(fd, ahcf, SYS_ID_AA64ISAR2_EL1);
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr0,
-                              ARM64_SYS_REG(3, 0, 0, 7, 0));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr1,
-                              ARM64_SYS_REG(3, 0, 0, 7, 1));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr2,
-                              ARM64_SYS_REG(3, 0, 0, 7, 2));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr3,
-                              ARM64_SYS_REG(3, 0, 0, 7, 3));
+        err |= get_host_cpu_reg64(fd, ahcf, SYS_ID_AA64MMFR0_EL1);
+        err |= get_host_cpu_reg64(fd, ahcf, SYS_ID_AA64MMFR1_EL1);
+        err |= get_host_cpu_reg64(fd, ahcf, SYS_ID_AA64MMFR2_EL1);
+        err |= get_host_cpu_reg64(fd, ahcf, SYS_ID_AA64MMFR3_EL1);
 
         /*
          * Note that if AArch32 support is not present in the host,
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 4476b32ff5..dea4621352 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -104,7 +104,7 @@ unsigned int arm_pamax(ARMCPU *cpu)
 {
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         unsigned int parange =
-            FIELD_EX64(cpu->isar.id_aa64mmfr0, ID_AA64MMFR0, PARANGE);
+            FIELD_EX64_IDREG(&cpu->isar.idregs, ID_AA64MMFR0, PARANGE);
 
         /*
          * id_aa64mmfr0 is a read-only register so values outside of the
@@ -312,7 +312,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
      * physical address size is invalid.
      */
     pps = FIELD_EX64(gpccr, GPCCR, PPS);
-    if (pps > FIELD_EX64(cpu->isar.id_aa64mmfr0, ID_AA64MMFR0, PARANGE)) {
+    if (pps > FIELD_EX64_IDREG(&cpu->isar.idregs, ID_AA64MMFR0, PARANGE)) {
         goto fault_walk;
     }
     pps = pamax_map[pps];
@@ -1727,7 +1727,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
          * ID_AA64MMFR0 is a read-only register so values outside of the
          * supported mappings can be considered an implementation error.
          */
-        ps = FIELD_EX64(cpu->isar.id_aa64mmfr0, ID_AA64MMFR0, PARANGE);
+        ps = FIELD_EX64_IDREG(&cpu->isar.idregs, ID_AA64MMFR0, PARANGE);
         ps = MIN(ps, param.ps);
         assert(ps < ARRAY_SIZE(pamax_map));
         outputsize = pamax_map[ps];
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index b2a88a0ebd..64473fc3c7 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -95,8 +95,8 @@ static void aarch64_a35_initfn(Object *obj)
     cpu->isar.id_aa64dfr1 = 0;
     SET_IDREG(idregs, ID_AA64ISAR0, 0x00011120);
     SET_IDREG(idregs, ID_AA64ISAR1, 0);
-    cpu->isar.id_aa64mmfr0 = 0x00101122;
-    cpu->isar.id_aa64mmfr1 = 0;
+    SET_IDREG(idregs, ID_AA64MMFR0, 0x00101122);
+    SET_IDREG(idregs, ID_AA64MMFR1, 0);
     cpu->clidr = 0x0a200023;
     cpu->dcz_blocksize = 4;
 
@@ -245,9 +245,9 @@ static void aarch64_a55_initfn(Object *obj)
     cpu->isar.id_aa64dfr0  = 0x0000000010305408ull;
     SET_IDREG(idregs, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(idregs, ID_AA64ISAR1, 0x0000000000100001ull);
-    cpu->isar.id_aa64mmfr0 = 0x0000000000101122ull;
-    cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
-    cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
+    SET_IDREG(idregs, ID_AA64MMFR0, 0x0000000000101122ull);
+    SET_IDREG(idregs, ID_AA64MMFR1, 0x0000000010212122ull);
+    SET_IDREG(idregs, ID_AA64MMFR2, 0x0000000000001011ull);
     SET_IDREG(idregs, ID_AA64PFR0, 0x0000000010112222ull);
     SET_IDREG(idregs, ID_AA64PFR1, 0x0000000000000010ull);
     cpu->id_afr0       = 0x00000000;
@@ -332,7 +332,7 @@ static void aarch64_a72_initfn(Object *obj)
     SET_IDREG(idregs, ID_AA64PFR0, 0x00002222);
     cpu->isar.id_aa64dfr0 = 0x10305106;
     SET_IDREG(idregs, ID_AA64ISAR0, 0x00011120);
-    cpu->isar.id_aa64mmfr0 = 0x00001124;
+    SET_IDREG(idregs, ID_AA64MMFR0, 0x00001124);
     cpu->isar.dbgdidr = 0x3516d000;
     cpu->isar.dbgdevid = 0x01110f13;
     cpu->isar.dbgdevid1 = 0x2;
@@ -372,9 +372,9 @@ static void aarch64_a76_initfn(Object *obj)
     cpu->isar.id_aa64dfr0  = 0x0000000010305408ull;
     SET_IDREG(idregs, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(idregs, ID_AA64ISAR1, 0x0000000000100001ull);
-    cpu->isar.id_aa64mmfr0 = 0x0000000000101122ull;
-    cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
-    cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
+    SET_IDREG(idregs, ID_AA64MMFR0, 0x0000000000101122ull);
+    SET_IDREG(idregs, ID_AA64MMFR1, 0x0000000010212122ull);
+    SET_IDREG(idregs, ID_AA64MMFR2, 0x0000000000001011ull);
     SET_IDREG(idregs, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
     SET_IDREG(idregs, ID_AA64PFR1, 0x0000000000000010ull);
     cpu->id_afr0       = 0x00000000;
@@ -444,9 +444,9 @@ static void aarch64_a64fx_initfn(Object *obj)
     cpu->isar.id_aa64dfr1 = 0x0000000000000000;
     cpu->id_aa64afr0 = 0x0000000000000000;
     cpu->id_aa64afr1 = 0x0000000000000000;
-    cpu->isar.id_aa64mmfr0 = 0x0000000000001122;
-    cpu->isar.id_aa64mmfr1 = 0x0000000011212100;
-    cpu->isar.id_aa64mmfr2 = 0x0000000000001011;
+    SET_IDREG(idregs, ID_AA64MMFR0, 0x0000000000001122);
+    SET_IDREG(idregs, ID_AA64MMFR1, 0x0000000011212100);
+    SET_IDREG(idregs, ID_AA64MMFR2, 0x0000000000001011);
     SET_IDREG(idregs, ID_AA64ISAR0, 0x0000000010211120);
     SET_IDREG(idregs, ID_AA64ISAR1, 0x0000000000010001);
     SET_IDREG(idregs, ID_AA64ZFR0, 0x0000000000000000);
@@ -614,9 +614,9 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     cpu->isar.id_aa64dfr0  = 0x0000000110305408ull;
     SET_IDREG(idregs, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(idregs, ID_AA64ISAR1, 0x0000000000100001ull);
-    cpu->isar.id_aa64mmfr0 = 0x0000000000101125ull;
-    cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
-    cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
+    SET_IDREG(idregs, ID_AA64MMFR0, 0x0000000000101125ull);
+    SET_IDREG(idregs, ID_AA64MMFR1, 0x0000000010212122ull);
+    SET_IDREG(idregs, ID_AA64MMFR2, 0x0000000000001011ull);
     SET_IDREG(idregs, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
     SET_IDREG(idregs, ID_AA64PFR1, 0x0000000000000020ull);
     cpu->id_afr0       = 0x00000000;
@@ -690,9 +690,9 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     cpu->isar.id_aa64dfr1 = 0x00000000;
     SET_IDREG(idregs, ID_AA64ISAR0, 0x1011111110212120ull); /* with FEAT_RNG */
     SET_IDREG(idregs, ID_AA64ISAR1, 0x0111000001211032ull);
-    cpu->isar.id_aa64mmfr0 = 0x0000000000101125ull;
-    cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
-    cpu->isar.id_aa64mmfr2 = 0x0220011102101011ull;
+    SET_IDREG(idregs, ID_AA64MMFR0, 0x0000000000101125ull);
+    SET_IDREG(idregs, ID_AA64MMFR1, 0x0000000010212122ull),
+    SET_IDREG(idregs, ID_AA64MMFR2, 0x0220011102101011ull),
     SET_IDREG(idregs, ID_AA64PFR0, 0x1101110120111112ull); /* GIC filled in later */
     SET_IDREG(idregs, ID_AA64PFR1, 0x0000000000000020ull);
     cpu->id_afr0       = 0x00000000;
@@ -936,9 +936,9 @@ static void aarch64_a710_initfn(Object *obj)
     cpu->id_aa64afr1       = 0;
     SET_IDREG(idregs, ID_AA64ISAR0, 0x0221111110212120ull); /* with Crypto */
     SET_IDREG(idregs, ID_AA64ISAR1, 0x0010111101211052ull);
-    cpu->isar.id_aa64mmfr0 = 0x0000022200101122ull;
-    cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
-    cpu->isar.id_aa64mmfr2 = 0x1221011110101011ull;
+    SET_IDREG(idregs, ID_AA64MMFR0, 0x0000022200101122ull);
+    SET_IDREG(idregs, ID_AA64MMFR1, 0x0000000010212122ull);
+    SET_IDREG(idregs, ID_AA64MMFR2, 0x1221011110101011ull);
     cpu->clidr             = 0x0000001482000023ull;
     cpu->gm_blocksize      = 4;
     cpu->ctr               = 0x000000049444c004ull;
@@ -1035,9 +1035,9 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     cpu->id_aa64afr1       = 0;
     SET_IDREG(idregs, ID_AA64ISAR0, 0x1221111110212120ull); /* with Crypto and FEAT_RNG */
     SET_IDREG(idregs, ID_AA64ISAR1, 0x0011111101211052ull);
-    cpu->isar.id_aa64mmfr0 = 0x0000022200101125ull;
-    cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
-    cpu->isar.id_aa64mmfr2 = 0x1221011112101011ull;
+    SET_IDREG(idregs, ID_AA64MMFR0, 0x0000022200101125ull);
+    SET_IDREG(idregs, ID_AA64MMFR1, 0x0000000010212122ull);
+    SET_IDREG(idregs, ID_AA64MMFR2, 0x1221011112101011ull);
     cpu->clidr             = 0x0000001482000023ull;
     cpu->gm_blocksize      = 4;
     cpu->ctr               = 0x00000004b444c004ull;
@@ -1204,7 +1204,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
     SET_IDREG(idregs, ID_AA64PFR1, t);
 
-    t = cpu->isar.id_aa64mmfr0;
+    t = GET_IDREG(idregs, ID_AA64MMFR0);
     t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* 16k pages supported */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16_2, 2); /* 16k stage2 supported */
@@ -1212,9 +1212,9 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN4_2, 2);  /*  4k stage2 supported */
     t = FIELD_DP64(t, ID_AA64MMFR0, FGT, 1);       /* FEAT_FGT */
     t = FIELD_DP64(t, ID_AA64MMFR0, ECV, 2);       /* FEAT_ECV */
-    cpu->isar.id_aa64mmfr0 = t;
+    SET_IDREG(idregs, ID_AA64MMFR0, t);
 
-    t = cpu->isar.id_aa64mmfr1;
+    t = GET_IDREG(idregs, ID_AA64MMFR1);
     t = FIELD_DP64(t, ID_AA64MMFR1, HAFDBS, 2);   /* FEAT_HAFDBS */
     t = FIELD_DP64(t, ID_AA64MMFR1, VMIDBITS, 2); /* FEAT_VMID16 */
     t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);       /* FEAT_VHE */
@@ -1225,9 +1225,9 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR1, ETS, 2);      /* FEAT_ETS2 */
     t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* FEAT_HCX */
     t = FIELD_DP64(t, ID_AA64MMFR1, TIDCP1, 1);   /* FEAT_TIDCP1 */
-    cpu->isar.id_aa64mmfr1 = t;
+    SET_IDREG(idregs, ID_AA64MMFR1, t);
 
-    t = cpu->isar.id_aa64mmfr2;
+    t = GET_IDREG(idregs, ID_AA64MMFR2);
     t = FIELD_DP64(t, ID_AA64MMFR2, CNP, 1);      /* FEAT_TTCNP */
     t = FIELD_DP64(t, ID_AA64MMFR2, UAO, 1);      /* FEAT_UAO */
     t = FIELD_DP64(t, ID_AA64MMFR2, IESB, 1);     /* FEAT_IESB */
@@ -1241,11 +1241,9 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR2, BBM, 2);      /* FEAT_BBM at level 2 */
     t = FIELD_DP64(t, ID_AA64MMFR2, EVT, 2);      /* FEAT_EVT */
     t = FIELD_DP64(t, ID_AA64MMFR2, E0PD, 1);     /* FEAT_E0PD */
-    cpu->isar.id_aa64mmfr2 = t;
+    SET_IDREG(idregs, ID_AA64MMFR2, t);
 
-    t = cpu->isar.id_aa64mmfr3;
-    t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
-    cpu->isar.id_aa64mmfr3 = t;
+    FIELD_DP64_IDREG(idregs, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
 
     t = GET_IDREG(idregs, ID_AA64ZFR0);
     t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 1);
-- 
2.41.0


