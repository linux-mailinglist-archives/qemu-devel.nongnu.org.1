Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 323178FDDDB
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jun 2024 06:45:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF4zg-0008D5-Fw; Thu, 06 Jun 2024 00:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sF4ze-0008Cq-94
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 00:44:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sF4za-0008JY-Ng
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 00:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717649089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmaAdKQzAZzsiULoP3TeJY9GmDnRELKZLCeesie7Gxw=;
 b=TcwD+UtqH3vYOEpslNM4oYBn5pbDcVrM0OCFyK+lkhp8s+Qv89nofy0//qZE8BUAth+MmL
 xDA2enC9wNiCp6hn8wd9COqkW0yNkSm4xtFAXt8eQPhiCB5OKGbtcZ7wElwjl7+kzYi1W+
 EnCpNjO07/F3yys5RD/NrK0PICgCNQM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-uGRC6_2BO6ixMfuQm5GE1A-1; Thu, 06 Jun 2024 00:44:47 -0400
X-MC-Unique: uGRC6_2BO6ixMfuQm5GE1A-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-6507e2f0615so456761a12.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 21:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717649083; x=1718253883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vmaAdKQzAZzsiULoP3TeJY9GmDnRELKZLCeesie7Gxw=;
 b=SWDuhTc/2tzNoOaP/MGdXQi8dcSDCLLgygSGYRxTMoT1BysnnR0CnNQ3FNGMmDBFOG
 npkNn3E3MytWEZ531milF4z08sFJ+YXoajJeeVUYhrIYkNcHyeUNr9iJa2gl6bQ4kb+x
 mjz6tzlMiP+zUQilHROffjidI64iO5QUzmVWAfOF2lmMRyFgOsaufBplep//TdCtfuvN
 QVRaUMt/vnGannGiTohHrRcnldwADG3w3Vo1kWKflzWKneIgYpCPFEtKoukvUEuEK37I
 whlZZ+fpwmgvlNNDUNFmtz6hGOAa/8leTxfQc3M1ATC1uCIN4SzlnaRuRXd0YBXGnyIy
 evrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEk/MkoNtxmp07qg6I0ZmLkAlmaFU//92OnxINElPMjNG/gcE0NlJdfmDAUH2koQMx9hfzqaaM0LUdWbKdwvcGLyZ2p/8=
X-Gm-Message-State: AOJu0YzOnfvFzY3Onr2rg121auPAHHKY2NpxT6VjARtyiT47E5fK67c1
 04lnKkG6w7xXJ2PC/lY1yceFOv7UvgxmbQ8is0E4unvG55xJrkT8I7TevcxwVwrBwkXltzqRV4B
 TincTjuyNPEJ+vlGk4a3d4m6/fZbp8bTHfZepXcM6e75NNjeG8udt
X-Received: by 2002:a05:6a21:614:b0:1b2:a78c:f5d0 with SMTP id
 adf61e73a8af0-1b2b71930bbmr4171694637.61.1717649083517; 
 Wed, 05 Jun 2024 21:44:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGareBrygFuhTAjPhnm0BTbkTwoRdx9MyJXsKYuufqY+ggORjvGdQp/5N1KxI80VrM1YLARQA==
X-Received: by 2002:a05:6a21:614:b0:1b2:a78c:f5d0 with SMTP id
 adf61e73a8af0-1b2b71930bbmr4171679637.61.1717649083021; 
 Wed, 05 Jun 2024 21:44:43 -0700 (PDT)
Received: from localhost.localdomain ([203.163.239.242])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-1f6bd81b9e2sm4057165ad.295.2024.06.05.21.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 21:44:42 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] tests/qtest/x86: check for availability of older cpu
 models before running tests
Date: Thu,  6 Jun 2024 10:14:19 +0530
Message-ID: <20240606044419.8806-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240606044419.8806-1-anisinha@redhat.com>
References: <20240606044419.8806-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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

It is better to check if some older cpu models like 486, athlon, pentium,
penryn, phenom, core2duo etc are available before running their corresponding
tests. Some downstream distributions may no longer support these older cpu
models.

