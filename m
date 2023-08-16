Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE66577E874
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:16:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWL2h-0002Mq-0S; Wed, 16 Aug 2023 14:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWL2f-0002Lf-6U
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:14:49 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWL2c-0003hD-OE
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:14:48 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bc3d94d40fso57609275ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209685; x=1692814485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VvfERpWnA//CSNMU9sCRk6rxPVpfXMYFa3j/mN7uLKY=;
 b=WWZaKad3FFfnbwyNKiYhKhMfZGQAYvFctIXGdCwHD3xlu0HgdAzcQhgKNmq3uDaEPb
 3PS6ctymeobik/f07N/HaeLork4P42RZxABUVHZfWo35m/XVVAbjVjxpRSxpv1W2K4Kq
 1FAiqJDW/ldaUtw0atnuCnPoZwJZAfuG3ltzPgzCAjdIttavH4NmmvlA3ayQWmqXfMhH
 W71/0UdzPNtJxq4PLYSGXTEEDRn75g2kN/WpKnsrhBxcx8WLI2cL9yON5XYfnw74+5xj
 oB9jD7nq3Bkn5NuNKko3vEhAA61MncsN4U0oec7Xap3fM7mE/ya88jGHax5x20t1J6jX
 w66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209685; x=1692814485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VvfERpWnA//CSNMU9sCRk6rxPVpfXMYFa3j/mN7uLKY=;
 b=dJxqIwHh0iHt4dfGwr5/2BUmfXffsVSAv1y6cNIW7Ae0kyDWL2ZWz/tF6qHVA6WHyc
 myuEVgEUO69VG0Jm6eJ4nRuMMpatnfvxFG5oTA2JKLef1GN7biO42A+TSPw//f8von5y
 /b+/h1ab/6R+b0NbFK/DYgdPeM38WDULAMjIvC3AQm6L5swZCExAHD72hTgO4rep7lGA
 FP2wq0dPBw/F9UstlY4kUrBb3lzISZ+6rSL0T4qDsjFP68eqzLw1ReL40ejjpy/tNMB9
 qyEw7WLSsWf+D6+I84GTgBny1YrYrxSI1EQ/5BvXYJHFI+CdBBtClAqhGNpSeTHWJ1jT
 5I9g==
X-Gm-Message-State: AOJu0Yw6YH8bSXpkgVRlQWbgJN+06654gW+AgMWBSUeF2WjLlwjZRmSF
 E9zYym/iE6vypWVZM8oabulOG6ID0xrYUN74fPk=
X-Google-Smtp-Source: AGHT+IE/PQm4CrCAeGk9MM//2pEWIBxGM2VolCzhBrDje1s2NO2P9ssfpnqlO9ETpgloOGg5L/esZQ==
X-Received: by 2002:a17:902:7789:b0:1bc:2d43:c747 with SMTP id
 o9-20020a170902778900b001bc2d43c747mr2707972pll.38.1692209685202; 
 Wed, 16 Aug 2023 11:14:45 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a170902868e00b001b9dab0397bsm13423563plo.29.2023.08.16.11.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:14:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	deller@gmx.de
Subject: [PATCH 6/6] linux-user: Show vdso address in /proc/pid/maps
Date: Wed, 16 Aug 2023 11:14:37 -0700
Message-Id: <20230816181437.572997-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816181437.572997-1-richard.henderson@linaro.org>
References: <20230816181437.572997-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h    | 1 +
 linux-user/elfload.c | 1 +
 linux-user/syscall.c | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 12f638336a..4de9ec783f 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -32,6 +32,7 @@ struct image_info {
         abi_ulong       brk;
         abi_ulong       start_stack;
         abi_ulong       stack_limit;
+        abi_ulong       vdso;
         abi_ulong       entry;
         abi_ulong       code_offset;
         abi_ulong       data_offset;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a670a7817a..12285eae82 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3726,6 +3726,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
     const VdsoImageInfo *vdso = vdso_image_info();
     if (vdso) {
         load_elf_vdso(&vdso_info, vdso);
+        info->vdso = vdso_info.load_bias;
     } else if (TARGET_ARCH_HAS_SIGTRAMP_PAGE) {
         abi_long tramp_page = target_mmap(0, TARGET_PAGE_SIZE,
                                           PROT_READ | PROT_WRITE,
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5c0fb20e19..c85cf6ffb9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8127,6 +8127,8 @@ static void open_self_maps_4(const struct open_self_maps_data *d,
         path = "[stack]";
     } else if (start == info->brk) {
         path = "[heap]";
+    } else if (start == info->vdso) {
+        path = "[vdso]";
     }
 
     /* Except null device (MAP_ANON), adjust offset for this fragment. */
-- 
2.34.1


