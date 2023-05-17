Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9FE70607F
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 08:56:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzB3a-0004qX-JS; Wed, 17 May 2023 02:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzB3X-0004q9-Mi
 for qemu-devel@nongnu.org; Wed, 17 May 2023 02:54:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzB3Q-00044n-Ck
 for qemu-devel@nongnu.org; Wed, 17 May 2023 02:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684306471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zx0HRa4C5kSXeAVVK9dYRcY3FysvwUd/wy24+LT33os=;
 b=NWWikCm8YGVhGDNadzcR7CTo9uWUXkEYidEzDxuVKsOITVHdETJwPDYguit40FH7QLDNdY
 cb4ObzFFkTs7THqFHJnp4QE0GZJIpjGU6aQUOCw5DZo0pmpw5cUDRMvKxZLQ0CQwwHh7Ix
 VqTygZGURnjmbgEOjEzHKCQj5C5akDg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-zna6s0QTMC-GeMjHSgPR8g-1; Wed, 17 May 2023 02:54:29 -0400
X-MC-Unique: zna6s0QTMC-GeMjHSgPR8g-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-649750dccfcso442616b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 23:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684306468; x=1686898468;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zx0HRa4C5kSXeAVVK9dYRcY3FysvwUd/wy24+LT33os=;
 b=D+6O33NsttLmpzyJn5EQB/1wQFNwPHX9YaDUxavQ0T+frlEN9L2A8qn/xgrAtj39sc
 5UvkkmqmYMWP8JaTa8uIVys+FtFpPWAUEKqcoOfyHWIlZmUvtnJbt59dPLhmTixvmKyV
 Cse6/sTcufw3wPgKq2I6FDXvOjer7+HAunpg9Phu5qX+njtB9YMCEVHI8DiAFMZ23HH1
 zCmwXmVzvIawStt5tWXmtHgu3KWSY+sF0U1lfderSDwv2n12ij7un3uT8bO06d5pd1iy
 gMWh6QP7kmO/sXiKi8YBfxx+F4a0GBCjptLgwaEDxDdossJiUZldSIcyk+67nG/L4fZt
 zFdw==
X-Gm-Message-State: AC+VfDzo6Lzd8rFkJmoGvuEspx2gNaveAe9N62Pk0yKgxhln2RBzm4N5
 xHzlkdIdFIR7MH7z9CmRzeYvH9dhn2VZtQjBGHszXNjafj9qqgaA3KUJG5X8FwTBnA/kCtT0IN1
 I38ruaFqFm5l2trc=
X-Received: by 2002:a05:6a00:2442:b0:63b:854c:e0f6 with SMTP id
 d2-20020a056a00244200b0063b854ce0f6mr54414946pfj.21.1684306468408; 
 Tue, 16 May 2023 23:54:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ68Q2iUAwayhFEPAaPkHXagPNgBScrV/Yw0aaRy7azKjG84mXgCramNE10DpVmFTklDNpQnfw==
X-Received: by 2002:a05:6a00:2442:b0:63b:854c:e0f6 with SMTP id
 d2-20020a056a00244200b0063b854ce0f6mr54414928pfj.21.1684306468036; 
 Tue, 16 May 2023 23:54:28 -0700 (PDT)
Received: from localhost.localdomain ([115.96.105.155])
 by smtp.googlemail.com with ESMTPSA id
 y67-20020a636446000000b0051b7e3546acsm14761779pgb.22.2023.05.16.23.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 23:54:27 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] acpi/tests/avocado/bits: enable bios bits avocado tests on
 gitlab CI pipeline
Date: Wed, 17 May 2023 12:23:57 +0530
Message-Id: <20230517065357.5614-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Biosbits avocado tests on gitlab has thus far been disabled because some
packages needed by this test was missing in the container images used by gitlab
CI. These packages have now been added with the commit:

da9000784c90d ("tests/lcitool: Add mtools and xorriso and remove genisoimage as dependencies")

Therefore, this change enables bits avocado test on gitlab.
At the same time, the bits cleanup code has also been made more robust with
this change.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/avocado/acpi-bits.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Pipeline is green:
https://gitlab.com/anisinha/qemu/-/pipelines/869670000
bios bits tests passing:
https://gitlab.com/anisinha/qemu/-/jobs/4298116787#L189

diff --git a/tests/avocado/acpi-bits.py b/tests/avocado/acpi-bits.py
index 14038fa3c4..3ed286dcbd 100644
--- a/tests/avocado/acpi-bits.py
+++ b/tests/avocado/acpi-bits.py
@@ -123,9 +123,9 @@ def base_args(self):
         """return the base argument to QEMU binary"""
         return self._base_args
 
-@skipIf(not supported_platform() or missing_deps() or os.getenv('GITLAB_CI'),
-        'incorrect platform or dependencies (%s) not installed ' \
-        'or running on GitLab' % ','.join(deps))
+@skipIf(not supported_platform() or missing_deps(),
+        'unsupported platform or dependencies (%s) not installed' \
+        % ','.join(deps))
 class AcpiBitsTest(QemuBaseTest): #pylint: disable=too-many-instance-attributes
     """
     ACPI and SMBIOS tests using biosbits.
@@ -356,7 +356,7 @@ def tearDown(self):
         """
         if self._vm:
             self.assertFalse(not self._vm.is_running)
-        if not os.getenv('BITS_DEBUG'):
+        if not os.getenv('BITS_DEBUG') and self._workDir:
             self.logger.info('removing the work directory %s', self._workDir)
             shutil.rmtree(self._workDir)
         else:
-- 
2.39.1


