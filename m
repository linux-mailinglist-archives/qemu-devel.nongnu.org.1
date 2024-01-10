Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A42498295E0
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:09:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUSK-0001W9-25; Wed, 10 Jan 2024 04:01:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSF-0001JM-W7
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:56 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSD-0005Al-H4
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:55 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3bbbe583e04so2377220b6e.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877252; x=1705482052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PU6Ueeeh90sUK8jzNNcOqoNQ/a1N5Q1K2FQlbLJ6+j8=;
 b=HtiFMeQV8XHV+ssoDe8EdaCHI8fierK3UbUcNsWDddh07giGJnp4xz/OGH5DV5G1jq
 aHgodA98SRFylSAQxGzqLgUqAdLRYdrcRFikvD5MEVvSS/yMaLpWerFkeyhWCYS9KS0v
 zk8pSyZ5+PJ+TimqWdtjqhtX/xpEBlLjmoAyGuHCzhI2/3SXBCf9YODAGjQ4N2abewYn
 fhFNCOQ3jTxCYZzgP5zf2U1jUMhBvJXCu8cMOF4EVvLcdLKN49HydgrNWdZlGo/aYYvW
 deN89vtugoQz1FO2CDGpoEkGenZbDgHqydoLWyw4WRLbpN207oKuqEh61AGEerKYA9PR
 X4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877252; x=1705482052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PU6Ueeeh90sUK8jzNNcOqoNQ/a1N5Q1K2FQlbLJ6+j8=;
 b=izykpyt1vC7kIdeGfR8tfisW27ZO0C8Y8p15oRqHj5fVpzK+GP+2W5y8N76Pl4QUtT
 lnPHaOE4n0e97TkbynqbQGoMHt2VrTf1qchhOIBR381SFgTJjn/V/wcTEnPmO+S4qMa3
 oTwOgYUeb6UBtmA0h2WJnWLH9jurePGdHTycm97vOq0UU85OqCM8d5nsoBem4AuaPzCD
 PV5c7ZGkUXeeT3TFVj9778ycV7T2/a+b1duAwvCJ+wZcVzdO873ZIH9k7a5/N95TiUmI
 cOGN2/ZCdUpOOzrePsGQ3UiCD4WuJlKoqFVzVoYUDJNf0xhysEfedjP4ShVHAxrJkEUJ
 sN1Q==
X-Gm-Message-State: AOJu0YzRoZNSH6atOazEuyaM64y3sh0GTnlxX+QNx+dbYVLM3pg0Fduk
 1fkRezPVLTd3xgQDg7T+WQL3c4mAl1qUeBpI
X-Google-Smtp-Source: AGHT+IFv43Q7N0FsYKf6FNFMElEtMgtMc0MBdIz/MC5CI7DTURUDcN2OoEl6kNfwaE6v52tKcFkAsw==
X-Received: by 2002:a54:4417:0:b0:3ba:11ee:ac86 with SMTP id
 k23-20020a544417000000b003ba11eeac86mr598031oiw.102.1704877252004; 
 Wed, 10 Jan 2024 01:00:52 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:00:51 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 49/65] target/riscv/cpu.c: finalize satp_mode earlier
Date: Wed, 10 Jan 2024 18:57:17 +1000
Message-ID: <20240110085733.1607526-50-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Profiles will need to validate satp_mode during their own finalize
methods. This will occur inside riscv_tcg_cpu_finalize_features() for
TCG. Given that satp_mode does not have any pre-req from the accelerator
finalize() method, it's safe to finalize it earlier.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231218125334.37184-22-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 563fd4f722..65f69a7dd3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1054,6 +1054,14 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
     Error *local_err = NULL;
 
+#ifndef CONFIG_USER_ONLY
+    riscv_cpu_satp_mode_finalize(cpu, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+#endif
+
     /*
      * KVM accel does not have a specialized finalize()
      * callback because its extensions are validated
@@ -1066,14 +1074,6 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
             return;
         }
     }
-
-#ifndef CONFIG_USER_ONLY
-    riscv_cpu_satp_mode_finalize(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
-    }
-#endif
 }
 
 static void riscv_cpu_realize(DeviceState *dev, Error **errp)
-- 
2.43.0


