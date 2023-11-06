Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 037097E1AEA
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:14:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztfx-0005a1-6f; Mon, 06 Nov 2023 02:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztdD-0001C3-It
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:46 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd1-00022s-Td
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:41 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ba54c3ed97so4305695b3a.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254148; x=1699858948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZN+AUq0fMLCJmtXlKU3nsk7QrHFyeF7qawtkUtQVWh8=;
 b=X34VlG4JT1JSD5fWVYxF4AAkshR+C6d65cnTUczr2W7j/xI2pg3e0Ai+2vebOh+vwo
 rO/YFUSwoZ1hgI1OmPvXiQOu6MVcJ0e2xBpja+2dLuLaeirzQOyj2ArrETRgdRiBbapO
 27ab6I8T0WN96i7qMyoy0AWFjJr+UVEea7pHeIPGyqtse6Ty1tKOEdPUJuGGqxSjcBMb
 E0q6VHtNtnMC6u+EUEcOw56AffixAcYQgxowlLTEveL0rjzVLrg5YEesw8R6sE8/u2sJ
 o/9eNCMWJLPCHM32t3nMkvxYsezfx97XO48CVQ8ehIe9fLFq6+lr6XkZXal/XrabxaAc
 x2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254148; x=1699858948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZN+AUq0fMLCJmtXlKU3nsk7QrHFyeF7qawtkUtQVWh8=;
 b=OXbMDxj3326L687TKViw1Z6c53utAXyTi6iJkmkBvQVUWCLB3YX+kTY6Skiw7XE+EP
 WqO8/18O0CJvy1tWpbLdhhza2fJAabGCMhDwUun7uTHwf6uqGLnBvGI5vvWlmO95zP5p
 dK/yJfBBaO2dMRtJ44ivXZt8bNGCbsGItsG6K/n0BM2/ALyFqI5wHWdIP7fjF7SiFZ1y
 ilTLM+I4ri4KPsereaihd6TCdwacF/pjN80ZocR+PB6pPrd2AeTIOB4ry1ocoYhPjWWs
 7My2RuxS5FbYmGG64thT9RCGd6bzX1Y7kEyt2kwuyp57w0tOcpqQYauIzK0fqHRs0f3U
 Ku9w==
X-Gm-Message-State: AOJu0YxiVuYJK5srdPdclx7zhjh2rqRkuIvJH3nbMGdtwcP+fVREfEz6
 t4//eay3QLSIXM9OPYaI/47ke/r7paa0kzlLvT8=
X-Google-Smtp-Source: AGHT+IHdixrZ+apzK+cNleiC6cvYHw9VfwKF2x+XzPhWCWv0SxlZyOuceGtRJcsaYxgFz+GKMUb9kw==
X-Received: by 2002:a05:6a20:a122:b0:148:f952:552b with SMTP id
 q34-20020a056a20a12200b00148f952552bmr38185243pzk.51.1699254148264; 
 Sun, 05 Nov 2023 23:02:28 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 69/71] util/fifo8: Constify VMState
Date: Sun,  5 Nov 2023 22:58:25 -0800
Message-Id: <20231106065827.543129-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/fifo8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/fifo8.c b/util/fifo8.c
index d4d1c135e0..de8fd0f1c5 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -109,7 +109,7 @@ const VMStateDescription vmstate_fifo8 = {
     .name = "Fifo8",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VBUFFER_UINT32(data, Fifo8, 1, NULL, capacity),
         VMSTATE_UINT32(head, Fifo8),
         VMSTATE_UINT32(num, Fifo8),
-- 
2.34.1


