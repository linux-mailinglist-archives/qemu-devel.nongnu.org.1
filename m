Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF00BF6EF7
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Oct 2025 15:59:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBCsf-0000H9-W8; Tue, 21 Oct 2025 09:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBCs8-0000G3-1j
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBCs4-0007xq-Bl
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761055071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMX5dMJBLwOdR9O82a01i56scmDpujZek0VL+du5ZCo=;
 b=QJUfI+jvWwAJqY3lbWsaG/Ud98p5G5bHU59nC3wI18lrEP5SJE0XuHlAb4iPiNwXZddo7E
 YVUuqKFbyZ1GTbGf/xDQ7LauIoof27EY5HD2bwo/6k0tfBTDlJfpF/ZOqiBkAgwA+brGTE
 HLZqGdkIoWTaWnLDiBoN4wFMLgAYCPw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-lRwNOAFrOeWOHelZ36i2_Q-1; Tue,
 21 Oct 2025 09:57:49 -0400
X-MC-Unique: lRwNOAFrOeWOHelZ36i2_Q-1
X-Mimecast-MFC-AGG-ID: lRwNOAFrOeWOHelZ36i2_Q_1761055068
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2556D1808985; Tue, 21 Oct 2025 13:57:48 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC8DB19560B0; Tue, 21 Oct 2025 13:57:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/6] gitlab-ci: Decrease the size of the compiler cache
Date: Tue, 21 Oct 2025 15:57:35 +0200
Message-ID: <20251021135735.96145-7-thuth@redhat.com>
In-Reply-To: <20251021135735.96145-1-thuth@redhat.com>
References: <20251021135735.96145-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Uploading the cache from the runner takes a long time in the MSYS2
job, mostly due to the size of the compiler cache.
However, looking at runs with a non-poluted cache, it seems like
you can get a build with a 99% hit rate already with ~ 160 MiB cache
size, so the compiler cache with 500 MiB certainly contains a lot of
stale files. Thus decrease the size of the ccache to a more reasonable
value to speed up the MSYS2 job in our CI.

While at it, also add a "du -sh" for the build folder to get a better
feeling for the amount of object code that is required for the build,
and publish the list of files in /var/cache to be able to better
analyze what is really clogging our cache here.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251020161759.50241-1-thuth@redhat.com>
---
 .gitlab-ci.d/windows.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 6e1135d8b86..5dbdabfbec0 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -25,6 +25,7 @@ msys2-64bit:
     expire_in: 7 days
     paths:
       - build/meson-logs
+      - build/cache-log.txt
     reports:
       junit: build/meson-logs/*.junit.xml
   before_script:
@@ -94,7 +95,7 @@ msys2-64bit:
   - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
   - $env:CCACHE_BASEDIR = "$env:CI_PROJECT_DIR"
   - $env:CCACHE_DIR = "$env:CCACHE_BASEDIR/ccache"
-  - $env:CCACHE_MAXSIZE = "500M"
+  - $env:CCACHE_MAXSIZE = "180M"
   - $env:CCACHE_DEPEND = 1 # cache misses are too expensive with preprocessor mode
   - $env:CC = "ccache gcc"
   - mkdir build
@@ -103,5 +104,7 @@ msys2-64bit:
   - ..\msys64\usr\bin\bash -lc "../configure $CONFIGURE_ARGS"
   - ..\msys64\usr\bin\bash -lc "make -j$env:JOBS"
   - ..\msys64\usr\bin\bash -lc "make check MTESTARGS='$TEST_ARGS' || { cat meson-logs/testlog.txt; exit 1; } ;"
+  - ..\msys64\usr\bin\bash -lc "ls -lR /var/cache > cache-log.txt"
+  - ..\msys64\usr\bin\bash -lc "du -sh ."
   - ..\msys64\usr\bin\bash -lc "ccache --show-stats"
   - Write-Output "Finished build at $(Get-Date -Format u)"
-- 
2.51.0


