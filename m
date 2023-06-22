Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF967739D77
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:35:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCGhx-0000mj-NG; Thu, 22 Jun 2023 05:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCGhw-0000mN-EV; Thu, 22 Jun 2023 05:34:28 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCGhv-0003Qm-0Y; Thu, 22 Jun 2023 05:34:28 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-666ecf9a081so5143734b3a.2; 
 Thu, 22 Jun 2023 02:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687426465; x=1690018465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kWccjYSUgbzH7iFLpghJHKGPLA8F7swC2dsX7bfHZ54=;
 b=rDtYOTbno9xDsTG69Nb4AiFnRFuOnz+Kjv+Us4bz0rH+shVIY7JXJo/AHwriYZkh4p
 PsDKqLTTyBkOT5sM27phnRGoZdgFEMxsl1OhsetRK+8FleosHPkDxeOOZmc547M6mnu/
 v9EMjC458DLE3UJFhzxsJi/+vo2/qhr0z5Or5mE/HUXswt1qG9OVMUsyT+Deei2Q91wp
 58pM4ylFoFafv4Z5aqSpQGFFN0pxdBE02o4RpL+ADjUYhxliG2M/YIjUlvlLPaLIMZ+6
 46d6/ut/D/bhOHIsKrest78ILbUngWnK6JRJc2sYKGBR3lgD4Ftut7mP3NGDT6u9LoUw
 +PWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687426465; x=1690018465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kWccjYSUgbzH7iFLpghJHKGPLA8F7swC2dsX7bfHZ54=;
 b=FexkPQf7mu44QxSYsdKDYMGXnpDzuCbO9MFZ78L3nCOnZtf6JFMa8gWTxJtBfHCzIX
 bPp+Bmjg1KN6iB4hSeXP6PIN77VmOZkhQMkgbVV5dx6Vq+bVUqPbefXhn0+HQgyuZeoF
 zRNK9Nx6kt+FeDg2AwDmQ/SEnldYsBgOJzLHSuy+4EFfzxo3Wj005XLqgaceCsOUjKFf
 eWmdgAcC80s0CJe9UYsUaTa7/CVtZ7Vo3vG0INvuSsL9b90pRL5h/ITTlKt88+wPq+qc
 s7oMJ2puVesxcOSsvrvCnkeyNCp3/zPBR2/PDIitYM1Sel3+DS+xPrDve+rQd2d1Uw4p
 H4qw==
X-Gm-Message-State: AC+VfDzLbL7n2ktqI3RSNcQ5BThdKOpHwnnJBziLmPL4LUGLpE+fkHDj
 jq8KvHZM1hYM/hVQpD/CYb1Q8e3/7Ho=
X-Google-Smtp-Source: ACHHUZ45cLqe8Ypcb1fQZfceYD2PtJ980w4Gy23Ud1TdNmcnL6bGRsWw6tsCXIJwQRZThAz3wgh+Ig==
X-Received: by 2002:a05:6a20:244e:b0:123:6ab3:7af1 with SMTP id
 t14-20020a056a20244e00b001236ab37af1mr3817978pzc.6.1687426464880; 
 Thu, 22 Jun 2023 02:34:24 -0700 (PDT)
Received: from wheely.local0.net (193-116-203-37.tpgi.com.au. [193.116.203.37])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a1709027c0300b001ac2c3e54adsm4925662pll.118.2023.06.22.02.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 02:34:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/7] hw/ppc/spapr: Test whether TCG is enabled with
 tcg_enabled()
Date: Thu, 22 Jun 2023 19:33:54 +1000
Message-Id: <20230622093357.255649-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622093357.255649-1-npiggin@gmail.com>
References: <20230622093357.255649-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Although the PPC target only supports the TCG and KVM
accelerators, QEMU supports more. We can not assume that
'!kvm == tcg', so test for the correct accelerator. This
also eases code review, because here we don't care about
KVM, we really want to test for TCG.

Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[np: Fix changelog typo noticed by Zoltan]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e55905a1f0..8e7d497f25 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2525,7 +2525,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
     int ret;
     unsigned int smp_threads = ms->smp.threads;
 
-    if (!kvm_enabled() && (smp_threads > 1)) {
+    if (tcg_enabled() && (smp_threads > 1)) {
         error_setg(errp, "TCG cannot support more than 1 thread/core "
                    "on a pseries machine");
         return;
-- 
2.40.1


