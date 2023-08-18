Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 451437804C9
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 05:38:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWqIR-0001o3-LD; Thu, 17 Aug 2023 23:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqIM-0001n5-Ka
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:37:06 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqIK-0005l4-EK
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:37:06 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6887bc25e6bso378438b3a.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 20:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692329823; x=1692934623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hH5uAkW/k9Z9dLyMtvuw4MXrWWfb5c8J/Uw6jYKipsU=;
 b=pAcMDTQbFfseVeFStMSL3ECUOhCD+MlWQLceR7LlFBDmEDG24wb7tdw2wfwuPyX909
 gPHaOo/fcEluLWPm0N4m0NaNdwNf+1BK/9h6FaFcwJFOKbV/+p1/jtp0DfvEbZr++t1e
 ousWFl1dTZA0AnEsu0HGFru9j+9KNeAWcnMCxMJtOP8zCu5bl/CUxfEkFPw3TShoQCwZ
 HZkX7/OzKUCD69Z/Lr56CXk5FYQ+WQ722/TFnnX0a2x+Qg1e0LvYchW8RIj0k5xD37tl
 MJpyBmNpq9RHAUhTXU47VvN+1kX0pDNOrN+pIX02CyhhwxTIiy6zNndzTXYHbCciVZgn
 +DHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692329823; x=1692934623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hH5uAkW/k9Z9dLyMtvuw4MXrWWfb5c8J/Uw6jYKipsU=;
 b=MjyaqtBvfviWdJJ21S+CIPtVU5zY2Ev6uBe3tEoTpVcDBFULi8w4MAuwr7R13V5UlX
 gYz+jOUzyMQODzM6AhtzJj9GcVmcy0DauqRgNOXdq1ZePP88QeqEPzxCLyMOME1uet/T
 MIUyeHv+84I0SOq3WsjkqOuqfcVUTNTDu5OQfBVF4njHiEtZKW5cwm95VBm9AyC6AHZB
 8KkcuHI5RIllr2hAzFz9CVZ8om26Ous7wygnsDkrIsyWcg2fr6GEZoadPCNPqHdbZGLf
 X/0IP6Kv3lozO/489+S5Si6kDIUZ6F93AxCsPSmEmw6ICe15gsyl8aTrCVUMtth4VksO
 QuAg==
X-Gm-Message-State: AOJu0Yz5fQCQXUYdcfeu7tKNYaxSw5+3kG9k0jT9dDkXhtbIlgw0AycM
 nycvTYRwPKt78P31v4nrlTrgYA==
X-Google-Smtp-Source: AGHT+IF5HKpr4rcvq1cfx1cnAJYURBUdQGJl7IxHLgK/uuphkORCUKLO51uDmyTP16QkMv2rLzhalA==
X-Received: by 2002:a05:6a00:1810:b0:67a:a906:9edb with SMTP id
 y16-20020a056a00181000b0067aa9069edbmr1752667pfa.30.1692329822911; 
 Thu, 17 Aug 2023 20:37:02 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c24-20020aa781d8000000b00686a80f431dsm484135pfn.126.2023.08.17.20.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 20:37:02 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH RESEND v5 04/26] gdbstub: Introduce gdb_find_static_feature()
Date: Fri, 18 Aug 2023 12:36:23 +0900
Message-ID: <20230818033648.8326-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818033648.8326-1-akihiko.odaki@daynix.com>
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
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
index 9b484d7eef..d0dcc99ed4 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -34,6 +34,8 @@ void gdb_register_coprocessor(CPUState *cpu,
  */
 int gdbserver_start(const char *port_or_device);
 
+const GDBFeature *gdb_find_static_feature(const char *xmlname);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /**
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 2772f07bbe..f0ba9efaff 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -414,6 +414,19 @@ static const char *get_feature_xml(const char *p, const char **newp,
     return name ? gdb_static_features[i].xml : NULL;
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
2.41.0


