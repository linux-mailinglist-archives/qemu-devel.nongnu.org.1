Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B54957E28BE
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:33:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01ar-0007vN-8V; Mon, 06 Nov 2023 10:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01am-0007pj-Us
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:45 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01aj-0004NK-Hf
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:44 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40836ea8cbaso32647955e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284760; x=1699889560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9IWF1UaMVtNNkX+uy7OYvvuM9TENlVQduNwTa/Gt+7k=;
 b=s1flXPzkgar/v9qBs5/bFq5N14hUbWiA2xIAoml/qCPIJj564aR3FWAblaoMhP+57w
 DF8zAXzp3co/SYCtqaizM1Yb0a8lzf/2LPq+UP7BHf2dPea8CmzPDEusgfG6uVhfddwy
 1c9c1SM5uvKiNis35/9Y1YrGZAIDe9YhRI80SWmfRTRSioiQnOKRZkYjgjEEi8XjW3kC
 oiL7vxF5VMvraZPQmbPfT0i0IhhgHQ211EVyC2ZUF34NOwkNVfvL8MWGR/nkXcXrP+ry
 WufaU0dg4bzOQfGD62BreNOhzlvjQVpt8whKgWGymMKZn/p/D0WXqLt1DsiRCHBoQ7nk
 ScXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284760; x=1699889560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9IWF1UaMVtNNkX+uy7OYvvuM9TENlVQduNwTa/Gt+7k=;
 b=VStAIc3fUH8fR/O9MS3dv3jf3/5XzKKN25l+VW3NgPhvKR6zKhhsb4BDXhRJcod6nK
 BcfiWSnlRQ0Hl4OZbL9EG93ruaXffiLIey4YEqywurbVxQbrRxiT6/bZKzySbQHwAH+o
 1mAK2AOI12Zt7ZDABoj96p2VA9cjkWqG7KqwwnV9lZs2XPYzdRElfbIxotOdytWi4fpT
 W3a2oawXzOwnjRsUK8jxnDh6xSs3i2XYwcPWCZfENduJ24HcJvdEzSPyjMTkWibuJUIa
 cHWNiELt7ZzEAv82pY6kREnbg1oqNFlfit2tOvJ48gKnb2c1LetrTGwVeJ2lBT9M6gPw
 hFgw==
X-Gm-Message-State: AOJu0Yz9CI7XC9r5SgkyndgQpDXiIPRYpsZhYKHOJyF264cRQH7fOoV0
 bjGI5PPMx7Vs4CxPKgHfH5c55/xvjmL5Ewlpbsg=
X-Google-Smtp-Source: AGHT+IGWXPV+F5hmMtDhKdV5JEWP4DuVpgUxtsIj2j1OcSrytdXqC75gx3ixnDdLfJXzbRX1FItdTQ==
X-Received: by 2002:a5d:4f05:0:b0:32d:9b30:9a76 with SMTP id
 c5-20020a5d4f05000000b0032d9b309a76mr25713871wru.47.1699284759696; 
 Mon, 06 Nov 2023 07:32:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d5-20020adff2c5000000b0032da6f17ffdsm9752176wrp.38.2023.11.06.07.32.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:32:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/12] hw/arm/virt: fix PMU IRQ registration
Date: Mon,  6 Nov 2023 15:32:27 +0000
Message-Id: <20231106153238.1426649-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106153238.1426649-1-peter.maydell@linaro.org>
References: <20231106153238.1426649-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Sebastian Ott <sebott@redhat.com>

Since commit 9036e917f8 ("{include/}hw/arm: refactor virt PPI logic")
PMU IRQ registration fails for arm64 guests:

[    0.563689] hw perfevents: unable to request IRQ14 for ARM PMU counters
[    0.565160] armv8-pmu: probe of pmu failed with error -22

That commit re-defined VIRTUAL_PMU_IRQ to be a INTID but missed a case
where the PMU IRQ is actually referred by its PPI index. Fix that by using
INTID_TO_PPI() in that case.

Fixes: 9036e917f8 ("{include/}hw/arm: refactor virt PPI logic")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1960
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 475d918d-ab0e-f717-7206-57a5beb28c7b@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 92085d2d8fb..0a16ab30958 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -631,7 +631,8 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
         qemu_fdt_setprop(ms->fdt, "/pmu", "compatible",
                          compat, sizeof(compat));
         qemu_fdt_setprop_cells(ms->fdt, "/pmu", "interrupts",
-                               GIC_FDT_IRQ_TYPE_PPI, VIRTUAL_PMU_IRQ, irqflags);
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(VIRTUAL_PMU_IRQ), irqflags);
     }
 }
 
-- 
2.34.1


