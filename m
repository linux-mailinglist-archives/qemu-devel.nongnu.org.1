Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B483DA888C8
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Apr 2025 18:42:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4MsW-0008Qp-Vc; Mon, 14 Apr 2025 12:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1u4MsJ-0007rY-Oa
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1u4MsG-0006XN-FA
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744648890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HL09en4O4QOpGwm35ea50Di8JN6ZUxSvnOPz3AJzN7k=;
 b=WDzyGHTx/ibzGEDp4dKoGOMZkumcYZtX0HiDzf9bWYMYyCOUtcKllAiGDLYb6DGtaCIufs
 10DOaynLaQMw9UsOr8WKJbxA0TWMq5ZTr/KT/TPFl/+4hMcY5Djg0Ha93+J0FdEawqdstA
 gH+hQbtyZL6IwYQIVq9MBuNYgi50cg4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-i3vWu4ptOUuEuCtaNKY4xQ-1; Mon,
 14 Apr 2025 12:41:27 -0400
X-MC-Unique: i3vWu4ptOUuEuCtaNKY4xQ-1
X-Mimecast-MFC-AGG-ID: i3vWu4ptOUuEuCtaNKY4xQ_1744648885
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50E181800349; Mon, 14 Apr 2025 16:41:25 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.67.24.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 72FC7180AF7C; Mon, 14 Apr 2025 16:41:09 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v3 08/10] arm/cpu: more customization for the kvm host cpu
 model
Date: Mon, 14 Apr 2025 18:38:47 +0200
Message-ID: <20250414163849.321857-9-cohuck@redhat.com>
In-Reply-To: <20250414163849.321857-1-cohuck@redhat.com>
References: <20250414163849.321857-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

If the interface for writable ID registers is available, expose uint64
SYSREG properties for writable ID reg fields exposed by the host
kernel. Properties are named  SYSREG_<REG>_<FIELD> with REG and FIELD
being those used  in linux arch/arm64/tools/sysreg. This done by
matching the writable fields retrieved from the host kernel against the
generated description of sysregs.

An example of invocation is:
-cpu host,SYSREG_ID_AA64ISAR0_EL1_DP=0x0
which sets DP field of ID_AA64ISAR0_EL1 to 0.

[CH: add properties to the host model instead of introducing a new
"custom" model]
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>

---

Interaction with the existing cpu properties is still a bit unclear --
at the moment, the different configurations can overwrite each other.
---
 target/arm/cpu.c        |  12 ++++
 target/arm/cpu64.c      |  22 ++++++-
 target/arm/kvm.c        | 135 ++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h    |  10 +++
 target/arm/trace-events |   4 ++
 5 files changed, 182 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a3de5ee2b19c..c03f38ad5cfe 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1991,6 +1991,18 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    /*
+     * If we failed to retrieve the set of writable ID registers for the "host"
+     * CPU model, report it here. No error if the interface for discovering
+     * writable ID registers is not available.
+     * In case we did get the set of writable ID registers, set the features to
+     * the configured values here and perform some sanity checks.
+     */
+    if (cpu->writable_id_regs == WRITABLE_ID_REGS_FAILED) {
+        error_setg(errp, "Failed to discover writable id registers");
+        return;
+    }
+
     if (!cpu->gt_cntfrq_hz) {
         /*
          * 0 means "the board didn't set a value, use the default". (We also
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 60a709502697..c595dbb532c1 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -757,11 +757,31 @@ static void aarch64_host_initfn(Object *obj)
 {
 #if defined(CONFIG_KVM)
     ARMCPU *cpu = ARM_CPU(obj);
-    kvm_arm_set_cpu_features_from_host(cpu, false);
+    bool expose_id_regs = true;
+    int ret;
+
+    cpu->writable_map = g_malloc(sizeof(IdRegMap));
+
+    /* discover via KVM_ARM_GET_REG_WRITABLE_MASKS */
+    ret = kvm_arm_get_writable_id_regs(cpu, cpu->writable_map);
+    if (ret == -ENOSYS) {
+        /* legacy: continue without writable id regs */
+        expose_id_regs = false;
+    } else if (ret) {
+        /* function will have marked an error */
+        return;
+    }
+
+    kvm_arm_set_cpu_features_from_host(cpu, expose_id_regs);
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_sve_properties(obj);
         aarch64_add_pauth_properties(obj);
     }
+    if (expose_id_regs) {
+        /* generate SYSREG properties according to writable masks */
+        kvm_arm_expose_idreg_properties(cpu, arm64_id_regs);
+    }
+
 #elif defined(CONFIG_HVF)
     ARMCPU *cpu = ARM_CPU(obj);
     hvf_arm_set_cpu_features_from_host(cpu);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 9e4cca1705c8..63e27906cc42 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -335,6 +335,141 @@ static int get_host_cpu_idregs(ARMCPU *cpu, int fd, ARMHostCPUFeatures *ahcf)
     return err;
 }
 
