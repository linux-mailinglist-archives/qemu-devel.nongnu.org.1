Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7256481C9D7
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 13:23:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGeYE-0001Vi-Tg; Fri, 22 Dec 2023 07:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGeYC-0001Ur-SQ
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:22:48 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGeYB-0005mt-0G
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:22:48 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5cd8667c59eso1369899a12.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 04:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1703247763; x=1703852563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNKontpfLUZyadIzXzNBnB69eWAYBQx8Z06ZfrYR8/0=;
 b=bHR973U682ixIDlPQ+i/QFa6uoEZHk26LTME1cebpk9GHdutDjWSSPjXXx5XUyEemD
 KsSNGfYmvr803AsYrx++JYaCDwUMwMoe1bVV+Ptu14RxdyilZEbKoHN40VMuJoGLyy9z
 8/FwArjJKjClG1up3P/cTB0FaEi6J5bOyh2KnvMbgB/ripnIYHmHf6tWifxmVuV7DlNP
 yiw5SP4Rvg6gL1mMrrlWT6WPSBcQ/7sfrG6wT0VZEE3noslEADJWEu5dK17RBmdxlxc3
 f9lylD6qiqbzyksitBkA6lkWKCuedYxMK2I6y6sNzRwJbesGN6XmS3P7+OOsrPtugw3T
 pXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703247763; x=1703852563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bNKontpfLUZyadIzXzNBnB69eWAYBQx8Z06ZfrYR8/0=;
 b=IumUwFrbwb6cPvsQ2GNAfT/jBM0oQjwHOgWphLJlSsKk2LMnRzSJbsrFSAOd54kSEJ
 k1QJVmyPmKnxkt0sh5yFD3hX1HPweEI5PFPlOd92vEieCV170WeNxx9lHJ6SQmyNY8Vi
 r/V3MmeyZqkiR+FSmQcZNyqB9sT6iFyZs4xK1py+jW7V8s4gVssP6yQdmy6HKToKdDQD
 hFW4hGAnulfYCJaleCJ8ju2doUor6Cbz/f7Mu6zHxVV4F0mr3XTKnAoWI7JgKo29h9Rs
 mZb+uHg2C4fkIUgvVWPNet0NW7AARzJomXC3GUzdhlb3rtwo4dVaNgySRzjS2mIZFNG3
 sMjA==
X-Gm-Message-State: AOJu0YyqB/MYrf8G3uj21Z3YNXY7wHETCxZHnmI66ITzVjJjycubBcQX
 l4lG10nnE5TJdDAa0n55nKfsAZTGToX/LicrnLGriev/w6m8Ww==
X-Google-Smtp-Source: AGHT+IGVsM/Li3YD6MuFO/G8cE7Px9qU45nHLuk38M8cY1Zc+0fHGtcYFu6e3WJKguSMrsMhEDoWSA==
X-Received: by 2002:a05:6a20:78a1:b0:194:b3af:8674 with SMTP id
 d33-20020a056a2078a100b00194b3af8674mr1122908pzg.10.1703247763704; 
 Fri, 22 Dec 2023 04:22:43 -0800 (PST)
Received: from grind.dc1.ventanamicro.com (201-69-66-51.dial-up.telesp.net.br.
 [201.69.66.51]) by smtp.gmail.com with ESMTPSA id
 g14-20020aa7874e000000b006ce7ad8c14esm3274901pfo.164.2023.12.22.04.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 04:22:43 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 01/16] target/riscv/cpu_cfg.h: remove user_spec and
 bext_spec
Date: Fri, 22 Dec 2023 09:22:20 -0300
Message-ID: <20231222122235.545235-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222122235.545235-1-dbarboza@ventanamicro.com>
References: <20231222122235.545235-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52e.google.com
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

They aren't being used.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu_cfg.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index f4605fb190..c67a8731d3 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -136,8 +136,6 @@ struct RISCVCPUConfig {
 
     uint32_t pmu_mask;
     char *priv_spec;
-    char *user_spec;
-    char *bext_spec;
     char *vext_spec;
     uint16_t vlen;
     uint16_t elen;
-- 
2.43.0


