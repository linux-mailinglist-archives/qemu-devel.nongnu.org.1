Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC85B7D100D
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 14:58:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtp4R-0001r3-P1; Fri, 20 Oct 2023 08:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtp4O-0001ps-Ol
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtp4N-0003C6-3F
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697806658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8xnr61vkCiU8hEDDEYbuPtJzxWEesy4Nxz1kN2OVVKg=;
 b=eGHRiQZcnEt6mRRk3XsY4QhcK8Bo/QC/n5OD6Ph2FPe47WHO+HYjUf1SvA4RwzdwFIADGw
 lrCZ8TE1CA+80wi20k7bhGb2C/CXNg6G/jsHMsE13MG5YUmr0aJvInDsNJk3M0E9l2cugV
 UTSKS+6arEnDUmdMxUAFA1ziUOV8voM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-aYUCRN_HMou2gttdhaHv9A-1; Fri, 20 Oct 2023 08:57:31 -0400
X-MC-Unique: aYUCRN_HMou2gttdhaHv9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5082C2810D6D;
 Fri, 20 Oct 2023 12:57:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1089503B;
 Fri, 20 Oct 2023 12:57:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH 0/3] hw/s390x: Don't call register_savevm_live() during
 instance_init()
Date: Fri, 20 Oct 2023 14:57:25 +0200
Message-ID: <20231020125728.579747-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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

We must not call register_savevm_live() during instance_init()
since instances can be created at any time, e.g. during introspection
of a device. We must register the savevm handler during realize()
instead. Fix it now in the s390x devices.

Thomas Huth (3):
  hw/s390x/s390-skeys: Don't call register_savevm_live() during
    instance_init()
  hw/s390x/s390-stattrib: Simplify handling of the "migration-enabled"
    property
  hw/s390x/s390-stattrib: Don't call register_savevm_live() during
    instance_init()

 hw/s390x/s390-skeys.c    | 35 ++++++--------------------
 hw/s390x/s390-stattrib.c | 54 +++++++++++++++-------------------------
 2 files changed, 28 insertions(+), 61 deletions(-)

-- 
2.41.0


