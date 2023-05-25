Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C754711A9E
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 01:28:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2KLl-000612-Dd; Thu, 25 May 2023 19:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLe-0005v4-1I
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:24 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLY-0005qH-3Q
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:21 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-53474b0c494so104563a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 16:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685057175; x=1687649175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmTrzaAymfCp1fyYj9R9fztmY/GgYJekROiEVCv4rCU=;
 b=D95VQ1tRvJ2i3Xtl/TXHyO428ZCDEjHiiy8RNMauvE+2eLnZBxLjEPgwbOzI0AWKXd
 0XlxlhGhDHyiGaEBF5z4ud6GED4fHoe0WusI1HIhYf/z8pSjugPfR3AZVqCcTLaIFo7C
 16T7hOzI+/PVgW6RTirRgIjquhDbP9Wexl2tVagA5WXLFML9bE31byxjFIVBODpNPYDb
 XWMHjfy02fekXFX7zvaPpXVtsUxd2ujNdi2tMlC/6A52GXwDmIiY5YIgWVyucBDjeAeL
 EwAJRMxEc9WA8GavvLekx9S4HUO+tm1FDpx1qVx4uii2t3lOD1+PAswd71IWJrM1jIAZ
 OR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685057175; x=1687649175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HmTrzaAymfCp1fyYj9R9fztmY/GgYJekROiEVCv4rCU=;
 b=EqgvEUpfyu89r6X82AO8kmDxUxUqiW65g5a6jqBxI49Bqx2yzjS4udIWBtUsWB2/QU
 MOi4LAt4/khSC63ORJJ1mK7aJmke+jphZm2SLm1640XnNQob/x8fZhxMVfF8apf38LjV
 cgui79lBXDnlxDCcT50ljMYF9q3zIZ0EhCq+tGLuWIk/BQQ0GRfHtIQG81grNN5Tk+c6
 ZZ61IEdquz+XUJP6ZQ753XMM7dbDXAfa1tA2X1+0GeiIpZze3xbdzCrW6ADg3oP73w6r
 CWSC3BpDcjnmnAO5wJbKZOTyTYCy5vUwY7oK6QzU5OO4WClSnaeBEtUDK11hGzvdm/fI
 p5Fg==
X-Gm-Message-State: AC+VfDwugwddK0qB70jxXJCV6eWjqQQHOZHNlKmbBjdPd0TKSTgXLc1v
 8aoNfK0TiQhr4lYCyr1vI4HQFcky85DxqX8gCU8=
X-Google-Smtp-Source: ACHHUZ6W3+CtCGa/Vlb1gO1efMmjrySNNVNZTh4vbgi4wEI4qCCWX2l/aVktLLt9WGy9Zif0NDc3kA==
X-Received: by 2002:a17:902:f686:b0:1aa:f78d:97b7 with SMTP id
 l6-20020a170902f68600b001aaf78d97b7mr433101plg.46.1685057174934; 
 Thu, 25 May 2023 16:26:14 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b0019e60c645b1sm1885036plg.305.2023.05.25.16.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 16:26:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 19/20] tests/tcg/multiarch: Adjust sigbus.c
Date: Thu, 25 May 2023 16:25:57 -0700
Message-Id: <20230525232558.1758967-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525232558.1758967-1-richard.henderson@linaro.org>
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

With -cpu max and FEAT_LSE2, the __aarch64__ section will only raise
an alignment exception when the load crosses a 16-byte boundary.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/sigbus.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/multiarch/sigbus.c b/tests/tcg/multiarch/sigbus.c
index 8134c5fd56..f47c7390e7 100644
--- a/tests/tcg/multiarch/sigbus.c
+++ b/tests/tcg/multiarch/sigbus.c
@@ -6,8 +6,13 @@
 #include <endian.h>
 
 
-unsigned long long x = 0x8877665544332211ull;
-void * volatile p = (void *)&x + 1;
+char x[32] __attribute__((aligned(16))) = {
+  0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+  0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10,
+  0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
+  0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20,
+};
+void * volatile p = (void *)&x + 15;
 
 void sigbus(int sig, siginfo_t *info, void *uc)
 {
@@ -60,9 +65,9 @@ int main()
      * We might as well validate the unaligned load worked.
      */
     if (BYTE_ORDER == LITTLE_ENDIAN) {
-        assert(tmp == 0x55443322);
+        assert(tmp == 0x13121110);
     } else {
-        assert(tmp == 0x77665544);
+        assert(tmp == 0x10111213);
     }
     return EXIT_SUCCESS;
 }
-- 
2.34.1


