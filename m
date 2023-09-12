Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D85979C7F1
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 09:16:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxZx-0002vu-Uw; Tue, 12 Sep 2023 03:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxZu-0002l5-HB
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:12:55 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxZs-0006br-Ct
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:12:54 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68fdcc37827so783040b3a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 00:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694502771; x=1695107571;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HIHlVenx/RhzjGmmo1wY84kTXKwuVoMzutK7Eoq9w/g=;
 b=MkgvozBV0w15M7RlxfQ/y+PgYdpAZa4O/AfJDulSAHu0Q0CjJqhlLdzc2QoPmZmohN
 EedhHfaLHV/sdpYYBqwf28lYA5QacdnmxRbGisTxxSRZA90sQvCYA2ZmIAge5Xt8PGX8
 M9SZgAxQVZqa/FlZcFqhLqIIWwgP3ntAMIJhwEPOzKsGe4fuYixMCLHlZ85DuEepFSuj
 aRNnAnEAmDgjQUrzRfdL6EJGeQcfIfHDaBnbZuwrGZnmAxnpIKezNqdgYwLFuA3+86yx
 1LzoXi6Dz2IaJRJzv7HeMl0UzjJuOSaPjUgBEyHtzkPiMhnVrCZ5BweHsKA0tgV4n/LG
 1/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694502771; x=1695107571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HIHlVenx/RhzjGmmo1wY84kTXKwuVoMzutK7Eoq9w/g=;
 b=b0ITfGXUyQlbveEKZv+hXDBAuJsKInvbQdZrKeV6byB/sg99S574WS+71nn95qx18Q
 pqmNZmw4WrtgZu3VmDZeNzfP4Fpe5lMahwlW00k0VXLki1VuIXuwtmlTPjOGstl8X5lK
 TQAAkgrJYyGqJZtkFZmqw057fH7qActCTwiow1uMGPLt6UYI98d65cFkg6imGIWw8Xmg
 7Drqw7sVSoV87OPHgbBtZB6r//Nv3JMrcQyrs1WRycs0dPsQpgSpebPH7M5lpvRDHYDH
 tfa31X3ojrCar1neXlUF6hPcGybK8gBpg4d5qybtqgLBUC73XU3u/0ry1X1kh5aCUf6C
 t8Zg==
X-Gm-Message-State: AOJu0Yxozq71R5uSN4yzbVwP6Ukg8B17v7Bm8Jz2HSBgmcCIv56jJve2
 /iNcEMGZFk5XqBznNbKAgrvU1g==
X-Google-Smtp-Source: AGHT+IFMp8ODVfzQihgxiEFbiJIsT1M9zJ/og4jDKx+VwmCwZb+6XHEZxiceGXswwng0NfFxLqTA5g==
X-Received: by 2002:a05:6a20:9381:b0:153:4ea6:d12e with SMTP id
 x1-20020a056a20938100b001534ea6d12emr2431636pzh.17.1694502770982; 
 Tue, 12 Sep 2023 00:12:50 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 f13-20020aa78b0d000000b0068be348e35fsm6647495pfd.166.2023.09.12.00.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 00:12:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 10/18] gdbstub: Simplify XML lookup
Date: Tue, 12 Sep 2023 16:11:56 +0900
Message-ID: <20230912071206.30751-11-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912071206.30751-1-akihiko.odaki@daynix.com>
References: <20230912071206.30751-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Now we know all instances of GDBFeature that is used in CPU so we can
traverse them to find XML. This removes the need for a CPU-specific
lookup function for dynamic XMLs.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 gdbstub/gdbstub.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 7554318118..90dc78832b 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -352,6 +352,7 @@ static const char *get_feature_xml(const char *p, const char **newp,
 {
     CPUState *cpu = gdb_get_first_cpu_in_process(process);
     CPUClass *cc = CPU_GET_CLASS(cpu);
+    GDBRegisterState *r;
     size_t len;
 
     /*
@@ -365,7 +366,6 @@ static const char *get_feature_xml(const char *p, const char **newp,
     /* Is it the main target xml? */
     if (strncmp(p, "target.xml", len) == 0) {
         if (!process->target_xml) {
-            GDBRegisterState *r;
             g_autoptr(GPtrArray) xml = g_ptr_array_new_with_free_func(g_free);
 
             g_ptr_array_add(
@@ -398,20 +398,15 @@ static const char *get_feature_xml(const char *p, const char **newp,
         }
         return process->target_xml;
     }
-    /* Is it dynamically generated by the target? */
-    if (cc->gdb_get_dynamic_xml) {
-        g_autofree char *xmlname = g_strndup(p, len);
-        const char *xml = cc->gdb_get_dynamic_xml(cpu, xmlname);
-        if (xml) {
-            return xml;
-        }
+    /* Is it the core feature? */
+    if (strncmp(p, cc->gdb_core_feature->xmlname, len) == 0) {
+        return cc->gdb_core_feature->xml;
     }
-    /* Is it one of the encoded gdb-xml/ files? */
-    for (int i = 0; gdb_static_features[i].xmlname; i++) {
-        const char *name = gdb_static_features[i].xmlname;
-        if ((strncmp(name, p, len) == 0) &&
-            strlen(name) == len) {
-            return gdb_static_features[i].xml;
+    /* Is it one of the coprocessor features? */
+    for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+        r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+        if (strncmp(p, r->feature->xmlname, len) == 0) {
+            return r->feature->xml;
         }
     }
 
-- 
2.42.0


