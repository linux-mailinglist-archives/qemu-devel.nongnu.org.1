Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80339930F6F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jul 2024 10:18:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTGug-00041i-N3; Mon, 15 Jul 2024 04:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.hamelin@grenoble-inp.org>)
 id 1sTGue-0003wW-8J
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:18:24 -0400
Received: from smtpout02-ext4.partage.renater.fr ([194.254.241.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.hamelin@grenoble-inp.org>)
 id 1sTGuZ-0007LV-KR
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:18:24 -0400
Received: from zmtaauth06.partage.renater.fr (zmtaauth06.partage.renater.fr
 [194.254.241.27])
 by smtpout20.partage.renater.fr (Postfix) with ESMTP id 326FFBFC02;
 Mon, 15 Jul 2024 10:18:08 +0200 (CEST)
Received: from zmtaauth06.partage.renater.fr (localhost [127.0.0.1])
 by zmtaauth06.partage.renater.fr (Postfix) with ESMTPS id 33E0E100194;
 Mon, 15 Jul 2024 10:17:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zmtaauth06.partage.renater.fr (Postfix) with ESMTP id 20C0C1001A6;
 Mon, 15 Jul 2024 10:17:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth06.partage.renater.fr 20C0C1001A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenoble-inp.org;
 s=F42A61D9-9621-4693-8E8E-830FB5F1ED6E; t=1721031454;
 bh=1u9im9PrwYwyWlZIDOInFL03bfdVzVDsSBcIqEzvq00=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=BFmzafK5Z/j+J/Aa6NnSQD/TMwByMQmmofDT3j5qNdq6xWf52BbH22eZkWTB8O0Ck
 KBnihNLDB5PR3BJAFZ/2XpI7w7t3KIQ1qvdL5atjhzUnEEXE074A6Rdht0Ne0zKf5R
 bVL3pYtMUGlBrvPDlLu7mJHXFs316NmmQ005O/XvtMAK7QA6G5zMF+DQwUjZQtXsJV
 h/rzxqNzrciI6HvEoYH3KDQ8W0ZBXy8gYplNF+2jv99J60SYHfH6+FPs4RHCwZ7TvX
 VExeb2iiyM7GzzEfUtF24Y7XwfQr5Fx0tcHtFqVj6Pq4TJqDDAKz4ZOqAHAVivAcFc
 8C8y7zkUqSf2g==
Received: from zmtaauth06.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaauth06.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 5MVNv1CTfGZw; Mon, 15 Jul 2024 10:17:34 +0200 (CEST)
Received: from 188.231.11.184 (unknown [194.254.241.249])
 by zmtaauth06.partage.renater.fr (Postfix) with ESMTPA id AD0E5100194;
 Mon, 15 Jul 2024 10:17:33 +0200 (CEST)
From: Simon Hamelin <simon.hamelin@grenoble-inp.org>
To: qemu-devel@nongnu.org
Cc: Simon Hamelin <simon.hamelin@grenoble-inp.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4] plugins/stoptrigger: TCG plugin to stop execution under
 conditions
Date: Mon, 15 Jul 2024 10:15:22 +0200
Message-ID: <20240715081521.19122-2-simon.hamelin@grenoble-inp.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.8 at clamav01
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: -100
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedvgddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucftgffptefvgfftnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuihhmohhnucfjrghmvghlihhnuceoshhimhhonhdrhhgrmhgvlhhinhesghhrvghnohgslhgvqdhinhhprdhorhhgqeenucggtffrrghtthgvrhhnpedttdduiefgtdelfeehuedtvdeuudekhffhffekudekhfdtudelffdvgeetleetfeenucfkphepudelgedrvdehgedrvdeguddrvdegleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleegrddvheegrddvgedurddvgeelpdhhvghlohepudekkedrvdefuddruddurddukeegpdhmrghilhhfrhhomhepshhimhhonhdrhhgrmhgvlhhinhesghhrvghnohgslhgvqdhinhhprdhorhhgpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehsihhmohhnrdhhrghmvghlihhnsehgrhgvnhhosghlvgdqihhnphdrohhrghdprhgtphhtthhopegvrhgunhgrgigvsegtrhgrnhhsrdhorhhgpdhrtghpthhtoheprghlvgigrdgsvghnnhgvvgeslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhgrrdhmrghnughouhhrrhesghhm
 rghilhdrtghomhdprhgtphhtthhopehpihgvrhhrihgtkhdrsghouhhvihgvrheslhhinhgrrhhordhorhhg
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=194.254.241.31;
 envelope-from=simon.hamelin@grenoble-inp.org;
 helo=smtpout02-ext4.partage.renater.fr
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_HELO_IP_MISMATCH=2.368, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

