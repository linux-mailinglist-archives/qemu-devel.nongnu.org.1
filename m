Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 061127A5BC9
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 09:58:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiVc5-0002gO-4B; Tue, 19 Sep 2023 03:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1qiVc0-0002g3-DM
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 03:57:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1qiVby-0002Fz-R7
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 03:57:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0E2391FDBE;
 Tue, 19 Sep 2023 07:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695110253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=nf0avUnGSC5BcZUmOBAJmr8/Eh+83mVxJG5jY2CK/5w=;
 b=EKzoLDtLnd3445faygbVDIpmhBq8ID8bh2SyIOhrUcIfEjXA1/2lvBO3VS9hdl3dJE+qPE
 /Xu4wpjH1G93OLTpU63K9b8k4OK6yKlTehsp4Dp6QiNshHRC0wEqYzUewQjt/FbFAkewZi
 QNm34FoK/l1YZ2HVfnPy3twJhTSJJaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695110253;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=nf0avUnGSC5BcZUmOBAJmr8/Eh+83mVxJG5jY2CK/5w=;
 b=/PTtOP/CZlYFAGA7wSJBbmWz0oU5UR70mJi+ow5bzm6UqSHdvDNez7Jql681yV9ANJzyE3
 wrF34DUrdFLZPlAA==
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by relay2.suse.de (Postfix) with ESMTP id 84CB72C142;
 Tue, 19 Sep 2023 07:57:32 +0000 (UTC)
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 872DA4AAC2C; Tue, 19 Sep 2023 09:57:32 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: qemu-devel@nongnu.org
Subject: [PATCH] riscv: Call set_satp_mode_max_supported in riscv_host_cpu_init
CC: Alexandre Ghiti <alexghiti@rivosinc.com>, Andrew Jones
 <ajones@ventanamicro.com>, Bin Meng <bmeng@tinylab.org>, Frank Chang
 <frank.chang@sifive.com>, Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@rivosinc.com>
X-Yow: Is this TERMINAL fun?
Date: Tue, 19 Sep 2023 09:57:32 +0200
Message-ID: <mvm34zavbmb.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=schwab@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When running in KVM mode with -cpu host, cfg.satp_mode.supported is not
initialized, causing an infinite loop in riscv_cpu_satp_mode_finalize.

Fixes: 6df3747a27 ("riscv: Introduce satp mode hw capabilities")
Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f227c7664e..bb8dc3bb40 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -623,8 +623,10 @@ static void riscv_host_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
 #if defined(TARGET_RISCV32)
     set_misa(env, MXL_RV32, 0);
+    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
 #elif defined(TARGET_RISCV64)
     set_misa(env, MXL_RV64, 0);
+    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
 #endif
     riscv_cpu_add_user_properties(obj);
 }
-- 
2.42.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

