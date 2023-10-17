Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE94A7CCBD6
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 21:10:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qspS2-0004WQ-Bg; Tue, 17 Oct 2023 15:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspS0-0004Lx-4D
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:09:56 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspRq-0001bL-JE
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:09:50 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c9a1762b43so48729635ad.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 12:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697569785; x=1698174585;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5iKyNrMNpb32xwXmKX8FoAKMAx545fFQbRP901F9ZY=;
 b=hqTAEEu1HCk0L8pRio8U8Vc4DmP+6ziueCL2WYm0+yRH6X7uA0C0F2OEmjL9JIzeXv
 HpxDKZ4fNKjdvaqWRWja8Z+4QNzVcKPXYHdXoNkOJN+g0GgX4iwMKhh5u9Fd1d4C2hHb
 MBJU11ENjdKUh6MeTMrE0UBQLSsw6lUV0pZ6MEKOVU8EDiGARa2yBmAdjq49M9w6hK8E
 5G6Y+qdosFFdm3HyW9D1guh063imThh0fT6OJfJ79D7rPLnbuAZQcotCoz/hr61ZUhig
 gadNvWRjR9a31ylZMYlXpv/xuKD5nsEBcNMEdfPnavJWAho5JgwMEV2VSwQ2Isv8ENYn
 W0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697569785; x=1698174585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J5iKyNrMNpb32xwXmKX8FoAKMAx545fFQbRP901F9ZY=;
 b=oVMGyF9uVu1oX537LUMlrAHA+wB7uxMcdIjNv6f1V82RCDGen8d3QxTb5QbM4NC8N3
 k82G9Rv5bfrwM7Jo5TW4vj05Knqp369OBcvyT/nBUWcDC8hbkghRQRBYkIcB830tBHsp
 mtuWaZjRpo0ScC4JICA5muIOflUYqUC0EbYDR5B7GogKMxa7fnBPExXPhNfX45RDqGhO
 zwlTHOn8BCe6ywBFUZPwmsZJa9fz6ddvl4eOKznCCb1Nht2J4Cm+vc1yaQXjDVU6lmDc
 snPnB4uWZ7GbtIAPm+WnvgD6U8xvBKCZZRNwWVdE4NQI49JfRKSvU9Twmrbf7ky9yygF
 V7ig==
X-Gm-Message-State: AOJu0YwE5mqeI+X5WUGAfx4UaXtz5Q09iZOyxmtuP3gz2T7AzSfSQU4x
 UyNk4/nPs0FRJkwfg1zHQ5GMMg==
X-Google-Smtp-Source: AGHT+IH0hhG+p2MdSUL+tjYYbtkpAkogWcQC36DgFzFyTDKxkxwOHocueSnUHT6oSFHvgYdI+XNLaQ==
X-Received: by 2002:a17:903:41ce:b0:1b0:f8:9b2d with SMTP id
 u14-20020a17090341ce00b001b000f89b2dmr4416638ple.29.1697569785304; 
 Tue, 17 Oct 2023 12:09:45 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 c3-20020a170902d48300b001c74df14e6esm1952496plg.51.2023.10.17.12.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 12:09:45 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v13 02/18] gdbstub: Introduce gdb_find_static_feature()
Date: Wed, 18 Oct 2023 04:09:12 +0900
Message-ID: <20231017190931.16211-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017190931.16211-1-akihiko.odaki@daynix.com>
References: <20231017190931.16211-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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
index 29540a0284..ae24c4848f 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -422,6 +422,19 @@ static const char *get_feature_xml(const char *p, const char **newp,
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


