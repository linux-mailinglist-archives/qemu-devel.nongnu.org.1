Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D60267B7004
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:38:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjFC-00005h-RB; Tue, 03 Oct 2023 13:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEv-0008Kv-Kn
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:22 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEu-0007Ui-0O
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:21 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-578d0d94986so816294a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354278; x=1696959078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n7GxguJ2YETUygbuc4jTMl6jemrPoFbwC2XQ+KXAbU8=;
 b=GNWmuHOPhOTK2GzMEqvh4JULnas5KKfbzCV6idrqKqF9LyXppOa160roavjPby3kJG
 yJzqly5vWms7pWzBYaRZwdd04iJC1qsD4/kaGyXnFc6S44XEqZ1r/bwwXgj0Vp+nufHA
 ShvhNIaWBAyQxNiUJr4IcBA15E2x4OmUSoVvlvzMyZhr875H4H30YXM128f6wKPOEl9C
 kfL1b5qg7zW7R5R0Mrhom6oF8XLlJqOnxrth/XPmHJceFmbox05ouAQbCUn5OgKS0hIl
 oym75dXTIlgWvQtqSHB2VR5JDkFRGhbf9Q14OujlbIVmsgO73QTCNI4yPNUWdeL0Koiq
 aL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354278; x=1696959078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n7GxguJ2YETUygbuc4jTMl6jemrPoFbwC2XQ+KXAbU8=;
 b=vWMOhLrAbvOX+xtJDNv6hLNXhZovzfoQnyqH9yEBJuBebAW5HixFPk054yoIrfPEmr
 feMvR4EgCLJy9PjpDBhJUfojWQUcDCjsKbF8qzk7iBExcRjz56wQbEVsfDT6OkKcRZVB
 IMp0V3zkJP6uHFRjYb5l4Jr0iYCjT5VAB24kpAI+ExQADfCTDlZ868w+SZaE4x7pXwlU
 A/4w3nQzcSGXaaJibgw0uo8sp7mEcZ01Wy6kI60SGbEWhUnMYqy2nVauc0hesvH28Kcd
 u0nA4ruNqYg8KDncEAGm10YHR4TIWuxktrXqqiffX7zt1s8DtTLmqNdm0haCGSKTLRXD
 NW+Q==
X-Gm-Message-State: AOJu0YyT7ihETVnVIRiW8tGf5ykKuxaCwacvleX7ldranuxejyoRZp3Q
 4jGn0DgQqVTSbwKrEXJnwruQqtRR2MPk5F2SFgE=
X-Google-Smtp-Source: AGHT+IEylIAE1lTMx3pjT+zfZbMDbWQx83Hznt8+SQkat49ACJ70tk8Qh+f+02EXK1rmQPFbRP80pQ==
X-Received: by 2002:a05:6a21:7892:b0:15e:96d3:a31b with SMTP id
 bf18-20020a056a21789200b0015e96d3a31bmr159521pzc.39.1696354278323; 
 Tue, 03 Oct 2023 10:31:18 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/47] accel/tcg: Remove env_neg()
Date: Tue,  3 Oct 2023 10:30:26 -0700
Message-Id: <20231003173052.1601813-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Replace the single use within env_tlb() and remove.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 9d8ab050c2..46e494eeba 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -449,17 +449,6 @@ static inline CPUState *env_cpu(CPUArchState *env)
     return (void *)env - sizeof(CPUState);
 }
 
-/**
- * env_neg(env)
- * @env: The architecture environment
- *
- * Return the CPUNegativeOffsetState associated with the environment.
- */
-static inline CPUNegativeOffsetState *env_neg(CPUArchState *env)
-{
-    return &env_cpu(env)->neg;
-}
-
 /**
  * env_tlb(env)
  * @env: The architecture environment
@@ -468,7 +457,7 @@ static inline CPUNegativeOffsetState *env_neg(CPUArchState *env)
  */
 static inline CPUTLB *env_tlb(CPUArchState *env)
 {
-    return &env_neg(env)->tlb;
+    return &env_cpu(env)->neg.tlb;
 }
 
 #endif /* CPU_ALL_H */
-- 
2.34.1


