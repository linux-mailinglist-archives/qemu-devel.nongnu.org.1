Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE277A1136
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 00:43:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgv2R-0000b3-SW; Thu, 14 Sep 2023 18:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3RowDZQcKCpsFJHGJ8DBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--komlodi.bounces.google.com>)
 id 1qgv2Q-0000am-0X
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 18:42:18 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3RowDZQcKCpsFJHGJ8DBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--komlodi.bounces.google.com>)
 id 1qgv2O-0006In-KB
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 18:42:17 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-d77fa2e7771so1814129276.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 15:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1694731335; x=1695336135; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=u6DWZwyrNMCTZjUs5xi9vI8KxT+j7urhO0P6zkh1kzA=;
 b=jB+ljRY8XfMiDV9+q1R1Ggq27ndVpDkJEIR+VvsacMyDK6G0li6qbJ7feHlqHCFEta
 FQ20OwmkUhEoRdr03cSar7ZYeXC1Df5KjJUDlcQuiCEOVpOQQfMJfAIl5+4qPCyhx2pU
 5WtDUoDAOYoI8t8RSTkT2wDgIK0qUE0VQohQpjWZUK35YQ6JvSN+aK0x/1lGcdvLHnb+
 h9v5tNfTvi+ikBabsHgBWvaH88D8tV8q0idtZwEjH0htvu+Sw4md9EuTiXO9FKltBOvv
 lNdPsctLoYZNRkHT+irZD1d83PP7fKmIkOkAMMQlxaTWGSfZ7vm+5agG+VUyaR+AStAJ
 7hXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694731335; x=1695336135;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u6DWZwyrNMCTZjUs5xi9vI8KxT+j7urhO0P6zkh1kzA=;
 b=DofQv6GVYtjK4Qdn3LSgsrKsPGln8lrOwmW1Tmgh0ttGV9Cvpi4pg5xrc4bS5m19UX
 uK4lsc275DjBiWISaJjJzN9cOIKvKz31sxbsbVkJcILxQcG4jgg8pBhYMIsy+QS/sGPp
 YqN/hlxgIjcyYqCSKcPyoVlVDx7vkWQ8tZMe0jGW/QgmcFmDcq4ovTCazlXAw6LGm0R0
 Dma8VXBXCvG16zO6KMudQJI0/c6PtjZdQixkHcs613Y1XUL5UQJcTm+N8ITq6KOEAiVh
 aEJiPtX4ZZSZn+mPiAv6Di6gS7Y2XQH/s8GJqNVzuehG24TWR/8CzNhd7vzWumICQrdE
 CbyA==
X-Gm-Message-State: AOJu0YzZnk3QTEblSPzNBENkJ0DncGE98SmaCT8PSCarCE8DLgavHTjI
 WGtwkLCQS+zAwIN0zQnKucMv0oR/0UmzVuHY+F8026hJafBVep2RHvy+F7bR6vepYgMcXNALCzf
 43DlwISUkoX5GaNI2gibkPoP+NhhMHkVfh+tDAJKzoHkJfphj4Z5/G7H5vVfRoCI=
X-Google-Smtp-Source: AGHT+IGANvGpiVCXJ9zz1trgUrKtQR+TUcjDNlu8e6miHgmtbETk3ebIYgdhtgTo5JLua1VcWPyE+wPTU5U+
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a5b:92:0:b0:d81:58d3:cc71 with SMTP id
 b18-20020a5b0092000000b00d8158d3cc71mr154170ybp.13.1694731334790; Thu, 14 Sep
 2023 15:42:14 -0700 (PDT)
Date: Thu, 14 Sep 2023 22:42:09 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230914224211.2184828-1-komlodi@google.com>
Subject: [PATCH 0/1] hw/arm/sse-timer: Add CNTFRQ reset property
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: komlodi@google.com, qemu-arm@nongnu.org, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3RowDZQcKCpsFJHGJ8DBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--komlodi.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi all,

This patch just adds an object property to initialize the reset value of
CNTFRQ.
We noticed that Linux would complain that CNTFRQ would have a mismatch
compared to an expected value, and this was because TF-A was assuming
that CNTFRQ was initialized to a different value out of reset.

Since it's valid for CNTFRQ to have a non-zero reset value, we just
added an object property so people can set it.

Thanks!
Joe

Joe Komlodi (1):
  hw/timer/sse-timer: Add CNTFRQ reset property

 hw/timer/sse-timer.c         | 4 +++-
 include/hw/timer/sse-timer.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.42.0.459.ge4e396fd5e-goog


