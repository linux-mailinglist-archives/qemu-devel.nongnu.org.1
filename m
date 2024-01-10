Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9B8829580
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 09:59:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUPT-0001MA-4Z; Wed, 10 Jan 2024 03:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPR-0001M1-B5
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:01 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPP-0003PO-LQ
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:01 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6dad22e13dcso2417122b3a.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877078; x=1705481878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+U00ZGgCHJATuNomrsfmDArmAS9Tt1PWtFo9Hlr5LU=;
 b=ZeBt3utTd4gN4GydctpkpwsUqXRUHSUw6UKC3IbrBRI30j4+n3MC8HIxwy5a3rAVux
 BDlMkKWWpsaQzVKItjl+dtT3Gpx/zqhLGLlutDlXdY23z73/yeU2zN/iVIiVAcNpX5sS
 XrvhIDSbVOdDj90ncURkzsjnCmEgGcP4BiWSVR5zTMftpmUXv6rR3SHGpiXHPfFyVKIp
 s7Pn5JqxWMRJ9IWtuMgrmGQDQ1tZRv07i5CITWn0Q/n/TftGk+yRFlIBQTNLnmhLjyNV
 BloeCh2+SKiQk9CB7qYF9cnOcGtvJks00gECRar946mB+ograEQ+jGTHGE8ndUp64QEo
 Lgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877078; x=1705481878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/+U00ZGgCHJATuNomrsfmDArmAS9Tt1PWtFo9Hlr5LU=;
 b=EiiIS4zpB6f7eKHuJ78zieNff+0mh2OhQ/DLmulfDfeBbGEFTVvDyQynsXyF0rGo6S
 L8ZszecKJu0Acs4I8xsD3vqjbAVaAa8SSokFxmES9zaQxlTW5vcXFr2hqBJlJFoTwu7e
 e492U4jrVDDMBkT9a/O2j3j2ZMMB7+c82uEqvHMWGasY6EufOaMNPdSgLxd1YM338Vm9
 tPmPoKerZZTcMxAGHVDcvwVpnpYdIWaQf9cGpuMkRMKUS8eqVccM/OZ6BROZ0fxWRXeV
 gCKmScV/WdbQhZDPb4ASQXcz/WCI+zp2QGCwRQIW0o5H50OKwebuG5aWu6Zvn838ddrm
 1CJw==
X-Gm-Message-State: AOJu0YwDDTZUgYL0Nzi//zADriJTHCeJKtzryuyG1EHuJe6QidQ08uYx
 si7cncY87ubHQBHLuLSAQ5v2957fKkz1wwkB
X-Google-Smtp-Source: AGHT+IG8y8rAF2Lfs5W5AXHXY7tKm9DyV1VORfif/3WDtHIUvAOT1NoQjvCWtuyMd0lx8BMeeLMEtw==
X-Received: by 2002:a05:6a00:3d0b:b0:6d9:ac04:ceea with SMTP id
 lo11-20020a056a003d0b00b006d9ac04ceeamr624827pfb.64.1704877077678; 
 Wed, 10 Jan 2024 00:57:57 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:57:57 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/65] target/riscv: Not allow write mstatus_vs without RVV
Date: Wed, 10 Jan 2024 18:56:32 +1000
Message-ID: <20240110085733.1607526-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

If CPU does not implement the Vector extension, it usually means
mstatus vs hardwire to zero. So we should not allow write a
non-zero value to this field.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231215023313.1708-1-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c50a33397c..d8f751a0ae 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1328,11 +1328,14 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
     mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
         MSTATUS_SPP | MSTATUS_MPRV | MSTATUS_SUM |
         MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
-        MSTATUS_TW | MSTATUS_VS;
+        MSTATUS_TW;
 
     if (riscv_has_ext(env, RVF)) {
         mask |= MSTATUS_FS;
     }
+    if (riscv_has_ext(env, RVV)) {
+        mask |= MSTATUS_VS;
+    }
 
     if (xl != MXL_RV32 || env->debugger) {
         if (riscv_has_ext(env, RVH)) {
-- 
2.43.0


