Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ED07CEC1E
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 01:33:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtG0u-0003wH-R1; Wed, 18 Oct 2023 19:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0s-0003fx-Df
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:42 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0p-0000I4-TU
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:42 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3575287211bso27379195ab.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697671899; x=1698276699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KeKGrdrxTYoWvojPluBjviNWq1U0AbGSCGNtTdLurtI=;
 b=RjcgIrZ4kB5mPpL2skFbOjOpDzAVP4HGYyuYWAQTyacyOLElsoIBi6XQ9cjbvV8MEy
 cOCHFbNhvG3HPlW+7Gdw4HRds5iYEAF3pI+n7LAVrLN9xTmVbp8Qmtc2DTKY23xxGrn7
 ACXcaZxKhKuGq6wJORMme9JVCPltiqr3OtB0a7Y2MLAN4XF4xGHSa9B5vz3r8+lb5q2M
 /LQnOqp1ByiHre1Ov5qYl2j9/XrLOtvCFDZSFdpHuycrdFFogTb/rrzgnva7L1j8vjeF
 Wd0FrvMSSt19jC0+4pCBVyxs2mcefA0x1gAlHEUAz7Ew0KWdp6K0b3twhFRfETwsBKU9
 ckrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697671899; x=1698276699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KeKGrdrxTYoWvojPluBjviNWq1U0AbGSCGNtTdLurtI=;
 b=xOKSAOc2HvHgByr7s0wMX07wfBaanj8Vf5f5YNJFv+Un/bzo1ZkPWJBAxEMRLoxmzF
 LHC0c/V6odnCw3elcz/Z7+esQDwFiGSqZ6BGt0yjsnkE+d+aObL88AHVgAIjq9FwZWTJ
 ujac3VdweoaG7UkS3RTObvALIShEfalPKQTeKzsmRhC1gyG/0ZDAl3vSpf/R+f2lGJGG
 lF8c/+SxRISBuz3W5Z+1g5vdYwjPK8QUNIGfKp6JYZJZsWokGSVR5ghMoU5/yPBchHBB
 W11/w6AqX8DMWvZqCAVLI3yrcpA8OkOHa5JvoZnJfY+3TXQp9eLVqz2N01OoEB/dKA5+
 4emg==
X-Gm-Message-State: AOJu0YzPXdSpgQ7FrMh9chLmYlHV8T/8FS2yEEMnBCtPp/kwZlrVGQp0
 tv2fnw1i6CXnlMLsxdE9G0f4vmNRR3KsXnnq1tQ=
X-Google-Smtp-Source: AGHT+IEHA6tQBbDHug2NbTbfjbuTtNCzZaI3DlsHU6EhtA6APOcIzUY1OeXNwC43dnDUFhUQvge5ig==
X-Received: by 2002:a92:c262:0:b0:34f:a4c5:8eca with SMTP id
 h2-20020a92c262000000b0034fa4c58ecamr999999ild.27.1697671898776; 
 Wed, 18 Oct 2023 16:31:38 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa796a9000000b006be5af77f06sm3881690pfk.2.2023.10.18.16.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 16:31:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>
Subject: [PULL 04/14] linux-user/elfload: Enable LSX/LASX in HWCAP for
 LoongArch
Date: Wed, 18 Oct 2023 16:31:24 -0700
Message-Id: <20231018233134.1594292-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018233134.1594292-1-richard.henderson@linaro.org>
References: <20231018233134.1594292-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12c.google.com
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

From: Jiajie Chen <c@jia.je>

Since support for LSX and LASX is landed in QEMU recently, we can update
HWCAPS accordingly.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231001085315.1692667-1-c@jia.je>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 213fd3e584..2e3809f03c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1237,6 +1237,14 @@ static uint32_t get_elf_hwcap(void)
         hwcaps |= HWCAP_LOONGARCH_LAM;
     }
 
+    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LSX)) {
+        hwcaps |= HWCAP_LOONGARCH_LSX;
+    }
+
+    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LASX)) {
+        hwcaps |= HWCAP_LOONGARCH_LASX;
+    }
+
     return hwcaps;
 }
 
-- 
2.34.1


