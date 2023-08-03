Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 854DB76E6CE
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 13:28:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRWD9-0006I8-SU; Thu, 03 Aug 2023 07:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRWD8-0006Hr-7x
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 07:09:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRWD6-0007Tr-LW
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 07:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691060979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=unJQVZgvKTpVRTo+OXvkX2eRgN6hq+QGkZVelyVDa7Y=;
 b=VkvFW8bgL4QAKJNX0yEjPiDwCccRPBeH3YcfoB2Ju26T4eJ/Pb/T9kEaL87ixOclwzSGAF
 J5NGEtvLrk9oJvfBPf0ev5u0VRcbUq+9J0gMPkmPo4pg8XdDGiIvX86MUNhHPx/xzH0n/X
 QJ4VIaN1Pm6ENrS45rxlf2+biCX8Kps=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-681-k7YPQ7mVOjif4a6EWsFWYg-1; Thu, 03 Aug 2023 07:09:36 -0400
X-MC-Unique: k7YPQ7mVOjif4a6EWsFWYg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2242F88D120;
 Thu,  3 Aug 2023 11:09:36 +0000 (UTC)
Received: from thuth.com (unknown [10.45.226.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2567D112132D;
 Thu,  3 Aug 2023 11:09:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 0/9] Fixes for 8.1-rc3
Date: Thu,  3 Aug 2023 13:09:23 +0200
Message-Id: <20230803110932.341091-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

The following changes since commit fb695ae3fdfe34ce7bf2eaa4595d48ca809c8841:

  Merge tag 'pull-qapi-2023-08-02' of https://repo.or.cz/qemu/armbru into staging (2023-08-02 06:51:53 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-08-03

for you to fetch changes up to f54ba56dad0e9cea275e9802915a293f1a8c7d22:

  gitlab: disable FF_SCRIPT_SECTIONS on msys jobs (2023-08-03 13:04:48 +0200)

----------------------------------------------------------------
* Fix timeout problems in the MSYS Gitlab CI jobs
* Fix a problem when compiling with Clang on Windows

----------------------------------------------------------------
Daniel P. Berrangé (8):
      gitlab: remove duplication between msys jobs
      gitlab: print timestamps during windows msys jobs
      gitlab: always use updated msys installer
      gitlab: drop $CI_PROJECT_DIR from cache path
      gitlab: always populate cache for windows msys jobs
      configure: support passthrough of -Dxxx args to meson
      gitlab: disable optimization and debug symbols in msys build
      gitlab: disable FF_SCRIPT_SECTIONS on msys jobs

Thomas Huth (1):
      util/oslib-win32: Fix compiling with Clang from MSYS2

 configure                |   4 ++
 util/oslib-win32.c       |   5 +-
 .gitlab-ci.d/windows.yml | 174 +++++++++++++++++++++++------------------------
 3 files changed, 94 insertions(+), 89 deletions(-)