This new plugin allows to stop emulation using conditions on the
emulation state. By setting this plugin arguments, it is possible
to set an instruction count limit and/or trigger address(es) to stop at.
The code returned at emulation exit can be customized.

This plugin demonstrates how someone could stop QEMU execution.
It could be used for research purposes to launch some code and
deterministically stop it and understand where its execution flow went.

Co-authored-by: Alexandre Iooss <erdnaxe@crans.org>
Signed-off-by: Simon Hamelin <simon.hamelin@grenoble-inp.org>
Signed-off-by: Alexandre Iooss <erdnaxe@crans.org>
---
v2:
  - use a scoreboard for counting instructions
  - no longer hook each instruction to exit at given address
  - add `exit_emulation` function for future use case such as stopping th=
e VM or triggering a gdbstub exception

v3:
  - add missing glib include
  - refactor code to print exit address when icount is reached

v4:
  - remove unnecessary lock

 contrib/plugins/Makefile      |   1 +
 contrib/plugins/stoptrigger.c | 151 ++++++++++++++++++++++++++++++++++
 docs/devel/tcg-plugins.rst    |  22 +++++
 3 files changed, 174 insertions(+)
 create mode 100644 contrib/plugins/stoptrigger.c

diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index 449ead1130..98a89d5c40 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -28,6 +28,7 @@ NAMES +=3D hwprofile
 NAMES +=3D cache
 NAMES +=3D drcov
 NAMES +=3D ips
+NAMES +=3D stoptrigger
=20
 ifeq ($(CONFIG_WIN32),y)
 SO_SUFFIX :=3D .dll
diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.=
c
new file mode 100644
index 0000000000..03ee22f4c6
--- /dev/null
+++ b/contrib/plugins/stoptrigger.c
@@ -0,0 +1,151 @@
+/*
+ * Copyright (C) 2024, Simon Hamelin <simon.hamelin@grenoble-inp.org>
+ *
+ * Stop execution once a given address is reached or if the
+ * count of executed instructions reached a specified limit
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+
+#include <assert.h>
+#include <glib.h>
+#include <inttypes.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
+
+/* Scoreboard to track executed instructions count */
+typedef struct {
+    uint64_t insn_count;
+} InstructionsCount;
+static struct qemu_plugin_scoreboard *insn_count_sb;
+static qemu_plugin_u64 insn_count;
+
+static uint64_t icount;
+static int icount_exit_code;
+
+static bool exit_on_icount;
+static bool exit_on_address;
+
+/* Map trigger addresses to exit code */
+static GHashTable *addrs_ht;
+
+static void exit_emulation(int return_code, char *message)
+{
+    qemu_plugin_outs(message);
+    g_free(message);
+    exit(return_code);
+}
+
+static void exit_icount_reached(unsigned int cpu_index, void *udata)
+{
+    uint64_t insn_vaddr =3D GPOINTER_TO_UINT(udata);
+    char *msg =3D g_strdup_printf("icount reached at 0x%" PRIx64 ", exit=
ing\n",
+                                insn_vaddr);
+
+    exit_emulation(icount_exit_code, msg);
+}
+
+static void exit_address_reached(unsigned int cpu_index, void *udata)
+{
+    uint64_t insn_vaddr =3D GPOINTER_TO_UINT(udata);
+    char *msg =3D g_strdup_printf("0x%" PRIx64 " reached, exiting\n", in=
sn_vaddr);
+    int exit_code;
+
+    exit_code =3D GPOINTER_TO_INT(
+        g_hash_table_lookup(addrs_ht, GUINT_TO_POINTER(insn_vaddr)));
+
+    exit_emulation(exit_code, msg);
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb=
)
+{
+    size_t tb_n =3D qemu_plugin_tb_n_insns(tb);
+    for (size_t i =3D 0; i < tb_n; i++) {
+        struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, i)=
;
+        gpointer insn_vaddr =3D GUINT_TO_POINTER(qemu_plugin_insn_vaddr(=
insn));
+
+        if (exit_on_icount) {
+            /* Increment and check scoreboard for each instruction */
+            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+                insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
+            qemu_plugin_register_vcpu_insn_exec_cond_cb(
+                insn, exit_icount_reached, QEMU_PLUGIN_CB_NO_REGS,
+                QEMU_PLUGIN_COND_EQ, insn_count, icount + 1, insn_vaddr)=
;
+        }
+
+        if (exit_on_address) {
+            if (g_hash_table_contains(addrs_ht, insn_vaddr)) {
+                /* Exit triggered by address */
+                qemu_plugin_register_vcpu_insn_exec_cb(
+                    insn, exit_address_reached, QEMU_PLUGIN_CB_NO_REGS,
+                    insn_vaddr);
+            }
+        }
+    }
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    g_hash_table_destroy(addrs_ht);
+    qemu_plugin_scoreboard_free(insn_count_sb);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info, int =
argc,
+                                           char **argv)
+{
+    addrs_ht =3D g_hash_table_new(NULL, g_direct_equal);
+
+    insn_count_sb =3D qemu_plugin_scoreboard_new(sizeof(InstructionsCoun=
t));
+    insn_count =3D qemu_plugin_scoreboard_u64_in_struct(
+        insn_count_sb, InstructionsCount, insn_count);
+
+    for (int i =3D 0; i < argc; i++) {
+        char *opt =3D argv[i];
+        g_auto(GStrv) tokens =3D g_strsplit(opt, "=3D", 2);
+        if (g_strcmp0(tokens[0], "icount") =3D=3D 0) {
+            g_auto(GStrv) icount_tokens =3D g_strsplit(tokens[1], ":", 2=
);
+            icount =3D g_ascii_strtoull(icount_tokens[0], NULL, 0);
+            if (icount < 1 || g_strrstr(icount_tokens[0], "-") !=3D NULL=
) {
+                fprintf(stderr,
+                        "icount parsing failed: '%s' must be a positive =
"
+                        "integer\n",
+                        icount_tokens[0]);
+                return -1;
+            }
+            if (icount_tokens[1]) {
+                icount_exit_code =3D g_ascii_strtoull(icount_tokens[1], =
NULL, 0);
+            }
+            exit_on_icount =3D true;
+        } else if (g_strcmp0(tokens[0], "addr") =3D=3D 0) {
+            g_auto(GStrv) addr_tokens =3D g_strsplit(tokens[1], ":", 2);
+            uint64_t exit_addr =3D g_ascii_strtoull(addr_tokens[0], NULL=
, 0);
+            int exit_code =3D 0;
+            if (addr_tokens[1]) {
+                exit_code =3D g_ascii_strtoull(addr_tokens[1], NULL, 0);
+            }
+            g_hash_table_insert(addrs_ht, GUINT_TO_POINTER(exit_addr),
+                                GINT_TO_POINTER(exit_code));
+            exit_on_address =3D true;
+        } else {
+            fprintf(stderr, "option parsing failed: %s\n", opt);
+            return -1;
+        }
+    }
+
+    if (!exit_on_icount && !exit_on_address) {
+        fprintf(stderr, "'icount' or 'addr' argument missing\n");
+        return -1;
+    }
+
+    /* Register translation block and exit callbacks */
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+
+    return 0;
+}
diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index f7d7b9e3a4..954623f9bf 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -642,6 +642,28 @@ The plugin has a number of arguments, all of them ar=
e optional:
   configuration arguments implies ``l2=3Don``.
   (default: N =3D 2097152 (2MB), B =3D 64, A =3D 16)
=20
+- contrib/plugins/stoptrigger.c
+
+The stoptrigger plugin allows to setup triggers to stop emulation.
+It can be used for research purposes to launch some code and precisely s=
top it
+and understand where its execution flow went.
+
+Two types of triggers can be configured: a count of instructions to stop=
 at,
+or an address to stop at. Multiple triggers can be set at once.
+
+By default, QEMU will exit with return code 0. A custom return code can =
be
+configured for each trigger using ``:CODE`` syntax.
+
+For example, to stop at the 20-th instruction with return code 41, at ad=
dress
+0xd4 with return code 0 or at address 0xd8 with return code 42::
+
+  $ qemu-system-aarch64 $(QEMU_ARGS) \
+    -plugin ./contrib/plugins/libstoptrigger.so,icount=3D20:41,addr=3D0x=
d4,addr=3D0xd8:42 -d plugin
+
+The plugin will log the reason of exit, for example::
+
+  0xd4 reached, exiting
+
 Plugin API
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
--=20
2.43.0


