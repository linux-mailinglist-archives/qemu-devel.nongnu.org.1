Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A4AA1B69B
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Jan 2025 14:04:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJLZ-0000Uv-73; Fri, 24 Jan 2025 08:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tbJL4-0000Pr-6O
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:03:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tbJL2-0007Gt-IZ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:03:09 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 496B45C5A69;
 Fri, 24 Jan 2025 13:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5E7C4CEE0;
 Fri, 24 Jan 2025 13:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737723785;
 bh=Ovgym6COY+4COyqSeNlwwKYtZTk/Tq2Ej2TcJmZIyic=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A7PxC7LfDSa/F4FQbgHFx28DZamDkbymKY6YrTpCTCLD2kyO8iOjrnx7T+gebtY1y
 1iZTbohzTslYsIWUsXvLiRj87j9L8mUSCXToOdsKG48Mdz9KXG10pZ31BEiWEUkfYR
 ORTD698Tt8Oem+6ZjPC2z0AxOBMihfD/NYg2NFbsiULjSQWaA58dhWCWx/sY+8ipZZ
 jxRUTm8tvbrAVFCM2S7jYKrnyy8XanJbnb/YTdHD67SjBMrXvYOyjCIluQE8RGuhug
 u+z8+q3hPBXxPxHltrWsGF2N5RQZFuZOwIbwFEoC8k0aJmIWcND+zErovZYz1F4QaC
 N1WAmr1D6x+Pw==
From: deller@kernel.org
To: Laurent Vivier <laurent@vivier.eu>, Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PULL v3 4/6] linux-user: netlink: Add emulation of IP_MULTICAST_IF
Date: Fri, 24 Jan 2025 14:02:52 +0100
Message-ID: <20250124130254.3134-5-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250124130254.3134-1-deller@kernel.org>
References: <20250124130254.3134-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Helge Deller <deller@gmx.de>

Add IP_MULTICAST_IF and share the code with IP_ADD_MEMBERSHIP / IP_DROP_MEMBERSHIP.
Sharing the code makes sense, because the manpage of ip(7) says:

IP_MULTICAST_IF (since Linux 1.2)
      Set the local device for a multicast socket.  The argument
      for setsockopt(2) is an ip_mreqn or (since Linux 3.5)
      ip_mreq structure similar to IP_ADD_MEMBERSHIP, or an
      in_addr structure.  (The kernel determines which structure
      is being passed based on the size passed in optlen.)  For
      getsockopt(2), the argument is an in_addr structure.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index df8609b4d8..6ee02383da 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2130,16 +2130,23 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
             }
             ret = get_errno(setsockopt(sockfd, level, optname, &val, sizeof(val)));
             break;
+        case IP_MULTICAST_IF:
         case IP_ADD_MEMBERSHIP:
         case IP_DROP_MEMBERSHIP:
         {
             struct ip_mreqn ip_mreq;
             struct target_ip_mreqn *target_smreqn;
+            int min_size;
 
             QEMU_BUILD_BUG_ON(sizeof(struct ip_mreq) !=
                               sizeof(struct target_ip_mreq));
 
-            if (optlen < sizeof (struct target_ip_mreq) ||
+            if (optname == IP_MULTICAST_IF) {
+                min_size = sizeof(struct in_addr);
+            } else {
+                min_size = sizeof(struct target_ip_mreq);
+            }
+            if (optlen < min_size ||
                 optlen > sizeof (struct target_ip_mreqn)) {
                 return -TARGET_EINVAL;
             }
@@ -2149,13 +2156,14 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
                 return -TARGET_EFAULT;
             }
             ip_mreq.imr_multiaddr.s_addr = target_smreqn->imr_multiaddr.s_addr;
-            ip_mreq.imr_address.s_addr = target_smreqn->imr_address.s_addr;
-            if (optlen == sizeof(struct target_ip_mreqn)) {
-                ip_mreq.imr_ifindex = tswapal(target_smreqn->imr_ifindex);
-                optlen = sizeof(struct ip_mreqn);
+            if (optlen >= sizeof(struct target_ip_mreq)) {
+                ip_mreq.imr_address.s_addr = target_smreqn->imr_address.s_addr;
+                if (optlen >= sizeof(struct target_ip_mreqn)) {
+                    __put_user(target_smreqn->imr_ifindex, &ip_mreq.imr_ifindex);
+                    optlen = sizeof(struct ip_mreqn);
+                }
             }
             unlock_user(target_smreqn, optval_addr, 0);
-
             ret = get_errno(setsockopt(sockfd, level, optname, &ip_mreq, optlen));
             break;
         }
-- 
2.47.0


