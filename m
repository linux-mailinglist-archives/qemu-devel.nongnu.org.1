Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C61EE7C63F4
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:20:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn3b-0001wJ-BJ; Thu, 12 Oct 2023 00:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3Z-0001vx-D1
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:17 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3X-0002PG-RR
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:17 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c8a1541232so5092435ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083934; x=1697688734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OmQXUWPoVlY/kcdl+q9QNIjdudp98g4fGGeBoQTZE8E=;
 b=OQ79ivZxgYe48yZUiowb9yjvesgAIoOWuFFEn+S+cyOq+joDcxcmkKxteFq6cyuWox
 kvUr9TLR6ugNarQEHxtDOUa8dgbD1HowwwsOcbGs8kKV2HJDDljLxFx3qfy51nlwUwp1
 lIXiq4obBrGOgHTdjpUllMKdReYr8VPT1XsciIOWigmpCBT+WAGiNLMac42cwtzjx8+V
 RIaliu2NEgrw0VQp+JUQgOls5za2ZYK0MzMzHvw9yRVwiIxgeLyBZbJ40vkBnVmhXcui
 xzrGf4wdGg6IbvjqeVZvD0YBPSdH/ngeZvaeXXT0LZQakc/4n/akDQTJkLo7RTZ4OVCs
 pnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083934; x=1697688734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OmQXUWPoVlY/kcdl+q9QNIjdudp98g4fGGeBoQTZE8E=;
 b=KUTBiQ5opMJ0n8X/1PsLF53XBHyH5C5Lou4/p3XiQdYwG6NlcBqSS4PqT3b4HMI6Yp
 u9zccsZR/QZr9nCWRHiLVSqRfQA5Gvc1laCsMRk0IpAJ8+U7epjgwIUGkOVzNIImyvyA
 nRszuinpbWpknCvmy34SVlU6ypRffN1RLO9WplDNLQP3Ez6Kp/EqGgOWOar5p9SpQQJA
 En66Pa0joFCE0v5rF8gqkzbNXGedEuroxvuACigYB5zP2gsSzWsFtuRJiwZtz2EC1dB3
 WL9mjsXVcrkXiGpp0ON8VaFvudalvqd5ybE5RiMmPMAcgObJSp480Q6TxGBWUEpnk9/R
 NZFw==
X-Gm-Message-State: AOJu0YxJlyYbKgWwWKfGIaqZqC6NfS3vQKYLiySFdIGFNXR26cqepDdL
 23pHl1Ne2NaUuZL8ll79qjrgrvY9CSlS5w==
X-Google-Smtp-Source: AGHT+IFIJ30OYt5xRuviIzwbr7Hn4S5LQ1MTj3d1s5DN4kQqH55IT+V7NVwqhfCsU2wlSu7mMEFRKQ==
X-Received: by 2002:a17:902:7583:b0:1c9:c6f4:e0c3 with SMTP id
 j3-20020a170902758300b001c9c6f4e0c3mr4933929pll.62.1697083934272; 
 Wed, 11 Oct 2023 21:12:14 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:12:13 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 20/54] target/riscv/cpu.c: consider user option with RVG
Date: Thu, 12 Oct 2023 14:10:17 +1000
Message-ID: <20231012041051.2572507-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Enabling RVG will enable a set of extensions that we're not checking if
the user was okay enabling or not. And in this case we want to error
out, instead of ignoring, otherwise we will be inconsistent enabling RVG
without all its extensions.

After this patch, disabling ifencei or icsr while enabling RVG will
result in error:

$ ./build/qemu-system-riscv64 -M virt -cpu rv64,g=true,Zifencei=false --nographic
qemu-system-riscv64: RVG requires Zifencei but user set Zifencei to false

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20230912132423.268494-21-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d1a3ddadd0..383e5df2a7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1153,9 +1153,23 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
           riscv_has_ext(env, RVA) && riscv_has_ext(env, RVF) &&
           riscv_has_ext(env, RVD) &&
           cpu->cfg.ext_icsr && cpu->cfg.ext_ifencei)) {
+
+        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_icsr)) &&
+            !cpu->cfg.ext_icsr) {
+            error_setg(errp, "RVG requires Zicsr but user set Zicsr to false");
+            return;
+        }
+
+        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_ifencei)) &&
+            !cpu->cfg.ext_ifencei) {
+            error_setg(errp, "RVG requires Zifencei but user set "
+                       "Zifencei to false");
+            return;
+        }
+
         warn_report("Setting G will also set IMAFD_Zicsr_Zifencei");
-        cpu->cfg.ext_icsr = true;
-        cpu->cfg.ext_ifencei = true;
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_icsr), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_ifencei), true);
 
         env->misa_ext |= RVI | RVM | RVA | RVF | RVD;
         env->misa_ext_mask |= RVI | RVM | RVA | RVF | RVD;
-- 
2.41.0


