Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E05A2FC11
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Feb 2025 22:32:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thbLt-0003tI-Kj; Mon, 10 Feb 2025 16:30:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thbLq-0003qM-0A
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:29:58 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thbLn-0002CW-Pb
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:29:57 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436249df846so32976955e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 13:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739222994; x=1739827794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WYUvy3QtP2AUaa/B3tYEfM+4wz3nraBak2/IB4Et0u8=;
 b=p7c2ZfKEaw7BHeh9NI3aSVmSaAcF7a9uO0jfbqq1x1TgRJj+RIxZjw2PygrYrldIN7
 NEL5ky2g0M9h62p9VxNqradG4hkp62dRMbL/+qQEAQigmNZhx/36ReFAglKz6zE3QMuB
 P1BR7IAS/SeNeFQb752163//guDXn8mv6qdP/tCGPiiehETN1mMoXXdsWmlyA5Yn/EhY
 Cgwq6nsH/nkwEBw8jptLcwge/RaybAPHahSqQkrK8ufqVYA4FDiwF0lfWbPuX2R2HWTl
 UxgF5R2nfAddHCch81MUtKcNBY8vhabo+uliXz5y/m/1jW5sJgxgX7iHi8iZyfkbOT1S
 vCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739222994; x=1739827794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WYUvy3QtP2AUaa/B3tYEfM+4wz3nraBak2/IB4Et0u8=;
 b=V9fSZUi5eQRojaGB0yVvgqsqpyHC7RzAMPbRnDVxfgYplTgzrHBw1eFLbR0/ZydDfX
 zWS/5xok6AyHtdM0av6TnX9woY7Oz8pc5Zp/71QuNRPZ7UGVcO14azPpfAixa0YoedQE
 QFmaPZeOQujVz5umrcqoUGxCuJUIIKIJJEAWRIuz0AgX4TXtRrF6YHW3sPLQ89TrQRaI
 cPy9ZOJ6Mq9sMIyio+UgtW9UTQkWgRl9UWohOKnRQE3ihy6rFlSXCWzUYg38B9K2mNV/
 FtRfK6OfObVC4B3nhGtw6bCGLyTLacAQVfAPk70OisLxESq9zMy4V8ILd5yqVi7dwpNy
 yqdw==
X-Gm-Message-State: AOJu0YweOXZKM+A0t3HSmhdIZGVJfwLnmD03NJlIeIEwwZjJdc0YzmqV
 aWEp9zImF3SKBt/6KXaFGICwKJJ1dO3Vm32JAdq3AcEfp6pZhMmD/J+vENwxKq+qpVICe4WASyh
 uWrA=
X-Gm-Gg: ASbGnctb8MReyhrNxYc+/AMbGAqAeoyVzJUAWDO6stuFvDCn/BeVPVD+1GZsDp+RmBG
 EgRG/fgycb5FamsYytj3dPy+GhYh2tjueR4ObWNYVsE8BkIi/qfFNxY0rH4V4vylYHQIALaBIOV
 lAFPfsVRUgDMcbRiMwI8tnkNZbsWpPYrm/UvGVVPVpx28KMjtqGlUmwp8oiZcQiqGTsJ5YpxdBE
 DZupiXWOItjpBq2qLJQqoQbDb9O9gblKQeTsz1HE8jI3QPPapH07y1r4yjFAWyYvObEHMMFKQm2
 yjQI7sNfN1TyOCaQjxPkQYKTfHi8zkp3fB/IPWkR9oA+tHiemT4u1pta5B3+rsfBZw==
X-Google-Smtp-Source: AGHT+IH5ALwlP0ZhR95HyQVBvnS8MJtDL7W5CgyoPSeFI6KEQ6xyhOKDOoEX36s9PG1YHLS/YuDzOQ==
X-Received: by 2002:a05:6000:1886:b0:38d:d99d:d221 with SMTP id
 ffacd0b85a97d-38dd99dd4e6mr5021186f8f.1.1739222993757; 
 Mon, 10 Feb 2025 13:29:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4394127afcbsm54084965e9.23.2025.02.10.13.29.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 13:29:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/10] target/microblaze: Set disassemble_info::endian
 value in disas_set_info
Date: Mon, 10 Feb 2025 22:29:24 +0100
Message-ID: <20250210212931.62401-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210212931.62401-1-philmd@linaro.org>
References: <20250210212931.62401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/microblaze/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 13d194cef88..27089e3c579 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -224,6 +224,7 @@ static void mb_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_arch_microblaze;
     info->print_insn = print_insn_microblaze;
+    info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG : BFD_ENDIAN_LITTLE;
 }
 
 static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.47.1


