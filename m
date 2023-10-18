Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EF67CEA41
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:52:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESB-0000uz-Vf; Wed, 18 Oct 2023 17:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtES7-0000jJ-Rs
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:44 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtES6-0004NF-8n
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:43 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b89ab5ddb7so4874823b3a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665901; x=1698270701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2CpBYHyN5WTjKAnF9eC52gwF9DPW7ui+s7AIy3W9Zs=;
 b=RNmoujDR7osnJn1omZfO8X0Q7DGMPFoqSHlR2bK2frPk6sH6n2EqzrCWqIq2wB9Y/K
 qtAaVdOrvNGrlYSOkMBOuceq1dxxYHTRMtyghyNr9V66mvSzZ2t4ZjDF7iiTuerONVfQ
 7esRH05DC633ED6cL7M5mExAXrD/DdE1aw3zFwifhNEcPGEgAF9VPi2ucaRGCw10cQZT
 cL4FW8DaK+d+Xs87pLZQtIwtMZ2R/JCpSM+IPKATKG9aKEfVdaj3Lmu63iL7qn6E5akK
 C7kF876BZHyr0ZFjjQAIQL2J4EHxnQhDhukg/2pByX2Kb7GwDZ2nnafg4TEs/5K/T8QO
 RNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665901; x=1698270701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F2CpBYHyN5WTjKAnF9eC52gwF9DPW7ui+s7AIy3W9Zs=;
 b=sogBXfbnoUGzMZstvxSEDiE5Cksc0DQfeuv3f+gXZxwY5fxFENeGKKg1qcvBPMVJat
 YT2N26lVa2W276T/yUR/wb0ThtOlR6rPrUfgBs6j1BxZV2kfnJSfBAV3F4MTgty/OvCC
 Wi05tyAXrptnuARUrjw1vyaS8MLsDmaVQFwbtaqQyl+fN6O9uiUFvlIVCI5PhjMGS+6E
 pGACR620FMN7Gibboyu6NSwgJapLLrxYpfhRwXFt9Qk1i6Fis3I8SXM5O894rX1mavEf
 0iFBkDF7U6VQAA1QNIQh6ef6U00DvS+5C/hvdnSUH8uFOajSa132rGQEgzf/LEDtiad4
 kJdA==
X-Gm-Message-State: AOJu0Yw/7sltaX4nJv/2oFnvDob2xYhaG1c5u2J5BEI9OJh0GhjOc7id
 HzcuGTA/Aq0hUnBXyr0RJHMenMKDb8CFgzos/KE=
X-Google-Smtp-Source: AGHT+IHYFQ+6BrYWrI3/d4T/bgwej28fvh99wIpAL3PIafA+FgvG5KVD3n+TYMjXik8PeWRPpDNq4Q==
X-Received: by 2002:a05:6a00:1788:b0:690:38b6:b2db with SMTP id
 s8-20020a056a00178800b0069038b6b2dbmr452679pfg.6.1697665901043; 
 Wed, 18 Oct 2023 14:51:41 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 05/61] target/hppa: Fix hppa64 case in machine.c
Date: Wed, 18 Oct 2023 14:50:39 -0700
Message-Id: <20231018215135.1561375-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Typo of VMSTATE_UINTTR_V and VMSTATE_UINTTR_ARRAY_V macros.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 905991d7f9..0c0bba68c0 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -24,9 +24,9 @@
 #if TARGET_REGISTER_BITS == 64
 #define qemu_put_betr   qemu_put_be64
 #define qemu_get_betr   qemu_get_be64
-#define VMSTATE_UINTTL_V(_f, _s, _v) \
+#define VMSTATE_UINTTR_V(_f, _s, _v) \
     VMSTATE_UINT64_V(_f, _s, _v)
-#define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v) \
+#define VMSTATE_UINTTR_ARRAY_V(_f, _s, _n, _v) \
     VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
 #else
 #define qemu_put_betr   qemu_put_be32
-- 
2.34.1


