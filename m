Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D4C7B6FE6
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:36:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjEy-0008Mi-Sx; Tue, 03 Oct 2023 13:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEg-0008FU-8N
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:10 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEe-0007S4-5i
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:05 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-690f7d73a3aso937289b3a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354261; x=1696959061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1zFZM0V0cx4lwmDbbxbCpwbX7YB70hzJOZ9UCN0zb+Q=;
 b=V4ZM71uuEfLKx384Tp0AshQspRgmLabwMRZf78Azp4lY3THIFA5TBoqOOu62ATfEfE
 dLOtTMGMOUwc3IBBuAosQ+mnqgAl8kDqGgGcg/SsEZl2TkaX+x2AAx94wRTHZOfUncRk
 JzVJGtxrP+CWGxFJmG+MYtw3QQdPQKwZvzAEii/mvuCPD1WUElB9XOOF3C7+mEtkjVLV
 0jXXi2jY0QnVbcd8mH0NE1yZUIl6LJNL7w1WpG34zxrdIbn3Ad3nkLjyw8yH8hFHwHYr
 emjRGuxnB3IgSMZA0BF0KODWyGqtJfsB0VbBvMj7GUM8jQKJHVleWlGJTRPpB82UXoaY
 VBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354261; x=1696959061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1zFZM0V0cx4lwmDbbxbCpwbX7YB70hzJOZ9UCN0zb+Q=;
 b=OOP/T+fQ5+PaTYk5uh4uVOzRAgUKDx1CY+YpfaYu1Fp29zgIeDSkR8fQ6fW0CiOVON
 kgOMiRuaS7H0aylXnc3CUoQ0g7cb67eqgbf2pj586hemKIU9OpZ8cg7qGe/42lJ93LMr
 XTDXrO7jwyOeOvWk2JpwKkLWXEAybq/bSB1/lMYohtFoYXzZES/C7l9liLHjuHOujOsd
 foYYVYdimIVXi1IYhtBNGZ9i4Yh62010a3ig3LK44ZWxCFp+Lmn981ykm61hY4stBaxD
 4sEbR4/MFAKGLlg1FZsNAUkBJcD5C5inQoliXsHrLqcVAfBnKS3ov5p7DNawxFxnALTx
 zk8Q==
X-Gm-Message-State: AOJu0YwviRmRjEXh26McOppv/36M8HndPRTnDvkHB2xqfQC4mQoF8YGR
 lDfDaQ2rXsMW0hSC89zbFjMznr/+8h/wsVYSKFk=
X-Google-Smtp-Source: AGHT+IH2o5m9IxNYOTF351/Wzqqv24ZwXDQPOsj3q7WkIdM2A++sSUN3x+AZj1TMs+2A2Bv3Cj9qUA==
X-Received: by 2002:a05:6a00:b84:b0:68c:49e4:bd71 with SMTP id
 g4-20020a056a000b8400b0068c49e4bd71mr225522pfj.34.1696354260694; 
 Tue, 03 Oct 2023 10:31:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PULL 06/47] accel/tcg: Have tcg_exec_realizefn() return a boolean
Date: Tue,  3 Oct 2023 10:30:11 -0700
Message-Id: <20231003173052.1601813-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Following the example documented since commit e3fe3988d7 ("error:
Document Error API usage rules"), have tcg_exec_realizefn() return
a boolean indicating whether an error is set or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Claudio Fontana <cfontana@suse.de>
Message-Id: <20231003123026.99229-7-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 2 +-
 accel/tcg/cpu-exec.c   | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index c2c62160c6..1e5c530ee1 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -422,7 +422,7 @@ void dump_exec_info(GString *buf);
 
 /* accel/tcg/cpu-exec.c */
 int cpu_exec(CPUState *cpu);
-void tcg_exec_realizefn(CPUState *cpu, Error **errp);
+bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
 void tcg_exec_unrealizefn(CPUState *cpu);
 
 /**
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c724e8b6f1..60f1986b85 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1088,7 +1088,7 @@ int cpu_exec(CPUState *cpu)
     return ret;
 }
 
-void tcg_exec_realizefn(CPUState *cpu, Error **errp)
+bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 {
     static bool tcg_target_initialized;
     CPUClass *cc = CPU_GET_CLASS(cpu);
@@ -1104,6 +1104,8 @@ void tcg_exec_realizefn(CPUState *cpu, Error **errp)
     tcg_iommu_init_notifier_list(cpu);
 #endif /* !CONFIG_USER_ONLY */
     /* qemu_plugin_vcpu_init_hook delayed until cpu_index assigned. */
+
+    return true;
 }
 
 /* undo the initializations in reverse order */
-- 
2.34.1