Signature of add_feature_test() has been modified to return void as
FeatureTestArgs* was not used by the caller.

One minor correction. Replaced 'phenom' with '486' in the test
'x86/cpuid/auto-level/phenom/arat' matching the cpu used.

CC: thuth@redhat.com
CC: imammedo@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/test-x86-cpuid-compat.c | 170 ++++++++++++++++++----------
 1 file changed, 108 insertions(+), 62 deletions(-)

changelog:
v2: reworked as per suggestion from danpb.
v3: reworked as_feature_test() same way as add_cpuid_test()

diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index 6a39454fce..d5307f39e7 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -67,10 +67,29 @@ static void test_cpuid_prop(const void *data)
     g_free(path);
 }
 
-static void add_cpuid_test(const char *name, const char *cmdline,
+static void add_cpuid_test(const char *name, const char *cpu,
+                           const char *cpufeat, const char *machine,
                            const char *property, int64_t expected_value)
 {
     CpuidTestArgs *args = g_new0(CpuidTestArgs, 1);
+    char *cmdline;
+    char *save;
+
+    if (!qtest_has_cpu(cpu)) {
+        return;
+    }
+    cmdline = g_strdup_printf("-cpu %s", cpu);
+
+    if (cpufeat) {
+        save = cmdline;
+        cmdline = g_strdup_printf("%s,%s", cmdline, cpufeat);
+        g_free(save);
+    }
+    if (machine) {
+        save = cmdline;
+        cmdline = g_strdup_printf("-machine %s %s", machine, cmdline);
+        g_free(save);
+    }
     args->cmdline = cmdline;
     args->property = property;
     args->expected_value = expected_value;
@@ -149,12 +168,24 @@ static void test_feature_flag(const void *data)
  * either "feature-words" or "filtered-features", when running QEMU
  * using cmdline
  */
-static FeatureTestArgs *add_feature_test(const char *name, const char *cmdline,
-                                         uint32_t eax, uint32_t ecx,
-                                         const char *reg, int bitnr,
-                                         bool expected_value)
+static void add_feature_test(const char *name, const char *cpu,
+                             const char *cpufeat, uint32_t eax,
+                             uint32_t ecx, const char *reg,
+                             int bitnr, bool expected_value)
 {
     FeatureTestArgs *args = g_new0(FeatureTestArgs, 1);
+    char *cmdline;
+
+    if (!qtest_has_cpu(cpu)) {
+        return;
+    }
+
+    if (cpufeat) {
+        cmdline = g_strdup_printf("-cpu %s,%s", cpu, cpufeat);
+    } else {
+        cmdline = g_strdup_printf("-cpu %s", cpu);
+    }
+
     args->cmdline = cmdline;
     args->in_eax = eax;
     args->in_ecx = ecx;
@@ -162,13 +193,17 @@ static FeatureTestArgs *add_feature_test(const char *name, const char *cmdline,
     args->bitnr = bitnr;
     args->expected_value = expected_value;
     qtest_add_data_func(name, args, test_feature_flag);
-    return args;
+    return;
 }
 
 static void test_plus_minus_subprocess(void)
 {
     char *path;
 
+    if (!qtest_has_cpu("pentium")) {
+        return;
+    }
+
     /* Rules:
      * 1)"-foo" overrides "+foo"
      * 2) "[+-]foo" overrides "foo=..."
@@ -198,6 +233,10 @@ static void test_plus_minus_subprocess(void)
 
 static void test_plus_minus(void)
 {
+    if (!qtest_has_cpu("pentium")) {
+        return;
+    }
+
     g_test_trap_subprocess("/x86/cpuid/parsing-plus-minus/subprocess", 0, 0);
     g_test_trap_assert_passed();
     g_test_trap_assert_stderr("*Ambiguous CPU model string. "
@@ -217,99 +256,105 @@ int main(int argc, char **argv)
 
     /* Original level values for CPU models: */
     add_cpuid_test("x86/cpuid/phenom/level",
-                   "-cpu phenom", "level", 5);
+                   "phenom", NULL, NULL, "level", 5);
     add_cpuid_test("x86/cpuid/Conroe/level",
-                   "-cpu Conroe", "level", 10);
+                   "Conroe", NULL, NULL, "level", 10);
     add_cpuid_test("x86/cpuid/SandyBridge/level",
-                   "-cpu SandyBridge", "level", 0xd);
+                   "SandyBridge", NULL, NULL, "level", 0xd);
     add_cpuid_test("x86/cpuid/486/xlevel",
-                   "-cpu 486", "xlevel", 0);
+                   "486", NULL, NULL, "xlevel", 0);
     add_cpuid_test("x86/cpuid/core2duo/xlevel",
-                   "-cpu core2duo", "xlevel", 0x80000008);
+                   "core2duo", NULL, NULL, "xlevel", 0x80000008);
     add_cpuid_test("x86/cpuid/phenom/xlevel",
-                   "-cpu phenom", "xlevel", 0x8000001A);
+                   "phenom", NULL, NULL, "xlevel", 0x8000001A);
     add_cpuid_test("x86/cpuid/athlon/xlevel",
-                   "-cpu athlon", "xlevel", 0x80000008);
+                   "athlon", NULL, NULL, "xlevel", 0x80000008);
 
     /* If level is not large enough, it should increase automatically: */
     /* CPUID[6].EAX: */
