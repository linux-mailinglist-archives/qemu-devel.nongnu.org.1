Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E975E7CC1ED
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 13:40:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsiQC-0003WQ-4R; Tue, 17 Oct 2023 07:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qsiQ9-0003Jh-Ep
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:39:33 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qsiQ7-00017r-Lj
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:39:33 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-57b635e3fd9so2819345eaf.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 04:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1697542650; x=1698147450;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hMAM8qdrYGuxqIHYEejog6OmMQG8IBlM1A/6y2FwqWc=;
 b=blx3E0i4rS3LPGJ/fbKGjIbzcQE76g7slGd3z9BBptFvaK+8JXOZnh/sdmT8/kJXIE
 8apP+9G/aBMWb6T9Wo3xFp8ohBJMhc8PjCniOYrUSfjzZhQHweeKZb/FM/Ho/edLe/8N
 Ad3bWsuj+mGj6A0srwQuu8TVk/M8iPmJFuI74281PUA7cD8orK3Wa9/WEhHWI6uq6uPK
 vvTJhD7yGYOux3VUX1ccSaZ5SBlax75aCcfh+vDB5zWYWrVkhJsaItF+dAQGJ4eM1gF3
 d5pZq6KQWN6ozU6sJT3Yu+DO9zpZHkCOh62WtfxOgOXrD684FZt4QsD00ivsAMpn3EsN
 ECZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697542650; x=1698147450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hMAM8qdrYGuxqIHYEejog6OmMQG8IBlM1A/6y2FwqWc=;
 b=PEoOeeh628Z05eCj9llVvOETqGrV6XvmziTtBSSIhZLdC2XjEj2QrrQD22BEhfJvl6
 ZvtGFvNCr57R45lYuPSk0lk/mQ4nl5qdVBNE5Tr4wj3Qi+X8JQfl7T2ZhsC3IR/aQdhx
 0k8enKrKgljZqcXLgUUm2+cxFEZ/U4Ym8kC3hbfQ3UIDpraITNMR0nQG0LV4uq8pJECi
 P2bsGdDAqv7NZKEscPjeCG3l4r3O+t8GCiYdDZ4uHa6wZ4jPrf/GJdGuPoZo6rLqp8I7
 ZM5ftb7bNd8JMqiU1uJKKNabrE1UG0cZGxqSA/q+G+oikTEcvUQ1XNOO6o0EmvpbX7kJ
 cipA==
X-Gm-Message-State: AOJu0YwsjUjj+4BQcxpRY20c33wQYGWR3MdFAoSD/Sz8qewj25ek4qo2
 qONdmttNQGqO/oM3ERFOTMtAHRd66TWm2AQk1xMc6bUF
X-Google-Smtp-Source: AGHT+IG0rxsOPnwJDL8anPIOAFahNe8Iz1nw4Kw5oViC8kSaGRJzTLiLMROjiIA+p4eRlP84/tV/rA==
X-Received: by 2002:a05:6358:1e:b0:143:e3a:de5f with SMTP id
 30-20020a056358001e00b001430e3ade5fmr1767956rww.26.1697542650040; 
 Tue, 17 Oct 2023 04:37:30 -0700 (PDT)
Received: from localhost.localdomain ([171.216.79.181])
 by smtp.gmail.com with ESMTPSA id
 x28-20020aa79a5c000000b00692c5b1a731sm1198647pfj.186.2023.10.17.04.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 04:37:29 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH 6/6] docs/migration: Add the dirty limit section
Date: Tue, 17 Oct 2023 19:36:09 +0800
Message-Id: <59985366f38053caac40c14d86b2a50bead944f6.1697502089.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1697502089.git.yong.huang@smartx.com>
References: <cover.1697502089.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc2e.google.com
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
index c3e1400c0c..1cbec22e2a 100644
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
+     The entire work of PREPARE (1) is prepared for the second stage,
+     CALCULATE(2), as the name implies. It involves preparing the dirty
+     page rate value and the corresponding upper limit of the VM:
+     The dirty page rate is calculated via the KVM dirty ring mechanism,
+     which tells QEMU how many dirty pages a virtual CPU has had since the
+     last KVM_EXIT_DIRTY_RING_RULL exception; The dirty page rate upper
+     limit is specified by caller, therefore fetch it directly.
+
+  - CALCULATE (2)
+
+     Calculate a suitable sleep period for each virtual CPU, which will be
+     used to determine the penalty for the target virtual CPU. The
+     computation must be done carefully in order to reduce the dirty page
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
+sleeps in the path of the KVM_EXIT_DIRTY_RING_RULL exception handler, that
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


