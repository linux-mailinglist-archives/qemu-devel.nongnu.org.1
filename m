Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F34D7D1232
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:06:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtr57-0005Zz-5A; Fri, 20 Oct 2023 11:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtr4o-0005Qb-UX
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtr4n-0001JG-Go
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697814372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=o2LVu0ENmLB1CXausAgZCe7fPsrDKclNZCGi+vrxv1M=;
 b=Ot/+x2gxwy35gqLgd1Hw6fh2PD5uFPX9FnulOOv1/XlqLyivcm8mHYrq4ZEc8vJ/sgIMpN
 dIGQV4bSpgftWBxW+8sxdkdlzSF7i6EwzFZJPHE+q6JVVieubaB+gs6QixWGTiWO2BTWbx
 7dAIfscQpAH3YkFf9WvqPNvaD2/YRqk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-EobNnZdsNGmQXiLtBkbOCA-1; Fri, 20 Oct 2023 11:05:57 -0400
X-MC-Unique: EobNnZdsNGmQXiLtBkbOCA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5082A185A7B6;
 Fri, 20 Oct 2023 15:05:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C41212166B2A;
 Fri, 20 Oct 2023 15:05:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v2 0/3] hw/s390x: Don't call register_savevm_live() during
 instance_init()
Date: Fri, 20 Oct 2023 17:05:51 +0200
Message-ID: <20231020150554.664422-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

We must not call register_savevm_live() during instance_init()
since instances can be created at any time, e.g. during introspection
of a device. We must register the savevm handler during realize()
instead. Fix it now in the s390x devices.

v2:
- Fixed bug in the third patch ("sas" -> "dev")
- Add an early return in case of error in the third patch
- Added Acked-by/Reviewed by from David and Eric (thanks!)

Thomas Huth (3):
  hw/s390x/s390-skeys: Don't call register_savevm_live() during
    instance_init()
  hw/s390x/s390-stattrib: Simplify handling of the "migration-enabled"
    property
  hw/s390x/s390-stattrib: Don't call register_savevm_live() during
    instance_init()

 hw/s390x/s390-skeys.c    | 35 ++++++-------------------
 hw/s390x/s390-stattrib.c | 55 +++++++++++++++-------------------------
 2 files changed, 29 insertions(+), 61 deletions(-)

-- 
2.41.0


