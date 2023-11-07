Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA137E387C
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:11:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J3P-0005n9-Tq; Tue, 07 Nov 2023 05:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J3N-0005gl-PY
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J3L-0002YT-Px
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qifpv3aNAIEISwFz81bmMK6pnQ3IauyLXcDLRV+33ZY=;
 b=ZqQzk+0yphGquV04jz+Yy+Gbz49oWai1W3Rac7EhliSyE89TawJP4FWToy7bzLd2SZzK7t
 9Xz6onJtwojcYZSV+ZjlKLp1yoHJWDAs5K49MsIn+C/o0CVtHCD4Im5Ty6NSDuzp/A/+LQ
 uu7tmwwP2ougpa071Sfn2kek3zZY9yk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-J603MWHLN_eUFY9kNcdLSg-1; Tue, 07 Nov 2023 05:11:21 -0500
X-MC-Unique: J603MWHLN_eUFY9kNcdLSg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5079fe7cc7cso6345354e87.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351880; x=1699956680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qifpv3aNAIEISwFz81bmMK6pnQ3IauyLXcDLRV+33ZY=;
 b=wIfGX3a0v8LEdqgxYHMq7UrvPYrGCqaNl0cIMyLHBf+iy/VnnHeOWQXhgMie/1tIuf
 eTQsgxm7MPTDm9u9VkZB64Aor/6kvslhy/YgXt8tIqs/uulUzmidp0azcI1YH38NyBYQ
 H3x95zsRiOSUtiNc7vk9et8RQUdmVipVa7tbYVWwzMBbxDWyo2NOzJjit88tekw+sSai
 iF66jXXWvgZVfMcA38mAJP6m0OR613qjqepMq3fE9pWtGnRIp8Xa9+zVX4oJ53d3pdtk
 hz9bw0PW+Fot4aGJ86C//1TUH9+eSBQ2SqdRzq055ZCCSH2CK9yQDDxXzb095S6mYYxc
 m91w==
X-Gm-Message-State: AOJu0Yz3kZcHZe4iCZQz+jFPdSWHf/OxqixnYhR+rTpIIpJj4l8mZm+h
 a7N86GCl0WzDvKFc1abG0hRYHojcckFUcl2IR+RbAjdccgjV+P1L0TAYHmYuRH0eaddcnzW1QA+
 3YbPfZtoJxJs4HkOhuHxwRokZRhi+3lD8lh437i4YZ4juHnrwoJ/KsSDVUQUWa17xs7TO
X-Received: by 2002:a05:6512:10cb:b0:507:aaa9:b080 with SMTP id
 k11-20020a05651210cb00b00507aaa9b080mr29451571lfg.33.1699351879780; 
 Tue, 07 Nov 2023 02:11:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSElT1kUkwKGt/kI8dyERyAqtlAgTjfSVgxPFPgtIPbAkSwBdEENHz1nGQUqDAv+gzMIDhkg==
X-Received: by 2002:a05:6512:10cb:b0:507:aaa9:b080 with SMTP id
 k11-20020a05651210cb00b00507aaa9b080mr29451542lfg.33.1699351879472; 
 Tue, 07 Nov 2023 02:11:19 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 y11-20020adff6cb000000b0032fc609c118sm1903923wrp.66.2023.11.07.02.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:11:18 -0800 (PST)
Date: Tue, 7 Nov 2023 05:11:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 24/63] tests: test-smp-parse: Add the test for cores/threads
 per socket helpers
Message-ID: <7d5936791ea349d9cef856babcce28470966bfa4.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Zhao Liu <zhao1.liu@intel.com>

Use the different ways to calculate cores/threads per socket, so that
the new CPU topology levels won't be missed in these 2 helpes:

* machine_topo_get_cores_per_socket()
* machine_topo_get_threads_per_socket()

Test the commit a1d027be95bc3 ("machine: Add helpers to get cores/
threads per socket").

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231023094635.1588282-2-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/unit/test-smp-parse.c | 67 ++++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 13 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index fdc39a846c..24972666a7 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -394,20 +394,47 @@ static char *smp_config_to_string(const SMPConfiguration *config)
         config->has_maxcpus ? "true" : "false", config->maxcpus);
 }
 
