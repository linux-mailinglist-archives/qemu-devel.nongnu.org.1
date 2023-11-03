Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B70F7E0578
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 16:22:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyvzH-0004oR-Dw; Fri, 03 Nov 2023 11:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyvzF-0004nF-Oi
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:21:29 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyvzC-0002nF-JS
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:21:29 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507a55302e0so2860058e87.0
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699024884; x=1699629684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96tTRZzTo5lzHBefnnTujQF6PrCnnI8GATKXvxfKeEQ=;
 b=pCYgun4hNlZmbDZsTtliI9l/s/3eTZddVliDWLP1Tt3Xa3+sn40Owo+Gx8HItdaYAX
 Q8atnlqA6N+DjZimAT25mqAN8VUfH21moKBDCofVvTrKSV1iE34E3jr1FdM/fBb0smtN
 uLmlsV5Ks6usjcSNI1htslnceEgFFmRommh8uqh5JeCJN9XuGFyGhwRIncQ+TrQH+RZ3
 /E9qqQ/93VI0gkrv8qlszJmes+VAy4rmnJjv+P62AEuIX1dZsiJcLxxCu/llsJeoakbI
 4hdofwoAFiVmKKNfGIwuC+cnhiSIYp/wng0NHUQ6TOgdMIckJEpdFVKhPk9waxQLTIqZ
 kTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699024884; x=1699629684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96tTRZzTo5lzHBefnnTujQF6PrCnnI8GATKXvxfKeEQ=;
 b=XOyj9xxf+oEOqo5jXToPvJu6LLgpxQXP99JigO3b+yvOWxGCpHkRUF0aREwM2Wvq0s
 n/sOdXSEV1Kr2a8rhkHoj0kSUPjCw5tQeCBeOvC12SUgqeryJTI58GTfqs+WOVX93Al+
 HWPefzqSZ+M+2C4IhwZU8cKprcmhx2Kwpr00/XKSiGbPxWrjqDINGMQc9aoH5tqaEqzJ
 XB+FQLjqJF2lE7b3LXni5heAnAnQiq91n2Gx4OWRqv/1d8goL7zgyxSBoVHXJxn9yKWY
 CpPE7XP7rz5KDThSTf6otfrBFvCiqEZGDI4S8WJS2vQ2nmBECuSWkIdDStq82ZnL9Vif
 hpUg==
X-Gm-Message-State: AOJu0YyLR3RuaSgJHkaMgXS03opQ3gotUU5mztja0DLJscUiK3yA120U
 59o4L7bR8FHtCJwYj8VuzNDfeQ==
X-Google-Smtp-Source: AGHT+IFyQH+GSfEg1g4v1r0rgTt6dydyxEotI+IZ3Ly79rjdZWUcJd9kMbSQ0X638tV/W4rb7hIcvw==
X-Received: by 2002:a05:6512:3a96:b0:509:4e4f:65ac with SMTP id
 q22-20020a0565123a9600b005094e4f65acmr4155784lfu.63.1699024884322; 
 Fri, 03 Nov 2023 08:21:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a7bc8d0000000b0040684abb623sm2712165wml.24.2023.11.03.08.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 08:21:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>
Subject: [PATCH v3 1/3] tests/qtest/bios-tables-test: Allow changes to virt
 SPCR and DBG2
Date: Fri,  3 Nov 2023 15:21:18 +0000
Message-Id: <20231103152120.829962-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103152120.829962-1-peter.maydell@linaro.org>
References: <20231103152120.829962-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

Allow changes to the virt board SPCR and DBG2 -- we are going to fix
an error in the UART descriptions there.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf..6673e2c4c13 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/virt/SPCR",
+"tests/data/acpi/virt/DBG2",
-- 
2.34.1


