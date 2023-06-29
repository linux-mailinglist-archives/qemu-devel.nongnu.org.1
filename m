Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C521374243E
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 12:49:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEpCY-0001zz-Jt; Thu, 29 Jun 2023 06:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEpCS-0001zB-3y
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEpCQ-00044E-9N
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688035709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0nXh9iMLANuzLwhbHImdirjx/XSnDv8FW/srERisBeY=;
 b=FsZCE2QW7fzOJFoLk5TbYXo/Lad1+uAifCelHSFqZPasTdWsu/0wC1ZsD5+nDpquZDefoV
 ekM/AltpOOO4YJv0kfKFxHGxHXHPqdLW4NwigJaqPqs/OmbRAe04dI3z56YEMDGChbBs0/
 tO02XnHTF7KvgmJvRJ73LJM74e3SIyY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-TPnhXnYCPX-wdfF1XRPdfQ-1; Thu, 29 Jun 2023 06:48:24 -0400
X-MC-Unique: TPnhXnYCPX-wdfF1XRPdfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A21701C3D7C5;
 Thu, 29 Jun 2023 10:48:23 +0000 (UTC)
Received: from thuth.com (dhcp-192-205.str.redhat.com [10.33.192.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E225C4067A00;
 Thu, 29 Jun 2023 10:48:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v3 0/7] pc-bios/s390-ccw: Fixes and improvements for start.S
 (and other files)
Date: Thu, 29 Jun 2023 12:48:14 +0200
Message-Id: <20230629104821.194859-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

tl;dr: Please review the final patch - it's the only one that really changed.

This is a respin of the currently pending s390-ccw bios patches. Compared
to v2, I've included other pending patches for the s390-ccw bios this time,
so the series grew a little bit.

The only real code change compared to the previous version is in the
final patch: Instead of using ".bss" as start address of the area that
should be cleared, it now loads __bss_start indirectly instead. That
way we should be safe in case there will be another segment between
__bss_start and .bss one day (like .sbss on other architectures). See
The comments in https://bugzilla.redhat.com/show_bug.cgi?id=2216662
for more information.

Old cover letter follows:

------------------------------- 8< ------------------------------------

Main motivation of this series was a bug that showed up when compiling
with Clang 16 and binutils 2.40 (which has been reported in Fedora ELN, see
https://bugzilla.redhat.com/show_bug.cgi?id=2216662). This is fixed in
the final patch. I checked with "objdump" that the change is fine, indeed.

While working on this issue, I came accross some other issues which I
address in the other patches patches:

- Juan recently noticed unnecessary types in the s390-ccw bios (patch 1)
  which I continued to improve in patch 2
- Recent binutils complain about executable stack - fixed in patch 3
- Indentation is a mixture between tabs and spaces in start.S (patch 4)
- We do not set up a stack frame for the main() function, which could
  cause memory corruption (patch 5)
- The stack is declared in multiple places, though it's only needed
  in start.S (patch 6)

v3:
- Included other pending s390-ccw bios patches
- Changed the commit message of the "__u*" clean-up patch
- Changed the final patch to load __bss_start indirectly instead

v2:
- Use ".space" instead of ".lcomm" in the third patch to make sure
  that the alignment is really taken into consideration (thanks Richard)
- Alignment of 8 should be enough in the third patch (thank Christian)
- Added Reviewed-bys from v1

Juan Quintela (1):
  s390-ccw: Getting rid of ulong

Thomas Huth (6):
  pc-bios/s390-ccw: Get rid of the the __u* types
  pc-bios/s390-ccw/Makefile: Use -z noexecstack to silence linker
    warning
  pc-bios/s390-ccw: Fix indentation in start.S
  pc-bios/s390-ccw: Provide space for initial stack frame in start.S
  pc-bios/s390-ccw: Move the stack array into start.S
  pc-bios/s390-ccw: Don't use __bss_start with the "larl" instruction

 pc-bios/s390-ccw/cio.h           | 232 +++++++++++++++----------------
 pc-bios/s390-ccw/helper.h        |   2 +-
 pc-bios/s390-ccw/s390-ccw.h      |  12 +-
 pc-bios/s390-ccw/virtio-scsi.h   |   2 +-
 pc-bios/s390-ccw/virtio.h        |   4 +-
 pc-bios/s390-ccw/main.c          |   1 -
 pc-bios/s390-ccw/netmain.c       |   1 -
 pc-bios/s390-ccw/virtio-blkdev.c |  12 +-
 pc-bios/s390-ccw/virtio-scsi.c   |   4 +-
 pc-bios/s390-ccw/virtio.c        |  12 +-
 pc-bios/s390-ccw/Makefile        |   2 +-
 pc-bios/s390-ccw/start.S         | 149 +++++++++++---------
 tests/tcg/s390x/head64.S         |   7 +-
 13 files changed, 220 insertions(+), 220 deletions(-)

-- 
2.39.3


