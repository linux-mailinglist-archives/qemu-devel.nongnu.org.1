Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0CA768416
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 09:03:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ07x-00053u-Vd; Sun, 30 Jul 2023 02:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinahbaum123@gmail.com>)
 id 1qQ07P-00050l-0t
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 02:41:31 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dinahbaum123@gmail.com>)
 id 1qQ07M-00066o-Gb
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 02:41:30 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-63cffc0f95eso16881826d6.3
 for <qemu-devel@nongnu.org>; Sat, 29 Jul 2023 23:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690699287; x=1691304087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4xC9SK4eFIAvijamL/a+2Jh7rRmbMCpO3Jhz9tlLJNY=;
 b=p/WSoWRnAsrBS47sCRFptenMCwCWEyIfM31gqeV5DM0v/mMMyfW1CRoMLJasSEB7qL
 HABYCuJArRSOlJVdvNb8ssTdCaFfnaQQyuX3AD5NYyem1jt5Kd5CXEqDTzwCSCDo3Z0o
 fp75jS6ty0kY4mQTZONuA9m/9AoOgUCYj3koS10AwmUtAkdUk2FU2BvMVPp62RZTwkZ7
 un4JcQXsHOk+s6rq8MUj2STBKyO3+s6k/lCcgZtzLXtdzWiblww+KN9S1U30Py/73bb+
 QoL6iiJyR5bdJhT3n/uQdZ5vS1tGj6c6/jWBFE1DLigZqjxdXn7E+fqCd9heE1tBZZ5w
 ieAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690699287; x=1691304087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4xC9SK4eFIAvijamL/a+2Jh7rRmbMCpO3Jhz9tlLJNY=;
 b=g6KwhAPURpylJrF8SjI9v0RKguXM4eR243Ut8n4FxRS7WLLajyvL6BHrxnasTYrHD7
 bjwbxw+RRsvlrtjnyz3YuzpoN43TyLawTxxh29zP5x5KEz0Cx3ncpwiUo4ISRGeLo72v
 5aitUB+YtPozvAruJ+QQEuCY7RWaCRA8Q1yJ94zCUET0xC/YYCvPEEkjc/rSIK/tiNVd
 N2R38kudSPsqggFR78dFfCvmnXWWEwEkQmU0eEM2k8aYat2l6A/nuxzXLCUT3ke69ldn
 yNhwlyklv52YC5WzIQRAIO4jVt7PbaoyigUhW0pYlwiAUUtpfLNBJxiZi7r2zEKuS+5f
 TyRA==
X-Gm-Message-State: ABy/qLY9dPgAHZS16KvI44KkTDhej98lQn2gWmwaV5vZs/5k+llOoZhw
 ElpmmpvHOfQpXYrp37+m0vOJ5FRHqe8dRg==
X-Google-Smtp-Source: APBJJlGMK117OZ1wpxMMzDGzYOEaMCOl8l2er69tJGjviqGwhxssbu4pSWTB9cW0Sf2mP9obeO8ezg==
X-Received: by 2002:a05:620a:f15:b0:76c:5715:b45f with SMTP id
 v21-20020a05620a0f1500b0076c5715b45fmr7382944qkl.14.1690699286924; 
 Sat, 29 Jul 2023 23:41:26 -0700 (PDT)
Received: from debian.hsd1.ma.comcast.net ([2601:182:cc00:77b0::aecb])
 by smtp.gmail.com with ESMTPSA id
 oq7-20020a05620a610700b00767c961eb47sm2347254qkn.43.2023.07.29.23.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jul 2023 23:41:26 -0700 (PDT)
From: Dinah Baum <dinahbaum123@gmail.com>
To: qemu-devel@nongnu.org
Cc: Dinah Baum <dinahbaum123@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 3/3] cpu,
 softmmu/vl.c: Change parsing of -cpu argument to allow -cpu cpu,
 help to print options for the CPU type similar to how the '-device' option
 works.
Date: Sun, 30 Jul 2023 02:40:57 -0400
Message-Id: <20230730064057.357598-4-dinahbaum123@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230730064057.357598-1-dinahbaum123@gmail.com>
References: <20230730064057.357598-1-dinahbaum123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=dinahbaum123@gmail.com; helo=mail-qv1-xf36.google.com
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1480
Signed-off-by: Dinah Baum <dinahbaum123@gmail.com>

Signed-off-by: Dinah Baum <dinahbaum123@gmail.com>
---
 cpu.c                    | 41 ++++++++++++++++++++++++++++++++++++++++
 include/qapi/qmp/qdict.h |  1 +
 qemu-options.hx          |  7 ++++---
 qobject/qdict.c          |  5 +++++
 softmmu/vl.c             | 35 +++++++++++++++++++++++++++++++++-
 5 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/cpu.c b/cpu.c
index a99d09cd47..9971ffeeba 100644
--- a/cpu.c
+++ b/cpu.c
@@ -43,6 +43,10 @@
 #include "trace/trace-root.h"
 #include "qemu/accel.h"
 #include "qemu/plugin.h"
+#include "qemu/cutils.h"
+#include "qemu/qemu-print.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qobject.h"
 
 uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
@@ -312,6 +316,43 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     return get_cpu_model_expansion_info(type, model, errp);
 }
 
