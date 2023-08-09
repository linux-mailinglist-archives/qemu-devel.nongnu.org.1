Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 512B37766B5
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 19:51:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTnK4-0000PA-OO; Wed, 09 Aug 2023 13:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTnK2-0000OB-Sm
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:50:14 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTnK0-0005ex-Ct
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:50:14 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-269304c135aso27705a91.3
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 10:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691603411; x=1692208211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xcj9HS+1RTdAlktW4alp8Kdowh1zi8Bxa6GJVKLdPCg=;
 b=MvaYNLo62LXDxaLB/bW2TAJbhKLyo8tVqtTaPLfpB/58cKtPp9A/e0dH3o2qbwAZZ1
 jLtUHXxlAIF9WCZrhDqoX82OD2ykYZ6QCy4OdS9e9Wj0GmscIeDToMlzVJ8Z3X0G4lLc
 rfzjMbiuB+C/lyWRye0RzDLg02uyTjfPdRQR7row4P6TGI1aA+mFGIgZ6FBjaQiHHZg1
 J5HUkq93IqsttOocCxXUWtbfEbCD8VFfmBV02o7OcGCsbAtMcK1jV+OefUxgquzAdnSS
 VrRtVmrfzC6euAQTBrim5aU0n4uXRRVH1GBNnt5ssbiyRUA1iWMzObWZ6fPRCRBCjr9Q
 Euig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691603411; x=1692208211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xcj9HS+1RTdAlktW4alp8Kdowh1zi8Bxa6GJVKLdPCg=;
 b=au1MFe37GWVX4P1gnSRfDN0bKgGAm+K4XeU6TSTnl8aGgW8lMMOMmvsIEIvqreiJ2E
 8Py5BZg8PZL2mdDiUfcFjPfyQcmRxG1TpN0v0jSwf5yzfKkGxB26Nie4Aepeu3CREQ1l
 DJka74khDxyLge1fFBgnl4th/abyTtf6Qoz92pe+MayyBEuqpAJToQSOM0Nc1Wl9nr4J
 8xRzbYvB/2nlJUEn6SlHbNEA4GlqV9CUOV0i3VBz5gzUbEr+gXbPJiizjpNHyCnpOEaK
 30dEacKGX3TUaRk2Mz/zjYjM0zvOZ0J+oF8RyRYDXUBKM3A9wfa+/+uCvemLt3IDZZJg
 S2MQ==
X-Gm-Message-State: AOJu0Yyj3V+49zluSKyQCsNXlhrqoz9oo4O6PEoN6EYx68A9tO0XI2Qp
 9u5kC83LQ/2Zi9+/gtIbzWLj1/BnKokJy88Tp24=
X-Google-Smtp-Source: AGHT+IGwb/oPuRJS1JXV0YIy5/RAq4e/7yCeI8eE7o04/Kdi+Qlni4QdXGuClM3h2r0g13KIG8E5Vg==
X-Received: by 2002:a17:90a:5b18:b0:268:2523:652c with SMTP id
 o24-20020a17090a5b1800b002682523652cmr2946945pji.31.1691603411150; 
 Wed, 09 Aug 2023 10:50:11 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090a2b4700b0025dc5749b4csm1753710pjc.21.2023.08.09.10.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 10:50:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 4/6] tests/tcg: Disable filename test for info proc mappings
Date: Wed,  9 Aug 2023 10:50:04 -0700
Message-Id: <20230809175006.242479-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809175006.242479-1-richard.henderson@linaro.org>
References: <20230809175006.242479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This test fails when host page size != guest page size,
because qemu may not be able to directly map the file.

Fixes: a6341482695 ("tests/tcg: Add a test for info proc mappings")
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/gdbstub/test-proc-mappings.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
index 7b596ac21b..5e3e5a2fb7 100644
--- a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
+++ b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
@@ -33,7 +33,8 @@ def run_test():
             return
         raise
     report(isinstance(mappings, str), "Fetched the mappings from the inferior")
-    report("/sha1" in mappings, "Found the test binary name in the mappings")
+    # Broken with host page size > guest page size
+    # report("/sha1" in mappings, "Found the test binary name in the mappings")
 
 
 def main():
-- 
2.34.1


