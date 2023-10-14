Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B0F7C928E
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 05:40:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrVVM-0001mR-Vm; Fri, 13 Oct 2023 23:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVVK-0001mB-Rf
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:39:54 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVVJ-0004cI-Bi
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:39:54 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-57babef76deso1472343eaf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 20:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697254792; x=1697859592;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3PWtMrj/7GIQTPZRsZK/to2jQcfRMu2yEW9CgHJJLA=;
 b=mzSwICdiCIsFGKs87njOLuo9eJw5EL45FwRbGe0OBYCKCslc3yxKx7aedhGt4M0/Fr
 3m9LRwO4MIY7Ldrv9Dd58nDMb06m330T5OIMadxPxWEyds/rxZ0P+WylornJioxsHSbB
 bbcRh5ywvG+R0advbLk5tnCzQzNnqmGv4c3Mj5j2yNPv+/mCLBU+6FxAewFmAslTj8ZB
 ET7hh2TG51LOtDpDh1LHrwLcWsSw+Va/s3KebSzH2QkMfHkE5rnsmyR9BuOjuLWqjpq5
 ikgcwQ3RfbKSqU3nd5cTSqzO2JGy7BHBo02ZoqI9aQGC5zq1jgVpuR78qqSacSpRQt7q
 84SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697254792; x=1697859592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e3PWtMrj/7GIQTPZRsZK/to2jQcfRMu2yEW9CgHJJLA=;
 b=AYFCbolK6o8w0ZV/AJiMoVZMDKG358uVwW7dRmfGYLSdFxVLu98mmRPi0819SHWLC9
 bw+f8vUVfQpd4A7q7Uf/S0U5zjBeaudZSLurel8lUdgxxd2hcVZMJP4g1UImWPDiVft6
 AYh+ds/bNv14p9ekfDg2VwPzi37DZP88mepQGWFzsQ5KZZtrBpRLi8FIuc+2K4eyHOYe
 llsr6XrqpIHnQYp9R7+TQXa6PxoCKWdVcu2hrFn6v3fwItpdM0y5pPi9C9G7vTGOM73G
 87CBJ9nQqBmAYjUfiqGR3VbHOBZyX8eLNbB0FzJ3p7Fcr3L8jaN9rfRrI+NP6r+coNoG
 dTeQ==
X-Gm-Message-State: AOJu0YwKNueBseHr5CRj7OaWyVX8Urd5flz6c3LCTCqASaqto8gpEbof
 21jCR8SDtREtZFwentXhGthrdg==
X-Google-Smtp-Source: AGHT+IG28iU1cxHWKkvm3eoG/gq/nd8w35KDa4cE6kzcKOH1JZdz8D6b1dwa5mBQA7gX1WmND/k+bA==
X-Received: by 2002:a05:6358:921:b0:143:8f7f:9150 with SMTP id
 r33-20020a056358092100b001438f7f9150mr32871309rwi.13.1697254792259; 
 Fri, 13 Oct 2023 20:39:52 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 b4-20020a62cf04000000b006926d199fdcsm1681550pfg.190.2023.10.13.20.39.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 20:39:51 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 02/18] gdbstub: Introduce gdb_find_static_feature()
Date: Sat, 14 Oct 2023 12:39:21 +0900
Message-ID: <20231014033940.15679-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231014033940.15679-1-akihiko.odaki@daynix.com>
References: <20231014033940.15679-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c29;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc29.google.com
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
index 1e96a71c0c..f7f9566740 100644
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


