Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9D381B3F8
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 11:42:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGGSV-0004eZ-JZ; Thu, 21 Dec 2023 05:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGS5-0004Cr-3J
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:53 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRp-0004Ew-Qb
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:52 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40d3c4bfe45so6370425e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 02:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703155116; x=1703759916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7b3xpykHeaHl4suIRJtcydNJ+7RVLNIDOZxUbbJygc=;
 b=G+ehFBDRblj27olzj/NwUs8DEHsY2/yLQA6gHtsOmWYL9CWlXzf9FUlGI3eHkJm4uL
 CGPomfWqu+BccyDFVRKiaG8nhforXPm7LhvIwsJfYzDrNHWLIDAmV/rbPebq4Ndb7mSz
 hG9BnYImz6dCL0vk4fYnsmm+aY1ojJRn3aFhcfdMRjkT2QNfT0OvfQWuag46/KGtV0nB
 fkuHSeGxJJAmY0FZprhlbynYsy0lYAvon8o68WdT81n2fERW/GEmWYiDWdZ9dK4nxvhY
 hv+syRnPkx0ED0VG6ngOpGUHSA/NGtZHJA/q9Ky5Adpet45qAIAcHRb5hm/50zFDoakJ
 +PTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703155116; x=1703759916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7b3xpykHeaHl4suIRJtcydNJ+7RVLNIDOZxUbbJygc=;
 b=WLCYjwQkEOmNkU89imyyQwdCA/tvO0sD6aVArUJwvKycl1fXisO6ffMg9ueBZsdp/P
 vFBRZa/RRq4w8yTP8b8fXSx5waZS7hTqPyVyeIVxJAF9EUgD0R0lWbU0aRM+q4jmHxHo
 Hj5qdYvZVS8kH7veKhp2cbI65ZbYBLbB0kRXu95T7PiVn6Qmmj62/r4SKlLmh3+Smkun
 aEkLT+cQWH81i9kHoD1AFvJJhzCFG7DEhNNLHwOd7kQhj1N++u7BkBy8BnTqBZ8FGDJM
 7wzVkq/5nPhdjd5j5t4E26MpTZl6LEbgUBVn22wyx1TKXlvZT7F28DcKG3MO3IHGnNRs
 2XUw==
X-Gm-Message-State: AOJu0Yx7Fhv0rHpBWGHaKRIXRoz74+gOGAX12TIel7jDrRf7DvZhzhOS
 5wRbVpxmKAWqzjxvJKHdz6aNPw==
X-Google-Smtp-Source: AGHT+IEJFY0TNegQ8gBMNwMdtMslj8hcG5HCGVOLNYH0SVe7ysLZ/5iwVMZ21AIB7D29i8FeQJ3Aqg==
X-Received: by 2002:a05:600c:a01b:b0:40d:382b:cc2b with SMTP id
 jg27-20020a05600ca01b00b0040d382bcc2bmr281573wmb.326.1703155116107; 
 Thu, 21 Dec 2023 02:38:36 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l4-20020a05600c1d0400b0040d3276ba19sm2796728wms.25.2023.12.21.02.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 02:38:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A72A25F909;
 Thu, 21 Dec 2023 10:38:22 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Brian Cain <bcain@quicinc.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-s390x@nongnu.org,
 David Woodhouse <dwmw2@infradead.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 36/40] gdbstub: expose api to find registers
Date: Thu, 21 Dec 2023 10:38:14 +0000
Message-Id: <20231221103818.1633766-37-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221103818.1633766-1-alex.bennee@linaro.org>
References: <20231221103818.1633766-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Expose an internal API to QEMU to return all the registers for a vCPU.
The list containing the details required to called gdb_read_register().

Based-on: <20231025093128.33116-15-akihiko.odaki@daynix.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - just make gdb_get_register_list return everything for a vCPU

vAJB:

This principle difference is the find registers is a single call which
can return a) multiple registers and b) is agnostic to the gdb
feature. This is because I haven't so far found any duplicate
registers in the system so I thing the regname by itself should be
enough. However I do expose the gdb feature name in case the caller
wants to do some additional filtering.
---
 include/exec/gdbstub.h | 47 +++++++++++++++++++++++++++++++++++
 gdbstub/gdbstub.c      | 56 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index da9ddfe54c5..7bddea8259e 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -111,6 +111,53 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
  */
 const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
+/**
+ * gdb_find_feature() - Find a feature associated with a CPU.
+ * @cpu: The CPU associated with the feature.
+ * @name: The feature's name.
+ *
+ * Return: The feature's number.
+ */
+int gdb_find_feature(CPUState *cpu, const char *name);
+
+/**
+ * gdb_find_feature_register() - Find a register associated with a CPU.
+ * @cpu: The CPU associated with the register.
+ * @feature: The feature's number returned by gdb_find_feature().
+ * @name: The register's name.
+ *
+ * Return: The register's number.
+ */
+int gdb_find_feature_register(CPUState *cpu, int feature, const char *name);
+
+/**
+ * gdb_read_register() - Read a register associated with a CPU.
+ * @cpu: The CPU associated with the register.
+ * @buf: The buffer that the read register will be appended to.
+ * @reg: The register's number returned by gdb_find_feature_register().
+ *
+ * Return: The number of read bytes.
+ */
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+
+/**
+ * typedef GDBRegDesc - a register description from gdbstub
+ */
+typedef struct {
+    int gdb_reg;
+    const char *name;
+    const char *feature_name;
+} GDBRegDesc;
+
+/**
+ * gdb_get_register_list() - Return list of all registers for CPU
+ * @cpu: The CPU being searched
+ *
+ * Returns a GArray of GDBRegDesc, caller frees array but not the
+ * const strings.
+ */
+GArray *gdb_get_register_list(CPUState *cpu);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 420ab2a3766..b0230138246 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -490,7 +490,61 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname)
     g_assert_not_reached();
 }
 
-static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
+int gdb_find_feature(CPUState *cpu, const char *name)
+{
+    GDBRegisterState *r;
+
+    for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+        r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+        if (!strcmp(name, r->feature->name)) {
+            return i;
+        }
+    }
+
+    return -1;
+}
+
+int gdb_find_feature_register(CPUState *cpu, int feature, const char *name)
+{
+    GDBRegisterState *r;
+
+    r = &g_array_index(cpu->gdb_regs, GDBRegisterState, feature);
+
+    for (int i = 0; i < r->feature->num_regs; i++) {
+        if (r->feature->regs[i] && !strcmp(name, r->feature->regs[i])) {
+            return r->base_reg + i;
+        }
+    }
+
+    return -1;
+}
+
+GArray *gdb_get_register_list(CPUState *cpu)
+{
+    GArray *results = g_array_new(true, true, sizeof(GDBRegDesc));
+
+    /* registers are only available once the CPU is initialised */
+    if (!cpu->gdb_regs) {
+        return results;
+    }
+
+    for (int f = 0; f < cpu->gdb_regs->len; f++) {
+        GDBRegisterState *r = &g_array_index(cpu->gdb_regs, GDBRegisterState, f);
+        for (int i = 0; i < r->feature->num_regs; i++) {
+            const char *name = r->feature->regs[i];
+            GDBRegDesc desc = {
+                r->base_reg + i,
+                name,
+                r->feature->name
+            };
+            g_array_append_val(results, desc);
+        }
+    }
+
+    return results;
+}
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     GDBRegisterState *r;
-- 
2.39.2


