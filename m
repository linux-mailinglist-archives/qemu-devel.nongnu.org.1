Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2801D80EBF7
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:37:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD20E-0003Qc-WE; Tue, 12 Dec 2023 07:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1zk-000251-5j
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:36:16 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1zg-0008Vk-FN
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:36:15 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c9f7fe6623so70787411fa.3
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702384565; x=1702989365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCN6XEpRfBzl6QRBVexJQczvz29R6MzglzJSIvh3kCU=;
 b=aG6/g82XeI6bfBPhwMK6Lzv9kR9aCU7Q7PaSmZGzET8LdmNENBP0karaZnrBkKxab/
 Is3iDFWvfgJqPGwT4i9E6L+iQyO1nKPBT2xppzX+hY9/FzDldX2e6Uo+egq/9KDZYXC3
 mWi+mPIFQRr0hODuk6cIIAx8rBNTNDRJ7ldzOY7q4ISTtCtniGofz8pEOb91RyEPseLV
 xjSxmHJvJez10P/LmlNJU56ZHjW8rjQRyrGqvXOmOi+nYmIGBJd7IsZNR5SegYagDI3z
 at/E2p6Kz3LU3lTyGfkGh8pwJlD+7WSqu+DO0d5tsvKY/XgyW35mhf5FGyd+EcIF/hQY
 jq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702384565; x=1702989365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jCN6XEpRfBzl6QRBVexJQczvz29R6MzglzJSIvh3kCU=;
 b=cgZovpJK6O4RWlgvAPnlDSHOcsovyLlniTXmjTVYaA2pwh1hByWIjepA5K1I8nDz2E
 EOoLmsjiTLYckqhnKGGYb5Zu13TMACXMOFKjg6X7u9/hZOdftx09fhk9P+MkbKfmuE8j
 O/OxM4m53sgD0J8huDcAP8DRu0ykNdct8nk/kFeu4OvzIZORcsJzdExCi8R08Oj3yqZn
 fxFEKsP3P0HFPxooQXv1e8A1GmZSOahmoqxbwXhPIceifRfhRP81Kj57eBZs/7yj6i83
 sioJbHOHkyP9IMEwXD/Z4yrVZ2pl9kC8r/+QZZJPr4IY3MCd9Evqrk7956X0/0RUgRu4
 p8GQ==
X-Gm-Message-State: AOJu0YwpInS40Um6Cg8GOq5+X6/C/RnYhz4I5PAsTYcFc6tXuquLHYzr
 Xrublz6YcEEAG+MNn7CvYrWuq37EgkCMNlaQlmiZSg==
X-Google-Smtp-Source: AGHT+IFmeBvWgvvBbzYGkF+zYPl5+e01JLIWWNuas4xPI2HT4LsHsl0TWRedv0QHFzvG+nl31n4+yA==
X-Received: by 2002:a05:6512:281e:b0:50b:f9b2:d00 with SMTP id
 cf30-20020a056512281e00b0050bf9b20d00mr2195977lfb.22.1702384565627; 
 Tue, 12 Dec 2023 04:36:05 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 dn20-20020a05640222f400b0054cc22af09esm4672659edb.46.2023.12.12.04.36.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 04:36:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Claudio Fontana <cfontana@suse.de>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, Brian Cain <bcain@quicinc.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 17/23] target/ppc/excp_helper: Avoid 'abi_ptr' in system
 emulation
Date: Tue, 12 Dec 2023 13:33:53 +0100
Message-ID: <20231212123401.37493-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212123401.37493-1-philmd@linaro.org>
References: <20231212123401.37493-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

'abi_ptr' is a user specific type. The system emulation
equivalent is 'target_ulong'. Use it in ppc_ldl_code()
to emphasis this is not an user emulation function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/excp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index a42743a3e0..3d7c9bbf1a 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -142,7 +142,7 @@ static inline bool insn_need_byteswap(CPUArchState *env)
     return !!(env->msr & ((target_ulong)1 << MSR_LE));
 }
 
-static uint32_t ppc_ldl_code(CPUArchState *env, abi_ptr addr)
+static uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
 {
     uint32_t insn = cpu_ldl_code(env, addr);
 
-- 
2.41.0


