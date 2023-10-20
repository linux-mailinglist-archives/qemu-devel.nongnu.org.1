Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBF37D12A3
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:27:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtrOL-0003UU-80; Fri, 20 Oct 2023 11:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qtrOJ-0003Ra-6X
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:26:23 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qtrOH-0006Bu-Kc
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:26:22 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c9d3a21f7aso7556045ad.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1697815460; x=1698420260;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r3LoJaZtBc7uIbn5BRVxl3tXOWLKI1Lh4C9OuQJm92w=;
 b=poGcqkFmr/Lcjy1Ib9QEk7czk5yScCyBRZHoRj6Xy5Zlxm+VrpNdFdL8+7JxfNXBOa
 63bHNF6i5kk5DuwQbcIUNVX279wIDFUjbra7cu4MbESRm+/DgmXniurJXvXtlBIzae5h
 O970c6i59NEN0IsYy7p/Kr9N16nVBFo4YN9Q11OwzeB2CWy08vmGG2m+D2Reot+yntQp
 SnNkAt5Bf+mjH3IQn2aeq69kxMueDnKgur8yb4oKdmcLD+NJ+sasY1O5ur8w7csXY7F1
 4suxU+6JpXPlNGUwS3YWVj+x1O+3JXD204rVvObrQOcXPcbVM+S5Kkw4QF0OPJsFBht/
 JUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697815460; x=1698420260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r3LoJaZtBc7uIbn5BRVxl3tXOWLKI1Lh4C9OuQJm92w=;
 b=l8SQYuXSJN+tqVGRKSnYdgoHdwwfpFuXkiaIdA0A+qlkJiKvyJRUYE8a3U0OlVEmbw
 xQH93AnW/kJK8Sg0HS7tbVYFw2dj9AjY/rjk4FXW66HW5xMAjkwm2Ur2DWDDtQTY6I6U
 0HuZBfHvifHu/MF1ENecUtxG4R8Lme4oaCH/lTxoVcuWJA+Lgr3buEfTmLTfmuX+Xpj9
 10TPV2m6ZkGWdvzMAbY96pkxS+8pVD98pac5U/QHrgykfIJVlhdar8J/VOqy2q67/zGr
 Cfwsfdc5pO/TayezS9XSOCLw/RyBilkHsaYmg1rxAoLiLYg1Ed5M/feARQlB6XiwWaRS
 pu1g==
X-Gm-Message-State: AOJu0Yy5xp121nEbxjD3x60MZLLeJnI7R4jZBQV9Ri3Xh2pfFmkHyu3Q
 7G//O/LH38Jzkj2RAf6pO3az1+mXge24LZ9t35cuxBJ3
X-Google-Smtp-Source: AGHT+IEuhN7ylgU5q4JOOmGhMQiVI/ybNca1TU7QpNQJG0Qs2Drijy7gZE4AjK7Y0ypAKYPmA/Q0iA==
X-Received: by 2002:a17:902:e551:b0:1c9:d358:b3cd with SMTP id
 n17-20020a170902e55100b001c9d358b3cdmr2469461plf.42.1697815460108; 
 Fri, 20 Oct 2023 08:24:20 -0700 (PDT)
Received: from localhost.localdomain ([171.216.79.181])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170902cec400b001c60d0a6d84sm1644824plg.127.2023.10.20.08.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 08:24:19 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v2 6/6] docs/migration: Add the dirty limit section
Date: Fri, 20 Oct 2023 23:23:48 +0800
Message-Id: <36194a8a23d937392bf13d9fff8e898030c827a3.1697815117.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1697815117.git.yong.huang@smartx.com>
References: <cover.1697815117.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
---
 docs/devel/migration.rst | 71 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index c3e1400c0c..347244af89 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -588,6 +588,77 @@ path.
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


