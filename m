Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6515E736613
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:27:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWhC-0003tP-8N; Tue, 20 Jun 2023 04:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWh8-0003rJ-AY
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:34 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWh6-0006Av-HJ
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:34 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-988883b0d8fso354092766b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687249591; x=1689841591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TSMjgdnc7KTNApiM9DYxdqyr8twYlwTyuST8ZOwwTSA=;
 b=kqNrTkMYWGCxu9lWQbNNtjQLYZsVA01a3RyVYe5qnBr2W8V9I9RUUBvN/bvDjEE09/
 FtVNLXoqPAje1319qm5zatzImXAHzeYeCHjnH0afdAuNQLpyryG/Cx3f8L0J/c4G7xRw
 PJDHHCPnC/PPTIBSfRyIb+fUH1JxLSayu/VwEpKRcuV2bJw2+AoVOhT1Lr/Cu6IOcwoQ
 pZT71eoZasAySymOUBpbFt/2d4NisTmVi7gNjP1Xs55PHEJd7jsLanc5KpFiSmgonPPx
 axZT6UjkKTsocWgGxq/GKtmASCKXaVHEYpDzAvCDcCJGiFZtJdyhfwBhDWZTjaswuwCE
 7j0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687249591; x=1689841591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TSMjgdnc7KTNApiM9DYxdqyr8twYlwTyuST8ZOwwTSA=;
 b=GLZyqS0MLAN1vyhfqYxnrY4J/SHYAPBD+xdgF3TRTdQCAq4hY1iP6qQ92aPMhRv0ry
 OVj8uVnKoSGwlHZwIbEet/CR/hdHFjuCBSp1XYYzCEK13INAWjRlmZnl8/gL2lymrRFE
 Ypd54q5Cx+vcbnyCoPCrDMla4Yqb6oJ+u0inLKthShP8rgAEeC+QOkpBLBt3lzNLzjQ4
 MUStSfOnPf3kV75k84/YbmVZoJxMjc8jvwWKDFMyWD/ksxupz+1DOSb6C9DTrCXJprui
 6rAVIZQW2VX250vFhIDx0GYi1iLP0E4PYhuQDrRTuynOqY4l5+EtUnso10iebBOlyXcU
 uR9A==
X-Gm-Message-State: AC+VfDy52+f4H1IEKkyagJvn2tG/I9zVQ1VL1ZXFb0okkjmTQYVaka4d
 tkDgYpDSYUACuzcFrXFq0o+wpBpI0KeMLBzfodduiKxf
X-Google-Smtp-Source: ACHHUZ5c4naReBt6m2zGF+KylFYgE0yybhIcwVCmI5VsFq2x5Wjh1m+HqwTZswQJuuNRMqxexuvpWQ==
X-Received: by 2002:a17:907:2da4:b0:988:806c:62da with SMTP id
 gt36-20020a1709072da400b00988806c62damr5896584ejc.58.1687249591027; 
 Tue, 20 Jun 2023 01:26:31 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 z19-20020a170906669300b00977c7566ccbsm935901ejo.164.2023.06.20.01.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 01:26:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/16] cputlb: Restrict SavedIOTLB to system emulation
Date: Tue, 20 Jun 2023 10:26:11 +0200
Message-Id: <20230620082611.770620-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620082611.770620-1-richard.henderson@linaro.org>
References: <20230620082611.770620-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Commit 2f3a57ee47 ("cputlb: ensure we save the IOTLB data in
case of reset") added the SavedIOTLB structure -- which is
system emulation specific -- in the generic CPUState structure.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20221216215519.5522-3-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 4871ad85f0..ee8d6b40b3 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -226,7 +226,7 @@ struct CPUWatchpoint {
     QTAILQ_ENTRY(CPUWatchpoint) entry;
 };
 
-#ifdef CONFIG_PLUGIN
+#if defined(CONFIG_PLUGIN) && !defined(CONFIG_USER_ONLY)
 /*
  * For plugins we sometime need to save the resolved iotlb data before
  * the memory regions get moved around  by io_writex.
@@ -410,9 +410,11 @@ struct CPUState {
 
 #ifdef CONFIG_PLUGIN
     GArray *plugin_mem_cbs;
+#if !defined(CONFIG_USER_ONLY)
     /* saved iotlb data from io_writex */
     SavedIOTLB saved_iotlb;
-#endif
+#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_PLUGIN */
 
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
-- 
2.34.1


