Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ED173F44E
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 08:14:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE1xz-00040g-4p; Tue, 27 Jun 2023 02:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qE1xx-0003zs-Cd
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 02:14:17 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qE1xv-0006EO-Of
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 02:14:17 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1b8063aa2e1so10452735ad.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 23:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687846454; x=1690438454;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=My9xR9TJf/wrEvGFuHlji2XBr5+DNfgJE/H3ERC3Bzc=;
 b=kVZz6cJqcaYr6YwswEqQjyQFoY0uP1Ne/mieixAWAlsvHMUi/zq4HqtspSNm0z8BJT
 aL9E9S2wTrE6LlH8qLrV4oRpzY9O3ZTSk9w9yRdACtQ9JwsghxnAj4KzwicGA0SzS0nN
 dgkzjivOijXAW80zUzjdYBzq820A3gBPzHHFvp5rqxwMfj4MNBiWCOwQZ0Y3QDgcyIQ0
 +oSx9tq6NSYP5oZleznOjTXM6YhHszgtC40hLJBj4IORDk3JSm8dadpHlqZ1QHCbe4LI
 x03KSQSOJL1XvZy2MawHt85HGACowCgEeTQUW8v+KK8WBNx+sE3xy/p+ujUS8uFsielb
 TTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687846454; x=1690438454;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=My9xR9TJf/wrEvGFuHlji2XBr5+DNfgJE/H3ERC3Bzc=;
 b=XTnsX9sl0MfK70FIWTp++Ft2XFq0S/DSNAG03hS8FM2oFz2ejsBchTKQhjpYCnf+5B
 iAsiMCmRUg9Cl9VQYxmbMptGb6Mu/cFwCHkZkvaOQC2fcxkL4GBysq9qzOe/KKjLICxz
 SA6CdLK6GScx/zklLT9ziNYZ/b/8d+jM1aX5CRf0cRqdGANxPH2gnLIViNchtgKKe8dX
 p+7+Sxo5iC+pbmcBmpELjh8UOirrWc6apkIaXoURMCRQREp6abAlPBRUtOK/Z3jhG7Fj
 DJjp6yMlsW/jGc6nQsgVZwb3y0q6gJM6LFFe/zIUqKUeRd7q7ltqB4s69QWMScSsD4oM
 NiPQ==
X-Gm-Message-State: AC+VfDyRsvXm7Q+j4vIjXqhAlwpFF5DlUxIpa25hPtR+zXkuoIlLoxnQ
 +9DWZs+N1BXucoPZAZlPKlc=
X-Google-Smtp-Source: ACHHUZ6ToNfHpnuxje1sIHpKRut2fFf1qY+VP1W9EH9sePNzqReGNFJlgpzkCxKgMGW76D1PAtJIgw==
X-Received: by 2002:a17:902:d503:b0:1b8:1243:a4af with SMTP id
 b3-20020a170902d50300b001b81243a4afmr2561586plg.21.1687846453637; 
 Mon, 26 Jun 2023 23:14:13 -0700 (PDT)
Received: from wheely.local0.net (193-116-109-121.tpgi.com.au.
 [193.116.109.121]) by smtp.gmail.com with ESMTPSA id
 i2-20020a17090332c200b001b55f00bb9dsm5122182plr.256.2023.06.26.23.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 23:14:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] icount: don't adjust virtual time backwards after warp
Date: Tue, 27 Jun 2023 16:14:06 +1000
Message-Id: <20230627061406.241847-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

The icount-based QEMU_CLOCK_VIRTUAL runs ahead of the RT clock at times.
When warping, it is possible it is still ahead at the end of the warp,
which causes icount adaptive mode to adjust it backward. This can result
in the machine observing time going backwards.

Prevent this by clamping adaptive adjustment to 0 at minimum.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 softmmu/icount.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/softmmu/icount.c b/softmmu/icount.c
index 4504433e16..486ea7ef41 100644
--- a/softmmu/icount.c
+++ b/softmmu/icount.c
@@ -259,11 +259,16 @@ static void icount_warp_rt(void)
         warp_delta = clock - timers_state.vm_clock_warp_start;
         if (icount_enabled() == 2) {
             /*
-             * In adaptive mode, do not let QEMU_CLOCK_VIRTUAL run too
-             * far ahead of real time.
+             * In adaptive mode, do not let QEMU_CLOCK_VIRTUAL run too far
+             * ahead of real time (it might already be ahead so careful not
+             * to go backwards).
              */
             int64_t cur_icount = icount_get_locked();
             int64_t delta = clock - cur_icount;
+
+            if (delta < 0) {
+                delta = 0;
+            }
             warp_delta = MIN(warp_delta, delta);
         }
         qatomic_set_i64(&timers_state.qemu_icount_bias,
-- 
2.40.1


