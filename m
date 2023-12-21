Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B7C81BD9D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:53:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGND7-0002Uo-DL; Thu, 21 Dec 2023 12:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGND5-0002U2-2V
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:51:51 -0500
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGND3-0007w0-6l
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:51:50 -0500
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-35fcea0ac1aso5028565ab.1
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1703181107; x=1703785907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNKontpfLUZyadIzXzNBnB69eWAYBQx8Z06ZfrYR8/0=;
 b=IeCcfGki/r1XMetuUJQ1OKkUFjMttf2qNURwlEFN1a4F1Frxsrxa/0GO9q5kWyHzPf
 ynhlP3wXksfod9bs1FCJSATY/jbaB+F3JILGhtME8D2A7SaHPNbcqGRmfYZn96eh7H7d
 bSDg3rYQVOwg0nQGDdQkd/vpLvjARUuS3cyxRU4GWXmnXiH2ts5Uq8tOKHMIg2zhN5X8
 bsSkZ5RLGXI8MjStRnZzPBe+ePZwNnnYDSdL+yExErbBhueJhQ7i1BcVTWQf/Hn9nI83
 5z94b990SUEqYGdzBvlEFIjKszWDts+G7ISh+8hTVHKDpMmEM6j61FlkEEBsbijGefAx
 LcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703181107; x=1703785907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bNKontpfLUZyadIzXzNBnB69eWAYBQx8Z06ZfrYR8/0=;
 b=XTiOitJLZQlW9KxT2ETqBmohWeU16BSYn/f3R/EZvDEao+k6swSCVCAcQjNN1NM0ab
 rxt0y2LTriPcYV9dRV1O+UfM3tPM8StgfYQZhMDGaA6ZAiGwBXKe47mNGc7HkjGh7RN+
 GEZy8jli8/GKY+phaI2enDQhRDFIvK1AoNbeAsz5BXs0oX8nUkYKuBDXSMnTmtY6wY3a
 czhVH5fQPCKTsc1AiR1V3Wufc2n/TNwzgkTLQUqHCfkooZ3Q/9v5wZAqKDKqoA/MCDmg
 +j50sI1byHM9v7XESDd9g27pYCG1EChjUUZ/AOROwXPPwaKFX19sQHKFL5bzAViOVQQr
 4Jsg==
X-Gm-Message-State: AOJu0YwLxDx8HULkt8kmQ4I7ezgCyc8iqGJ9MaW5Fq0ulJqp7uePkC4n
 O/eDjkZa2aQppKcU8AAhEMtk3vcOQfp4mBYcJuqFBA==
X-Google-Smtp-Source: AGHT+IH4el+xtvfYc8eu3QrCedv9jj6VkMTVMjHqfjl8O9qOL+5GVbTntzuCPo3HwUYRjnMNJRzgUA==
X-Received: by 2002:a05:6e02:1b8f:b0:35f:b126:374e with SMTP id
 h15-20020a056e021b8f00b0035fb126374emr8256453ili.107.1703181107083; 
 Thu, 21 Dec 2023 09:51:47 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.205])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a63f50a000000b005b18c53d73csm1806261pgh.16.2023.12.21.09.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:51:46 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 01/16] target/riscv/cpu_cfg.h: remove user_spec and bext_spec
Date: Thu, 21 Dec 2023 14:51:22 -0300
Message-ID: <20231221175137.497379-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221175137.497379-1-dbarboza@ventanamicro.com>
References: <20231221175137.497379-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-il1-x129.google.com
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


