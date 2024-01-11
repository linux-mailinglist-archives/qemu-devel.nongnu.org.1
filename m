Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D324982AD05
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:11:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssY-0001Rn-6F; Thu, 11 Jan 2024 06:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssN-0001PU-9N
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:31 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssH-0004Yh-V8
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:30 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-336dcebcdb9so4808302f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971124; x=1705575924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1O9OPo4rv9t8UJdjCTvrRPzHe9Vt4uLDECv1wcuWN70=;
 b=wMDNaPujpnQPBfJ9xvfuTuuPAA+YWgj1m3fAwfdt3KDEGAsGHvNReHu9tfE0+tLyXn
 NwJIc7UIKJm85qNLAUPEEOK13P0Q35555pbBY97tQiQSJBI6T/GfwntnM1YsR55vAyZF
 RI0ZSRA9p0glZqbcOJdz7LfrOVmGQWlwjqGk2r3ePGdatLQ9FQcj4iHz+pz9fWjQdXiC
 5NCtMmeIeuAD6TYJVebJ3CO4BH9q7EzVUCmm+9THB1E5sGj6DuQ6RVtevHkhNxSqnkX5
 JrZD78jiKKc9O6pM+18Cw3Wj4Z1pq4O41Cm4H2mPEp8sx2Yo5IgcSPJ9RsNceiNHssaV
 8Zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971124; x=1705575924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1O9OPo4rv9t8UJdjCTvrRPzHe9Vt4uLDECv1wcuWN70=;
 b=VzdHbEC3/7oVXKPskWP+Olw4MTLG7XYxu3Mo4yIuwrzj+2DjY4w8lXuoWWBTjBVm4t
 PmWnDwuBh7DH72f/KZVBibbIDPy6ED1elCc1yMMC9s4KjNSNMykGUupcDHW8MktbmG5d
 28V31SOlxReEfgOJvk18JxRUsTrrg8qiua/nXfOuK+/z+dISDKtqtHx9+ZkgeAk//372
 5nzhRccvkKjHS9nbxIqJxmoXwWaLmIFlCVjhzvjvCwQSex0I3RLbIkVdQrgz1QZuSw1y
 pScbpZhfKJ1QLGXBAkbh9h2t2qiTdo4xHR0MYhHk9Wl/CywDlrByGNV7XZCkRRdS0goj
 EeCQ==
X-Gm-Message-State: AOJu0Yzo/KJ/jbl3TZ5uDhXklV5nK+OPhXnYnCghoh8TmSkLjTB2nS62
 0IVz9IWoNP91fscp/sAvCalNrKVEukqLdpvXLQR9LRPVdsQ=
X-Google-Smtp-Source: AGHT+IH4W7Dw0MasedjXLlQVGTq317Xp5Hq4Gb0B7kyRQA/AmhYZ7ZfHc+SLBRw9CvRZ0zobmVOqMQ==
X-Received: by 2002:adf:ebc8:0:b0:337:4d36:ae41 with SMTP id
 v8-20020adfebc8000000b003374d36ae41mr265708wrn.35.1704971124034; 
 Thu, 11 Jan 2024 03:05:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/41] target/arm: Report HCR_EL2.{NV,NV1,NV2} in cpu dumps
Date: Thu, 11 Jan 2024 11:05:03 +0000
Message-Id: <20240111110505.1563291-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

When interpreting CPU dumps where FEAT_NV and FEAT_NV2 are in use,
it's helpful to include the values of HCR_EL2.{NV,NV1,NV2} in the CPU
dump format, as a way of distinguishing when we are in EL1 as part of
executing guest-EL2 and when we are just in normal EL1.

Add the bits to the end of the log line that shows PSTATE and similar
information:

PSTATE=000003c9 ---- EL2h  BTYPE=0 NV NV2

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c15ad52ab3d..7d763786d88 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1059,6 +1059,7 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     uint32_t psr = pstate_read(env);
     int i, j;
     int el = arm_current_el(env);
+    uint64_t hcr = arm_hcr_el2_eff(env);
     const char *ns_status;
     bool sve;
 
@@ -1096,6 +1097,10 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     if (cpu_isar_feature(aa64_bti, cpu)) {
         qemu_fprintf(f, "  BTYPE=%d", (psr & PSTATE_BTYPE) >> 10);
     }
+    qemu_fprintf(f, "%s%s%s",
+                 (hcr & HCR_NV) ? " NV" : "",
+                 (hcr & HCR_NV1) ? " NV1" : "",
+                 (hcr & HCR_NV2) ? " NV2" : "");
     if (!(flags & CPU_DUMP_FPU)) {
         qemu_fprintf(f, "\n");
         return;
-- 
2.34.1


