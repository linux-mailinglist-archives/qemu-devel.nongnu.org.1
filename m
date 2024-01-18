Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CED31831C25
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:14:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTzK-0007Qo-G3; Thu, 18 Jan 2024 10:07:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTzH-0007PS-Fd; Thu, 18 Jan 2024 10:07:23 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTzF-00080j-VK; Thu, 18 Jan 2024 10:07:23 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d3f29fea66so74035985ad.3; 
 Thu, 18 Jan 2024 07:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590440; x=1706195240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sIGwAEv7tWfbm8LJIqYCxKyeigVfLO6vfUaQ1pCq2VE=;
 b=dxbV8vuZ69yKfw+PhxzXv83CFi+5pb0fwwAA2QghU1BBEb8xNNCXul55hzxc4AfUPv
 sqkVssP5jeO3Ge7BG5d99V+mogD7FAW76IpTEEqEO3yj3rTY2PK8harpD4mLjU0mb2g6
 gqxDh4P6eisx4I8J73g3ErYBSCxk8Vy21XPUk4eIeD4lJEJ9tEUT0lBmhXr2Qmv3SZfu
 zoxrRRKk+S6qwGcHBrrgDpzMNs7HgKdxOjgiSby+hALop+2PRbbK+Gg/8v7dFkyohs9a
 WAHJmtyOweU7KU4gXdciaeIYtpVG/NBr3AAackVeNSw+86OGoRRvSxMcwjo+EP32ZQw6
 Zz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590440; x=1706195240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sIGwAEv7tWfbm8LJIqYCxKyeigVfLO6vfUaQ1pCq2VE=;
 b=BffnFzynO+3cl83lo8cOnIDedY/JvKkisgrFrDpGNJsJX6NWG/eg76hJ893+AwJlIQ
 s9Au8Rn0kxThe8by5mlRsN3zCfkDG2PBMzj3xdOCNVdU1H/iFpIKCtLZCdadqJNf3L9J
 B1tqJjgsfuNzKPbDDYUXNHq00hjM9loIQTI+BKbKAAQM74RqDqPZ1Plviz5yuU0cNLDd
 pzvD4OQ5M50SKhKwce+n3vR9OvBzy92EkxveMAracOcDwfAgmtys4mxV9aR2GqB8O7rH
 W5KzBPsZBn/yvaHrAq+fcPIVipa2D30xLKQuniyY6a7ndCyXNsKpUjBcCfjVipWDly1v
 9Tgw==
X-Gm-Message-State: AOJu0Yw4L/fBxwdLciEQHaDYIe3ZsGSgFBdUFogCPbPFT0945E3lXqZn
 c9+G1VFnapXQfIJuW6xcYiUSO3iQyCOokt4ry4fmnxedQ2Ky3KBmQV7A9Qwi
X-Google-Smtp-Source: AGHT+IFJEnn1mDY0ZWn0LZSvbDv6+HFP33sAdSEMkRbjbkrXfWJg9vgzofqeqh8q5oRnoqTpDaJpbg==
X-Received: by 2002:a17:903:2807:b0:1d5:e8ef:bc5a with SMTP id
 kp7-20020a170903280700b001d5e8efbc5amr750382plb.117.1705590440043; 
 Thu, 18 Jan 2024 07:07:20 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:07:19 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Subject: [PATCH 05/26] target/ppc: Update gdbstub to read SPR's CFAR, DEC, HDEC,
 TB-L/U
Date: Fri, 19 Jan 2024 01:06:23 +1000
Message-ID: <20240118150644.177371-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>

SPR's CFAR, DEC, HDEC, TB-L/U are not implemented as part of CPUPPCState.
Hence, gdbstub is not able to access them using (CPUPPCState *)env->spr[] array.
Update gdb_get_spr_reg() method to handle these SPR's specifically.

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/gdbstub.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index ec5731e5d6..dfe31d0f47 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -394,7 +394,32 @@ static int gdb_get_spr_reg(CPUPPCState *env, GByteArray *buf, int n)
     }
 
     len = TARGET_LONG_SIZE;
-    gdb_get_regl(buf, env->spr[reg]);
+
+    /* Handle those SPRs that are not part of the env->spr[] array */
+    target_ulong val;
+    switch (reg) {
+#if defined(TARGET_PPC64)
+    case SPR_CFAR:
+        val = env->cfar;
+        break;
+#endif
+    case SPR_HDEC:
+        val = cpu_ppc_load_hdecr(env);
+        break;
+    case SPR_TBL:
+        val = cpu_ppc_load_tbl(env);
+        break;
+    case SPR_TBU:
+        val = cpu_ppc_load_tbu(env);
+        break;
+    case SPR_DECR:
+        val = cpu_ppc_load_decr(env);
+        break;
+    default:
+        val = env->spr[reg];
+    }
+    gdb_get_regl(buf, val);
+
     ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, len), len);
     return len;
 }
@@ -411,7 +436,18 @@ static int gdb_set_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
 
     len = TARGET_LONG_SIZE;
     ppc_maybe_bswap_register(env, mem_buf, len);
-    env->spr[reg] = ldn_p(mem_buf, len);
+
+    /* Handle those SPRs that are not part of the env->spr[] array */
+    target_ulong val = ldn_p(mem_buf, len);
+    switch (reg) {
+#if defined(TARGET_PPC64)
+    case SPR_CFAR:
+        env->cfar = val;
+        break;
+#endif
+    default:
+        env->spr[reg] = val;
+    }
 
     return len;
 }
-- 
2.42.0


