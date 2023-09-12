Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F9879C7CC
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 09:13:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxZc-0002Pd-7n; Tue, 12 Sep 2023 03:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxZU-0002PC-Rw
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:12:28 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxZS-0006Um-LC
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:12:28 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68fbd31d9ddso1464415b3a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 00:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694502744; x=1695107544;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tnf03Q7+288TJsyd7lSqF33vPvOy+ywzsBcRMgBbA/w=;
 b=iEZRNk79mGZEKnoa8w5PpkyL+PWj/7R2qEyLoB6fHBcJ1o+t+iQ0r38r7P8ZMHKzc3
 N3MTIxiqM9wpuQrVxVrZ57bB0eNlqHQwLuazqEP842DPWnJjJ5bxuKaF51nreyLEsU3o
 8y6YjIXlbYCIyLO1FnchlZTVoXT09Jzkh2eY7JpeqrzHGTx2dp6fTq1+hkHzuNI25clr
 OI80JZIWjh67NXB6+rfTwtzEoiHUEVkvqXYHR8ZJHLEZdUQDGA5mYGe25rHsf3R4O+Zj
 1NLVa4R41Sym4iWWx0YIvApJcLPyZoz9ZlzADZMq/0Vlom4WOqsNFtL1Jv91g5G8WHk/
 jrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694502744; x=1695107544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tnf03Q7+288TJsyd7lSqF33vPvOy+ywzsBcRMgBbA/w=;
 b=KK+p8fueoxwuTt4RuJ1MpH2VL+K2bZmZ1T8yG5SEgUsQgpocZPlxoB3G+VPrmPVv48
 LU4jlZOwiHhSEXgAyefsekmrFmLhBG87UVG2tfUE5d+TCVKdqpTXDpmGdHBVW5xmj3Lg
 baCqSpvXZrWgWLbCAqtdiSYx2X14WMYzcUXcfQV1swFvqLRnb+9hW/9C3LxNFGr6tHo3
 BAZEhtFzuA22sRH7eNPZd0rSFMSX0igaNovJIjDf4DOZTuoOiTHN6Y5Csr9A6x7P6ssz
 Skuabyl5QX5KMUJths48ve+2k1u/0kHX1niw5wwW5JgDTVqkfOL7yAhMI7+tKGLFTtsY
 sURg==
X-Gm-Message-State: AOJu0YwBcj1oxEAGY23Hg1oHeHRTujUFsaXPifLkme8h1onfoTT+zWXs
 HGwAQmUeNgGMyrbbtlm08FwFag==
X-Google-Smtp-Source: AGHT+IEHi234+aQcRcLvmbz/ta68+HfFYA9UPAxxLgpBmTGyi8z6m0NeFBepHuFWzWcHi7E5+JZqPw==
X-Received: by 2002:a05:6a00:b44:b0:68a:586a:f62 with SMTP id
 p4-20020a056a000b4400b0068a586a0f62mr11237424pfo.4.1694502743803; 
 Tue, 12 Sep 2023 00:12:23 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 f13-20020aa78b0d000000b0068be348e35fsm6647495pfd.166.2023.09.12.00.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 00:12:23 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 02/18] gdbstub: Introduce gdb_find_static_feature()
Date: Tue, 12 Sep 2023 16:11:48 +0900
Message-ID: <20230912071206.30751-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912071206.30751-1-akihiko.odaki@daynix.com>
References: <20230912071206.30751-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
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

This function is useful to determine the number of registers exposed to
GDB from the XML name.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/gdbstub.h |  2 ++
 gdbstub/gdbstub.c      | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index a43aa34dad..071021415a 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -44,6 +44,8 @@ void gdb_register_coprocessor(CPUState *cpu,
  */
 int gdbserver_start(const char *port_or_device);
 
+const GDBFeature *gdb_find_static_feature(const char *xmlname);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 9810d15278..fd73d6d257 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -420,6 +420,19 @@ static const char *get_feature_xml(const char *p, const char **newp,
     return NULL;
 }
 
+const GDBFeature *gdb_find_static_feature(const char *xmlname)
+{
+    const GDBFeature *feature;
+
+    for (feature = gdb_static_features; feature->xmlname; feature++) {
+        if (!strcmp(feature->xmlname, xmlname)) {
+            return feature;
+        }
+    }
+
+    g_assert_not_reached();
+}
+
 static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
-- 
2.42.0


