Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B620F7498EB
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:02:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHLoa-0006be-Lb; Thu, 06 Jul 2023 06:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3548fa01511b4d8d19d4b187d3989b7033b733d8@lizzy.crudebyte.com>)
 id 1qHLoY-0006bE-Fe
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:02:18 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3548fa01511b4d8d19d4b187d3989b7033b733d8@lizzy.crudebyte.com>)
 id 1qHLoW-0007mw-Vp
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:References:In-Reply-To:Message-Id:Content-ID:
 Content-Description; bh=mu4TLuPO23MeoA2Jh9N2UjgcbozLpVaiaXwvphKuMXI=; b=kmVcd
 Q+cNMxynyUhh3O9Tq/K8cVxE4nvg/lVi4VomBGQt10J/vgNYbCqRudAregnkUDenwxRL5wqIDJgZY
 Z/h0KPqSQwtXm/9/zHdkifQgw5haB2JitC0h+3Y/0HzB3fol6LouBa44KPXo6Topqk90CR0rmXV/O
 9EPrqILVeW/EP/SAgMg5nxRW69Zww/Dps71G03cIlgtZs4cbZopAcM72r4wBApP4r3o6HOzeGq6WH
 au0I8em8yxlb+Gmm65t3q6xM2fp5HyRDA8JkeVhKud/ZFPsR4yNzK1CuU/ujW8mC5tw3Hp8uraheO
 4HZTGKruQBvVqJ5W9S7ENFJV7aJNQ==;
Message-Id: <3548fa01511b4d8d19d4b187d3989b7033b733d8.1688637466.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1688637466.git.qemu_oss@crudebyte.com>
References: <cover.1688637466.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 06 Jul 2023 11:57:47 +0200
Subject: [PULL 2/2] MAINTAINERS: raise status of 9p to 'Maintained'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
    Philippe Mathieu-Daudé <philmd@linaro.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=3548fa01511b4d8d19d4b187d3989b7033b733d8@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Change status of 9p from 'Odd Fixes' to 'Maintained', as this better
reflects current situation. I already take care of 9p patches for a
while, which included new features as well.

Based-on: <E1qDkmw-0007M1-8f@lizzy.crudebyte.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <E1qGKgV-0003Hj-01@lizzy.crudebyte.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 80934ad2c3..d422ce50e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2120,7 +2120,7 @@ F: include/sysemu/balloon.h
 virtio-9p
 M: Greg Kurz <groug@kaod.org>
 M: Christian Schoenebeck <qemu_oss@crudebyte.com>
-S: Odd Fixes
+S: Maintained
 W: https://wiki.qemu.org/Documentation/9p
 F: hw/9pfs/
 X: hw/9pfs/xen-9p*
-- 
2.30.2