+static ARM64SysRegField *get_field(int i, ARM64SysReg *reg)
+{
+    GList *l;
+
+    for (l = reg->fields; l; l = l->next) {
+        ARM64SysRegField *field = (ARM64SysRegField *)l->data;
+
+        if (i >= field->lower && i <= field->upper) {
+            return field;
+        }
+    }
+    return NULL;
+}
+
+static void set_sysreg_prop(Object *obj, Visitor *v,
+                            const char *name, void *opaque,
+                            Error **errp)
+{
+    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint64_t *idregs = cpu->isar.idregs;
+    uint64_t old, value, mask;
+    int lower = field->lower;
+    int upper = field->upper;
+    int length = upper - lower + 1;
+    int index = field->index;
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+
+    if (length < 64 && value > ((1 << length) - 1)) {
+        error_setg(errp,
+                   "idreg %s set value (0x%lx) exceeds length of field (%d)!",
+                   name, value, length);
+        return;
+    }
+
+    mask = MAKE_64BIT_MASK(lower, length);
+    value = value << lower;
+    old = idregs[index];
+    idregs[index] = old & ~mask;
+    idregs[index] |= value;
+    trace_set_sysreg_prop(name, old, mask, value, idregs[index]);
+}
+
+static void get_sysreg_prop(Object *obj, Visitor *v,
+                            const char *name, void *opaque,
+                            Error **errp)
+{
+    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint64_t *idregs = cpu->isar.idregs;
+    uint64_t value, mask;
+    int lower = field->lower;
+    int upper = field->upper;
+    int length = upper - lower + 1;
+    int index = field->index;
+
+    mask = MAKE_64BIT_MASK(lower, length);
+    value = (idregs[index] & mask) >> lower;
+    visit_type_uint64(v, name, &value, errp);
+    trace_get_sysreg_prop(name, value);
+}
+
+/*
+ * decode_idreg_writemap: Generate props for writable fields
+ *
+ * @obj: CPU object
+ * @index: index of the sysreg
+ * @map: writable map for the sysreg
+ * @reg: description of the sysreg
+ */
+static int
+decode_idreg_writemap(Object *obj, int index, uint64_t map, ARM64SysReg *reg)
+{
+    int i = ctz64(map);
+    int nb_sysreg_props = 0;
+
+    while (map) {
+
+        ARM64SysRegField *field = get_field(i, reg);
+        int lower, upper;
+        uint64_t mask;
+        char *prop_name;
+
+        if (!field) {
+            /* the field cannot be matched to any know id named field */
+            warn_report("%s bit %d of %s is writable but cannot be matched",
+                        __func__, i, reg->name);
+            warn_report("%s is cpu-sysreg-properties.c up to date?", __func__);
+            map =  map & ~BIT_ULL(i);
+            i = ctz64(map);
+            continue;
+        }
+        lower = field->lower;
+        upper = field->upper;
+        prop_name = g_strdup_printf("SYSREG_%s_%s", reg->name, field->name);
+        trace_decode_idreg_writemap(field->name, lower, upper, prop_name);
+        object_property_add(obj, prop_name, "uint64",
+                            get_sysreg_prop, set_sysreg_prop, NULL, field);
+        nb_sysreg_props++;
+
+        mask = MAKE_64BIT_MASK(lower, upper - lower + 1);
+        map = map & ~mask;
+        i = ctz64(map);
+    }
+    trace_nb_sysreg_props(reg->name, nb_sysreg_props);
+    return 0;
+}
+
+/* analyze the writable mask and generate properties for writable fields */
+void kvm_arm_expose_idreg_properties(ARMCPU *cpu, ARM64SysReg *regs)
+{
+    int i, idx;
+    IdRegMap *map = cpu->writable_map;
+    Object *obj = OBJECT(cpu);
+
+    for (i = 0; i < NR_ID_REGS; i++) {
+        uint64_t mask = map->regs[i];
+
+        if (mask) {
+            /* reg @i has some writable fields, decode them */
+            idx = kvm_idx_to_idregs_idx(i);
+            if (idx < 0) {
+                /* no matching reg? */
+                warn_report("%s: reg %d writable, but not in list of idregs?",
+                            __func__, i);
+            } else {
+                decode_idreg_writemap(obj, i, mask, &regs[idx]);
+            }
+        }
+    }
+}
+
 static bool
 kvm_arm_get_host_cpu_features(ARMCPU *cpu, ARMHostCPUFeatures *ahcf,
                               bool exhaustive)
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 90ba4f7d8987..ba5de45f868c 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -157,6 +157,16 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu, bool exhaustive);
  */
 void kvm_arm_add_vcpu_properties(ARMCPU *cpu);
 
+typedef struct ARM64SysReg ARM64SysReg;
+/**
+ * kvm_arm_expose_idreg_properties:
+ * @cpu: The CPU object to generate the properties for
+ * @reg: registers from the host
+ *
+ * analyze the writable mask and generate properties for writable fields
+ */
+void kvm_arm_expose_idreg_properties(ARMCPU *cpu, ARM64SysReg *regs);
+
 /**
  * kvm_arm_steal_time_finalize:
  * @cpu: ARMCPU for which to finalize kvm-steal-time
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 955149ee1ac4..8d2a234d5272 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -15,3 +15,7 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
 get_host_cpu_idregs(const char *name, uint64_t value) "scratch vcpu host value for %s is 0x%"PRIx64
 kvm_arm_writable_idregs_to_cpreg_list(const char *name, uint64_t previous, uint64_t new) "%s overwrite default 0x%"PRIx64" with 0x%"PRIx64
+decode_idreg_writemap(const char* name, int lower, int upper, char *prop_name) "%s [%d:%d] is writable (prop %s)"
+get_sysreg_prop(const char *name, uint64_t value) "%s 0x%"PRIx64
+set_sysreg_prop(const char *name, uint64_t old, uint64_t mask, uint64_t field_value, uint64_t new) "%s old reg value=0x%"PRIx64" mask=0x%"PRIx64" new field value=0x%"PRIx64" new reg value=0x%"PRIx64
+nb_sysreg_props(const char *name, int count) "%s: %d SYSREG properties"
-- 
2.49.0


