Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1544A7D1F4F
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 22:07:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quIET-00057X-3p; Sat, 21 Oct 2023 16:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1quIEP-0004yu-FC
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 16:05:57 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1quIEL-0006th-W4
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 16:05:56 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-540105dea92so746951a12.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 13:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1697918752; x=1698523552;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97zIIxwvzvuxLbE1OphDxtWK5OJmfKyrS2a8WN8AJRw=;
 b=p7jmFuc1jKNPWNqxrEoV/YfE6PDbfyMHv+evQR0vn3qp1SRC/And669Md1Bi6FG28R
 GYaSvRD+qrLmH/ExnNvJIaM7ga/l/ku8MX6NwDWwb5+32b6k/OiCOoK4799pO1URtL1z
 RFknyq3UsvgVbE9aytpsWZihSf9QkCPQtHGCghqJY3NhvZIiFFfkGmZWx9ua96+/UAb1
 aNUKMe741pt7rpcVeTF/U5cyRTl5fh/3FahxsF+/NoLSEnH3nHfr2K+HZdZZnBIk/76I
 l5TFxwZqesv6d+optEHhcCpC5lPXVqNMG4XvF+cNLAzK0ShUosmAD+t+6iAW/n/I4FoA
 g0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697918752; x=1698523552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=97zIIxwvzvuxLbE1OphDxtWK5OJmfKyrS2a8WN8AJRw=;
 b=KueZPQADgcd0WBWLEfpvvE16ahHcKrgitz5TMLdKeahwwpTpdb/p+I3pXjrAAQ8hyL
 EZDSOuuZ3lCacWLp+U/v5rMB3djfWrC5/EO6wVojREJMl78LzIg4FIfdptUBBxC196fC
 swO2aC2+nqxACqNGXNi13DUBvni2bf6O877IxtN0jDZHMTJpzLSEWTTzi9XC2ZKXZ8hL
 kucxv5sHQ1BcX/Q57zZQYnpEPnrOcj9qaZ4FA0v6NLtFXu/hIqfMyExhvgVf3j88zVxn
 EsXIDurmnh5MA5EqyqksoTTuC149DZkACs6C34Bgk2rBFGBwe6bU86U+9dKLCVSELFt3
 e2/A==
X-Gm-Message-State: AOJu0YykKs4Io+0MgMyfuP982WVxDtf0rCHgRbRz1/dSkD87vBH9J4En
 Sy9Iu39LZ8zGi/ufCCVy4dOzKzVnRGF9YuiK2MQ=
X-Google-Smtp-Source: AGHT+IFeOnpuTc8gzWF5zi9kod6ByqZKxgeNeCBT5i3jmcWErGxlesIGEvXY8ACJuuXVep/PEfdibg==
X-Received: by 2002:a17:907:930b:b0:9be:71ab:fb58 with SMTP id
 bu11-20020a170907930b00b009be71abfb58mr3930481ejc.75.1697918751994; 
 Sat, 21 Oct 2023 13:05:51 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-249.customer.bnet.at.
 [89.104.8.249]) by smtp.gmail.com with ESMTPSA id
 u2-20020a17090617c200b0098ce63e36e9sm4138253eje.16.2023.10.21.13.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 13:05:51 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, roman@roolebo.dev, pbonzini@redhat.com,
 lists@philjordan.eu, phil@philjordan.eu
Subject: [PATCH v2 2/4] hvf: Fixes some compilation warnings
Date: Sat, 21 Oct 2023 22:05:16 +0200
Message-Id: <20231021200518.30125-3-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231021200518.30125-1-phil@philjordan.eu>
References: <20231021200518.30125-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::531;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x531.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

A bunch of function definitions used empty parentheses instead of (void) syntax, yielding the following warning when building with clang on macOS:

warning: a function declaration without a prototype is deprecated in all versions of C [-Wstrict-prototypes]

In addition to fixing these function headers, it also fixes what appears to be a typo causing a variable to be unused after initialisation.

warning: variable 'entry_ctls' set but not used [-Wunused-but-set-variable]

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/vmx.h        | 3 +--
 target/i386/hvf/x86_decode.c | 2 +-
 target/i386/hvf/x86_emu.c    | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 0fffcfa46c..3954ef883d 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -95,8 +95,7 @@ static void enter_long_mode(hv_vcpuid_t vcpu, uint64_t cr0, uint64_t efer)
     efer |= MSR_EFER_LMA;
     wvmcs(vcpu, VMCS_GUEST_IA32_EFER, efer);
     entry_ctls = rvmcs(vcpu, VMCS_ENTRY_CTLS);
-    wvmcs(vcpu, VMCS_ENTRY_CTLS, rvmcs(vcpu, VMCS_ENTRY_CTLS) |
-          VM_ENTRY_GUEST_LMA);
+    wvmcs(vcpu, VMCS_ENTRY_CTLS, entry_ctls | VM_ENTRY_GUEST_LMA);
 
     uint64_t guest_tr_ar = rvmcs(vcpu, VMCS_GUEST_TR_ACCESS_RIGHTS);
     if ((efer & MSR_EFER_LME) &&
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 3728d7705e..a4a28f113f 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -2111,7 +2111,7 @@ uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
     return decode->len;
 }
 
-void init_decoder()
+void init_decoder(void)
 {
     int i;
     
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index ccda568478..852f766161 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -1410,7 +1410,7 @@ static struct cmd_handler {
 
 static struct cmd_handler _cmd_handler[X86_DECODE_CMD_LAST];
 
-static void init_cmd_handler()
+static void init_cmd_handler(void)
 {
     int i;
     for (i = 0; i < ARRAY_SIZE(handlers); i++) {
@@ -1482,7 +1482,7 @@ bool exec_instruction(CPUX86State *env, struct x86_decode *ins)
     return true;
 }
 
-void init_emu()
+void init_emu(void)
 {
     init_cmd_handler();
 }
-- 
2.36.1


