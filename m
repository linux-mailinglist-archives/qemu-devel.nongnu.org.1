Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C886A8AAAE3
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Apr 2024 10:49:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxjv1-0002eU-S3; Fri, 19 Apr 2024 04:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxjuz-0002dg-2Z
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 04:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxjux-0007YC-FI
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 04:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713516502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bp3oHnePKhWq2QoakUNtEuAtVReIW674eSBPqyAvHNk=;
 b=UloekG+sRi9PDxnFsoeZVhAB8VoYf5p9qceL8TBfWEoWr2jFN6L0S4RES12Eu5w568zavt
 hcm7fEwfjQ5jvTGvP7nASfIYULPcDsouekZ8ux8mzTEkiZwOX8qrhghj6VjGb53fAJwwSb
 5GLjdR6eKYFyli+rFzDOz7Sm2F84UF4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-tf9drnTdOyWWaLdCrnQfPw-1; Fri, 19 Apr 2024 04:48:18 -0400
X-MC-Unique: tf9drnTdOyWWaLdCrnQfPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E47A834FB1;
 Fri, 19 Apr 2024 08:48:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5060E1121306;
 Fri, 19 Apr 2024 08:48:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 1/4] target/sparc/cpu: Rename the CPU models with a "+" in
 their names
Date: Fri, 19 Apr 2024 10:48:09 +0200
Message-ID: <20240419084812.504779-2-thuth@redhat.com>
In-Reply-To: <20240419084812.504779-1-thuth@redhat.com>
References: <20240419084812.504779-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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

Commit b447378e12 ("qom/object: Limit type names to alphanumerical ...")
cut down the amount of allowed characters for QOM types to a saner set.
The "+" character was meant to be included in this set, so we had to
add a hack there to still allow the legacy names of POWER and Sparc64
CPUs. However, instead of putting such a hack in the common QOM code,
there is a much better place to do this: The sparc_cpu_class_by_name()
function which is used to look up the names of all Sparc CPUs.
Thus let's finally get rid of the "+" in the Sparc CPU names, and provide
backward compatibility for the old names via some simple checks in the
sparc_cpu_class_by_name() function.

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qom/object.c       |  8 --------
 target/sparc/cpu.c | 14 ++++++++++++--
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index d4a001cf41..759e194972 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -158,14 +158,6 @@ static bool type_name_is_valid(const char *name)
                         "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                         "0123456789-_.");
 
-    /* Allow some legacy names with '+' in it for compatibility reasons */
-    if (name[plen] == '+') {
-        if (plen >= 17 && g_str_has_prefix(name, "Sun-UltraSparc-I")) {
-            /* Allow "Sun-UltraSparc-IV+" and "Sun-UltraSparc-IIIi+" */
-            return true;
-        }
-    }
-
     return plen == slen;
 }
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index e820f50acf..774e234e09 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -314,7 +314,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Sun UltraSparc IV+",
+        .name = "Sun UltraSparc IV plus",
         .iu_version = ((0x3eULL << 48) | (0x19ULL << 32) | (0x22ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -323,7 +323,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES | CPU_FEATURE_CMT,
     },
     {
-        .name = "Sun UltraSparc IIIi+",
+        .name = "Sun UltraSparc IIIi plus",
         .iu_version = ((0x3eULL << 48) | (0x22ULL << 32) | (0ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_3,
@@ -762,6 +762,16 @@ static ObjectClass *sparc_cpu_class_by_name(const char *cpu_model)
     char *typename;
 
     typename = sparc_cpu_type_name(cpu_model);
+
+    /* Fix up legacy names with '+' in it */
+    if (g_str_equal(typename, SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IV+"))) {
+        g_free(typename);
+        typename = g_strdup(SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IV-plus"));
+    } else if (g_str_equal(typename, SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IIIi+"))) {
+        g_free(typename);
+        typename = g_strdup(SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IIIi-plus"));
+    }
+
     oc = object_class_by_name(typename);
     g_free(typename);
     return oc;
-- 
2.44.0


