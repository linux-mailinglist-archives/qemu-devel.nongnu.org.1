Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9EB800AB8
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 13:18:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r92Sn-0005hu-6V; Fri, 01 Dec 2023 07:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r92S0-0005X7-JP; Fri, 01 Dec 2023 07:16:57 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r92Rw-0006Jk-6k; Fri, 01 Dec 2023 07:16:56 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6cdfee14c24so509154b3a.2; 
 Fri, 01 Dec 2023 04:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701433009; x=1702037809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A8CijVa+e1oWr2EV0tfoz247smmQS3FwcjTPUtBwtaM=;
 b=VozzuXtkI1YjeyyePe5HJjW15Law2Pn/CWvtH6bTmF85MXkcMZ85R5IiBvpYvYJX2f
 SiSoOlls9yto2UBJvItjK1xKiiJfdwhSlEaHlIrSTqiv2XAXbuey7FRz9dcqAoI5LPKe
 nckkIqnTGdLtXfrbAFlDZZTUJ+oABfMJDHrWm5W7cdr1aw8e6XEx7TtfA6AsmUXTfpH7
 fa0lSz0O8DJJtatyKkkZ4/FwxYOiVBL5WpZgpp1S2LRgvVSbQXGs21HVhMiVADRR+512
 vQ71mUaEH87+CZF9So43GRvG+1KhLyELEgvmJpXjVPCSY78oECQH0vJ67Vqn7/sfhJY+
 sQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701433009; x=1702037809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A8CijVa+e1oWr2EV0tfoz247smmQS3FwcjTPUtBwtaM=;
 b=epAJJR8WlKJVH23aGJvgQ2nT+gOjdxmPkg5qMlCIMQFoSIqZjL0Tc6YXOPdi+O/Mc0
 FORQJysb2nxbKxWeHQE8DKiDC6odFJYfDVg0/QuViprTm3UKkIS2YwdNjQQcaBrXxHGt
 1UhshEHg3MNEX8NZhxYcA3eWmOl3Wpde2lqyGrcLDq0lcRKVcj138Vv0+8/LrmTsnw4u
 w2oOjdZV70qRogpMi3wZJvgMs5wcECsetzd+aUJ7k1Ln/8cgGqVcrjyZMNDLTH/LjObj
 0s0r1m+XqgWKKI0SCSiEpNx+jBOxeNWPWLRkSMULIAUGIvp6/1oEdKjvVHwh/P2Rj187
 +6ig==
X-Gm-Message-State: AOJu0YyBFPMH2CG6Hx47iNvPJLXdbA+6oYfd/rbA4Eyj+a6o8EBpk+oU
 fQ0FQgHUVj8rVfQryfgJqxWRysoDfv0=
X-Google-Smtp-Source: AGHT+IGyuVrLHwn2M1CI4eUZBlG+fbN+lDo48FBbf6XiOWJHpfMKdiREhwPfRVIeChlUeEZYL7CoAQ==
X-Received: by 2002:a05:6a00:4c81:b0:6cd:f209:80cf with SMTP id
 eb1-20020a056a004c8100b006cdf20980cfmr4749092pfb.4.1701433008991; 
 Fri, 01 Dec 2023 04:16:48 -0800 (PST)
Received: from wheely.local0.net ([124.170.16.164])
 by smtp.gmail.com with ESMTPSA id
 r19-20020aa78b93000000b006cdd39faaaesm2830782pfd.20.2023.12.01.04.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 04:16:48 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 1/8] target/ppc: Rename TBL to TB on 64-bit
Date: Fri,  1 Dec 2023 22:16:29 +1000
Message-ID: <20231201121636.142694-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201121636.142694-1-npiggin@gmail.com>
References: <20231201121636.142694-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From the earliest PowerPC ISA, TBR (later SPR) 268 has been called TB
and accessed with mftb instruction. The problem is that TB is the name
of the 64-bit register, and 32-bit implementations can only read the
lower half with one instruction, so 268 has also been called TBL and
it does only read TBL on 32-bit.

Change SPR 268 to be called TB on 64-bit implementations.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper_regs.c  | 4 ++++
 target/ppc/ppc-qmp-cmds.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index f380342d4d..8c00ed8c06 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -460,7 +460,11 @@ void register_generic_sprs(PowerPCCPU *cpu)
     }
 
     /* Time base */
+#if defined(TARGET_PPC64)
+    spr_register(env, SPR_VTBL,  "TB",
+#else
     spr_register(env, SPR_VTBL,  "TBL",
+#endif
                  &spr_read_tbl, SPR_NOACCESS,
                  &spr_read_tbl, SPR_NOACCESS,
                  0x00000000);
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index f9acc21056..ffaff59e78 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -103,7 +103,11 @@ const MonitorDef monitor_defs[] = {
     { "xer", 0, &monitor_get_xer },
     { "msr", offsetof(CPUPPCState, msr) },
     { "tbu", 0, &monitor_get_tbu, },
+#if defined(TARGET_PPC64)
+    { "tb", 0, &monitor_get_tbl, },
+#else
     { "tbl", 0, &monitor_get_tbl, },
+#endif
     { NULL },
 };
 
-- 
2.42.0