-    add_cpuid_test("x86/cpuid/auto-level/phenom/arat",
-                   "-cpu 486,arat=on", "level", 6);
+    add_cpuid_test("x86/cpuid/auto-level/486/arat",
+                   "486", "arat=on", NULL, "level", 6);
     /* CPUID[EAX=7,ECX=0].EBX: */
     add_cpuid_test("x86/cpuid/auto-level/phenom/fsgsbase",
-                   "-cpu phenom,fsgsbase=on", "level", 7);
+                   "phenom", "fsgsbase=on", NULL, "level", 7);
     /* CPUID[EAX=7,ECX=0].ECX: */
     add_cpuid_test("x86/cpuid/auto-level/phenom/avx512vbmi",
-                   "-cpu phenom,avx512vbmi=on", "level", 7);
+                   "phenom", "avx512vbmi=on", NULL, "level", 7);
     /* CPUID[EAX=0xd,ECX=1].EAX: */
     add_cpuid_test("x86/cpuid/auto-level/phenom/xsaveopt",
-                   "-cpu phenom,xsaveopt=on", "level", 0xd);
+                   "phenom", "xsaveopt=on", NULL, "level", 0xd);
     /* CPUID[8000_0001].EDX: */
     add_cpuid_test("x86/cpuid/auto-xlevel/486/3dnow",
-                   "-cpu 486,3dnow=on", "xlevel", 0x80000001);
+                   "486", "3dnow=on", NULL, "xlevel", 0x80000001);
     /* CPUID[8000_0001].ECX: */
     add_cpuid_test("x86/cpuid/auto-xlevel/486/sse4a",
-                   "-cpu 486,sse4a=on", "xlevel", 0x80000001);
+                   "486", "sse4a=on", NULL, "xlevel", 0x80000001);
     /* CPUID[8000_0007].EDX: */
     add_cpuid_test("x86/cpuid/auto-xlevel/486/invtsc",
-                   "-cpu 486,invtsc=on", "xlevel", 0x80000007);
+                   "486", "invtsc=on", NULL, "xlevel", 0x80000007);
     /* CPUID[8000_000A].EDX: */
     add_cpuid_test("x86/cpuid/auto-xlevel/486/npt",
-                   "-cpu 486,svm=on,npt=on", "xlevel", 0x8000000A);
+                   "486", "svm=on,npt=on", NULL, "xlevel", 0x8000000A);
     /* CPUID[C000_0001].EDX: */
     add_cpuid_test("x86/cpuid/auto-xlevel2/phenom/xstore",
-                   "-cpu phenom,xstore=on", "xlevel2", 0xC0000001);
+                   "phenom", "xstore=on", NULL, "xlevel2", 0xC0000001);
     /* SVM needs CPUID[0x8000000A] */
     add_cpuid_test("x86/cpuid/auto-xlevel/athlon/svm",
-                   "-cpu athlon,svm=on", "xlevel", 0x8000000A);
+                   "athlon", "svm=on", NULL, "xlevel", 0x8000000A);
 
 
     /* If level is already large enough, it shouldn't change: */
     add_cpuid_test("x86/cpuid/auto-level/SandyBridge/multiple",
-                   "-cpu SandyBridge,arat=on,fsgsbase=on,avx512vbmi=on",
-                   "level", 0xd);
+                   "SandyBridge", "arat=on,fsgsbase=on,avx512vbmi=on",
+                   NULL, "level", 0xd);
     /* If level is explicitly set, it shouldn't change: */
     add_cpuid_test("x86/cpuid/auto-level/486/fixed/0xF",
-                   "-cpu 486,level=0xF,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
-                   "level", 0xF);
+                   "486",
+                   "level=0xF,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
+                   NULL, "level", 0xF);
     add_cpuid_test("x86/cpuid/auto-level/486/fixed/2",
-                   "-cpu 486,level=2,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
-                   "level", 2);
+                   "486",
+                   "level=2,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
+                   NULL, "level", 2);
     add_cpuid_test("x86/cpuid/auto-level/486/fixed/0",
-                   "-cpu 486,level=0,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
-                   "level", 0);
+                   "486",
+                   "level=0,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
+                   NULL, "level", 0);
 
     /* if xlevel is already large enough, it shouldn't change: */
     add_cpuid_test("x86/cpuid/auto-xlevel/phenom/3dnow",
-                   "-cpu phenom,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   "xlevel", 0x8000001A);
+                   "phenom", "3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+                   NULL, "xlevel", 0x8000001A);
     /* If xlevel is explicitly set, it shouldn't change: */
     add_cpuid_test("x86/cpuid/auto-xlevel/486/fixed/80000002",
-                   "-cpu 486,xlevel=0x80000002,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   "xlevel", 0x80000002);
+                   "486",
+                   "xlevel=0x80000002,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+                   NULL, "xlevel", 0x80000002);
     add_cpuid_test("x86/cpuid/auto-xlevel/486/fixed/8000001A",
-                   "-cpu 486,xlevel=0x8000001A,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   "xlevel", 0x8000001A);
+                   "486",
+                   "xlevel=0x8000001A,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+                   NULL, "xlevel", 0x8000001A);
     add_cpuid_test("x86/cpuid/auto-xlevel/phenom/fixed/0",
-                   "-cpu 486,xlevel=0,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   "xlevel", 0);
+                   "486",
+                   "xlevel=0,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+                   NULL, "xlevel", 0);
 
     /* if xlevel2 is already large enough, it shouldn't change: */
     add_cpuid_test("x86/cpuid/auto-xlevel2/486/fixed",
-                   "-cpu 486,xlevel2=0xC0000002,xstore=on",
-                   "xlevel2", 0xC0000002);
+                   "486", "xlevel2=0xC0000002,xstore=on",
+                   NULL, "xlevel2", 0xC0000002);
 
     /* Check compatibility of old machine-types that didn't
      * auto-increase level/xlevel/xlevel2: */
     if (qtest_has_machine("pc-i440fx-2.7")) {
         add_cpuid_test("x86/cpuid/auto-level/pc-2.7",
-                       "-machine pc-i440fx-2.7 -cpu 486,arat=on,avx512vbmi=on,xsaveopt=on",
-                       "level", 1);
+                       "486", "arat=on,avx512vbmi=on,xsaveopt=on",
+                       "pc-i440fx-2.7", "level", 1);
         add_cpuid_test("x86/cpuid/auto-xlevel/pc-2.7",
-                       "-machine pc-i440fx-2.7 -cpu 486,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                       "xlevel", 0);
+                       "486", "3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+                       "pc-i440fx-2.7", "xlevel", 0);
         add_cpuid_test("x86/cpuid/auto-xlevel2/pc-2.7",
-                       "-machine pc-i440fx-2.7 -cpu 486,xstore=on",
+                       "486", "xstore=on", "pc-i440fx-2.7",
                        "xlevel2", 0);
     }
     /*
@@ -319,18 +364,18 @@ int main(int argc, char **argv)
      */
     if (qtest_has_machine("pc-i440fx-2.3")) {
         add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.3/off",
-                       "-machine pc-i440fx-2.3 -cpu Penryn",
+                       "Penryn", NULL, "pc-i440fx-2.3",
                        "level", 4);
         add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.3/on",
-                       "-machine pc-i440fx-2.3 -cpu Penryn,erms=on",
+                       "Penryn", "erms=on", "pc-i440fx-2.3",
                        "level", 7);
     }
     if (qtest_has_machine("pc-i440fx-2.9")) {
         add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/off",
-                       "-machine pc-i440fx-2.9 -cpu Conroe",
+                       "Conroe", NULL, "pc-i440fx-2.9",
                        "level", 10);
         add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/on",
-                       "-machine pc-i440fx-2.9 -cpu Conroe,erms=on",
+                       "Conroe", "erms=on", "pc-i440fx-2.9",
                        "level", 10);
     }
 
