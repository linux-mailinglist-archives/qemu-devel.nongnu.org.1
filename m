Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C70CD74D134
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:16:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qImyt-0000Yo-VN; Mon, 10 Jul 2023 05:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qImyq-0000YP-LP
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qImyo-0004GQ-TL
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688980489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hPJsOI+zzCv1eQCb9a0zktfrzYp6J0mbt8xyGov7Pd8=;
 b=VOHwU6utjXMU0zkmzdDjLHH6BwpEe0XV/GJUu8CaYDU6ic1FPeqSVVLIQ5u8xPQ9qcimxW
 xeQF84m9qk9KI3J2DeMYbig8ihlxLbGkV36vlU9Ll/GVOvTVUTbgqbCEqKxuzeg+GFlkZ9
 LaxVxa7efVQfelM4AwdW0aDn50b1DiQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-paDuHiIIN4KFYDmI8ChubA-1; Mon, 10 Jul 2023 05:14:47 -0400
X-MC-Unique: paDuHiIIN4KFYDmI8ChubA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55960858EED;
 Mon, 10 Jul 2023 09:14:47 +0000 (UTC)
Received: from kostyanf14nb.redhat.com (unknown [10.45.225.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A4BB200B402;
 Mon, 10 Jul 2023 09:14:45 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v5 0/4] QGA VSS Logging
Date: Mon, 10 Jul 2023 12:14:35 +0300
Message-Id: <20230710091439.1010553-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

v5 -> v4:
  Fix commit name according to function rename
  Fix function code style
  Remove extra \n from log
  Add missing log

v4: https://patchew.org/QEMU/20230710074639.996030-1-kkostiuk@redhat.com/

v4 -> v3:
  Use _countof instead of hardcoded array size
  Use fputs instead of fprintf without formating

v3: https://patchew.org/QEMU/20230707092258.768420-1-kkostiuk@redhat.com/

v3 -> v2:
  Reformat few log lines
  Move G_GNUC_PRINTF attribute to the declaration

v2: https://patchew.org/QEMU/20230707083105.746811-1-kkostiuk@redhat.com/

v2 -> v1:
  Rename debug macro
  Move log code to function

v1: https://patchew.org/QEMU/20230705141205.525776-1-kkostiuk@redhat.com/


Konstantin Kostiuk (4):
  QGA VSS: Add wrapper to send log to debugger and stderr
  QGA VSS: Replace 'fprintf(stderr' with qga_debug
  QGA VSS: Print error in err_set
  QGA VSS: Add log in functions begin/end

 qga/vss-win32/install.cpp   | 47 +++++++++++++++++++++++++++++-----
 qga/vss-win32/meson.build   |  2 +-
 qga/vss-win32/provider.cpp  |  3 +++
 qga/vss-win32/requester.cpp | 51 ++++++++++++++++++++++++++++++++-----
 qga/vss-win32/vss-debug.cpp | 39 ++++++++++++++++++++++++++++
 qga/vss-win32/vss-debug.h   | 25 ++++++++++++++++++
 6 files changed, 153 insertions(+), 14 deletions(-)
 create mode 100644 qga/vss-win32/vss-debug.cpp
 create mode 100644 qga/vss-win32/vss-debug.h

--
2.34.1