-static char *cpu_topology_to_string(const CpuTopology *topo)
+/* Use the different calculation than machine_topo_get_threads_per_socket(). */
+static unsigned int cpu_topology_get_threads_per_socket(const CpuTopology *topo)
+{
+    /* Check the divisor to avoid invalid topology examples causing SIGFPE. */
+    if (!topo->sockets) {
+        return 0;
+    } else {
+        return topo->max_cpus / topo->sockets;
+    }
+}
+
+/* Use the different calculation than machine_topo_get_cores_per_socket(). */
+static unsigned int cpu_topology_get_cores_per_socket(const CpuTopology *topo)
+{
+    /* Check the divisor to avoid invalid topology examples causing SIGFPE. */
+    if (!topo->threads) {
+        return 0;
+    } else {
+        return cpu_topology_get_threads_per_socket(topo) / topo->threads;
+    }
+}
+
+static char *cpu_topology_to_string(const CpuTopology *topo,
+                                    unsigned int threads_per_socket,
+                                    unsigned int cores_per_socket)
 {
     return g_strdup_printf(
         "(CpuTopology) {\n"
-        "    .cpus     = %u,\n"
-        "    .sockets  = %u,\n"
-        "    .dies     = %u,\n"
-        "    .clusters = %u,\n"
-        "    .cores    = %u,\n"
-        "    .threads  = %u,\n"
-        "    .max_cpus = %u,\n"
+        "    .cpus               = %u,\n"
+        "    .sockets            = %u,\n"
+        "    .dies               = %u,\n"
+        "    .clusters           = %u,\n"
+        "    .cores              = %u,\n"
+        "    .threads            = %u,\n"
+        "    .max_cpus           = %u,\n"
+        "    .threads_per_socket = %u,\n"
+        "    .cores_per_socket   = %u,\n"
         "}",
         topo->cpus, topo->sockets, topo->dies, topo->clusters,
-        topo->cores, topo->threads, topo->max_cpus);
+        topo->cores, topo->threads, topo->max_cpus,
+        threads_per_socket, cores_per_socket);
 }
 
 static void check_parse(MachineState *ms, const SMPConfiguration *config,
@@ -415,14 +442,26 @@ static void check_parse(MachineState *ms, const SMPConfiguration *config,
                         bool is_valid)
 {
     g_autofree char *config_str = smp_config_to_string(config);
-    g_autofree char *expect_topo_str = cpu_topology_to_string(expect_topo);
-    g_autofree char *output_topo_str = NULL;
+    g_autofree char *expect_topo_str = NULL, *output_topo_str = NULL;
+    unsigned int expect_threads_per_socket, expect_cores_per_socket;
+    unsigned int ms_threads_per_socket, ms_cores_per_socket;
     Error *err = NULL;
 
+    expect_threads_per_socket =
+                        cpu_topology_get_threads_per_socket(expect_topo);
+    expect_cores_per_socket =
+                        cpu_topology_get_cores_per_socket(expect_topo);
+    expect_topo_str = cpu_topology_to_string(expect_topo,
+                                             expect_threads_per_socket,
+                                             expect_cores_per_socket);
+
     /* call the generic parser */
     machine_parse_smp_config(ms, config, &err);
 
-    output_topo_str = cpu_topology_to_string(&ms->smp);
+    ms_threads_per_socket = machine_topo_get_threads_per_socket(ms);
+    ms_cores_per_socket = machine_topo_get_cores_per_socket(ms);
+    output_topo_str = cpu_topology_to_string(&ms->smp, ms_threads_per_socket,
+                                             ms_cores_per_socket);
 
     /* when the configuration is supposed to be valid */
     if (is_valid) {
@@ -433,7 +472,9 @@ static void check_parse(MachineState *ms, const SMPConfiguration *config,
             (ms->smp.clusters == expect_topo->clusters) &&
             (ms->smp.cores == expect_topo->cores) &&
             (ms->smp.threads == expect_topo->threads) &&
-            (ms->smp.max_cpus == expect_topo->max_cpus)) {
+            (ms->smp.max_cpus == expect_topo->max_cpus) &&
+            (ms_threads_per_socket == expect_threads_per_socket) &&
+            (ms_cores_per_socket == expect_cores_per_socket)) {
             return;
         }
 
-- 
MST