+void list_cpu_model_expansion(CpuModelExpansionType type,
+                              CpuModelInfo *model,
+                              Error **errp)
+{
+    CpuModelExpansionInfo *expansion_info;
+    QDict *qdict;
+    QDictEntry *qdict_entry;
+    const char *key;
+    QObject *obj;
+    QType q_type;
+    GPtrArray *array;
+    int i;
+    const char *type_name;
+
+    expansion_info = get_cpu_model_expansion_info(type, model, errp);
+    if (expansion_info) {
+        qdict = qobject_to(QDict, expansion_info->model->props);
+        if (qdict) {
+            qemu_printf("%s features:\n", model->name);
+            array = g_ptr_array_new();
+            for (qdict_entry = (QDictEntry *)qdict_first(qdict); qdict_entry;
+                 qdict_entry = (QDictEntry *)qdict_next(qdict, qdict_entry)) {
+                g_ptr_array_add(array, qdict_entry);
+            }
+            g_ptr_array_sort(array, (GCompareFunc)dict_key_compare);
+            for (i = 0; i < array->len; i++) {
+                qdict_entry = array->pdata[i];
+                key = qdict_entry_key(qdict_entry);
+                obj = qdict_get(qdict, key);
+                q_type = qobject_type(obj);
+                type_name = QType_str(q_type);
+                qemu_printf("  %s=<%s>\n", key, type_name);
+            }
+        }
+    }
+}
+
 #if defined(CONFIG_USER_ONLY)
 void tb_invalidate_phys_addr(hwaddr addr)
 {
diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index 82e90fc072..d0b6c3d358 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -67,5 +67,6 @@ bool qdict_get_try_bool(const QDict *qdict, const char *key, bool def_value);
 const char *qdict_get_try_str(const QDict *qdict, const char *key);
 
 QDict *qdict_clone_shallow(const QDict *src);
+int dict_key_compare(QDictEntry **entry1, QDictEntry **entry2);
 
 #endif /* QDICT_H */
diff --git a/qemu-options.hx b/qemu-options.hx
index 29b98c3d4c..e0f0284927 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -169,11 +169,12 @@ SRST
 ERST
 
 DEF("cpu", HAS_ARG, QEMU_OPTION_cpu,
-    "-cpu cpu        select CPU ('-cpu help' for list)\n", QEMU_ARCH_ALL)
+    "-cpu cpu        select CPU ('-cpu help' for list)\n"
+    "                use '-cpu cpu,help' to print possible properties\n", QEMU_ARCH_ALL)
 SRST
 ``-cpu model``
-    Select CPU model (``-cpu help`` for list and additional feature
-    selection)
+    Select CPU model (``-cpu help`` and ``-cpu cpu,help``) for list and additional feature
+    selection
 ERST
 
 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 8faff230d3..31407e62f6 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -447,3 +447,8 @@ void qdict_unref(QDict *q)
 {
     qobject_unref(q);
 }
+
+int dict_key_compare(QDictEntry **entry1, QDictEntry **entry2)
+{
+    return g_strcmp0(qdict_entry_key(*entry1), qdict_entry_key(*entry2));
+}
diff --git a/softmmu/vl.c b/softmmu/vl.c
index b0b96f67fa..1fd87f2c06 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -501,6 +501,15 @@ static QemuOptsList qemu_action_opts = {
     },
 };
 
+static QemuOptsList qemu_cpu_opts = {
+    .name = "cpu",
+    .implied_opt_name = "cpu",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_cpu_opts.head),
+    .desc = {
+        { /* end of list */ }
+    },
+};
+
 const char *qemu_get_vm_name(void)
 {
     return qemu_name;
@@ -1159,6 +1168,26 @@ static int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
     return 0;
 }
 
+static int cpu_help_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    CpuModelInfo *model;
+
+    if (cpu_option && is_help_option(cpu_option)) {
+        list_cpus();
+        return 1;
+    }
+
+    if (!cpu_option || !qemu_opt_has_help_opt(opts)) {
+        return 0;
+    }
+
+    model = g_new0(CpuModelInfo, 1);
+    model->name = (char *)qemu_opt_get(opts, "cpu");
+    /* TODO: handle other expansion cases */
+    list_cpu_model_expansion(CPU_MODEL_EXPANSION_TYPE_FULL, model, errp);
+    return 1;
+}
+
 static int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     Error *local_err = NULL;
@@ -2466,7 +2495,9 @@ static void qemu_process_help_options(void)
         list_cpus();
         exit(0);
     }
-
+    if (qemu_opts_foreach(qemu_find_opts("cpu"), cpu_help_func, NULL, NULL)) {
+        exit(0);
+    }
     if (qemu_opts_foreach(qemu_find_opts("device"),
                           device_help_func, NULL, NULL)) {
         exit(0);
@@ -2704,6 +2735,7 @@ void qemu_init(int argc, char **argv)
     qemu_add_opts(&qemu_semihosting_config_opts);
     qemu_add_opts(&qemu_fw_cfg_opts);
     qemu_add_opts(&qemu_action_opts);
+    qemu_add_opts(&qemu_cpu_opts);
     module_call_init(MODULE_INIT_OPTS);
 
     error_init(argv[0]);
@@ -2755,6 +2787,7 @@ void qemu_init(int argc, char **argv)
             switch(popt->index) {
             case QEMU_OPTION_cpu:
                 /* hw initialization will check this */
+                qemu_opts_parse_noisily(qemu_find_opts("cpu"), optarg, true);
                 cpu_option = optarg;
                 break;
             case QEMU_OPTION_hda:
-- 
2.30.2


