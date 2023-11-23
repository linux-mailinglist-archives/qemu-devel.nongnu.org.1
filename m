Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC9B7F68AB
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 22:30:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6HFR-0005hR-Pz; Thu, 23 Nov 2023 16:28:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1r6H4S-0003Hm-2o; Thu, 23 Nov 2023 16:17:12 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1r6H4P-0000AA-Se; Thu, 23 Nov 2023 16:17:11 -0500
Received: from buffy.. (buffy [192.168.147.6])
 by zoidberg.rfc1149.net (Postfix) with ESMTP id 24BBC80024;
 Thu, 23 Nov 2023 22:17:07 +0100 (CET)
Authentication-Results: zoidberg.rfc1149.net;
 dmarc=fail (p=none dis=none) header.from=rfc1149.net
Authentication-Results: zoidberg.rfc1149.net;
 spf=fail smtp.mailfrom=rfc1149.net
From: Samuel Tardieu <sam@rfc1149.net>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Samuel Tardieu <sam@rfc1149.net>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH] target/hexagon/idef-parser/prepare: use env to invoke bash
Date: Thu, 23 Nov 2023 22:15:06 +0100
Message-ID: <20231123211506.636533-1-sam@rfc1149.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Nov 2023 16:28:31 -0500
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

This file is the only one involved in the compilation process which
still uses the /bin/bash path.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 target/hexagon/idef-parser/prepare | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hexagon/idef-parser/prepare b/target/hexagon/idef-parser/prepare
index 72d6fcbd21..cb3622d4f8 100755
--- a/target/hexagon/idef-parser/prepare
+++ b/target/hexagon/idef-parser/prepare
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 
 #
 #  Copyright(c) 2019-2021 rev.ng Labs Srl. All Rights Reserved.
-- 
2.42.0


