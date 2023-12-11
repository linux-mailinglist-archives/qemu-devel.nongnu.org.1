Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9485C80DCE5
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:24:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCnjc-0004SK-P8; Mon, 11 Dec 2023 16:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnjT-0004GW-GM
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:22:32 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnjR-0005lG-OB
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:22:31 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-54f4b31494fso7251633a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702329748; x=1702934548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCN6XEpRfBzl6QRBVexJQczvz29R6MzglzJSIvh3kCU=;
 b=j0sybf8R9qPyueRhalbXpgIaMYo2vno4hdHCwJpHMNxt99FgLmy9SeQTKePAWxlp4F
 66zZ+jH1SHxOST5xzz1Q6C9Ub0OZrQagpRmBU2Z+gKzh2zVMDU7j7BkFM7Qp8cx2xB7C
 uuueSOht49EnbcWu6+U4BY2PcJw4ktOARZXvvKh2Oi/Kfu0PmAqdLIdLO4o6AfxleSzC
 2TKpcY1dexlULMoUii3UyzoZ1UkBlW0DwAjoc633hJyNn3n1lNLMFST/IvlxVyUkcQXd
 QOKVO22TdRbccqtQ1m7vgH6Tdi2Mx1r1wNDGEs3qGS1ag9L01aKhn8Oae9G1KOj6msyQ
 OQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702329748; x=1702934548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jCN6XEpRfBzl6QRBVexJQczvz29R6MzglzJSIvh3kCU=;
 b=TK39clEmnB9su93+aziu+Kyh8Ng1FUOfC+Hd6r9RLMZPMMUlv2vhovYL7WxIgGffV4
 gVBTqpvqI373lOryyL0C2/8Q2XeW8FZgtg9EFMiUmMTdlewvR0sXNZllDRBxRcP4eTDy
 dRmCFO241j283JCQxGOletdBfm9So4qQNuJaxsUiJKSdMnziHp9DX2Qd+/gRH0eiER57
 itbaNZ9M/YrQgPqJ5ZqP/JBUR/6jOVNr4t0mmIMuCAcAqGo62bcLpd7oAkL9WyuoG+4G
 5EcaFoNNnDWBRT23QMj7UPmPtPkAwin1ketXPl6gz2RtmJcN2quQxlj7Qru26O37AfQt
 I/eA==
X-Gm-Message-State: AOJu0YzqAQ6kRmwZdqAsuJetDlhtAHKl9sbY1BdnbXKUYWpB4bbyBcTY
 x5M4rj8DN9Kfg8kaOKFnqbdCP4cudtsHiORRpvKLYg==
X-Google-Smtp-Source: AGHT+IEwqt6eLG4A82nj43gtpanBMrnXiDuQHfBbhdfTI3qN+rGfYQe2+K/0exl5E5chj/jjV3dMSA==
X-Received: by 2002:a50:c905:0:b0:54f:4f7f:1a57 with SMTP id
 o5-20020a50c905000000b0054f4f7f1a57mr5170138edh.31.1702329748112; 
 Mon, 11 Dec 2023 13:22:28 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 dk11-20020a0564021d8b00b0054c8415f834sm4087989edb.34.2023.12.11.13.22.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Dec 2023 13:22:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Claudio Fontana <cfontana@suse.de>,
 Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 17/24] target/ppc/excp_helper: Avoid 'abi_ptr' in system
 emulation
Date: Mon, 11 Dec 2023 22:19:54 +0100
Message-ID: <20231211212003.21686-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211212003.21686-1-philmd@linaro.org>
References: <20231211212003.21686-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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


