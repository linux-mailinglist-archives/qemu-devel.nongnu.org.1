Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF3F832C58
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 16:27:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQqkR-0002Oh-NL; Fri, 19 Jan 2024 10:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqkP-0002Ny-0i
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqkM-0001Dh-Gb
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705677930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GGb21HYInozYXJNipOznPib30aAvVfHgn1KFXusDCJU=;
 b=GTCLaTufWEbA3nKqtdACOiCzVVlycOpwqX7QcoHDF/sxArhIvjb/7xuJnOBpjDd7EROZcO
 MJU+ST6UtGd56jZfzyQ3wopMw27dJ7/LFDy/GUZtLue3O6JkrWWywzs/InMtvQ4Git+Mjp
 11qy7yxDA0FpjS/NaKOJcjm1ACPtDMA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-yjWcmwqAMuW7FCBCzeBbmw-1; Fri, 19 Jan 2024 10:25:26 -0500
X-MC-Unique: yjWcmwqAMuW7FCBCzeBbmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A62A68C46C3;
 Fri, 19 Jan 2024 15:25:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6153040C95AD;
 Fri, 19 Jan 2024 15:25:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/11] tests/vm/netbsd: Remove missing py311-expat package
Date: Fri, 19 Jan 2024 16:25:07 +0100
Message-ID: <20240119152507.55182-12-thuth@redhat.com>
In-Reply-To: <20240119152507.55182-1-thuth@redhat.com>
References: <20240119152507.55182-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since the pkgsrc-2023Q3 release [*], the py-expat package has been
merged into the base 'python' package:

 - Several packages have been folded into base packages.  While the
   result is simpler, those updating may need to force-remove the
   secondary packages, depending on the update method.  When doing
   make replace, one has to pkg_delete -f the secondary packages.
   pkgin handles at least the python packages correctly, removing the
   split package when updating python.  Specific packages and the
   former packages now included:

     * cairo: cairo-gobject
     * python: py-cElementTree py-curses py-cursespanel py-expat
       py-readline py-sqlite3

Remove py311-expat from the package list in order to avoid:

  ### Installing packages ...
  processing remote summary (http://cdn.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/9.3/All)...
  database for http://cdn.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/9.3/All is up-to-date
  py311-expat is not available in the repository
  ...
  calculating dependencies.../py311-expat is not available in the repository
  pkg_install error log can be found in /var/db/pkgin/pkg_install-err.log

[*] https://mail-index.netbsd.org/netbsd-announce/2024/01/01/msg000360.html

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2109
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240117140746.23511-1-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/vm/netbsd | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 649fcad353..a3f6dd6b3c 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -31,7 +31,6 @@ class NetBSDVM(basevm.BaseVM):
         "pkgconf",
         "xz",
         "python311",
-        "py311-expat",
         "ninja-build",
 
         # gnu tools
-- 
2.43.0


