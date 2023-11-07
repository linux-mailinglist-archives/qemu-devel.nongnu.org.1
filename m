Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1657E32EF
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:31:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bs9-0003n3-FN; Mon, 06 Nov 2023 21:31:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bs6-0003ip-4y
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:18 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bs4-0002ru-PB
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:17 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc938f9612so29699085ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324275; x=1699929075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=piEVhGj0gurniGgLecEKxr71LIHprX+NvezqLWXeL+k=;
 b=WaIw8pSjJ8s5lvmuOGJtm/NpyBgp5Zn3JewXmIP9SZv0XjPT/6yGzNOqFuegzvOX7E
 D2dZuT/PdS3/i31OnazgejdkY5pS0sAQHKgWOFkQBVAnpSxk4RdCOffghJle8PkBub75
 RJm2B3Ch7LxC3363VB+YT4PXPbKKuqCvRhDGFRCCUw9ttgovGAMhW8nuZKAMW1Isl3fZ
 USfDdHQc0UAb+Ya9/FF/MSLO0sHs8CDz0Xxb87lignKw+7WO5O/+y/eUxCmqdBgOrADi
 lxkrfENsg57hUirxJCgmb0hYmW3kJewEBK1yvs2XrbgyPYn4kjSoy104MwFKnavNAxHm
 3kCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324275; x=1699929075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=piEVhGj0gurniGgLecEKxr71LIHprX+NvezqLWXeL+k=;
 b=kY8qX3gZ5xA+2wq13W1h4Ejqyk2lBlO5mWXPif+Vc3fDYQXWmLayC1nMuHOiaE/nR+
 3VDiWKRDET0fZ8i1lfVwUSsCmEzeXCtN+e9KJvDJddGnAhgXPa8Pk99b7SBLyOmTS5hX
 LaDZI1AfpHKy+mAQbt6SyCLusU55owg1HUNzzUkUmbj3lwLNFW2ha5nSIC1/zDzyvOW8
 vmnLrWZchyy+XPNZLo5Th8TcJ5iwv9pi7+LuOz57fbPkKQ8bzFmIw3Y+qWYWtJurlz8q
 FFj9pSvRKhHtct57HnOlD/rnMbjACj0bHZDPCKXhQhD0t8HItBnqeigxdQHJeYbwzRL1
 zGdA==
X-Gm-Message-State: AOJu0Yw56h6dMWjE/vHr7XNMDi8BaQbhvMGwHr277p3Ok4tDPCaFJMyd
 jNqc2IMvYta5TXaJ1xFgq/dTaZ9CRlbPZw==
X-Google-Smtp-Source: AGHT+IFwrWErbv4zda56Oxb7bV6Dq4lwBaKTODh1StyHQY+fCm0zdig7hEj4DVpRoySiKh4vLYkCrw==
X-Received: by 2002:a17:902:f303:b0:1cc:32be:b13 with SMTP id
 c3-20020a170902f30300b001cc32be0b13mr16408196ple.64.1699324275184; 
 Mon, 06 Nov 2023 18:31:15 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:31:14 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/49] target/riscv/kvm: add zicntr reg
Date: Tue,  7 Nov 2023 12:29:19 +1000
Message-ID: <20231107022946.1055027-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

Add zicntr support in the KVM driver now that QEMU supports it.

This reg was added in Linux 6.6.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231023153927.435083-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 6bf035f39c..0c5c0e957b 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -228,6 +228,7 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
 static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zicbom", ext_zicbom, KVM_RISCV_ISA_EXT_ZICBOM),
     KVM_EXT_CFG("zicboz", ext_zicboz, KVM_RISCV_ISA_EXT_ZICBOZ),
+    KVM_EXT_CFG("zicntr", ext_zicntr, KVM_RISCV_ISA_EXT_ZICNTR),
     KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINTPAUSE),
     KVM_EXT_CFG("zbb", ext_zbb, KVM_RISCV_ISA_EXT_ZBB),
     KVM_EXT_CFG("ssaia", ext_ssaia, KVM_RISCV_ISA_EXT_SSAIA),
-- 
2.41.0


