Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 421DE8201AA
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:27:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKL7-0006sD-W7; Fri, 29 Dec 2023 16:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKKx-0006ra-Cu
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:12 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKKr-0005xb-JX
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:11 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d427518d52so36463235ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885044; x=1704489844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Te0syHdSvAn6waobc73q7nKB4LmwnyEhA4q5YcHJ4/8=;
 b=aD8hvsouABLKVV6O/R2AKm5vkOgfkF8Li1w2M6ljeRx5JKirpvohG7Yhe9N1I1WxjT
 iTOGqM+2ivWxwimsPyOz03knSRMSEtiVqKq8aEVz7Cbb1V4lqt8kybbpczQ4Qi8SN+TA
 05GOf+jDE5SvYT+PMgNnCxCZPYLH5TlOYw9yy91camh6OgqARiNNd+ig+jH6T7LUtQAm
 RZ/+BkLr/gAO3IhxQ7pxVIEbBlPW7YZy1TeHcvDvg2NzoL84te/w+q0GXbk6t16hVls8
 ZnAb3xXAp/u8sp4a5+osdzoBJUm9SZlV1QpGh++moYwRWDp/4ZvoITfrTPL8IG5lkE3T
 1ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885044; x=1704489844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Te0syHdSvAn6waobc73q7nKB4LmwnyEhA4q5YcHJ4/8=;
 b=C2QnB+9BFCwVXDjuLiwBmJ58JtkbMJKQUZOGnN37Hls0luGwbNCPHVpGrG6/2RIMzT
 oCZTvwVsLullpbq9vZSquuwNmtScaP0ExoflKNBsD6UllS2AFqqWI0TNkO9LOj0iM3Wr
 Z0H9EqNNPQ7GOC5S+DgFQc6O75XMSettVZkf00EiMhVy2zHVTyDkuPY6PiRACAAMVTgB
 +CQXTQvORWPy9ZK9I5FNaWHi1eVGYgKo2pn5njTiFfVWaQgqKcwPd9Oxq2jAF+iwxj9t
 jqzg1MQ1MxSAJ0e3ZEB8ni5AcqeuYs4kzVhrcRU7qxb6voiRYZND4Qls6dc93/0HyNBQ
 ojBA==
X-Gm-Message-State: AOJu0YwNIql8mlT0ldv89aesSbOQSGybofW7N4xtaVzN+IUQIqD1zOlE
 L4pYqr2LVUjpCiaT0lRuK0Jj1sBfAT/tPsA3EEzsFsPbcA/HHA==
X-Google-Smtp-Source: AGHT+IFc8lswCJXzwpqSJvxgoOc3rhwklGDIHJQ1WFyVFcETCR547G0DlawemLZhwGGfKQCmJbh2Og==
X-Received: by 2002:a17:902:74c4:b0:1d3:bceb:ba62 with SMTP id
 f4-20020a17090274c400b001d3bcebba62mr15614893plt.45.1703885043950; 
 Fri, 29 Dec 2023 13:24:03 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/71] target/alpha: Constify VMState in machine.c
Date: Sat, 30 Dec 2023 08:22:39 +1100
Message-Id: <20231229212346.147149-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-5-richard.henderson@linaro.org>
---
 target/alpha/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/alpha/machine.c b/target/alpha/machine.c
index 2b7c8148ff..f09834f635 100644
--- a/target/alpha/machine.c
+++ b/target/alpha/machine.c
@@ -24,7 +24,7 @@ static const VMStateInfo vmstate_fpcr = {
     .put = put_fpcr,
 };
 
-static VMStateField vmstate_env_fields[] = {
+static const VMStateField vmstate_env_fields[] = {
     VMSTATE_UINTTL_ARRAY(ir, CPUAlphaState, 31),
     VMSTATE_UINTTL_ARRAY(fir, CPUAlphaState, 31),
     /* Save the architecture value of the fpcr, not the internally
@@ -73,7 +73,7 @@ static const VMStateDescription vmstate_env = {
     .fields = vmstate_env_fields,
 };
 
-static VMStateField vmstate_cpu_fields[] = {
+static const VMStateField vmstate_cpu_fields[] = {
     VMSTATE_CPU(),
     VMSTATE_STRUCT(env, AlphaCPU, 1, vmstate_env, CPUAlphaState),
     VMSTATE_END_OF_LIST()
-- 
2.34.1


