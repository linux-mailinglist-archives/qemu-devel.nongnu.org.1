Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A45587676D7
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 22:18:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPTaE-00032y-CG; Fri, 28 Jul 2023 15:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qPTa8-00032U-VS; Fri, 28 Jul 2023 15:57:01 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qPTa7-0004mO-EN; Fri, 28 Jul 2023 15:57:00 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1bbb8daeefaso1943220fac.2; 
 Fri, 28 Jul 2023 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690574217; x=1691179017;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cK0wTA84D1QgR8qLv8d4Bl7d3/e8HHOpy8GoO7L5fYM=;
 b=fdNO23fFc80aPsYKdfZsYGVO5oC5U5u1dSs9gQbEeQbFp8Qth524JECaVmcPrbMEdi
 FJ6qvDGQi8GjqFqoBCGD6u+o/K17pxPmmthN+YpZSSud8zqi7UzSSVgnFdBR87C54mvt
 jwew6BO7hBCmMWDVsXi3bFaW6X5PnGhqRcfIGBH0HO+BwARcnfEOLHEHoAi3EN3IEnA5
 rPxVxg7gBw/U5EoC7oLmANicfM0MgptE/99L+pPoC/T89zoge0NGf4fGKIP9B9T7bjyu
 YHSB5U4weiraRIe5eJ8883fIcRfQj6iSkwOBrCTilnZfAy+pUP5Rz2cTgPSH8HpGcjkJ
 wlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690574217; x=1691179017;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cK0wTA84D1QgR8qLv8d4Bl7d3/e8HHOpy8GoO7L5fYM=;
 b=DZKg+ZlR715MHFJIsJatr+zatfJYhC1qmqqLHfOXotcto/thnAfwTYdmzwAuWQyBNH
 MW2Ktsb312J9KP/C0Ai46JUrpDb3h19BK9BdgR97BFguY0Ljm1H9DrwYBIjSPlKF1K/d
 7Yp1wz8j9EW86Dsl80jyOIRYbKZGn+lzLtqkEztysgf4VmrT4eK4A0enGJy2LC8VXCNF
 6Hf8UJzEX45K9aX/57VrmyTKW7q9H2RQoi9D3VrRkvKmrV1E4+xgpz06r45XJViJWpd/
 8Llj9P2X+ypxHrHDvrxdiwYtQYxYixkulAykm5boL1CGradJa2sLm93Ss1Ku+v674hRE
 6K6Q==
X-Gm-Message-State: ABy/qLYEB/OELJlax6qRyw2DETBhQhtr0lxtrYXHgfapFvYX6BGr64Xo
 IQgFrMDFrBipLoyt1c1H9b/Fz8hZqHs=
X-Google-Smtp-Source: APBJJlGzzzskGRONZUrxQap8c9GPsRQQ2d3THy2eXKQohFmIi7nzq/XoDvTps9TMLuJUI2gHa6KL7g==
X-Received: by 2002:a05:6870:f695:b0:1b7:60aa:43f1 with SMTP id
 el21-20020a056870f69500b001b760aa43f1mr5111884oab.11.1690574217180; 
 Fri, 28 Jul 2023 12:56:57 -0700 (PDT)
Received: from grind.. (201-69-66-36.dial-up.telesp.net.br. [201.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a056870180600b001b02a3426ddsm2087050oaf.14.2023.07.28.12.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 12:56:56 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-trivial@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH for-8.2 0/2] ppc: get rid of free() (gitlab #1798)
Date: Fri, 28 Jul 2023 16:56:44 -0300
Message-ID: <20230728195646.168997-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x2c.google.com
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

Hello,

Here's some trivial changes following Peter's call to arms against
free() and friends in gitlab issue #1798 in an attempt to enforce
our memory management guidelines [1].

We only have 2 "free()" occurences that needs fixing in the ppc tree.
The hard part is to be dilligent to to not introduce new ones.

Michael, feel free to take it via qemu-trivial.


[1] https://www.qemu.org/docs/master/devel/style.html#low-level-memory-management 

Daniel Henrique Barboza (2):
  hw/ppc: use g_free() in spapr_tce_table_post_load()
  target/ppc: use g_free() in test_opcode_table()

 hw/ppc/spapr_iommu.c   | 2 +-
 target/ppc/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.41.0


