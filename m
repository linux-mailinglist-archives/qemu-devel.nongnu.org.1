Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B14A474ACEE
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 10:32:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHgs5-0008R6-0w; Fri, 07 Jul 2023 04:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHgrz-0008Qh-Rc
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHgrx-0003kK-F7
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688718670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GrfOG/ga+xDAeHS/3qxFQoXKrZeoCgwxwQ9NhgCmk98=;
 b=NTwVYKLNxRoN/VnQs8HBFNcDHZ2P/qqII5i7HM4qxMZNicHU+1K4dtZYfRbKXlsoe2718P
 0uLHgBQopM0MGjQY2jJQjuhtSyyPjr7HQ4I84FwwRugKtwrGJYqh3lXVwqtbdSfeM4YE/l
 /KEJPcgB7Vs9u/gXjJnjfmMHHgC2ryE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-yLBT2nIGN4mq-s45kVyZSQ-1; Fri, 07 Jul 2023 04:31:09 -0400
X-MC-Unique: yLBT2nIGN4mq-s45kVyZSQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00ECA88D125;
 Fri,  7 Jul 2023 08:31:09 +0000 (UTC)
Received: from kostyanf14nb.redhat.com (unknown [10.45.225.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4D671121330;
 Fri,  7 Jul 2023 08:31:07 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/4] QGA VSS Logging
Date: Fri,  7 Jul 2023 11:31:01 +0300
Message-Id: <20230707083105.746811-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Print all VSS error and trace to debugger and stderr.

Konstantin Kostiuk (4):
  QGA VSS: Add wrapper to send log to debugger and stderr
  QGA VSS: Replace 'fprintf(stderr' with PRINT_DEBUG
  QGA VSS: Print error in err_set
  QGA VSS: Add log in functions begin/end

 qga/vss-win32/install.cpp   | 46 ++++++++++++++++++++++++++++-----
 qga/vss-win32/meson.build   |  2 +-
 qga/vss-win32/provider.cpp  |  3 +++
 qga/vss-win32/requester.cpp | 51 ++++++++++++++++++++++++++++++++-----
 qga/vss-win32/vss-debug.cpp | 31 ++++++++++++++++++++++
 qga/vss-win32/vss-debug.h   | 24 +++++++++++++++++
 6 files changed, 143 insertions(+), 14 deletions(-)
 create mode 100644 qga/vss-win32/vss-debug.cpp
 create mode 100644 qga/vss-win32/vss-debug.h

--
2.34.1


