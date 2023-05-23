Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A662B70D1C0
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:49:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I17-0003Xg-LW; Mon, 22 May 2023 22:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0n-0003EF-Ke
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:39 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0m-00048Y-8W
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:33 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-51f6461af24so4617381a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809871; x=1687401871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/o6tO6nnGhFzf3Sfn2qxcpID+VyiZYYCYj5UcWk+7nM=;
 b=ilt2bJs1zXrTVKGM+AwKVuydLvE2wwnPzj6SDfmbPgO7vUR8/wtJK222KPG2qZ6QXE
 5f47s9WZuQAMAml43oOywsKHcxaz+Y1oV1G3II4h0TgYnsenQn/dujPkXGyYX2v6uVgD
 Ol7JV4wyAaOl1QtG3jtBxEvlFHMm2IQv4aXhdghWSuoYKgiU0z7tS+8tHQ5LX48BtHWZ
 gyxdd23NT1n/lVL9ZtQXe6BT2x5wKDKDIgEnfI31PFWcNKzSPkHxOhU+8R5JL4Hq+bUs
 uh5HxVyAz9pkUeS8VHXNYY2AogCmMXXuP5hY2JqGlu8fn6OYkd+ztKZeJkK+cCZnS4c/
 iERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809871; x=1687401871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/o6tO6nnGhFzf3Sfn2qxcpID+VyiZYYCYj5UcWk+7nM=;
 b=T4bG8V/4WsfRxrZ/zJcnK/o4iXc1DZYpb+fjc3zzQgb3LoVKbopzremk/LF3RYna4+
 yFdkKT5EvYjh110FDj13IMpDaHBdyA/Z8MIMkRX5qondSe9eWqcIAXn/xp9L8cwkjFH6
 gkUdJrTNNAm1f78e338ajr6vbr4lGMMS+PCO5HW9tCn00zxzRQgDU27cJDqxLYqNgc8p
 1NIVcTvUTPH4Dvr7huljKxNAAdFsvOlGGWIiHdlhFzlkKbzo5R2LJa4E0ScmyVEMJ0L/
 5CWctyZ/2oAkq2eBNjhC8zPLwMKq1+G+x+H4gVImM0TxqDmoaXUBgsn7Yg/pliLqYk+U
 6fwg==
X-Gm-Message-State: AC+VfDylhAQ/VCaJFzWjItrqK6J8dbyqgBrkZiwwNifbHBEzrC68GZPf
 hFAPOjuE4dfjf0NI+iIMt/ezIQ==
X-Google-Smtp-Source: ACHHUZ6F5F3+Vok66oie8O1b8xLq1MFnkF6QJQNX2RHWDSRurRKulIjbsla3g9xlAZ90PJQmvMBk2w==
X-Received: by 2002:a17:90a:c093:b0:253:9131:4955 with SMTP id
 o19-20020a17090ac09300b0025391314955mr10068240pjs.34.1684809871063; 
 Mon, 22 May 2023 19:44:31 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:44:30 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 11/48] tests/avocado: Remove unused imports
Date: Tue, 23 May 2023 11:43:02 +0900
Message-Id: <20230523024339.50875-12-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/avocado/netdev-ethtool.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/avocado/netdev-ethtool.py b/tests/avocado/netdev-ethtool.py
index f7e9464184..8de118e313 100644
--- a/tests/avocado/netdev-ethtool.py
+++ b/tests/avocado/netdev-ethtool.py
@@ -7,7 +7,6 @@
 
 from avocado import skip
 from avocado_qemu import QemuSystemTest
-from avocado_qemu import exec_command, exec_command_and_wait_for_pattern
 from avocado_qemu import wait_for_console_pattern
 
 class NetDevEthtool(QemuSystemTest):
-- 
2.40.1


