Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D947A2E70
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 10:03:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhQG4-0003DG-15; Sat, 16 Sep 2023 04:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhQFy-0003CD-Fe
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 04:02:25 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhQFw-0005yC-Gq
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 04:02:21 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68fbb10dec7so2651542b3a.3
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 01:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694851339; x=1695456139;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tnf03Q7+288TJsyd7lSqF33vPvOy+ywzsBcRMgBbA/w=;
 b=vm4AFZzb5KvicQXETQ4tsqDN8UtvnmLkT4jY0DKLzfuLjeI90iLvV7rO82GYe4Wgyo
 k7WhR1YH1Dk3eSSiQfLs29cQzFKLDLPs/1PaPbAmxL++KqklH9rMpZSEz7jIfhF+I7jI
 c4itAyzOv5v4//wNPCdu+q1w2ygbDQ2VJXb8vpYXo9GykFXCZ/mI+ROZ2u4nUtRJfmlk
 ArYuvJ9mTVAbV8Egf1+H3FIKkCENPN33ps7Ve//hjQ2rvACJoMfbU9cR4LbiPq6+PS4M
 gQADStUDVN/LD86Doce6v67aMmJqRp50IYK+OgSa3b/nAe6B9MFlW0mOTOBp5+ZlWH1B
 OfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694851339; x=1695456139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tnf03Q7+288TJsyd7lSqF33vPvOy+ywzsBcRMgBbA/w=;
 b=KD/57abey0YMDVoyxBAFFA6QbO3GyZTht26v964bAel9GtAmPCntJlhP3uVxRkKSOK
 PZiFPB++bOJFO1ggLqxv3K5g3lrjrTzZoea24PP4pE6tB5EpKbW/3I/X3nUFA/e1HTj5
 LSYqaRvKEYnzHyk3Co4bY8AsTWt+Mz0mRR0AP4Vw96ohx3+/cF+Pcg4eXlUzh0uVN1cU
 brsDLj/wUaoYW6P2vQmAAAmgiKQkk1U+cbdcDhWomWIJ4cRB/cJMWGrZqQ8amROCEtLC
 1Y/aQtE445KR8YB+hAgYsD0mJFauWztA9hS+GgtMsOOY4AHdpITGRTHw690UpF/yP6lG
 ZOSg==
X-Gm-Message-State: AOJu0YyUv9jwA5+ZeOOVPkWRv08rPGfM0I3o7Rdg4LBHCp2s+VAK58AV
 4lbiwspVW9iwIrazvdnFUVRhJnjFcFh6eWAPgjY=
X-Google-Smtp-Source: AGHT+IG5ylxptxqrsqMDXDxOX5FX2lPnsuYBAo9rVpjiC8hcbcg1obJnCwHBwkcdrMC6mKnoAJx9Rg==
X-Received: by 2002:a05:6a20:3d1d:b0:131:f504:a631 with SMTP id
 y29-20020a056a203d1d00b00131f504a631mr4703700pzi.51.1694851339293; 
 Sat, 16 Sep 2023 01:02:19 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b0068a46cd4120sm4029484pfa.199.2023.09.16.01.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 01:02:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v8 02/19] gdbstub: Introduce gdb_find_static_feature()
Date: Sat, 16 Sep 2023 17:01:19 +0900
Message-ID: <20230916080149.129989-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230916080149.129989-1-akihiko.odaki@daynix.com>
References: <20230916080149.129989-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
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


