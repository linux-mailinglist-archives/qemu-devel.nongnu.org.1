Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1C4838D11
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 12:12:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSEgD-00036l-GH; Tue, 23 Jan 2024 06:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rSEfz-0002qt-Jh
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:10:45 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rSEfw-0004Nm-50
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:10:42 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-338aca547d9so3308876f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 03:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706008235; x=1706613035;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a6UoAAKm1BSVru2djWDEvJDwpv7xKurDJDJjWffjIbA=;
 b=DcAkNhnYQUEA1KZukWTKB3AmzF7Zj8nqeFywO0L5/Fa3MSZtmpCVIdVVVIZnUvyVlO
 7J3z43vT4LfsMhBcLsNRxSzY0woANDtoMeFwmxsmWKa3lvni7RB+sIPD8x3j6ZNo/3Va
 m65rQtr9lV61Hb4WYViMlK5fppuOIkoLHSB5or2oqAK2IIqkVLZHvwVrmX51P4epQuuY
 E9he1lYJPuL9uKrT5J/KodpIshmfwvAfkYdFdjBN3ZQnu1hfm0cKSRE83t4hEJCwB7fV
 Sy6gey1JsVzF3aZf+XrLG//Jl7v6Hxf+GcxLhbC6FZMPQ5P3/P5eHTE8AVp7Z6z/Ia14
 +sHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706008235; x=1706613035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6UoAAKm1BSVru2djWDEvJDwpv7xKurDJDJjWffjIbA=;
 b=qhDYxzQi9Ixu7HViqq1fSYBneZHySwde8ZNQ0yx5Yatwpp+ti08RrF6cHyOGRGgpod
 Qlz3fxLGuUHUQuyQySDlr20Yk+I9x+f3+yyIvFTnTu2hy3DA7if3v1n8eMVi7kiqEuUf
 Bka2I9GVmYLI6sq6LL6+xN+MxaoFvSMUIV6uL2b1ACuxR9FdT66QTqh8h3Km1i62jt6b
 o4+ObB5+ZlIGQ/iPbiH4vjr0Tmq8mYJ++qbIhi69F5cLaLzSgid35ExA5wg3PUug52I8
 IKdk8G9x2NG9TrolBXmyjgUAX+WN8jNpaNYy0rjre0aUlw+u9f9owjInvbKAtA0diLar
 JoRA==
X-Gm-Message-State: AOJu0Yxtb/qXuGG0xPygTZvctpO98lzNVNq+frvI9kpWbv6IP7R1FciJ
 z5bswv3RQJMSVV0CIUOM/ZJLRzRqkTyMMipw5h5ay8ZL3uVF+bRJIJbij843ezziuvrAiQnDFTM
 yEjk=
X-Google-Smtp-Source: AGHT+IGXQ9R9gZGixdo57qdApxgwlFBEkkow5z3BRcUSXlogUwHnrwj53SC89qJ6MRyFXrZrKKC5ow==
X-Received: by 2002:a05:6000:108a:b0:337:bfd9:bd48 with SMTP id
 y10-20020a056000108a00b00337bfd9bd48mr1568534wrw.62.1706008235559; 
 Tue, 23 Jan 2024 03:10:35 -0800 (PST)
Received: from rockhopper.. (214.11.169.217.in-addr.arpa. [217.169.11.214])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a5d4c4f000000b00337d6f0013esm12288013wrt.107.2024.01.23.03.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 03:10:35 -0800 (PST)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH v3 3/3] target/riscv: Expose Zaamo and Zalrsc extensions
Date: Tue, 23 Jan 2024 11:10:30 +0000
Message-ID: <20240123111030.15074-4-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123111030.15074-1-rbradford@rivosinc.com>
References: <20240123111030.15074-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=rbradford@rivosinc.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Expose the newly added extensions to the guest and allow their control
through the CPU properties.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
---
 target/riscv/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8d3ec74a1c..604baf53c8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -103,7 +103,9 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
+    ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
+    ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
     ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
     ISA_EXT_DATA_ENTRY(zfbfmin, PRIV_VERSION_1_12_0, ext_zfbfmin),
@@ -1491,6 +1493,9 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("x-ssaia", ext_ssaia, false),
 
+    MULTI_EXT_CFG_BOOL("x-zaamo", ext_zaamo, false),
+    MULTI_EXT_CFG_BOOL("x-zalrsc", ext_zalrsc, false),
+
     MULTI_EXT_CFG_BOOL("x-zvfh", ext_zvfh, false),
     MULTI_EXT_CFG_BOOL("x-zvfhmin", ext_zvfhmin, false),
 
-- 
2.43.0


