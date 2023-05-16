Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4683F70480A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 10:41:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyqES-0008Cj-AZ; Tue, 16 May 2023 04:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1pyqEP-0008CM-T3
 for qemu-devel@nongnu.org; Tue, 16 May 2023 04:40:29 -0400
Received: from esa16.hc2706-39.iphmx.com ([216.71.140.205])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1pyqEG-0006ta-2v
 for qemu-devel@nongnu.org; Tue, 16 May 2023 04:40:28 -0400
X-IronPort-RemoteIP: 209.85.222.198
X-IronPort-MID: 277439399
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:0awAza4i1l42NsqBww+BhQxRtIbFchMFZxGqfqrLsTDasY5as4F+v
 jcXWTjXa/6IZWT9fI90YY++8EwFsJ+HmtQ2GVFpqXxnEysa+MHIO4+lIxarNUt+DCFioGGLT
 Sk6QoOdRCzhZiaE/n9BCpC48T8nk/nOHuGmYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbyRFuspvlDs15K6p4G5B4ARnDRx2lAS2e0c9Xcp3yZ6ZciOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNy+uTnuUiG9Y+DCDX4pZkc/HKbitq/0Te5p0G2M80Mi+7vdkoc+dZk
 72hvbToIesg0zaldO41CnG0GAknVUFKFSOuzdFSfqV/wmWfG0YAzcmCA2kuYIc887ZYMVhX1
 tYZLg0KZSiIq+KPlefTpulE3qzPLeHuNYIb/2hjlHTXVKd2B5/ERKrO6JlT2zJYasJmR66PI
 ZpEL2A1NlKZMk0n1lQ/UfrSmM+hgmn5fydwok/TqKYqi4TW5FYuj+S2YYGEK7RmQ+1kuB7Do
 EiW4ljcOTcCZdqU9QO4/22V07qncSTTHdh6+KeD3udnhUDWymENBRk+U1y9rv+kzEmkVLpix
 1c8/yMvqe0r9xXuQICsD1u3p3mLuhNaUN1VewEn1DywJmPvy17xLgA5ovRpMrTKaOdeqeQW6
 2K0
IronPort-HdrOrdr: A9a23:+0mhVa8y+0aLg8pRnnRuk+DlI+orL9Y04lQ7vn2YcXduA6mlfq
 GV7ZcmPHrP41wssR4b9OxoR5PwJ080maQY3WBzB9eftWvd1ldARbsKhbcKqAeAJ8SRzIFgPY
 AKSdkdNDXKZmIK6foT2WKDYrEdKdC8gdmVuds=
X-Talos-CUID: =?us-ascii?q?9a23=3A4fCUHmi9E9b8yD1VlPs3mpPH6DJuaiDX6H6ADH+?=
 =?us-ascii?q?BEEVDSbuoTlSo849kqp87?=
X-Talos-MUID: 9a23:v7hBFwrdvAw248AatNgezwBEbJxuyfSzNGU2t41XvcK4DBF9JA7I2Q==
Received: from mail-qk1-f198.google.com ([209.85.222.198])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 May 2023 04:40:10 -0400
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7595c946411so171963785a.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 01:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1684226409; x=1686818409;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j2+mHMqAKKVm4KyyAEahzJ6RrZ5CZz48MfX4/78iWLg=;
 b=FGAmFUaEt8rs+XSZPNIY0bZADnf+fwNqAki5+MiAs8EXFzvyhjWw8EiCNjJHSJKv1c
 qyNh4O0SQbD0osHNvX/0CEF9sI43SU7c0V/zh7Lvf58PtIajAxACofLjDGIZA3OCzEoY
 cYz0P1i4GnhsLxh6CyfBGV3jR3SG1Jj0y5aPVsNkVm8L3j6g4ypFvXBU40yZrkoE2Ks3
 32EivsebfP1CA8cqIjbDC9TonjRqpgSAmSMNqZhrYUAKZTD6uF/S1mT9Ne0EFGOEfu4j
 3Z/NrtXD90hBnmI7ld/wXch/3nmWi41JlGEM1mCSU1EAluEi5NRH01QHCohs6e2xwG9n
 3zDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684226409; x=1686818409;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j2+mHMqAKKVm4KyyAEahzJ6RrZ5CZz48MfX4/78iWLg=;
 b=JHdEggaoDr++NQmXjocAZAM7jYsLlKkJJ/ZRktu9fu6moVay+BVHDpMhhBhyXM+96p
 ukMKlb7AHIgCzNKQSZryLai2dr2STXfytRWA/8A7GGVlF8F0g0kmmVSyFAw4StugvcMd
 x4iqFD5nKRGRI1kd50L058aI1/DMk+650mCSGDynXGkfJylgIO+BY0s/yeV87HUD/rwD
 bkVAP9zne5P/v4EiN7gCOR6EQaDW/XhbbK7PVMMq/wthqBp8wYCHJkkLyjxd7cFy63Ba
 OAYT8VRkUsCKliWc72bd5SHMdw5jX584qUp6mMhwU1I3LRcCAn0pHlsIPC/F8E3kSWOP
 Eucg==
