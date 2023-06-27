Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7143373F5F7
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 09:47:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE3Q3-0007pm-Mw; Tue, 27 Jun 2023 03:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qE3Pz-0007pG-MD
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qE3Px-0005o0-D1
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687852036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/i10SF7CtUYEzFvQdKcxm77yBlkHJE4lvNpKPJa7kxQ=;
 b=AhB/0GetNtfdnozSDcpdGw8FtB9yMWvPlRjh7hRAb3vQvDIZ1Up+iYUJ67j3xI/TOGKoks
 mIxAMqgZ3PykpbQT9CIkEnb6PqSiuSQwUHMFg+nHuavCii+O5RYrYRBz0o5a/dvunk6Z3U
 ow3xe1mUDgrD20GfMwuTc4VhAKDFu6Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-Cc8MiIW4PlWFxa-NGiPmFA-1; Tue, 27 Jun 2023 03:47:11 -0400
X-MC-Unique: Cc8MiIW4PlWFxa-NGiPmFA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E6AF8C7C23;
 Tue, 27 Jun 2023 07:47:10 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.242])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C8BC401061;
 Tue, 27 Jun 2023 07:47:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 mrezanin@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clegoate@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v2 0/4] pc-bios/s390-ccw: Fixes and improvements for start.S
Date: Tue, 27 Jun 2023 09:46:59 +0200
Message-Id: <20230627074703.99608-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

Main motivation of this series was a bug that showed up when compiling
with Clang 16 and binutils 2.40 (which has been reported in Fedora ELN, see
https://bugzilla.redhat.com/show_bug.cgi?id=2216662). This is fixed in
the fourth patch. I checked with "objdump" that the change is fine, indeed.

While working on this issue, I came accross some other issues which I
address in the first three patches:

- Indentation is a mixture between tabs and spaces in start.S (patch 1)
- We do not set up a stack frame for the main() function, which could
  cause memory corruption (patch 2)
- The stack is declared in multiple places, though it's only needed
  in start.S (patch 3)

v2:
- Use ".space" instead of ".lcomm" in the third patch to make sure
  that the alignment is really taken into consideration (thanks Richard)
- Alignment of 8 should be enough in the third patch (thank Christian)
- Added Reviewed-bys from v1

Thomas Huth (4):
  pc-bios/s390-ccw: Fix indentation in start.S
  pc-bios/s390-ccw: Provide space for initial stack frame in start.S
  pc-bios/s390-ccw: Move the stack array into start.S
  pc-bios/s390-ccw: Don't use __bss_start with the "larl" instruction

 pc-bios/s390-ccw/s390-ccw.h |   1 -
 pc-bios/s390-ccw/main.c     |   1 -
 pc-bios/s390-ccw/netmain.c  |   1 -
 pc-bios/s390-ccw/start.S    | 144 +++++++++++++++++++-----------------
 4 files changed, 76 insertions(+), 71 deletions(-)

-- 
2.39.3


