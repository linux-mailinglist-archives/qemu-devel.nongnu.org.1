Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE137DCE25
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:47:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxp3h-0000wc-H3; Tue, 31 Oct 2023 09:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxp3V-0000t1-OV
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:45:18 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxp3Q-0006dt-3N
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:45:17 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c594196344so83087951fa.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 06:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698759908; x=1699364708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96tTRZzTo5lzHBefnnTujQF6PrCnnI8GATKXvxfKeEQ=;
 b=seApOCf+fLBoUMLm2cF+gOVGH5czrT0+YX40XMcBRcpmskp4/JUKSUT/CGHVOZmFi9
 CidejBDEED5y4xBaZkV6Gmevnm3dqH0L15b6KZ9lHNODpQJiWytUt5/xDhcU9MP86z4J
 kii92kokw4u+ydHs1J4QBb1Ax4J7wucN39OrVC8e7o+LN4bYEua6JgpjNqXZZwYrcjor
 6iBEwbxE5l2t3KxF9Ri1XRdNs8AVC6AMk/IlamQpJeSR7uUAVO+xJGUMBNO168Ppe503
 g+IowtArj1ThkkMVZEKoQHXNnHU+K6QjSd4NKFMR3bKaZJX4V55rQuxbK65PE7D6V/1e
 m9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698759908; x=1699364708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96tTRZzTo5lzHBefnnTujQF6PrCnnI8GATKXvxfKeEQ=;
 b=aUmHsCL8XbCYNJQfOHyjpc7MxG4vLsZkXuplkZk+CWf6fwlSZ3BXutI7VP8eUtG28/
 v9pUJbwls6hiW84mSxzXXASI5vA1J2fKVq3oLvnBxZG84J2jTaqUuwS0O9gtMx9oxNsY
 iK3viXi6d3lmM6mdKnWQ+SMN7cMOW10JpTzNvnKNPqg+Gvmp96vuuQEFRcQicUSMu0Mr
 D16s3LRhyCKnpw8kXX7HzV67TsyZP2WH0ZbV1t3oo8Nn8LscH/O/4wVyy4Jw19Ut9Mfr
 wkv0PgTUTpY8c2+Gf4Mx0K/r+iPhH2c8tUF+TJxWcGHjUW4FLc3/h8M4w7/0AA+Gm+ft
 e/1Q==
X-Gm-Message-State: AOJu0YzK6oN+PIrtRtWtDhAu8GsRs+skqg/tULrAhSCkjF6BoxZYW21b
 lrcNHfdkxrSNHS9Bb0njnCljcA==
X-Google-Smtp-Source: AGHT+IG2ONyE32kvBNV+vQzr9W4f859ArKdW13BCbda/3Cs9FDjD2vhOAMOwjNLLtzgfP5GcWBjQ4g==
X-Received: by 2002:a2e:9116:0:b0:2b9:aa4d:3728 with SMTP id
 m22-20020a2e9116000000b002b9aa4d3728mr10180207ljg.29.1698759907741; 
 Tue, 31 Oct 2023 06:45:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u24-20020a05600c00d800b004068de50c64sm1754989wmm.46.2023.10.31.06.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 06:45:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>
Subject: [PATCH v2 1/3] tests/qtest/bios-tables-test: Allow changes to virt
 SPCR and DBG2
Date: Tue, 31 Oct 2023 13:45:03 +0000
Message-Id: <20231031134505.4110877-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031134505.4110877-1-peter.maydell@linaro.org>
References: <20231031134505.4110877-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


