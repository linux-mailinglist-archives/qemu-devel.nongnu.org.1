Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F437DE1E5
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 15:08:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyBsw-0008Jc-Ga; Wed, 01 Nov 2023 10:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qyBsi-0008AA-6s
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:07:42 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qyBsV-00059H-5c
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:07:36 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc131e52f1so7909155ad.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 07:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1698847525; x=1699452325;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TzzPa37+vveYYM4giPSatH9IvOY1pw04HIwine/8Tgg=;
 b=DcxsFIGkKwWLVtnXtr0ExrYFxNtbKWCYFXxh528UNLMmaoj2IS02q0YoiiMOs7vXCn
 euImTpIcG7ypTHhmFRrDdYM9UYvFbqfmVZEeaKENa2ol2JHkTx5h2cxE815oZ/jLZ8vI
 eTQncKym0yjgSeOgrZ5KD+CKmH8LkoBY9DDYYa91jjqqlGo/IesUl7mh9CBW7RId41sK
 7TMcC511S8EPR6TQzA6+2pBV8QZ6n6SYZPv0He22L7IEYZ7w/pX4VPZ0Eds5xrArKyHi
 GhJ+8gpozx9ztDJhngv9HHwf74ZEMn6/GZsgEfnEzCeYBMu3B8Do/NWoECYKPOiJ7eX1
 Y/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698847525; x=1699452325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TzzPa37+vveYYM4giPSatH9IvOY1pw04HIwine/8Tgg=;
 b=qRMcg2MBvQUV1es/5Y/Ny0j7SN1yL0mudO2VS4FmM3rTbd4VuF++TbrW+TVJtGBafl
 czS9CqTl4QOEcwuIvmuRBreUkWELKz0zDzS58NmhMuqnhRV7f4fgCrqixqEvUjRS3iOR
 d/17ViWxrH3cm1o9e1R2kEztt3D1dytFeXVrXvsfTw+d31TTKiHvGJlNlB2GOBIbCfrD
 M4xVaCRoW1W2YcbMvE4BDm+VenccxP/UFUnnHILJd1rNjrsVKVT5/IAzEt2mNS27V2lk
 2Pon805HO7z9rj2FjLQnRopJUWX2TCTO94zKu7GCikM+Ne1a5AkHQ13Vd7hZRNQ6HKjQ
 RYXQ==
X-Gm-Message-State: AOJu0YwkTqt9vvDBdF4IQuA1RKLi7u1pRWbokX1sa77q2f6w+iPhkvac
 ftSJaRUDcAszTF5hmNyQ9Evc1FoxqVqFuhgKHC6SpBhe
X-Google-Smtp-Source: AGHT+IEdYl6ope62G/udRkSb4hOmWZxm3IV7o+btlktPj+Xlgl7RAOO8e4PrwkKHhtphfLyVapgbBA==
X-Received: by 2002:a17:903:228a:b0:1cc:3004:750c with SMTP id
 b10-20020a170903228a00b001cc3004750cmr3507375plh.20.1698847525070; 
 Wed, 01 Nov 2023 07:05:25 -0700 (PDT)
Received: from localhost.localdomain ([125.71.94.114])
 by smtp.gmail.com with ESMTPSA id
 jn7-20020a170903050700b001cc32261bdcsm1396118plb.248.2023.11.01.07.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 07:05:24 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v3 6/6] docs/migration: Add the dirty limit section
Date: Wed,  1 Nov 2023 22:04:09 +0800
Message-Id: <0f2b2c63fec22ea23e4926cdeb567b7a0ebd8152.1698847223.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1698847223.git.yong.huang@smartx.com>
References: <cover.1698847223.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The dirty limit feature has been introduced since the 8.1
QEMU release but has not reflected in the document, add a
section for that.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <36194a8a23d937392bf13d9fff8e898030c827a3.1697815117.git.yong.huang@smartx.com>
---
 docs/devel/migration.rst | 71 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index be913630c3..12c35f9bc4 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -590,6 +590,77 @@ path.
      Return path  - opened by main thread, written by main thread AND postcopy
      thread (protected by rp_mutex)
 
+Dirty limit
+=====================
+The dirty limit, short for dirty page rate upper limit, is a new capability
+introduced in the 8.1 QEMU release that uses a new algorithm based on the KVM
+dirty ring to throttle down the guest during live migration.
+
+The algorithm framework is as follows:
+
+::
+
+  ------------------------------------------------------------------------------
+  main   --------------> throttle thread ------------> PREPARE(1) <--------
+  thread  \                                                |              |
+           \                                               |              |
+            \                                              V              |
+             -\                                        CALCULATE(2)       |
+               \                                           |              |
+                \                                          |              |
+                 \                                         V              |
+                  \                                    SET PENALTY(3) -----
+                   -\                                      |
+                     \                                     |
+                      \                                    V
+                       -> virtual CPU thread -------> ACCEPT PENALTY(4)
+  ------------------------------------------------------------------------------
+
+When the qmp command qmp_set_vcpu_dirty_limit is called for the first time,
+the QEMU main thread starts the throttle thread. The throttle thread, once
+launched, executes the loop, which consists of three steps:
+
+  - PREPARE (1)
+
+     The entire work of PREPARE (1) is preparation for the second stage,
+     CALCULATE(2), as the name implies. It involves preparing the dirty
+     page rate value and the corresponding upper limit of the VM:
+     The dirty page rate is calculated via the KVM dirty ring mechanism,
+     which tells QEMU how many dirty pages a virtual CPU has had since the
+     last KVM_EXIT_DIRTY_RING_FULL exception; The dirty page rate upper
+     limit is specified by caller, therefore fetch it directly.
+
+  - CALCULATE (2)
+
+     Calculate a suitable sleep period for each virtual CPU, which will be
+     used to determine the penalty for the target virtual CPU. The
+     computation must be done carefully in order to reduce the dirty page
+     rate progressively down to the upper limit without oscillation. To
+     achieve this, two strategies are provided: the first is to add or
+     subtract sleep time based on the ratio of the current dirty page rate
+     to the limit, which is used when the current dirty page rate is far
+     from the limit; the second is to add or subtract a fixed time when
+     the current dirty page rate is close to the limit.
+
+  - SET PENALTY (3)
+
+     Set the sleep time for each virtual CPU that should be penalized based
+     on the results of the calculation supplied by step CALCULATE (2).
+
+After completing the three above stages, the throttle thread loops back
+to step PREPARE (1) until the dirty limit is reached.
+
+On the other hand, each virtual CPU thread reads the sleep duration and
+sleeps in the path of the KVM_EXIT_DIRTY_RING_FULL exception handler, that
+is ACCEPT PENALTY (4). Virtual CPUs tied with writing processes will
+obviously exit to the path and get penalized, whereas virtual CPUs involved
+with read processes will not.
+
+In summary, thanks to the KVM dirty ring technology, the dirty limit
+algorithm will restrict virtual CPUs as needed to keep their dirty page
+rate inside the limit. This leads to more steady reading performance during
+live migration and can aid in improving large guest responsiveness.
+
 Postcopy
 ========
 
-- 
2.39.1


