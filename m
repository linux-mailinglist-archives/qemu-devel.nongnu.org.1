Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 150DC742CEC
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 21:05:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEwxT-0001l4-4u; Thu, 29 Jun 2023 15:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEwxN-0001WS-Tx
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 15:05:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEwxK-00063i-HA
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 15:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688065525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kYqGimwMpKbKYpVY7hlc0HHvAtQqT5+G1Hm8G1wyTzI=;
 b=Wjdy8qDtHTn3Mv8Y9I6xNTZaDptJl5ueK0iabtUTzfUA+gNKs8b6Xhwh5HJX0fr0qS8PQR
 YMY/zB1sBS3FFxwwzalvVjiQerkY4v0vLKHXFno+33xF3aFz6aDwZDXpVxE+ciZNxkKlrS
 QIAJ8AtYIYtwyeqeH64KFoHCUI9IqVw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-aNqioeBHOemS6sLbjkFnFw-1; Thu, 29 Jun 2023 15:03:23 -0400
X-MC-Unique: aNqioeBHOemS6sLbjkFnFw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBAC5185A792;
 Thu, 29 Jun 2023 19:03:13 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18172140E952;
 Thu, 29 Jun 2023 19:03:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/8] s390-ccw bios updates
Date: Thu, 29 Jun 2023 21:03:02 +0200
Message-Id: <20230629190310.337850-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

 Hi Richard!

The following changes since commit 0eb8f90edebc11022a42abb211b026fac2e276f5:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2023-06-28 17:29:53 +0200)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-06-29

for you to fetch changes up to b806bc8d9cc16172f0cf2c9e42ca1d75b72f6555:

  pc-bios: Update the s390 bios images with the recent changes (2023-06-29 20:47:45 +0200)

----------------------------------------------------------------
* Fix a compilation issue in the s390-ccw bios with Clang + binutils 2.40
* Create an initial stack frame for the main() function of the s390-ccw bios
* Clean up type definitions in the s390-ccw bios

----------------------------------------------------------------
Juan Quintela (1):
      s390-ccw: Getting rid of ulong

Thomas Huth (7):
      pc-bios/s390-ccw: Get rid of the the __u* types
      pc-bios/s390-ccw/Makefile: Use -z noexecstack to silence linker warning
      pc-bios/s390-ccw: Fix indentation in start.S
      pc-bios/s390-ccw: Provide space for initial stack frame in start.S
      pc-bios/s390-ccw: Move the stack array into start.S
      pc-bios/s390-ccw: Don't use __bss_start with the "larl" instruction
      pc-bios: Update the s390 bios images with the recent changes

 pc-bios/s390-ccw/cio.h           | 232 +++++++++++++++++++--------------------
 pc-bios/s390-ccw/helper.h        |   2 +-
 pc-bios/s390-ccw/s390-ccw.h      |  12 +-
 pc-bios/s390-ccw/virtio-scsi.h   |   2 +-
 pc-bios/s390-ccw/virtio.h        |   4 +-
 pc-bios/s390-ccw/main.c          |   1 -
 pc-bios/s390-ccw/netmain.c       |   1 -
 pc-bios/s390-ccw/virtio-blkdev.c |  12 +-
 pc-bios/s390-ccw/virtio-scsi.c   |   4 +-
 pc-bios/s390-ccw/virtio.c        |  12 +-
 pc-bios/s390-ccw.img             | Bin 42608 -> 42608 bytes
 pc-bios/s390-ccw/Makefile        |   2 +-
 pc-bios/s390-ccw/start.S         | 149 +++++++++++++------------
 pc-bios/s390-netboot.img         | Bin 67232 -> 67232 bytes
 tests/tcg/s390x/head64.S         |   7 +-
 15 files changed, 220 insertions(+), 220 deletions(-)


