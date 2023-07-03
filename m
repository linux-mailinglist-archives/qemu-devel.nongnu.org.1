Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54522745EA5
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 16:40:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGKhh-0007ga-14; Mon, 03 Jul 2023 10:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b876096c6217fa393e0eb3040d024afcaf1e6dff@lizzy.crudebyte.com>)
 id 1qGKha-0007gH-FM
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:38:55 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b876096c6217fa393e0eb3040d024afcaf1e6dff@lizzy.crudebyte.com>)
 id 1qGKhV-0004cr-JZ
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=IVU3u9REbMi2Jvfo1usH993VuZXU4Q8CUAX2QtxpABQ=; b=eMkAh
 /YnLi+UsCsq38uMjsqU/sPzYtLNsyUHqsh4V0AUiGC4h2MdoH++RNs6ulp4sAkyGEb/e1UF6t9DVi
 TlinF1wUHuhn5eypXknGdgwWZNenuNHxdVsYusPk+KermQPbO/ebMxXKGNa7dMWCxsF5HoErhJAbD
 tm+ZC21q/rQ5Egh0yT2Y/SRQ+i1k75HNERi7giSRM9wyvfGxBYtMpdqkXwfOaABO8RfZSg1PRnHuV
 r6vFn/1nbkaqVs5b5zpdf25HnUV/P4+nvOg+bH9Fmu919you/uWUKnA0m3BnHVL0pWuynM20W3fL6
 K70S0XNOSY5ngnl+ufN9M2cwPqmQg==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 3 Jul 2023 16:34:17 +0200
Subject: [PATCH] MAINTAINERS: raise status of 9p to 'Maintained'
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Message-Id: <E1qGKgV-0003Hj-01@lizzy.crudebyte.com>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=b876096c6217fa393e0eb3040d024afcaf1e6dff@lizzy.crudebyte.com;
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
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e8a3205eb4..71f2479ec5 100644
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