@@ -341,42 +386,43 @@ int main(int argc, char **argv)
      */
     if (qtest_has_machine("pc-i440fx-2.3")) {
         add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.3",
-                       "-machine pc-i440fx-2.3 -cpu SandyBridge",
+                       "SandyBridge", NULL, "pc-i440fx-2.3",
                        "xlevel", 0x8000000a);
     }
     if (qtest_has_machine("pc-i440fx-2.4")) {
         add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-off",
-                       "-machine pc-i440fx-2.4 -cpu SandyBridge,",
+                       "SandyBridge", NULL, "pc-i440fx-2.4",
                        "xlevel", 0x80000008);
         add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-on",
-                       "-machine pc-i440fx-2.4 -cpu SandyBridge,svm=on,npt=on",
+                       "SandyBridge", "svm=on,npt=on", "pc-i440fx-2.4",
                        "xlevel", 0x80000008);
     }
 
     /* Test feature parsing */
     add_feature_test("x86/cpuid/features/plus",
-                     "-cpu 486,+arat",
+                     "486", "+arat",
                      6, 0, "EAX", 2, true);
     add_feature_test("x86/cpuid/features/minus",
-                     "-cpu pentium,-mmx",
+                     "pentium", "-mmx",
                      1, 0, "EDX", 23, false);
     add_feature_test("x86/cpuid/features/on",
-                     "-cpu 486,arat=on",
+                     "486", "arat=on",
                      6, 0, "EAX", 2, true);
     add_feature_test("x86/cpuid/features/off",
-                     "-cpu pentium,mmx=off",
+                     "pentium", "mmx=off",
                      1, 0, "EDX", 23, false);
+
     add_feature_test("x86/cpuid/features/max-plus-invtsc",
-                     "-cpu max,+invtsc",
+                     "max" , "+invtsc",
                      0x80000007, 0, "EDX", 8, true);
     add_feature_test("x86/cpuid/features/max-invtsc-on",
-                     "-cpu max,invtsc=on",
+                     "max", "invtsc=on",
                      0x80000007, 0, "EDX", 8, true);
     add_feature_test("x86/cpuid/features/max-minus-mmx",
-                     "-cpu max,-mmx",
+                     "max", "-mmx",
                      1, 0, "EDX", 23, false);
     add_feature_test("x86/cpuid/features/max-invtsc-on,mmx=off",
-                     "-cpu max,mmx=off",
+                     "max", "mmx=off",
                      1, 0, "EDX", 23, false);
 
     return g_test_run();
-- 
2.42.0


