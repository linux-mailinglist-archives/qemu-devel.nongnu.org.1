Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB737981CA
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:07:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUdv-0003je-II; Fri, 08 Sep 2023 02:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdq-00038r-DZ
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:54 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdo-0006W0-2R
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:54 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c06f6f98c0so13945335ad.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153210; x=1694758010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLQpbDK+vhuZxw59pu2RWadiyahlNw5xeOR7KVVdyRM=;
 b=UHFJBevJ9D4QCcvNIVO2BSF+a5ZIbIv+W4VAtYZGhqjVofkt0+kAI/3jYmb0iyR5Sq
 dudHYLa2Cj6UnkB6ilUJjFmU2OhJySrrTB53gDAJ0Omdj0pXDjiwai3Jtvq/WvCrxD7A
 BQpQ0U2X/gUaZvtydRC48l+B6nBRYDGG4U27MOBKWY11mPhIMBPGpOQNs27JOHJMUj3Q
 4DYX0TyeukJQpZ/Qv359pmffb5kdiPr0ka0UlugAgF49U4txwAdhMhI/X2F58LoKiFF7
 juQx8Qaznqw6XkD2tNPLBbAQHn0qH8LyaXbWIj5lXKWocwKWotnXhZIBSXcoiJo0l1Kl
 QdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153210; x=1694758010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vLQpbDK+vhuZxw59pu2RWadiyahlNw5xeOR7KVVdyRM=;
 b=wInLeencRGurxtxU8G72AxbJO3NIvrqrHZkJGx6LblxTmhWtaYYEgIQplcrN9QpJbN
 6jPjXROc3QzsE/asTwuOn8UNp9ek5sqZohZoXePPn5NJAksFbL9ebYRuHcwbb5I5auFb
 ZYVkrofixJdHOOwW8K8tyJTmdjuf5Q6pAtmCNZYty4T1GEmHnfIveNHrJ+gdETof7590
 V7RbemHwCq4YeJ3Um7MeCQZkuNQ3AJCaVTkZTpvVgfMwnFntNm+NgA+HeCR2WYN86+UW
 xJRVRzHWpicEi5FtGmFxN4OagsBOrwoha5PCb+gtti3y+lW9P8hl7Y1C7JfJB0ebvotn
 yC7w==
X-Gm-Message-State: AOJu0Yw4kqSCvN9lCHl0Wuylkx85CC25MFGkbRU/Zr2VcxwMWrrVPEgn
 X8myKlkEtm3E43ebmmPe0W6D48YB5/qXuIRT
X-Google-Smtp-Source: AGHT+IF4Jc6fLiiBf4wDe1+7kJlBT5rHB8TezB5mx6qHTn3qiWPlp0a3mFKzmqm1yq0DG2N0qlez/w==
X-Received: by 2002:a17:902:da92:b0:1bb:a522:909a with SMTP id
 j18-20020a170902da9200b001bba522909amr2153787plx.37.1694153210483; 
 Thu, 07 Sep 2023 23:06:50 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:06:49 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 30/65] target/riscv: check the in-kernel irqchip support
Date: Fri,  8 Sep 2023 16:03:56 +1000
Message-ID: <20230908060431.1903919-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

We check the in-kernel irqchip support when using KVM acceleration.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20230727102439.22554-3-yongxuan.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index dbcf26f27d..2953547cb6 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -926,7 +926,15 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
 int kvm_arch_irqchip_create(KVMState *s)
 {
-    return 0;
+    if (kvm_kernel_irqchip_split()) {
+        error_report("-machine kernel_irqchip=split is not supported on RISC-V.");
+        exit(1);
+    }
+
+    /*
+     * We can create the VAIA using the newer device control API.
+     */
+    return kvm_check_extension(s, KVM_CAP_DEVICE_CTRL);
 }
 
 int kvm_arch_process_async_events(CPUState *cs)
-- 
2.41.0


