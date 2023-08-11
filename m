Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1E57799B7
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 23:42:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUZsI-0003Bs-Kk; Fri, 11 Aug 2023 17:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZsF-00038N-Fz
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:40:47 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZsB-000293-CN
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:40:46 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-267fabc8465so1450498a91.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 14:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691790041; x=1692394841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qn8yFftrxEzFHRpsLAJ/ue+KyTKojTWWz5oD7VvEO7I=;
 b=kefcNVh0oqfXtAyNZ/1m3UKENF/tryUjFFWwcXqQNRS0LgVqpKCJMjTobkP++fYypF
 dvRB/O8NJmPpy8i4KKOYZD3ncr8k9jLi+FmoFCtnKFskWsZ+cezKhlrsu354m/aExfAQ
 PL1uhou3YeQHw9VLbepuU92AFNjbh0hvQ609j2PECuj5AWdKRwGB9yNwajFcVmAR+EXS
 /j0Sotv3TjzG8PJNeNi4Gz2enkLnXV/jiM7NN/70N7y62jg4bU4J500u/B7UY4WhqeyX
 ROX/tClNffPR+Mi3CK9hjSjOBYxmsP0HtlkpMTAbqJ6j9HcAkIfc+QAeZNYEbmpj+p3s
 l/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691790041; x=1692394841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qn8yFftrxEzFHRpsLAJ/ue+KyTKojTWWz5oD7VvEO7I=;
 b=VQJAoy4Ywmk2E1CtZ/SgOCbiKh9TrXF3YURdc4K5LwGeCJQZ3Nu94Ru7RZM0CULB74
 5l47EmGRvj5bSIHkKaA2HYGWXSGTDY+RmCFhHCGGPLPQWQW6PfovHnuxiyhgdX1rgwxW
 O4a+OOGc7fpSYg1n+Xy1m47p8VP34jj1lqwwtFx+Dbbv8Uj2lJeuikQ0xIE+Fxct4bp4
 KYHl7gcoL3t44MsgSdxePieoigOsB9FRvUEoqWu10fSHQWpYe6hyhH3YuuxA7FpJXGhT
 LrryS35Mlynz/dnAN7439xV7jUnaY571wchw30k/ucj5IAlCbwJy5nrGJbqDWn22ARpZ
 +66w==
X-Gm-Message-State: AOJu0YxvjObQ3FVIhaMKWeT9W+b36VKNxsKj4BK/oIPk7AiukX88QjmL
 XfdcxrnrxpSKqt2rpazploXKItk3UVn4lilnzyk=
X-Google-Smtp-Source: AGHT+IGCVELkXOi5bequfzWNvDQKhA7WW4vtHRLu9HiFE81IAX9ucHNl4h9TMJw3HTanEq598diBdA==
X-Received: by 2002:a17:90b:1d8a:b0:267:f223:3732 with SMTP id
 pf10-20020a17090b1d8a00b00267f2233732mr2323926pjb.28.1691790040971; 
 Fri, 11 Aug 2023 14:40:40 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 gk18-20020a17090b119200b00263ba6a248bsm5723840pjb.1.2023.08.11.14.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 14:40:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 09/11] target/arm: Suppress FEAT_TRBE (Trace Buffer
 Extension)
Date: Fri, 11 Aug 2023 14:40:29 -0700
Message-Id: <20230811214031.171020-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811214031.171020-1-richard.henderson@linaro.org>
References: <20230811214031.171020-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Like FEAT_TRF (Self-hosted Trace Extension), suppress tracing
external to the cpu, which is out of scope for QEMU.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 85c02308e4..43c5ac6456 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2088,6 +2088,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         /* FEAT_SPE (Statistical Profiling Extension) */
         cpu->isar.id_aa64dfr0 =
             FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, PMSVER, 0);
+        /* FEAT_TRBE (Trace Buffer Extension) */
+        cpu->isar.id_aa64dfr0 =
+            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, TRACEBUFFER, 0);
         /* FEAT_TRF (Self-hosted Trace Extension) */
         cpu->isar.id_aa64dfr0 =
             FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, TRACEFILT, 0);
-- 
2.34.1


