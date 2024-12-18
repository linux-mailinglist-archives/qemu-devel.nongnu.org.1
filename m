Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 626769F6E96
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Dec 2024 20:54:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO06V-0005g4-5i; Wed, 18 Dec 2024 14:53:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tO06T-0005fd-K1
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:53:05 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tO06S-0001br-6D
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:53:05 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 6FDC3A40AD1;
 Wed, 18 Dec 2024 19:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7820AC4CED7;
 Wed, 18 Dec 2024 19:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734551575;
 bh=Z3ILH7yeOybgi1/CJ1rwkFp19U43yvxFnde7k2lHHz8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=da5Zo39mGj/C/sKjJPyJ5TTCXqIiZSvtKgrafsfClXHA/Z9f28uHYF3hejqIjnvry
 mqes00R8w/1g62uni82N4pDbonqZpZcRNIcqUFV6cUSRiYN6CS2x36hTIiGpGKKkpq
 2/dgcUsOWQ4itcnxcqu6em8aRAukYF8fV8BD78cuOSzcAh6lih8IPNfM4UIoRSFk3i
 fXuoNo/bmwBnHtiHcPtti17ljjV/rcD++NOydkh4RBARTZaYmVPbmcs2H6wZIqAtrq
 +CgYExB9bsWpa4O59XQDE/3nPIEvb4e07J5BRp8Nbt9tOUKVZuFcLfnRKegvD1VOp4
 9Ta0WGX0B/HeQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: deller@gmx.de
Subject: [PULL 3/6] linux-user: netlink: Add IP_PKTINFO cmsg parsing
Date: Wed, 18 Dec 2024 20:52:44 +0100
Message-ID: <20241218195247.5459-4-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241218195247.5459-1-deller@kernel.org>
References: <20241218195247.5459-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Helge Deller <deller@gmx.de>

Fixes those warnings:
 Unsupported host ancillary data: 0/8

Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 494323efba..bbe2560927 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1996,6 +1996,18 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
                     (void *) &errh->offender, sizeof(errh->offender));
                 break;
             }
+            case IP_PKTINFO:
+            {
+                struct in_pktinfo *pkti = data;
+                struct in_pktinfo *target_pkti = target_data;
+
+                __put_user(pkti->ipi_ifindex, &target_pkti->ipi_ifindex);
+                host_to_target_sockaddr((unsigned long) &target_pkti->ipi_spec_dst,
+                    (void *) &pkti->ipi_spec_dst, sizeof(pkti->ipi_spec_dst));
+                host_to_target_sockaddr((unsigned long) &target_pkti->ipi_addr,
+                    (void *) &pkti->ipi_addr, sizeof(pkti->ipi_addr));
+                break;
+            }
             default:
                 goto unimplemented;
             }
-- 
2.47.0


