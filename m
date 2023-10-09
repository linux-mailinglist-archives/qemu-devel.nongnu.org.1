Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6917BE761
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 19:09:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qptjk-0000yR-8z; Mon, 09 Oct 2023 13:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qptji-0000x2-Oq
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 13:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qptjh-00006H-9r
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 13:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696871284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=D0nzdaq5F7I7mzK6PuH7vPLW0ZAhdiXYk3OzT+ohu+A=;
 b=hNJ0Rg6KJOq5lzxP2oC52CYEc94LNBbOQ3MT9fZtc6l0LiqrpiUuHzwEa+ba3tWfy43zY0
 z780KV6yp/7FSAIIx7nDClahvBtsjqdRFvlx84U0fHisPoPj8urKeI7JkZCqTVhnIHewcP
 d5Qjrj9ts+Bs32BAQdTIhHPOwskAgtI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-om2hdzaSN1q165CNoa36Jw-1; Mon, 09 Oct 2023 13:07:48 -0400
X-MC-Unique: om2hdzaSN1q165CNoa36Jw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CF48185A79B;
 Mon,  9 Oct 2023 17:07:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F9BC40C6EBF;
 Mon,  9 Oct 2023 17:07:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clegoate@redhat.com>
Subject: [PATCH v2 0/2] target/s390x/kvm: Simplify the synchronization code
Date: Mon,  9 Oct 2023 19:07:43 +0200
Message-ID: <20231009170745.63446-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

KVM_SYNC_GPRS, KVM_SYNC_ACRS, KVM_SYNC_CRS and KVM_SYNC_PREFIX are
available since kernel 3.10. Since we already require at least kernel
3.15 in the s390x KVM code, we can also assume that the KVM_CAP_SYNC_REGS
sync code is always possible for these registers, and remove the
related checks and fallbacks via KVM_SET_REGS and KVM_GET_REGS.

v2:
- Split the patch from v1 into two patches
- Use a #define KVM_SYNC_REQUIRED_BITS for the required sync bits
- Use memcpy() instead of for-loops for copying the registers

Thomas Huth (2):
  target/s390x/kvm: Turn KVM_CAP_SYNC_REGS into a hard requirement
  target/s390x/kvm: Simplify the GPRs, ACRs, CRs and prefix
    synchronization code

 target/s390x/kvm/kvm.c | 120 ++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 87 deletions(-)

-- 
2.41.0


