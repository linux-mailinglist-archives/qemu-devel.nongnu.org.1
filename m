Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C4E713AB4
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 18:50:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3Jag-0000ZA-O1; Sun, 28 May 2023 12:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3Jad-0000Yp-RM; Sun, 28 May 2023 12:49:55 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3JaZ-0003bl-6w; Sun, 28 May 2023 12:49:55 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-557c7ffea48so902372eaf.1; 
 Sun, 28 May 2023 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685292589; x=1687884589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pzN1GHaGp5LFGpm9e56JgC+WWPnZBV+2t51s4e6Bl1Q=;
 b=okkJ0wLWcr9f/aLPcoQXlIf4ij2Edr3nHfHo8znz/ZM1yPvw4erpxjsTVydr/XAWF+
 EHYgXM7tfvh6MrN20CPUEiulFXaiaWud0yOn24S8rJFKCSJCtbQnf2ihwXzGYX9qcSoD
 6JtpU92srHgfFnz76gmEnob9nRH2Zn40bIPkQZpwKW3ZBd8dn60BTYHw0nYPGOnDUhtB
 G06IYAIb8Ss5eCETIKrD6LPpky8g8FwOKMYkGQIOQdMfX5SphW55vxOxZSofqbJgMcq6
 tsP7mdo3+ao3nVhPfdVoKL2002C6OgEuGdN2JklJ6cp94zCojAO2P7c2g/Z8W5cN1nEw
 f9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685292589; x=1687884589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pzN1GHaGp5LFGpm9e56JgC+WWPnZBV+2t51s4e6Bl1Q=;
 b=JK0VdI9MG3VOLIsmtbBXj/f6PWMIky/AA6bUgFNDVXojd9tuYDJVf9/p63yoIdVO6c
 n3W52UNOV4djsrjYapN80/BnzU+/jOsIQG1Esiu8vs/5iYkPEeIEypSc2Vh7NHDDYfM6
 +1XqyEpBXhXQPaNCVV+Mx3qinj0mwLxgLcNLBETck4dXQlk1ySzV0tn4fwkHIwzlvQ0v
 Bh0xL4LYxRPGpirpzFZpr3b/WnxNQsVlz54b5WHeiExRC7K+hCDSLWxPwE+260h7MvlA
 on4kdpB40LKjjkjfH/7P9dfDk6vSlULkP25WP3GxkAxsRkx6Zv6rfBJ6s/VdlbSSWQly
 NV2w==
X-Gm-Message-State: AC+VfDzwAlzzE+ct6MIV4YZh7Ph9geBSJJzGRqab7HBmCs6o991ZtcoC
 5lOzLSUFdgDmFGIXrES6/Hn1I+ht//k=
X-Google-Smtp-Source: ACHHUZ5Fvv14SAC7GsknZmrh71JwIDKFMuB0QIoHCov7qq+SgTzY00Qdx8OCxZBo8tQkGC6YMFd03g==
X-Received: by 2002:a4a:4146:0:b0:547:4f15:6147 with SMTP id
 x67-20020a4a4146000000b005474f156147mr2177894ooa.0.1685292589406; 
 Sun, 28 May 2023 09:49:49 -0700 (PDT)
Received: from grind.. (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 w4-20020a4adec4000000b0054f85f67f31sm3378830oou.46.2023.05.28.09.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 May 2023 09:49:49 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 06/10] target/ppc: Use SMT4 small core chip type in POWER9/10
 PVRs
Date: Sun, 28 May 2023 13:49:18 -0300
Message-Id: <20230528164922.20364-7-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528164922.20364-1-danielhb413@gmail.com>
References: <20230528164922.20364-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc2c.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

QEMU's PVR value for POWER9 DD2.0 has chip type 1, which is the SMT4
"small core" type that OpenPOWER processors use. QEMU's PVR for all
other POWER9/10 have chip type 0, which "enterprise" systems use.

The difference does not really matter to QEMU (because it does not care
about SMT mode in the target), but for consistency all PVRs should use
the same chip type. We'll go with the SMT4 OpenPOWER type.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20230515160131.394562-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/cpu-models.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index 1326493a9a..a77e036b3a 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -348,11 +348,11 @@ enum {
     CPU_POWERPC_POWER8NVL_BASE     = 0x004C0000,
     CPU_POWERPC_POWER8NVL_v10      = 0x004C0100,
     CPU_POWERPC_POWER9_BASE        = 0x004E0000,
-    CPU_POWERPC_POWER9_DD1         = 0x004E0100,
+    CPU_POWERPC_POWER9_DD1         = 0x004E1100,
     CPU_POWERPC_POWER9_DD20        = 0x004E1200,
     CPU_POWERPC_POWER10_BASE       = 0x00800000,
-    CPU_POWERPC_POWER10_DD1        = 0x00800100,
-    CPU_POWERPC_POWER10_DD20       = 0x00800200,
+    CPU_POWERPC_POWER10_DD1        = 0x00801100,
+    CPU_POWERPC_POWER10_DD20       = 0x00801200,
     CPU_POWERPC_970_v22            = 0x00390202,
     CPU_POWERPC_970FX_v10          = 0x00391100,
     CPU_POWERPC_970FX_v20          = 0x003C0200,
-- 
2.40.1


