Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1208A790AC8
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 06:32:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcelz-0002Ch-IK; Sun, 03 Sep 2023 00:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcelk-0002Bb-9H
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 00:31:28 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qceli-0006qH-40
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 00:31:28 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bf11b1c7d0so7491685ad.0
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 21:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693715485; x=1694320285;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1OoGlAFSrsHe5yxYX+ZMvZlZQ825ETdOqmrQ0CIV6k=;
 b=kA4M3398WlSF5p2S3z6dHSLu+W19S67s9Sj/c15Cooqx4EdWUdXHOC12zULCKXbsyh
 PExPSTTEYWRJh/8DHD46f5bkOhV3SqLhiPPod05aWrK8F5Dvp/Wop/YQZRNyJTRt6/Fi
 TSNN53U3MW8ju2BsqP9YW4ybLiEeQhoYCxLUKebUw4EeZ+syuLaJJ4fUM9aipIJCWBPs
 mwTNze8OCLnLBAbMPsJrXvqs9DezF54rkAkchP1fqDwfAtK+6gRG7/MdctmXmtAiMKCk
 WTE3IXZ/uvDa0AWtHB7a4JH2Ol6RkVM/e9AnfK/phCWFnekrvdZxlqbL7yQ6i8Zd9Vg/
 u8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693715485; x=1694320285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f1OoGlAFSrsHe5yxYX+ZMvZlZQ825ETdOqmrQ0CIV6k=;
 b=jzHlHpKekEALbncjmJhnf8p6ygjQ+c0E7UY8e9YDhnQ9Ub4LFbSqbcp+MUa+6vKU91
 jOnej/tjo6UQ24DcTRVuLXmvCxUGBFBUbcEzmhsAt+ocD8dYsmjIphTAtksVpM6XkJgs
 uZ8z6qziR5QKRmkhDnXZOmmKNyK7+Ug3bjZeTai2QeYvddPC9aYCD0jS4kA15kE1AWbK
 oQbqXey1lYaaP+W/bxAlUmQUBbC4QMzmFGGV2frSNFUL2cGYphyt7Fw4YojvSzkuLdAn
 6CGGkJZF1+K9ldnrdsStr/Udixpm6JCBe79FesKQZpTKQUVyLxuU9P0zyi6scyr57Fz1
 VLlA==
X-Gm-Message-State: AOJu0YzKUk19usVJ4m6X5wITlDElMLkq/Rt0RrxdU+tsz/w3Z2uVVYvX
 BIA2uv+CeCGEyQNk2ZaXD9CRYg==
X-Google-Smtp-Source: AGHT+IGdm0kRAJURqufTgnNRidPox8bHlYkKt/8voSC1xGfWCJaCI3aeIWpP1XeXTFJk5XvdAstKBQ==
X-Received: by 2002:a17:902:d2c5:b0:1c2:193e:1126 with SMTP id
 n5-20020a170902d2c500b001c2193e1126mr8068868plc.28.1693715484818; 
 Sat, 02 Sep 2023 21:31:24 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 iz2-20020a170902ef8200b001bb9f104328sm5295792plb.146.2023.09.02.21.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 21:31:24 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH 3/8] target/arm: Move the reference to arm-core.xml
Date: Sun,  3 Sep 2023 13:30:13 +0900
Message-ID: <20230903043030.20708-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230903043030.20708-1-akihiko.odaki@daynix.com>
References: <20230903043030.20708-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
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

Some subclasses overwrite gdb_core_xml_file member but others don't.
Always initialize the member in the subclasses for consistency.

This especially helps for AArch64; in a following change, the file
specified by gdb_core_xml_file is always looked up even if it's going to
be overwritten later. Looking up arm-core.xml results in an error as
it will not be embedded in the AArch64 build.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 93c28d50e5..d71a162070 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2354,7 +2354,6 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->sysemu_ops = &arm_sysemu_ops;
 #endif
     cc->gdb_num_core_regs = 26;
-    cc->gdb_core_xml_file = "arm-core.xml";
     cc->gdb_arch_name = arm_gdb_arch_name;
     cc->gdb_get_dynamic_xml = arm_gdb_get_dynamic_xml;
     cc->gdb_stop_before_watchpoint = true;
@@ -2376,8 +2375,10 @@ static void arm_cpu_instance_init(Object *obj)
 static void cpu_register_class_init(ObjectClass *oc, void *data)
 {
     ARMCPUClass *acc = ARM_CPU_CLASS(oc);
+    CPUClass *cc = CPU_CLASS(acc);
 
     acc->info = data;
+    cc->gdb_core_xml_file = "arm-core.xml";
 }
 
 void arm_cpu_register(const ARMCPUInfo *info)
-- 
2.42.0


