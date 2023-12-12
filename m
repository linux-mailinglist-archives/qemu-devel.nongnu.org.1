Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C25D80EC00
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:38:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD217-00064x-Mj; Tue, 12 Dec 2023 07:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD20V-0004Eo-Du
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:37:05 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD20Q-00010M-6V
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:37:01 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a1c7d8f89a5so745905566b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702384611; x=1702989411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QFKe5fpokVIiAkSRFD2bRfU4SaX29W1o3RfhIDFCgNg=;
 b=nfS3inKesmoFelJzRAw5nE15vupRo/3PcngAdug8VbsoS7XI3T8uV4pxlLeqSOske/
 KxRWrP5Fus8ygyYuVcDgS4IqJaCK78hyVoB6bDWuoKS1qS4Sqqy/hKDlxAvQYGYBjIIE
 nL4eHNNAglSE0px4cuOTurU1wxY62bUuGS0UOqH0fCy8xmIdglOTzpUs9cU+dreyeglt
 NS4C0gLG7f63qo0Fhs66ZIPHKoJ2xfOClCenge+9bSNVRAFiJ8SlA8etzY885KKxQlej
 TEs6ZjHhYXqKHJl/Bb3aeS4Yssx1kBsZG1md3DFSCooBbsag5wKxeEsW4C6J7erIOf/x
 YdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702384611; x=1702989411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QFKe5fpokVIiAkSRFD2bRfU4SaX29W1o3RfhIDFCgNg=;
 b=a+Qg89YAQ+7mZDeB9Z4/NtRXKcAg/9gWcj+bW08SMinXi59C+K0MNwUDro/iMyh9ez
 6o3UJPr5WqwwSSinwGYtEdRyh55kNWjGZP0B/aQh8tcLhraTu1AEh2uXXkit7BdMlwYj
 rbvk1aM+jNYxylfdKRR5vXzcxwDJELWR0cnImPQFmmSE/Vmnc70fu1wmNUbTAjvD5osQ
 ZezsQSp1w/9qmUXLRpqrdnvv9Dr/DWiwgW15u/heyFWXmFKYYPBfbYBlivUZSBgoqmjY
 y7MEwGbTBVdlnH10TEjxBlJyE2zMbTsKvv4g1I5rvRGN58kytXg+tkqU/0JShvHQbCsE
 ABqg==
X-Gm-Message-State: AOJu0YwbaKMtOBq429TE/40tXNE6YPERR7fvgQyOiVMnSCNYO/xrLe/e
 iYJIHvoKFUhYpap7SK1eEtAUNS5Wztmt2hiefpIBbw==
X-Google-Smtp-Source: AGHT+IFF7iCrEUraOTsqojZyeZYPSVUonA3S/n22uK3Y3ScvB2ZYIEk3THogrsIssxV7Ekr/5rmurQ==
X-Received: by 2002:a17:907:7251:b0:a02:54fa:4f2f with SMTP id
 ds17-20020a170907725100b00a0254fa4f2fmr3683854ejc.53.1702384611672; 
 Tue, 12 Dec 2023 04:36:51 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 tk3-20020a170907c28300b00a1cd54ec021sm6243423ejc.57.2023.12.12.04.36.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 04:36:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Claudio Fontana <cfontana@suse.de>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, Brian Cain <bcain@quicinc.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 23/23] exec/cpu_ldst: Avoid including 'cpu.h'
Date: Tue, 12 Dec 2023 13:33:59 +0100
Message-ID: <20231212123401.37493-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212123401.37493-1-philmd@linaro.org>
References: <20231212123401.37493-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

"exec/cpu_ldst.h" doesn't need to huge "cpu.h" header,
but simply:

 - exec/cpu-defs.h           (TARGET_LONG_BITS)
 - exec/tlb-common.h         (CPUTLBEntry)

 - exec/user/abitypes.h      (abi_ulong)
 - exec/user/guest-base.h    (guest_base)
 - exec/cpu-all.h            (GUEST_ADDR_MAX and env_cpu)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
env_cpu() will soon be removed from "exec/cpu-all.h". Do we
want to move GUEST_ADDR_MAX declaration to "user/guest-base.h",
eventually renaming it as "user/guest-addr.h"?
---
 include/exec/cpu_ldst.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index e039cc7f80..ec0784bf15 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -65,11 +65,14 @@
 #include "exec/memopidx.h"
 #include "exec/abi_ptr.h"
 #include "qemu/int128.h"
-#include "cpu.h"
+#include "exec/cpu-defs.h"
+#include "exec/tlb-common.h"
 
 #if defined(CONFIG_USER_ONLY)
 
+#include "exec/user/abitypes.h"
 #include "exec/user/guest-base.h"
+#include "exec/cpu-all.h"
 
 #ifndef TARGET_TAGGED_ADDRESSES
 static inline abi_ptr cpu_untagged_addr(CPUState *cs, abi_ptr x)
-- 
2.41.0


