Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E1F766F7E
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 16:31:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPORl-0002tc-1N; Fri, 28 Jul 2023 10:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPORi-0002sw-Nn
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:27:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPORh-0006vn-6N
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690554476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qFBclDpHMvB2SY95UgOVvPf2UO6iTDBpYFkLBxVGyZg=;
 b=LJO4x/xi5wnX49cWGCdTaQ9TLxyULh2CobjfzDygc8HXdISzZNmb2TebVbgPKKTe+hfI2s
 n1vMwbTjkVGISVm7dh4scF4uSrIuXBTrumn+XPiUAM24ZXXgsL7RBy/2PVYjhiawjIsDFB
 60gRPwq7TIFSKmS/HFdy14cTOauCLHk=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-_hyd6882O0qJwiJVZI5biw-1; Fri, 28 Jul 2023 10:27:52 -0400
X-MC-Unique: _hyd6882O0qJwiJVZI5biw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A6871C04322;
 Fri, 28 Jul 2023 14:27:52 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C0FD640C206F;
 Fri, 28 Jul 2023 14:27:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 0/6] Use Clang for compiling in the  64-bit MSYS2 job
Date: Fri, 28 Jul 2023 16:27:42 +0200
Message-Id: <20230728142748.305341-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

The 64-bit MSYS2 job often times out in our CI, though we already have
limited it to a very minimum by using --without-default-devices etc.
GCC is incredibly slow here. By using Clang instead of GCC, the job
is ca. 15 minutes faster - that's enough buffer to avoid the timeouts
here.

The caveat is that Clang does not support __attribute__((gcc_struct))
on Windows. So we have to make sure that our structs are still padded
right. By checking the build with "pahole", Daniel discovered that
there is still an issue in VTD_IR_TableEntry, so that's why this
struct gets changed in this patch series, too. All other structs did
not show a difference with "pahole", so building with Clang should
hopefully be fine after these modifications here.

Daniel P. Berrangé (1):
  gitlab: remove duplication between msys jobs

Marc-André Lureau (1):
  ui/dbus: fix clang compilation issue

Thomas Huth (4):
  util/oslib-win32: Fix compiling with Clang from MSYS2
  hw/i386/intel_iommu: Fix VTD_IR_TableEntry for ms_struct layout
  include/qemu/compiler: Fix problem with gcc_struct and Clang
  gitlab-ci.d/windows: Use Clang for compiling in the 64-bit MSYS2 job

 include/hw/i386/intel_iommu.h |  14 ++--
 include/qemu/compiler.h       |   2 +-
 hw/i386/intel_iommu.c         |   2 +-
 ui/dbus-listener.c            |   3 +-
 util/oslib-win32.c            |   4 +-
 .gitlab-ci.d/windows.yml      | 134 +++++++++++++---------------------
 6 files changed, 65 insertions(+), 94 deletions(-)

-- 
2.39.3


