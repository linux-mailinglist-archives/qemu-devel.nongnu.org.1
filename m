Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCDBBCDEB9
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Oct 2025 18:08:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7FdT-0000eN-Nm; Fri, 10 Oct 2025 12:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v7FdG-0000b2-GY
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:06:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v7Fd8-0007av-CY
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760112357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5bEZEYMem/bO+cwYQb2z8XqYPIiQePkKDRA2Y279HiE=;
 b=WVYfW5jeb+AKY6F5RPI+AhcddUSSwsJW6zICsv+CZGYtM18q2XHM1x9C4eT5XBTq4vi3/6
 9enFbD9ue6xz3StkrP2QAO3aeBoWY2zLdj7wVif8eyAqXqv6NpOX0OcP1uerO4+bdwX+7/
 iIWT9hVOkS3LPzRAOj8Btn34sugxdD4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-ySO8M6FEONmTYpeEuja0Gw-1; Fri,
 10 Oct 2025 12:05:53 -0400
X-MC-Unique: ySO8M6FEONmTYpeEuja0Gw-1
X-Mimecast-MFC-AGG-ID: ySO8M6FEONmTYpeEuja0Gw_1760112351
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A7C018004D8; Fri, 10 Oct 2025 16:05:50 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.177])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0E511955F42; Fri, 10 Oct 2025 16:05:47 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yonggang Luo <luoyonggang@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] gitlab: purge msys pacman cache
Date: Fri, 10 Oct 2025 17:05:45 +0100
Message-ID: <20251010160545.144760-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For the Windows msys2 CI job we install many packages using pacman
and use the GitLab cache to preserve the pacman cache across CI
runs. While metadata still needs downloading, this avoids pacman
re-downloading packages from msys2 if they have not changed.

The problem is that pacman never automatically purges anything
from its package cache. Thus the GitLab cache is growing without
bound and packing/unpacking the cache is consuming an increasing
amount of time in the CI job.

If we run 'pacman -Sc' /after/ installing our desired package set,
it will purge any cached downloaded packages that are not matching
any installed package.

This will (currently) cap the pacman download cache at approx
256 MB.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/windows.yml | 1 +
 1 file changed, 1 insertion(+)

See a test job with this change, plus a find across the msys
pacman cache, showing the cleanup effects....

Before cleanup:

  https://gitlab.com/berrange/qemu/-/jobs/11679136531#L34

After cleanup:

  https://gitlab.com/berrange/qemu/-/jobs/11679136531#L1126

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 1e6a01bd9a..6e1135d8b8 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -87,6 +87,7 @@ msys2-64bit:
       mingw-w64-x86_64-pkgconf
       mingw-w64-x86_64-python
       mingw-w64-x86_64-zstd"
+  - .\msys64\usr\bin\bash -lc "pacman -Sc --noconfirm"
   - Write-Output "Running build at $(Get-Date -Format u)"
   - $env:JOBS = $(.\msys64\usr\bin\bash -lc nproc)
   - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
-- 
2.50.1


