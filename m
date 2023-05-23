Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EDA70DED0
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:11:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SUj-0000ne-4f; Tue, 23 May 2023 09:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSZ-0005AA-VV
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:56 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSY-00039l-Gn
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:55 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-64d24136685so3504749b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850033; x=1687442033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g9Z7ehG7+swOH6zB5dODu6bYg//xIYbQwbOdJN6xAFw=;
 b=VoLmy0zeNcxaB5k7SHGJIMvmSv3GNgwUNssLKkLX0oJ+fdREZgdWAV0q7/C80wqhsd
 +J8Zy4RaR1aln7Y01qOF7yMyN19G/5UHN3kk8fGpKIxJHDUlu2ixzWIdgRIoFrHaTUx2
 QnXce6DkEMPAHhZclAPdMXzanrtXP3qLcz+vjmZOn/OjYLczb3DecAFDhwna+RRVlJmI
 npKhkQ5RnQoY1yB0AyElvkz++Jd4stSk+H4+hlmB1QfWIEomqPHNjHG30RHHoHrV3NlX
 LG7gn54gr4J/r4fs13VAHDEqVfU7bIE04of0sG4qS8l7XYwApMXnzX5nI4WpZTwwQ52x
 8vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850033; x=1687442033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g9Z7ehG7+swOH6zB5dODu6bYg//xIYbQwbOdJN6xAFw=;
 b=RhIEoUC0xGBKoBTUaY/KAUtCi0DC8o0E67th/iXsdy3QUQkU0dmfuqOsrSbKDfHHLi
 a0sa86Azo4LvBWkSzhUKLTFoD8ahz9UAWAdqRCx9MdKdAORYauKI2TIbl0LqFUVdMGNx
 VXwKJXIV4ifzz7HkX59/RvMKbZ85w5BA5o5Rv6wT79TuqKw+lXMRmQfKsHGERmWzEmuR
 Bs3NNmX1Pb3M1quuO/QkRnmozcoNR4N3ldbhqqot2C9WBbKifBFE9J+MMmxwOUvUqXhN
 UAh6+OXafPzDLIlewzPczMWYDcvoA98s7baVamTop8Cfr4+B3jSMgRgRDRpRkIq1W3XJ
 S09g==
X-Gm-Message-State: AC+VfDxkSnCEVG+C7M6YtG3l0MXXI0t5PT3P9LCXvJktpOtW/5tnrERo
 I6bSl0fow8N4bOeIXHf+6Iizi2fYAmTvIMueJ54=
X-Google-Smtp-Source: ACHHUZ7OJoqdX1mY2SfA5jrlcIBHe2qiJrOrI4dZF5/fTiHjFrkZicRSccbo30gqObd5oE8XJyPniQ==
X-Received: by 2002:a05:6a20:2454:b0:104:873:c3be with SMTP id
 t20-20020a056a20245400b001040873c3bemr12728349pzc.12.1684850033220; 
 Tue, 23 May 2023 06:53:53 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 36/52] include/exec: Remove CODE_GEN_AVG_BLOCK_SIZE
Date: Tue, 23 May 2023 06:53:06 -0700
Message-Id: <20230523135322.678948-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

The last use was removed with 2ac01d6dafab.

Fixes: 2ac01d6dafab ("translate-all: use a binary search tree to track TBs in TBContext")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index f01c7d57e8..698943d58f 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -467,16 +467,6 @@ int probe_access_full(CPUArchState *env, target_ulong addr, int size,
                       CPUTLBEntryFull **pfull, uintptr_t retaddr);
 #endif
 
-/* Estimated block size for TB allocation.  */
-/* ??? The following is based on a 2015 survey of x86_64 host output.
-   Better would seem to be some sort of dynamically sized TB array,
-   adapting to the block sizes actually being produced.  */
-#if defined(CONFIG_SOFTMMU)
-#define CODE_GEN_AVG_BLOCK_SIZE 400
-#else
-#define CODE_GEN_AVG_BLOCK_SIZE 150
-#endif
-
 /* Hide the qatomic_read to make code a little easier on the eyes */
 static inline uint32_t tb_cflags(const TranslationBlock *tb)
 {
-- 
2.34.1


