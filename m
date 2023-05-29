Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6879714F51
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 20:21:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3hU5-0007fV-Kg; Mon, 29 May 2023 14:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1q3hU3-0007ex-J0
 for qemu-devel@nongnu.org; Mon, 29 May 2023 14:20:43 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1q3hU1-0001C6-Uf
 for qemu-devel@nongnu.org; Mon, 29 May 2023 14:20:43 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-75b17aa343dso199241485a.3
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1685384440; x=1687976440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ditkvgARSzWzoYJqFtP0/VdEyM3sOS6PtcRTcUcchLI=;
 b=eWuQNrm4dGht6EAPLOgFBFWtQXqsYOFvVhdMAgTLxTYCN6zdlZOVf5SwGWDhxH6gpO
 JCmDzKO7yN6xheOIVCVL2RphlyoQUNBMiqyjDqDI5nmim4DIRHDhl1lzfpvK9itjJ2Mh
 yFuLYCOtfjdqP+QCh5RcNwSUHINMiT4f2GakZkk7BtvEBg/Hvsv2/1YMGjy9Jmn3O65j
 ATwCTMjsSS1fmcpuF9+qmU7KNiED5bpZ95+qHUCW0/52HEfCjJ0HfyQfN5yutx6cARyp
 1K4LCXHiQjIZ7QPdzQy3tptbmoqUgWWTQKT5makOFjBfj0tH/0PR0jvrWJ4Ov/RrALfK
 6waA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685384440; x=1687976440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ditkvgARSzWzoYJqFtP0/VdEyM3sOS6PtcRTcUcchLI=;
 b=Rn3j8RSByAR8waRoOtV7gXWeXv+tejhx49zlU0g49z8O08S67/Qy0HC4Wluvnk/wEz
 vuL5io1ssF4MlvXnruxJq+ALOCEt+ierf8S0vzmSD4U6GOjx+z2DVZwAonHReFmLwVeO
 x7WZ6j3gqAOn+ZD0Aroe+oL/tXFyt6RmuHp0RWSGR6bgfzaLkR2CIf+4/b6wgN+YxxCn
 YM1fmHjFBVZ/d6kQAxaXYNawNSKhKjsSdK363W2+O3Dq5LfO1eM1PHQqpLEhqw/MnhQD
 CedXbs3aHlbs+vfp32+E4TOiBO/XKqhIZsG8Qh6+dt6ULQ5qfQIiVMFVpM/7SXL/ki8X
 rppQ==
X-Gm-Message-State: AC+VfDyusB4rFcqhs+PpLyo1i6Q5OsnkZkziKAgcc4xDcq+iT44JOPat
 xoNm5b5pGkUIUMvV5AYqEudCUA==
X-Google-Smtp-Source: ACHHUZ6BWGYkuDCOOzv0A45ehuwwKyXCMSglKeIiR1qhOihyFCgZler6X7EWmWf/FQ8xfJzl/2TCdA==
X-Received: by 2002:a05:620a:3c16:b0:75b:23a1:8332 with SMTP id
 tn22-20020a05620a3c1600b0075b23a18332mr7938039qkn.45.1685384440475; 
 Mon, 29 May 2023 11:20:40 -0700 (PDT)
Received: from n231-230-216.byted.org ([147.160.184.95])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a05620a126f00b0074e3cf3b44dsm2873314qkl.125.2023.05.29.11.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 May 2023 11:20:40 -0700 (PDT)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com,
	quintela@redhat.com,
	qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 4/4] Add QEMU command line argument to enable DSA offloading.
Date: Mon, 29 May 2023 18:20:01 +0000
Message-Id: <20230529182001.2232069-5-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230529182001.2232069-1-hao.xiang@bytedance.com>
References: <20230529182001.2232069-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This change adds a new argument --dsa-accelerate to qemu.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 qemu-options.hx                      | 10 ++++++++++
 softmmu/runstate.c                   |  4 ++++
 softmmu/vl.c                         | 22 ++++++++++++++++++++++
 storage-daemon/qemu-storage-daemon.c |  2 ++
 4 files changed, 38 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index b37eb9662b..29491ee691 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4890,6 +4890,16 @@ SRST
         otherwise the option is ignored. Default is off.
 ERST
 
+DEF("dsa-accelerate", HAS_ARG, QEMU_OPTION_dsa,
+    "-dsa-accelerate <file>\n"
+    "                Use Intel Data Streaming Accelerator for certain QEMU\n"
+    "                operations, eg, checkpoint.\n",
+    QEMU_ARCH_I386)
+SRST
+``-dsa-accelerate path``
+    The device path to a DSA accelerator.
+ERST
+
 DEF("dump-vmstate", HAS_ARG, QEMU_OPTION_dump_vmstate,
     "-dump-vmstate <file>\n"
     "                Output vmstate information in JSON format to file.\n"
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index 2f2396c819..1f938e192f 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -41,6 +41,7 @@
 #include "qapi/qapi-commands-run-state.h"
 #include "qapi/qapi-events-run-state.h"
 #include "qemu/accel.h"
+#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/job.h"
 #include "qemu/log.h"
@@ -834,6 +835,9 @@ void qemu_cleanup(void)
     tpm_cleanup();
     net_cleanup();
     audio_cleanup();
+
+    dsa_cleanup();
+
     monitor_cleanup();
     qemu_chr_cleanup();
     user_creatable_cleanup();
diff --git a/softmmu/vl.c b/softmmu/vl.c
index b0b96f67fa..8ace491183 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -161,6 +161,7 @@ static const char *mem_path;
 static const char *incoming;
 static const char *loadvm;
 static const char *accelerators;
+static const char *dsa_path;
 static bool have_custom_ram_size;
 static const char *ram_memdev_id;
 static QDict *machine_opts_dict;
@@ -373,6 +374,20 @@ static QemuOptsList qemu_msg_opts = {
     },
 };
 
+static QemuOptsList qemu_dsa_opts = {
+    .name = "dsa-accelerate",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_dsa_opts.head),
+    .desc = {
+        {
+            .name = "device",
+            .type = QEMU_OPT_STRING,
+            .help = "The device path to DSA accelerator used for certain "
+                    "QEMU operations, eg, checkpoint\n",
+        },
+        { /* end of list */ }
+    },
+};
+
 static QemuOptsList qemu_name_opts = {
     .name = "name",
     .implied_opt_name = "guest",
@@ -2704,6 +2719,7 @@ void qemu_init(int argc, char **argv)
     qemu_add_opts(&qemu_semihosting_config_opts);
     qemu_add_opts(&qemu_fw_cfg_opts);
     qemu_add_opts(&qemu_action_opts);
+    qemu_add_opts(&qemu_dsa_opts);
     module_call_init(MODULE_INIT_OPTS);
 
     error_init(argv[0]);
@@ -3504,6 +3520,12 @@ void qemu_init(int argc, char **argv)
                 }
                 configure_msg(opts);
                 break;
+            case QEMU_OPTION_dsa:
+                dsa_path = optarg;
+                if (configure_dsa(dsa_path)) {
+                    exit(1);
+                }
+                break;
             case QEMU_OPTION_dump_vmstate:
                 if (vmstate_dump_file) {
                     error_report("only one '-dump-vmstate' "
diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index 0e9354faa6..0e4375407a 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -439,6 +439,8 @@ int main(int argc, char *argv[])
     job_cancel_sync_all();
     bdrv_close_all();
 
+    dsa_cleanup();
+
     monitor_cleanup();
     qemu_chr_cleanup();
     user_creatable_cleanup();
-- 
2.30.2


