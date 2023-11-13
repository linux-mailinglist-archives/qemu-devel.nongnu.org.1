Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A81FF7EA266
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:50:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2b58-00036v-VG; Mon, 13 Nov 2023 12:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r2b4y-00032z-3L
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:50:32 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r2b4s-0003yf-44
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:50:31 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5aa481d53e5so3089291a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699897819; x=1700502619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZ1VrrtWk1nduWUh835SHfxyaNVb4BnIs3BTwPsszNo=;
 b=EUpFpa7/szxmNeDFML9Ki5TC/t6JcZvBA8HwuAYyI+0I5W2a0bH9e4WxR5OrmYqZMT
 xw0qH+mAUrLGPIsZr/z7klL8U9Ti+UFKi0oBwcRi2TgTG+s+MFZcI5NL0CVQzqzz4oyP
 VNtjj6BhSFt3pd5u73ijYhHjgwvUP6erj2Qt+eYgQm7bCc17tCV+epEyjC+z2hEKZy0x
 sk6mU1mEKBPPLivC1mq20xMDKKnZ3EkgcqNNKmPPhEkPn4W8Qhf6EtKHT4ST4gE/sNau
 YwQa6Px7c9M7w8AZfN/3R7UA8SwE38kj3Vx6kE3zp+1Q4NrHfIsn9vc0cmEhahSJGz0u
 Euxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699897819; x=1700502619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZ1VrrtWk1nduWUh835SHfxyaNVb4BnIs3BTwPsszNo=;
 b=IuSuL+WWwJSytpZG2s6Nk0Dv2/pRIiRFuMB4kOiBoOMhnzdwuPJxap62DQuA1uzYE/
 wuf+hre1seMm0pokAkHuLK18n4eIYuExq9BGa1j1uNja5YTbY0eOhOyscu6z9CVS6nhQ
 Troab6UE0OljNrX3plesqBCpHAXCO1Xd6IXFXNVanrx0wp3YtA9j68Ov5LzK7X1zNnhN
 AXdTlyiZsBLBxJ67v96UKslfJxU626c3XhxKanDq7p/Pczuzg0QwOBllhKGlZZmy3jzz
 mLZKurCawRCqbP7H0we3M1eFuNMrRoVrLLc7b2r2iFu9j8owPb22fqRs7mIwGpgWaCEn
 MJxg==
X-Gm-Message-State: AOJu0YyQkZkPbN36IrnwRLJMhbEkGsAQWWklXL2tpSUKqFmyujDMI1sb
 E2W7o4lStmOFouu3023jSalmBpnXHwxyaOuf108=
X-Google-Smtp-Source: AGHT+IGzKH/aDurWAx8swMAh5h+B9UO5eJXvmVMRRvjPj7c2bS7eYaTtwVF7fi0gvphbTGutWak01g==
X-Received: by 2002:a17:90b:33c7:b0:280:ff37:8981 with SMTP id
 lk7-20020a17090b33c700b00280ff378981mr4920190pjb.44.1699897819604; 
 Mon, 13 Nov 2023 09:50:19 -0800 (PST)
Received: from grind.. ([152.250.131.148]) by smtp.gmail.com with ESMTPSA id
 hg23-20020a17090b301700b00277560ecd5dsm5869329pjb.46.2023.11.13.09.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:50:19 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, mjt@tls.msk.ru, alistair.francis@wdc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH stable-8.1.3 1/2] target/riscv/kvm: improve
 'init_multiext_cfg' error msg
Date: Mon, 13 Nov 2023 14:50:10 -0300
Message-ID: <20231113175011.151022-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113175011.151022-1-dbarboza@ventanamicro.com>
References: <20231113175011.151022-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Our error message is returning the value of 'ret', which will be always
-1 in case of error, and will not be that useful:

qemu-system-riscv64: Unable to read ISA_EXT KVM register ssaia, error -1

Improve the error message by outputting 'errno' instead of 'ret'. Use
strerrorname_np() to output the error name instead of the error code.
This will give us what we need to know right away:

qemu-system-riscv64: Unable to read ISA_EXT KVM register ssaia, error code: ENOENT

Given that we're going to exit(1) in this condition instead of
attempting to recover, remove the 'kvm_riscv_destroy_scratch_vcpu()'
call.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231003132148.797921-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 082e9e4a58ba80ec056220a2f762a1c6b9a3a96c)
---
 target/riscv/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index dbcf26f27d..c8e1bb9087 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -727,8 +727,8 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
                 val = false;
             } else {
                 error_report("Unable to read ISA_EXT KVM register %s, "
-                             "error %d", multi_ext_cfg->name, ret);
-                kvm_riscv_destroy_scratch_vcpu(kvmcpu);
+                             "error code: %s", multi_ext_cfg->name,
+                             strerrorname_np(errno));
                 exit(EXIT_FAILURE);
             }
         } else {
-- 
2.41.0


