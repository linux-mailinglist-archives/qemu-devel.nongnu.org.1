Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE18791950
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:03:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdA8r-00070H-Py; Mon, 04 Sep 2023 10:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdA8L-0006tI-1e
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdA8G-00087r-UK
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693836046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VFPBYL8WCBkvRDrgZ8SmpUkV+reUMUNEYijgnwmOz2c=;
 b=N5xfPTlgteVjqFLuF3QxCyIc5ySmz8BDcOVjyMJKyuwaAeSx0cEDHwS4nlP4BdYlNoDgE9
 3TFlO9+hdVGTPAGU1xWKMTryCBgY95Pn+7jWzvj8uSW2me/Ynuf64T6bZSRUJJKnngqtdg
 NRP5h3IX9Zubg23encALtHtyVC/MUqQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-21E2CggrNgq2i33E3upGjQ-1; Mon, 04 Sep 2023 10:00:44 -0400
X-MC-Unique: 21E2CggrNgq2i33E3upGjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2CA28759E2;
 Mon,  4 Sep 2023 14:00:43 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 558971121318;
 Mon,  4 Sep 2023 14:00:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Subject: [risu PATCH 0/4] Add support for s390x to RISU
Date: Mon,  4 Sep 2023 16:00:36 +0200
Message-Id: <20230904140040.33153-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
instructions work already fine.

(In the long run, we'd need to support instructions with 48-bit
length on s390x, too, since most newer "interesting" instructions
like e.g. vector SIMD instructions are encoded with 48 bit. This
will require modifications to the generic code, too, so I limited
my initial implementation to 16-bit and 32-bit instruction length
support to keep the code self-contained in the s390x architecture
specific files)

Thomas Huth (4):
  s390x: Add basic s390x support to the C code
  s390x: Add simple s390x.risu file
  s390x: Add basic risugen perl module for s390x
  s390x: Update the configure script for s390x support

 configure            |   4 +-
 risu_reginfo_s390x.c | 142 +++++++++++++++++++++++++++++++
 risu_reginfo_s390x.h |  23 +++++
 risu_s390x.c         |  48 +++++++++++
 risugen_s390x.pm     | 194 +++++++++++++++++++++++++++++++++++++++++++
 s390x.risu           |  48 +++++++++++
 test_s390x.S         |  32 +++++++
 7 files changed, 490 insertions(+), 1 deletion(-)
 create mode 100644 risu_reginfo_s390x.c
 create mode 100644 risu_reginfo_s390x.h
 create mode 100644 risu_s390x.c
 create mode 100644 risugen_s390x.pm
 create mode 100644 s390x.risu
 create mode 100644 test_s390x.S

-- 
2.39.3


