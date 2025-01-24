Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 143B6A1B692
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Jan 2025 14:03:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJLY-0000To-26; Fri, 24 Jan 2025 08:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tbJKz-0000Ox-Mi
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:03:07 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tbJKx-0007GG-5A
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:03:05 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C8CE15C5B68;
 Fri, 24 Jan 2025 13:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6649EC4CED2;
 Fri, 24 Jan 2025 13:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737723781;
 bh=f4X9zMW2UNRK6C5YvFLwtVaulKW3SQq3pLWgREWOxYk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Zcnn+5+mrMMfXf76PztBcaCVPnjvYdMxwwTjI0iHkY+ebE4WQcvAHv2U3tdeRsNuM
 +5S1dMjxNH3Kg7P/1ps0Q9GE0uPtiUvOMAewaeAL7om5ZsHej+bHsdkfCaIGL5Voul
 1B9YQhFsbLZnO828dZq93ilgK4p/i437LBdCxDiHLhWfhkcE6xgQhequcqldXx898E
 +1lBuTBsM45YflB3OhtPssvF3sr5EBFNc+OvSOazAPijqMVcxZ18sBCfNjUfQTDNwG
 GWxVrUFWO4brChFkYyIcKCEN/H0PrsOwbijJWckZmPM6OG9B5qdeA9LKuKNtJAd3e2
 i0Q930x+V7M0Q==
From: deller@kernel.org
To: Laurent Vivier <laurent@vivier.eu>, Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PULL v3 2/6] linux-user: Use unique error messages for cmsg parsing
Date: Fri, 24 Jan 2025 14:02:50 +0100
Message-ID: <20250124130254.3134-3-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250124130254.3134-1-deller@kernel.org>
References: <20250124130254.3134-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Avoid using the same error message for two different code paths
as it complicates determining the one which actually triggered.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 78c7c0b34e..a157abc40c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1827,7 +1827,7 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
                 *dst = tswap32(*dst);
             }
         } else {
-            qemu_log_mask(LOG_UNIMP, "Unsupported ancillary data: %d/%d\n",
+            qemu_log_mask(LOG_UNIMP, "Unsupported target ancillary data: %d/%d\n",
                           cmsg->cmsg_level, cmsg->cmsg_type);
             memcpy(data, target_data, len);
         }
@@ -2049,7 +2049,7 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
 
         default:
         unimplemented:
-            qemu_log_mask(LOG_UNIMP, "Unsupported ancillary data: %d/%d\n",
+            qemu_log_mask(LOG_UNIMP, "Unsupported host ancillary data: %d/%d\n",
                           cmsg->cmsg_level, cmsg->cmsg_type);
             memcpy(target_data, data, MIN(len, tgt_len));
             if (tgt_len > len) {
-- 
2.47.0


