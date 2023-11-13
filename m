Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEFD7E9AB4
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 12:08:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2UnS-0006SK-Nw; Mon, 13 Nov 2023 06:08:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2UnR-0006QW-3V
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:08:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2UnP-0001IS-KL
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699873678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mmrUoHF8gDfPo53/iEkVqM837wljFIpEgPPUhue9WXs=;
 b=E+MQvgDN8RrRkcBY8UHdSeaw1PcAJ8tFpnWiS49dhsUEptHzCR+92/3+gU5wZqaSYqYpwB
 RS2OLmk4UMpzkOC4+bL2d+SeB5DIoUOuAQ4yBkpqZF/KGzbgSUQq0cHn9ZIrJS0UQ0qxTz
 70Go4jZa2iasHka/MPsSFDKfqvSvdj8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-k_FyX96jPLW_sVTezcermw-1; Mon,
 13 Nov 2023 06:07:55 -0500
X-MC-Unique: k_FyX96jPLW_sVTezcermw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52B423C0BE26;
 Mon, 13 Nov 2023 11:07:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0961E2166B26;
 Mon, 13 Nov 2023 11:07:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/12] tests/vm/netbsd: Use Python v3.11
Date: Mon, 13 Nov 2023 12:07:37 +0100
Message-ID: <20231113110740.38270-10-thuth@redhat.com>
In-Reply-To: <20231113110740.38270-1-thuth@redhat.com>
References: <20231113110740.38270-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We requiere the 'ninja-build', which depends on 'python311':

  $ pkgin show-deps ninja-build
  direct dependencies for ninja-build-1.11.1nb1
          python311>=3.11.0

So we end up installing both Python v3.10 and v3.11:

  [31/76] installing python311-3.11.5...
  [54/76] installing python310-3.10.13...
  [74/76] installing py310-expat-3.10.13nb1...

Then the build system picks Python v3.11, and doesn't find
py-expat because we only installed the 3.10 version:

  python determined to be '/usr/pkg/bin/python3.11'
  python version: Python 3.11.5

  *** Ouch! ***

  Python's pyexpat module is not found.
  It's normally part of the Python standard library, maybe your distribution packages it separately?
  Either install pyexpat, or alleviate the need for it in the first place by installing pip and setuptools for '/usr/pkg/bin/python3.11'.

  (Hint: NetBSD's pkgsrc debundles this to e.g. 'py310-expat'.)

  ERROR: python venv creation failed

Fix by installing py-expat for v3.11. Remove the v3.10
packages since we aren't using them anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231109150900.91186-1-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/vm/netbsd | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 40b27a3469..649fcad353 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -30,8 +30,8 @@ class NetBSDVM(basevm.BaseVM):
         "git-base",
         "pkgconf",
         "xz",
-        "python310",
-        "py310-expat",
+        "python311",
+        "py311-expat",
         "ninja-build",
 
         # gnu tools
-- 
2.41.0


