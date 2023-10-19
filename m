Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D08A67D0181
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:30:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXem-0005jQ-V9; Thu, 19 Oct 2023 14:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXeP-0005f8-09
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXeN-0000d3-Cs
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HGbWylb8H+QpIrFYsSYMoQCOLgbUc7uDdWXTJl1zQX0=;
 b=IMZueYMZ/z4Qs0+5HSTHwIyYj0t2CG1AtYh+CUAtyRJFyuI/bETmIk7Lpv3HLIGol7AIbx
 yiBBhDEeDOHqnUyweQS+AjoefUrt6+CWLif0vw8034fjghrD3YvFqAmC42KCLUWQAylgFG
 6b7KB4fF+3gHAde3l5Sd0fDtnz+VtjA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-e0B89RbkNKGvkQ5w29gPzQ-1; Thu, 19 Oct 2023 14:21:37 -0400
X-MC-Unique: e0B89RbkNKGvkQ5w29gPzQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4084e263ec4so2527765e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739695; x=1698344495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HGbWylb8H+QpIrFYsSYMoQCOLgbUc7uDdWXTJl1zQX0=;
 b=mS01rRSkgsZay6IqhPH2h/oT7v/xVpxCa7CwYa4o8K9MF41xyn/FLl4j51e7TEDcO2
 VM+qVBsVvQak9fc7nI0NS6Xy94ZzgGbXswxH2GIFGh/MaSV8Nt7j2l11zZeokJPv9ZhG
 W7H3dwzIuct2DcwFmFkGfpFvTEibw5U2BScltAvdh/Rj2LCfGLAbHfCnX4mfB2ZpNjx9
 gXzIHJSgmNey4kFkUA3dXkkhpxjN/UAuTiFaoLbfCDbvmMgfAN38ReehNwwah2aOAnGd
 De7YAYkLbPEw0ftYfOoJz51PORCZFZ13p/a+0LOldiKOrxQZxda5/KCP6Sr2gJXYXCe4
 LFSg==
X-Gm-Message-State: AOJu0YyboYPtf2p0tg13+Fxd4VSXR3H0kGy/vsLPxkvFsceCZRHe/iGP
 84ZHo+ELyRPcTA7AqsJCjyLhNLxBQTzr7HYiJQ/XdPQS0ligvZeY5XKmfIaHZ76XDzr4IkZYD+2
 nNHQcsnA5tQ00Gcy+7a5yCeWc5te2EfFi+ktnTaLkP+Utr1VhG77UDZvPLDZAady8x6fm
X-Received: by 2002:a05:600c:35c5:b0:408:4266:12db with SMTP id
 r5-20020a05600c35c500b00408426612dbmr2421349wmq.13.1697739695331; 
 Thu, 19 Oct 2023 11:21:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj9WO36sCZ/JMoGxbIosI9EI7xHeHwAvOcQm3DbdeHDIeP2YuHzxNQL5iGqvGSswc8xTYjBg==
X-Received: by 2002:a05:600c:35c5:b0:408:4266:12db with SMTP id
 r5-20020a05600c35c500b00408426612dbmr2421334wmq.13.1697739694958; 
 Thu, 19 Oct 2023 11:21:34 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 m29-20020a05600c3b1d00b003fe61c33df5sm5098867wms.3.2023.10.19.11.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:21:34 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:21:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL v2 08/78] tests: test-smp-parse: Add the test for
 cores/threads per socket helpers
Message-ID: <364c7520a62bc16ba62360a8b05cd367368f1b20.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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
Message-Id: <20230928125943.1816922-2-zhao1.liu@linux.intel.com>
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


