Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 528F59B733F
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Oct 2024 04:56:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MFg-0007E0-Ih; Wed, 30 Oct 2024 23:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFe-0007Dr-Q2
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:38 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFd-0003sz-Dd
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:38 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20ce5e3b116so4796765ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346816; x=1730951616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KsUdRFL4MaqtHmfDlQHVQnrDQefajvGRTdAPOYDyCGY=;
 b=ZBJPNUv40BNugb3bIz1KAn9OoODlRHjpKcvxBO+yr/ZYlpuuYLXpFa4JlZWuJdxGko
 V/u3Wb6sj4bXxAj1JMNxB/Uhh2kCIkocBsoZl3XS8luiJiaqCwLSjfjr1K/aoSV9XFsj
 fwBjl/fT0yqmGsdhTSNWm/x4HzGzmB33uoobn6S4DMrhEGfu7liivoa2Yzd5Paika2Mm
 Rqqs82aTSR38a8Hq350Jhg440ZO8bFjyFiVnVZS5Pz+tDJjPY+FdJ2/MdXuDr83tYN25
 O1nywKRdOUOBc8QhtcjEMuzqdmfmMOpFJyWrbzSMuTEoomfqGszivT7DURm4+joT5gJO
 H24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346816; x=1730951616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KsUdRFL4MaqtHmfDlQHVQnrDQefajvGRTdAPOYDyCGY=;
 b=L4+Vd5RJSci105OdUjouzrwxxVLgfeij38p4cwQiLVrTtFTQ8T92qRlumZI8xc8ltr
 b9/vDsjAqesWNhFt82cQupm1p5A8ZfynW821VFcx83WqRda+i2+4kHdw7N3PJ0DwwtuN
 iOUNqaDEgdYwgBNmn40AcITWjNXHkFvsF2t1BMicIgmXAd1BAXQ/VjVsfYfJDx782AJ0
 0TQV9mZKt/yZwCamXx20OymBMcBo/7XkI7w7FvEj/owzvHJPDa34pRZ1hH+Npg+ZJxzi
 J5a+nTDzejzoJgn/8g33kDcsNALdnU6uOWyi5kjKLI5ETxtF5id/P70NptKSXfXP0fId
 AvnA==
X-Gm-Message-State: AOJu0Yyk3ocZqWh+IzVcm5xbJeF0pvtQQHVytlCngGeyQhVdVuIv2i5J
 gKbT4DEq+ucMpBTBcAkJ143IPW+fxfOBhTXybArCGMTHnWAQLQopNxCe79X3
X-Google-Smtp-Source: AGHT+IFLa5OBYkZQYMWvY+D+1wFAXLTxiVQUwqJsyucT/Rkm3hJ0z5YOmC2fghXvhDXliRTh/UGkFg==
X-Received: by 2002:a17:902:e542:b0:20b:7388:f74 with SMTP id
 d9443c01a7336-210c687ce91mr249196275ad.12.1730346815795; 
 Wed, 30 Oct 2024 20:53:35 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:53:35 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/50] target/riscv: Adjust PMP size for no-MMU RV64 QEMU
 running RV32
Date: Thu, 31 Oct 2024 13:52:31 +1000
Message-ID: <20241031035319.731906-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Ensure pmp_size is correctly determined using mxl for RV32
in RV64 QEMU.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240919055048.562-3-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 9eea397e72..5e74b7220f 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -326,7 +326,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
              */
             pmp_size = -(addr | TARGET_PAGE_MASK);
         } else {
-            pmp_size = sizeof(target_ulong);
+            pmp_size = 2 << riscv_cpu_mxl(env);
         }
     } else {
         pmp_size = size;
-- 
2.47.0


