Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA78D791B37
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:15:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCCE-0002KS-Jo; Mon, 04 Sep 2023 12:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCCC-0002JX-3q
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:13:00 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCC8-0007T3-Jt
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:12:58 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-52a40cf952dso2130459a12.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693843975; x=1694448775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/QPTGpqE19ojkMQkX2Y6AuPNy2skSuX4jI00wN8BZsE=;
 b=lfmrOEobDHYx2daOffwn7VWFk/BOR5dQTb/Urw2mv8NYwlrMaS3CX/6UmcRdof9T5E
 ZgSnFxRothI+YSWgRZ6RqW54LnOXVCv1h0AFkl/a6c2mYAxouP8qM/ZkBWYdbhjiEjRJ
 WnWO0vseRHXCEgkgUO0ZYXAb/wzTRMsvHGzJHdcwiss/Ku1J4l88g7BhenAEqJicsm7V
 snzZ2HLMdVNpuwqkRLfAAEhu2KNiUz+UYpocZRyjkAge7+Addkvrw/o6V0YHod8/YaqF
 kA95FHvrQoIm8QZTTfaPf3eOZ8DhvcjflPNCS3ByG4LgDk/TrPsOlZ0Kkl94rouAQI72
 EB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693843975; x=1694448775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/QPTGpqE19ojkMQkX2Y6AuPNy2skSuX4jI00wN8BZsE=;
 b=ScGe5OLinxCWjo6CFUfshb1uoMKdwgMJQTWVEUB09duwwSdD3F+CTT2/iF3DzVegju
 Re+elZe1LU/opmZGxpMTeotHUynDiYh2Id9hyT7Cy30TnaSvuGiu7C5a5ydYZgBoXTfE
 +pv5Pv8g4cmuVLYd968MdIkYkuxEyC+JVUYlV/+d7c6M0ORSjbYr0mwu2CLzz4zJvslx
 e1Jl3WwLoYQcx3YYW2TwOkY4MTOt2comMjEIH+wBPtVbJbc8KOlIZ8ZV7nWE4kQdVwvS
 cgLOMW1ZYOlVOhFnnozHL5jU3TMWZC70MQxKhKd5UdFCtRuDsQDyBxCDGGnB0qKNAed3
 NzFw==
X-Gm-Message-State: AOJu0YzWXiHkF7K0AskPaff39wdAilBzUKJHt/dpnBmA0B/DwN18X9oQ
 Xkx6srEc1cY/o34SYJx2bOkUAe7SRMLxXHo8UAY=
X-Google-Smtp-Source: AGHT+IF0u271HXLJdyLIzkSETZzSvaAbeONIx04oZhlM6TFoV9M0v1NZlMkamwkD95Heltkmj6KABg==
X-Received: by 2002:a17:906:1bb2:b0:9a6:69bf:fa5a with SMTP id
 r18-20020a1709061bb200b009a669bffa5amr599075ejg.63.1693843975220; 
 Mon, 04 Sep 2023 09:12:55 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 g3-20020a170906594300b0099cb349d570sm6327357ejr.185.2023.09.04.09.12.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:12:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 03/22] target/arm/hvf: Clean up local variable shadowing
Date: Mon,  4 Sep 2023 18:12:15 +0200
Message-ID: <20230904161235.84651-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904161235.84651-1-philmd@linaro.org>
References: <20230904161235.84651-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

Per Peter Maydell analysis [*]:

  The hvf_vcpu_exec() function is not documented, but in practice
  its caller expects it to return either EXCP_DEBUG (for "this was
  a guest debug exception you need to deal with") or something else
  (presumably the intention being 0 for OK).

  The hvf_sysreg_read() and hvf_sysreg_write() functions are also not
  documented, but they return 0 on success, or 1 for a completely
  unrecognized sysreg where we've raised the UNDEF exception (but
  not if we raised an UNDEF exception for an unrecognized GIC sysreg --
  I think this is a bug). We use this return value to decide whether
  we need to advance the PC past the insn or not. It's not the same
  as the return value we want to return from hvf_vcpu_exec().

  Retain the variable as locally scoped but give it a name that
  doesn't clash with the other function-scoped variable.

This fixes:

  target/arm/hvf/hvf.c:1936:13: error: declaration shadows a local variable [-Werror,-Wshadow]
        int ret = 0;
            ^
  target/arm/hvf/hvf.c:1807:9: note: previous declaration is here
    int ret;
        ^
[*] https://lore.kernel.org/qemu-devel/CAFEAcA_e+fU6JKtS+W63wr9cCJ6btu_hT_ydZWOwC0kBkDYYYQ@mail.gmail.com/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Peter, feel free to alter the commit description if it doesn't
sound right.
---
 target/arm/hvf/hvf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 486f90be1d..0715f8a01c 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1933,16 +1933,16 @@ int hvf_vcpu_exec(CPUState *cpu)
         uint32_t rt = (syndrome >> 5) & 0x1f;
         uint32_t reg = syndrome & SYSREG_MASK;
         uint64_t val;
-        int ret = 0;
+        int sysreg_ret = 0;
 
         if (isread) {
-            ret = hvf_sysreg_read(cpu, reg, rt);
+            sysreg_ret = hvf_sysreg_read(cpu, reg, rt);
         } else {
             val = hvf_get_reg(cpu, rt);
-            ret = hvf_sysreg_write(cpu, reg, val);
+            sysreg_ret = hvf_sysreg_write(cpu, reg, val);
         }
 
-        advance_pc = !ret;
+        advance_pc = !sysreg_ret;
         break;
     }
     case EC_WFX_TRAP:
-- 
2.41.0


