Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03831791B55
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:17:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCDK-0003oF-5q; Mon, 04 Sep 2023 12:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCD3-0003O6-My
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:13:57 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCCz-0007dJ-Fx
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:13:53 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52713d2c606so2185766a12.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844026; x=1694448826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07RpMt5MApgRw9NJGh9PZXX3Pgabrwsg/tvmA1poNBo=;
 b=c/973/uTe+N/IQykusnsMFRVUVB2N7JThDoD1ZZmid2KoFWyS206xgELMhWyjUvzhn
 Nj+656nMRl2zkTuSE9/MBHrlQn6kGelrB4clh1Sj8r1ZeaCCKqTEGt4JxeiZxAImz8zR
 w9tJNqlj7zvwEVPzW6SK/HR05/TJImooitZZiyeilD+0YMsqZJsMoljA8fGZW23exoVk
 /RWH+8ZNPQQmL9JAIBSWFWRvRWXt9czo6jVNryq6C+ddIYjXsY0c28t1Qe5eegAUn9B3
 Th+J3uBcEZgGsbGGb1AjKTNMWhOlBuf6NbSUWxm9ooPaIBdtKE8+Erv/uNyKewQ+kuV4
 +sSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844026; x=1694448826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=07RpMt5MApgRw9NJGh9PZXX3Pgabrwsg/tvmA1poNBo=;
 b=fCu8ZyvPTzZCvWrVnv4ikKhtolt3NHrzjYWMQYPsNz0iqnn5oF1QS1wTHbI/8Ur9/2
 GZ5nsqRldgojtjCt8KD3Zoo2Klvn6mtcNWQ6Y8YAGk7sSjr746N52RxM/3FuU4KbD6D5
 sFiYLR5SY5Km2YesOtT3mN1ykURd+FJx7BaS+Q5pqSyt+zhAF7hd3Rmas7AT/cHIcJOA
 +a9EGRSS7CLKUdRmeM2MqS8UmIEbR9qLaxtS9CF5VHrcYIP9VzqTfC47bgal8RqgfKae
 mmUYenyoad2Yggu8wPPi2Voe12PRIgS8+Y0ZmBjeN7MfuwjC/sSITkYeb9Ay7oPMKqLF
 MZ5Q==
X-Gm-Message-State: AOJu0Yxd9LyRY5Py2ycO4R+DbZG9fUgWtUghrmc7ZZBoIcgtZfwIyM7P
 DfLIrpkA+l7p9jo+s7QhWwHDRA==
X-Google-Smtp-Source: AGHT+IEtq9JxWRLoj2Kdb+nqAOkU2tICmitdfMIBGyajNBDR8U1ynZry61tv0wwMLuDNm4NB0wjFkQ==
X-Received: by 2002:aa7:d6cb:0:b0:523:d8bf:3298 with SMTP id
 x11-20020aa7d6cb000000b00523d8bf3298mr6739551edr.17.1693844026378; 
 Mon, 04 Sep 2023 09:13:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 b22-20020aa7d496000000b0051dd19d6d6esm6048130edr.73.2023.09.04.09.13.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:13:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 12/22] hw/m68k: Clean up local variable shadowing
Date: Mon,  4 Sep 2023 18:12:24 +0200
Message-ID: <20230904161235.84651-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904161235.84651-1-philmd@linaro.org>
References: <20230904161235.84651-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fix:

  hw/m68k/virt.c:263:13: error: declaration shadows a local variable [-Werror,-Wshadow]
            BOOTINFOSTR(param_ptr, BI_COMMAND_LINE,
            ^
  hw/m68k/bootinfo.h:47:13: note: expanded from macro 'BOOTINFOSTR'
        int i; \
            ^
  hw/m68k/virt.c:130:9: note: previous declaration is here
    int i;
        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/bootinfo.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/bootinfo.h b/hw/m68k/bootinfo.h
index a3d37e3c80..0e6e3eea87 100644
--- a/hw/m68k/bootinfo.h
+++ b/hw/m68k/bootinfo.h
@@ -44,15 +44,14 @@
 
 #define BOOTINFOSTR(base, id, string) \
     do { \
-        int i; \
         stw_p(base, id); \
         base += 2; \
         stw_p(base, \
                  (sizeof(struct bi_record) + strlen(string) + \
                   1 /* null termination */ + 3 /* padding */) & ~3); \
         base += 2; \
-        for (i = 0; string[i]; i++) { \
-            stb_p(base++, string[i]); \
+        for (unsigned i_ = 0; string[i_]; i_++) { \
+            stb_p(base++, string[i_]); \
         } \
         stb_p(base++, 0); \
         base = QEMU_ALIGN_PTR_UP(base, 4); \
@@ -60,7 +59,6 @@
 
 #define BOOTINFODATA(base, id, data, len) \
     do { \
-        int i; \
         stw_p(base, id); \
         base += 2; \
         stw_p(base, \
@@ -69,8 +67,8 @@
         base += 2; \
         stw_p(base, len); \
         base += 2; \
-        for (i = 0; i < len; ++i) { \
-            stb_p(base++, data[i]); \
+        for (unsigned i_ = 0; i_ < len; ++i_) { \
+            stb_p(base++, data[i_]); \
         } \
         base = QEMU_ALIGN_PTR_UP(base, 4); \
     } while (0)
-- 
2.41.0


