Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 536E97C4B20
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 09:04:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqTGF-0007QX-4q; Wed, 11 Oct 2023 03:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqTGC-0007Pz-Hv
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 03:04:00 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqTG9-0005j0-Rh
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 03:03:59 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-57bbb38d5d4so3640318eaf.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 00:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697007836; x=1697612636;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O0u0iDtDqSUfhbskNEVoqKGJR0eCYFZCWT6zUIhEbo0=;
 b=mTbumhAP2CJupbZPBHenuZbVfpREEBNR4qB97ynPhjhI7Im8Y/QjiQHeHdHYluGVsm
 RlSPK69vcH/F+iYVgbvW99Opp2cbYyqV0BGTpGVvnswjTmetA+ECwDP6NyhS+j4QYbZb
 jiT3FgqP29HLU9wPTul/MVmzlwOAIyEBh/gjjfRhDJNWFfU6vUh8yU0Mt2Dul7Vr8gy7
 Sc7Dh4uPZERUud1JwMNKpzSDAjwCGlMsjvkJunQ3O/+3pqtK6K89JS92oNPxy5ow1198
 cm9kclhsFo1PzkEKTTZMgRFBAK336yNwzv3iyzvCIjOyrgzYGdmiDlA06wabTMtTXonP
 tsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697007836; x=1697612636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O0u0iDtDqSUfhbskNEVoqKGJR0eCYFZCWT6zUIhEbo0=;
 b=jjawlhuXG5uwpHtM/Hh1MFgWKxOQfz/kNqq3oEIbwwkx6wAlsKeJIlblLtBHmL6Tlk
 RGxCWmrflWGV77PnrKvs6emjLw2Z23Cm0PSYs7WtiNgydycQg7G5Uwm2Nwsv3k23Y2bq
 2ShRTKEV6Y+bXTqaGby5yyOXIQxZ7wetnRRh4msNFb98cU6HKreHphECihb8yedmFd0P
 V8MiU7GXJoNZT8z0Y3quGK7arTLXg0KR7CFtYxwmsCaQydNZI9ux7RhmCvfYB3SyN3qX
 SLQDqboX7VACq4uIeLgurYBq830y01/Mb5QT9imZy4h/fYX+cqNT3nePhsLxMZoUB8gi
 epMg==
X-Gm-Message-State: AOJu0Yw1+xpazEwfstItfhQ9fK9D2JL7VqNVF2BcPbhZCGtyJwkJWXoh
 UAUArRXC1s43E7fpbbTFKmLYzA==
X-Google-Smtp-Source: AGHT+IHhWdZU8AjtTXT+8MwM5vtkTU6J6Ku8Ao9xN+Cs6DvDpE+71jLVNg4AC3GtTeRcm7zHyqlxPw==
X-Received: by 2002:a05:6358:7e8b:b0:133:7c4:e752 with SMTP id
 o11-20020a0563587e8b00b0013307c4e752mr18631369rwn.26.1697007835908; 
 Wed, 11 Oct 2023 00:03:55 -0700 (PDT)
Received: from localhost ([157.82.206.10]) by smtp.gmail.com with UTF8SMTPSA id
 r29-20020a63205d000000b00565e2ad12e5sm10906685pgm.91.2023.10.11.00.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 00:03:55 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v9 03/23] target/riscv: Validate misa_mxl_max only once
Date: Wed, 11 Oct 2023 16:02:49 +0900
Message-ID: <20231011070335.14398-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011070335.14398-1-akihiko.odaki@daynix.com>
References: <20231011070335.14398-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2b.google.com
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

misa_mxl_max is now a class member and initialized only once for each
class. This also moves the initialization of gdb_core_xml_file which
will be referenced before realization in the future.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/riscv/cpu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1306054d27..0c087df9f9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1087,9 +1087,8 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
     }
 }
 
-static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu)
+static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
 {
-    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
     CPUClass *cc = CPU_CLASS(mcc);
 
     /* Validate that MISA_MXL is set properly. */
@@ -1487,8 +1486,6 @@ static void riscv_cpu_realize_tcg(DeviceState *dev, Error **errp)
         return;
     }
 
-    riscv_cpu_validate_misa_mxl(cpu);
-
     riscv_cpu_validate_priv_spec(cpu, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -2277,6 +2274,8 @@ static void riscv_cpu_class_init(ObjectClass *c, void *opaque)
 
     mcc->misa_mxl_max = data->misa_mxl_max;
     mcc->misa_ext_mask = data->misa_ext_mask;
+
+    riscv_cpu_validate_misa_mxl(mcc);
 }
 
 static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
-- 
2.42.0


