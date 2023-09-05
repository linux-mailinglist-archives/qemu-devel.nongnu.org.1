Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C928792242
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 13:52:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdUZq-0007yk-83; Tue, 05 Sep 2023 07:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdUZQ-0007vJ-Dq
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdUZL-0001mr-Gq
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693914605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VDOECKYO3qMvT7EtyMwAUJcZtLv9ezgcyQybwtyVlNM=;
 b=hI2+6R3znajfoB0/wdAmG4n3WJJb94GiBDU1VNhbeOpW5A80FdO6OdxjsVCQBqfS/CZzOu
 YXJLKswSFU+oikbqzUrrmo5/qSU4tti5WBOEWfAKOejb+pzTDoHEqjCGhFDoOguGjbVz1R
 G9fyDF03f/gWDSHDgj+FlYjHSywfGUc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-I55prYU7OBKAW7W_aKVq9A-1; Tue, 05 Sep 2023 07:50:04 -0400
X-MC-Unique: I55prYU7OBKAW7W_aKVq9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3DA618DA724;
 Tue,  5 Sep 2023 11:50:03 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.241])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 601174043CCD;
 Tue,  5 Sep 2023 11:50:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Subject: [risu PATCH v2 0/4] Add support for s390x to RISU
Date: Tue,  5 Sep 2023 13:49:56 +0200
Message-Id: <20230905115000.53587-1-thuth@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
instructions work already fine.

v2:
- Removed the code to avoid r14 (return address) and r15 (stack pointer)
  since it is not necessary anymore since commit ad82a069e8d6a
- Initialize the floating point registers in test_s390x.S, too
- Added Acked-bys and Reviewed-bys from v1

Thomas Huth (4):
  s390x: Add basic s390x support to the C code
  s390x: Add simple s390x.risu file
  s390x: Add basic risugen perl module for s390x
  s390x: Update the configure script for s390x support

 configure            |   4 +-
 risu_reginfo_s390x.c | 140 ++++++++++++++++++++++++++++++++
 risu_reginfo_s390x.h |  23 ++++++
 risu_s390x.c         |  48 +++++++++++
 risugen_s390x.pm     | 186 +++++++++++++++++++++++++++++++++++++++++++
 s390x.risu           |  48 +++++++++++
 test_s390x.S         |  51 ++++++++++++
 7 files changed, 499 insertions(+), 1 deletion(-)
 create mode 100644 risu_reginfo_s390x.c
 create mode 100644 risu_reginfo_s390x.h
 create mode 100644 risu_s390x.c
 create mode 100644 risugen_s390x.pm
 create mode 100644 s390x.risu
 create mode 100644 test_s390x.S

-- 
2.39.3


