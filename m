Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 043B9836670
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 16:02:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRvo3-00087Z-21; Mon, 22 Jan 2024 10:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRvnv-0007jF-Ab
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:01:39 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRvnn-0001lx-4Y
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:01:38 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40eaf3528c8so7312885e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 07:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705935689; x=1706540489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L7VOplgsBBAgAtEJeAgTFkF54S4NCVefHHQnrnHK8t0=;
 b=AeXivKSIoxzxKpSA5sDZUPsObI+mOKI6PtGCp/2+NCKKUp6/qasomAmjU47aa7LGwR
 rV/MqzpdLGHcEQk4bm67pbfE2Ca7EKP3EOrT+akQnEsOvR6t5huLkfPhSV3Ll87uTjJP
 cBzift88zp7T7Og8YUvkFyHROsvUIYzjLOMma6MxoGyu5MacDBwp09hgVleVe1tN31Pf
 cocfTKjFfSGYW3rM/tdf0oOPGOA4XWfY04r2B0EnoVczTbxz5RSMrZdef/algMQqoKhn
 o14wNHaYls1Z02ZgXTp0rXegaTap90mnZyWJ999oi1vZZNeEo804Ql/O9KfH7UNgA7UE
 wVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705935689; x=1706540489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L7VOplgsBBAgAtEJeAgTFkF54S4NCVefHHQnrnHK8t0=;
 b=WyQ3iRxzIxKscXJpFQkvplMn2q4ji6VWOiBgXB2xjjKanu/f6fbabWTEdqYBb93HpA
 dpxSzZIhwfVxO8KMHmkrmLs/PnZ+I+bdX21v+XYB8TUTiUaYLFbblbMJ4WCQVBxdx3OO
 VyLLNQWYEI5ECrFWfg2BPmzbkLyGIYQw7kgcqewDFjJfwZ18ntWEJQc6ICs3g/aRQVp2
 JMC8e0IIrsErLOhFPw+EgUdKPhGqzPlVY8G1Y1etqD8RWDJsVoEuCEMr2dpd5L/tPdRK
 5AUqUH9HQ4VPkR8DnPbhXC0n8NpHGj3wLmuiHbQEb32imf9kj7FPB49w9ECMz9mUED4n
 fJcA==
X-Gm-Message-State: AOJu0YzM/lKvav4obueg0oBDNHiS4zmkLJ1XP+Mm/x9S+Toj7O6Sgkpz
 dJsi6+22E8VUqSkGG5obQPKCelUyYEYwpLDAZ4TBZMqtZxldQ2gTZoHpS4tdkc0=
X-Google-Smtp-Source: AGHT+IFxNTPr8NUI2fFrYkNhQafasrORn8JAkp9EvucZOYRV+FHSy9wjv9TICupAQqM47gPf+Jni/Q==
X-Received: by 2002:a05:600c:154c:b0:40d:7f19:40b1 with SMTP id
 f12-20020a05600c154c00b0040d7f1940b1mr2366763wmg.169.1705935688882; 
 Mon, 22 Jan 2024 07:01:28 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 s15-20020a5d6a8f000000b00336898daceasm11699962wru.96.2024.01.22.07.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 07:01:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AC7E75F936;
 Mon, 22 Jan 2024 14:56:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, kvm@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Laurent Vivier <laurent@vivier.eu>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, John Snow <jsnow@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 David Woodhouse <dwmw2@infradead.org>, Cleber Rosa <crosa@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Nicholas Piggin <npiggin@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Eduardo Habkost <eduardo@habkost.net>, Brian Cain <bcain@quicinc.com>,
 Paul Durrant <paul@xen.org>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 16/21] gdbstub: expose api to find registers
Date: Mon, 22 Jan 2024 14:56:05 +0000
Message-Id: <20240122145610.413836-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122145610.413836-1-alex.bennee@linaro.org>
References: <20240122145610.413836-1-alex.bennee@linaro.org>
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
Message-Id: <20240103173349.398526-38-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - rm unused api functions left over
---
 include/exec/gdbstub.h | 28 ++++++++++++++++++++++++++++
 gdbstub/gdbstub.c      | 27 ++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index da9ddfe54c5..eb14b91139b 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -111,6 +111,34 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
  */
 const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
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
index 420ab2a3766..14f2f32e63f 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -490,7 +490,32 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname)
     g_assert_not_reached();
 }
 
-static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
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


