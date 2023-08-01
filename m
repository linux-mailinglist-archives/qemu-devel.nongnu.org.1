Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D3276B568
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 15:04:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQp2w-0006hF-Un; Tue, 01 Aug 2023 09:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQp2t-0006g8-FJ
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQp2r-0006r7-TL
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690895053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7Z27Os2R99iHoSw8FApkIlvL6P2heEda+L0BynOUtc=;
 b=J3kPP4xyyuOi1ObM6plIOvOMWXfUTzW+0sAuhhq2x24LxhLiCZ+mjeON2Lfxy2M5ux84hq
 F5VemJ/vab7jzMV8POamOFzn0uyz/1nwTaOWrRZSI8eUyJPR9D/eOSvGR6anzWEFypRSE9
 o8A+zOJD0Y/8Qn0G5xJNa1FWKobwPcU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-UQbTrSmyP3uuNuSSFvMhqw-1; Tue, 01 Aug 2023 09:04:09 -0400
X-MC-Unique: UQbTrSmyP3uuNuSSFvMhqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7375081D9EC;
 Tue,  1 Aug 2023 13:04:09 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2F251454145;
 Tue,  1 Aug 2023 13:04:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/8] gitlab: print timestamps during windows msys jobs
Date: Tue,  1 Aug 2023 14:03:57 +0100
Message-ID: <20230801130403.164060-3-berrange@redhat.com>
In-Reply-To: <20230801130403.164060-1-berrange@redhat.com>
References: <20230801130403.164060-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

It is hard to get visibility into where time is consumed in our Windows
msys jobs. Adding a few log console messages with the timestamp will
aid in our debugging.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/windows.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index f086540e40..831b080d12 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -19,6 +19,7 @@
     reports:
       junit: "build/meson-logs/testlog.junit.xml"
   before_script:
+  - Write-Output "Acquiring msys2.exe installer at $(Get-Date -Format u)"
   - If ( !(Test-Path -Path msys64\var\cache ) ) {
       mkdir msys64\var\cache
     }
@@ -27,6 +28,7 @@
       "https://github.com/msys2/msys2-installer/releases/download/2022-06-03/msys2-base-x86_64-20220603.sfx.exe"
       -outfile "msys64\var\cache\msys2.exe"
     }
+  - Write-Output "Invoking msys2.exe installer at $(Get-Date -Format u)"
   - msys64\var\cache\msys2.exe -y
   - ((Get-Content -path .\msys64\etc\\post-install\\07-pacman-key.post -Raw)
       -replace '--refresh-keys', '--version') |
@@ -36,6 +38,7 @@
   - .\msys64\usr\bin\bash -lc 'pacman --noconfirm -Syuu'  # Normal update
   - taskkill /F /FI "MODULES eq msys-2.0.dll"
   script:
+  - Write-Output "Installing mingw packages at $(Get-Date -Format u)"
   - .\msys64\usr\bin\bash -lc "pacman -Sy --noconfirm --needed
       bison diffutils flex
       git grep make sed
@@ -66,6 +69,7 @@
       $MINGW_TARGET-spice
       $MINGW_TARGET-usbredir
       $MINGW_TARGET-zstd "
+  - Write-Output "Running build at $(Get-Date -Format u)"
   - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
   - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
   - mkdir build
@@ -73,6 +77,7 @@
   - ..\msys64\usr\bin\bash -lc "../configure --enable-fdt=system $CONFIGURE_ARGS"
   - ..\msys64\usr\bin\bash -lc "make"
   - ..\msys64\usr\bin\bash -lc "make check MTESTARGS='$TEST_ARGS' || { cat meson-logs/testlog.txt; exit 1; } ;"
+  - Write-Output "Finished build at $(Get-Date -Format u)"
 
 msys2-64bit:
   extends: .shared_msys2_builder
-- 
2.41.0


