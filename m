Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4755E716D6B
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:21:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44o1-0006E3-Gp; Tue, 30 May 2023 15:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44ns-0005xh-5R
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:44 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44np-0004bU-K4
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:43 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64d5b4c400fso5437093b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685474080; x=1688066080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v9ZiT6iOGzF/qLv4FneWlWxT5JuhvBvbdJMyfzS4B+I=;
 b=Jh1E650B8MIKTHMoZhkaJOIV6uycReeoe/IoFyZjyvZl1+XrJuohpMReoZ90V43AO/
 CrPEuTBO+GjCWIxjwiMixx/C9qfSGnWI25Y2UBp7K5xBPlNZcR/0wDDlOcaoXwF+iSd5
 hVPxpnAId+SQGwGUVa6/nCGLM0ggVgZSG8BSw2IZ1Wb6h6qDvd7pPmD6ZOEGuyTNbZ3T
 dlUDFjiGf6mulsKcDWJ+UoKkoKpCm8I5hqxxSE/c8hIXlxzJ0A4j+xqqlxXZQtSH0Vxk
 ndWMcnS5976f7jQeeGpEFfyflnqU6pZEoe3UhIhgvKXuqNEoeWUJQ2DZa65eSPELVNgw
 zqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685474080; x=1688066080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v9ZiT6iOGzF/qLv4FneWlWxT5JuhvBvbdJMyfzS4B+I=;
 b=YiY0V9q9UElnrP4U36E3hkWn/myPkPB5e4sIwPyK9rMlqCvV+PrEA+ewUp32f+rMb4
 Bz1WLhbrH2E6XWt4qCmCVTgyAHLhTnhB+uy8Hzi7IxuSKz5X+gemEoTM43I3dlbyeKeO
 hG6rNy1e/5LCXjSYUfPIDpSupDuM0+x5fiqQ+gvVBFrZBBUw0fb7vbGtZqyd+llwyFBo
 3RrO7suEYIrj/PNIqWt5al78ixnwHnXhQWPywv2YZ3KeXIKzsFGjLztq5hzB7MvvY+mo
 eNjC6oa1oIW4vp5TFNUfI8e2bQJDNbPpH2WWFAY3qYCll8vsQkyXufM4t8BlmPPDWlIN
 rtSQ==
X-Gm-Message-State: AC+VfDy3jlZXNjI17I93aQLbC0j0FBp59WGVV5BWmJv1Z/NghFIvFbk+
 vXSl9SiMXlVkf7Be33UOlQ+5zXOoWE8M1RYZhjk=
X-Google-Smtp-Source: ACHHUZ4jM9DHg+5pFsEpZCkefvtJX1VSlR+2uoyHCCADkn6ZeVJcue/WGSGLTExQBuXjo93TjAde4A==
X-Received: by 2002:a05:6a20:2d0f:b0:10f:5fc:80d5 with SMTP id
 g15-20020a056a202d0f00b0010f05fc80d5mr3420801pzl.35.1685474080320; 
 Tue, 30 May 2023 12:14:40 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 10-20020a63104a000000b0051806da5cd6sm8926757pgq.60.2023.05.30.12.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:14:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 01/20] target/arm: Add commentary for
 CPUARMState.exclusive_high
Date: Tue, 30 May 2023 12:14:19 -0700
Message-Id: <20230530191438.411344-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530191438.411344-1-richard.henderson@linaro.org>
References: <20230530191438.411344-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Document the meaning of exclusive_high in a big-endian context,
and why we can't change it now.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d469a2637b..81c0df9c25 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -677,8 +677,16 @@ typedef struct CPUArchState {
         uint64_t zcr_el[4];   /* ZCR_EL[1-3] */
         uint64_t smcr_el[4];  /* SMCR_EL[1-3] */
     } vfp;
+
     uint64_t exclusive_addr;
     uint64_t exclusive_val;
+    /*
+     * Contains the 'val' for the second 64-bit register of LDXP, which comes
+     * from the higher address, not the high part of a complete 128-bit value.
+     * In some ways it might be more convenient to record the exclusive value
+     * as the low and high halves of a 128 bit data value, but the current
+     * semantics of these fields are baked into the migration format.
+     */
     uint64_t exclusive_high;
 
     /* iwMMXt coprocessor state.  */
-- 
2.34.1