X-Gm-Message-State: AC+VfDzz3mk0x/+tV56vguZzXOrrRClu6p53vct4qPh0e52qKTr10Shv
 xZM784F/T9y5Aq9J2M2qlcDFiFZgCpCPJpUQQOylhvvtTOLjcoZm46+KUXaQjugPzPyhSWLXhDP
 d/OdFOgWmHwJl49R98rygyowQ/DB4KdrDdCJwENsn
X-Received: by 2002:ad4:5be9:0:b0:621:68e8:999f with SMTP id
 k9-20020ad45be9000000b0062168e8999fmr28364632qvc.33.1684226409486; 
 Tue, 16 May 2023 01:40:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/DjKieXIpYEcufTArJSlQWfuCNYgUViZgVasxUJUlZ2S3FICBZgrkJ0QKwYYOBOcG+HU1Cw==
X-Received: by 2002:ad4:5be9:0:b0:621:68e8:999f with SMTP id
 k9-20020ad45be9000000b0062168e8999fmr28364617qvc.33.1684226409222; 
 Tue, 16 May 2023 01:40:09 -0700 (PDT)
Received: from mozz.bu.edu (mozz.bu.edu. [128.197.127.33])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a0cf851000000b0061b7784b3basm5025852qvo.84.2023.05.16.01.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 01:40:08 -0700 (PDT)
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Cc: mcascell@redhat.com, Alexander Bulekov <alxndr@bu.edu>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] memory: stricter checks prior to unsetting engaged_in_io
Date: Tue, 16 May 2023 04:40:02 -0400
Message-Id: <20230516084002.3813836-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.140.205; envelope-from=alxndr@bu.edu;
 helo=esa16.hc2706-39.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

engaged_in_io could be unset by an MR with re-entrancy checks disabled.
Ensure that only MRs that can set the engaged_in_io flag can unset it.

Closes: https://gitlab.com/qemu-project/qemu/-/issues/1563
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 softmmu/memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/softmmu/memory.c b/softmmu/memory.c
index b7b3386e9d..26424f1d78 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -534,6 +534,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
     unsigned access_size;
     unsigned i;
     MemTxResult r = MEMTX_OK;
+    bool reentrancy_guard_applied = false;
 
     if (!access_size_min) {
         access_size_min = 1;
@@ -552,6 +553,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
             return MEMTX_ACCESS_ERROR;
         }
         mr->dev->mem_reentrancy_guard.engaged_in_io = true;
+        reentrancy_guard_applied = true;
     }
 
     /* FIXME: support unaligned access? */
@@ -568,7 +570,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
                         access_mask, attrs);
         }
     }
-    if (mr->dev) {
+    if (mr->dev && reentrancy_guard_applied) {
         mr->dev->mem_reentrancy_guard.engaged_in_io = false;
     }
     return r;
-- 
2.39.0


