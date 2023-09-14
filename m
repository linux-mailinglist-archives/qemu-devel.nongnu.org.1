Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E46FD7A02C5
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 13:35:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgkb7-0000id-O9; Thu, 14 Sep 2023 07:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgkb5-0000gz-65
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:33:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgkb1-00082T-VS
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694691199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HERiBSiHe4qhNPw+uXeuZLWpgkuKax2KkC8u2Rtkla4=;
 b=QlXOI85fluGTMI3KLN93D1ubPebOVkQux7v+tOOMMQ0Wt9XtDsc8zdsV6B5GbTq/ynAfhu
 A5PAfahIB4kaGS4g6dxp1Dvp7pJ/GxQ11RKAAtKlcs701Z+XwUPiLQQeV2MZdGaUII4PSd
 HbgMYXqrJMa2y0UOrM3HllP4kX4sH3c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-364-YOXP97_BOL6u9sIa2mbSKA-1; Thu, 14 Sep 2023 07:33:14 -0400
X-MC-Unique: YOXP97_BOL6u9sIa2mbSKA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7034101A529;
 Thu, 14 Sep 2023 11:33:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95C9D1054FC0;
 Thu, 14 Sep 2023 11:33:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [risu PATCH v3 0/7] Add support for s390x to RISU
Date: Thu, 14 Sep 2023 13:33:04 +0200
Message-ID: <20230914113311.379537-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

 Hi Peter!

Here are some patches that add basic support for s390x to RISU.
It's still quite limited, e.g. no support for load/store memory
operations yet, but the basics with simple 16-bit or 32-bit
instructions work *now* already fine.

(I'm also already experimenting in extending RISU to support
instructions with opcodes lengths > 32-bit, but the patches
are not quite ready yet)

v3:
- Use si_addr to get the address of the faulting instruction
  (since the PSW address in the ucontext already points to the
  next instruction)
- Use the kernel header asm/ucontext.h instead the one from the
  glibc since the latter does not provide information about
  vector registers (VRs are not used yet, but will be added later)
- Disable exceptions in the floating point control register so
  we can also test floating point instructions
- Added some more instructions to s390x.risu
- Added RFC patch to compile test aarch64, ppc64le and s390x on
  Travis-CI

v2:
- Removed the code to avoid r14 (return address) and r15 (stack pointer)
  since it is not necessary anymore since commit ad82a069e8d6a
- Initialize the floating point registers in test_s390x.S, too
- Added Acked-bys and Reviewed-bys from v1

Thomas Huth (7):
  Pass siginfo_t->si_addr to the reginfo_init() function
  s390x: Add basic s390x support to the C code
  s390x: Add simple s390x.risu file
  s390x: Add basic risugen perl module for s390x
  s390x: Update the configure script for s390x support
  build-all-archs: Add s390x to the script that builds all architectures
  Add a travis.yml file for testing RISU in the Travis-CI

 .travis.yml                |  37 ++++++++
 build-all-archs            |   3 +-
 configure                  |   4 +-
 risu.c                     |  12 +--
 risu.h                     |   2 +-
 risu_reginfo_aarch64.c     |   2 +-
 risu_reginfo_arm.c         |   2 +-
 risu_reginfo_i386.c        |   2 +-
 risu_reginfo_loongarch64.c |   2 +-
 risu_reginfo_m68k.c        |   2 +-
 risu_reginfo_ppc64.c       |   2 +-
 risu_reginfo_s390x.c       | 140 ++++++++++++++++++++++++++++
 risu_reginfo_s390x.h       |  25 +++++
 risu_s390x.c               |  51 ++++++++++
 risugen_s390x.pm           | 186 +++++++++++++++++++++++++++++++++++++
 s390x.risu                 |  81 ++++++++++++++++
 test_s390x.S               |  53 +++++++++++
 17 files changed, 591 insertions(+), 15 deletions(-)
 create mode 100644 .travis.yml
 create mode 100644 risu_reginfo_s390x.c
 create mode 100644 risu_reginfo_s390x.h
 create mode 100644 risu_s390x.c
 create mode 100644 risugen_s390x.pm
 create mode 100644 s390x.risu
 create mode 100644 test_s390x.S

-- 
2.41.0


