Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF32A82EB8
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Apr 2025 20:31:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2aB0-0003ZB-F9; Wed, 09 Apr 2025 14:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2aAx-0003Vb-Kw
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 14:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2aAv-0003CY-KB
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 14:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744223363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cNKAuzXUkX8dWA8fQFDRIagvbomGFhNKZEr9QRehom4=;
 b=LePE6fxhRImYc85AtcB/LNLSm+mNqUhHXfAaAPIxIrw4ZHGjR5pBNnV9OW8Z4pE8aB2n0y
 R8urJvt/R/zIu9Fe8CyRoqMWlkdOntM1ppInUgfjcGWwyM1PXTLEhWccFEPpXnS6sqeiP9
 OjS6b0GsArVCFSAL0kqEcqjhzbhLrJc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-NARs1h3qOw2QkqvV8Fwhew-1; Wed,
 09 Apr 2025 14:29:20 -0400
X-MC-Unique: NARs1h3qOw2QkqvV8Fwhew-1
X-Mimecast-MFC-AGG-ID: NARs1h3qOw2QkqvV8Fwhew_1744223359
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72E601809CA5; Wed,  9 Apr 2025 18:29:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.144])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98F661955DCE; Wed,  9 Apr 2025 18:29:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, <qemu-block@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 0/2] block: discard alignment fixes
Date: Wed,  9 Apr 2025 14:29:12 -0400
Message-ID: <20250409182914.4725-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Two discard alignment issues were identified in
https://issues.redhat.com/browse/RHEL-86032:
1. pdiscard_alignment is not populated for host_device in file-posix.c.
2. Misaligned head/tail discard requests are not skipped when file-posix.c
   returns -EINVAL. This causes an undesired pause when guests are configured
   with werror=stop.

Stefan Hajnoczi (2):
  file-posix: probe discard alignment on Linux block devices
  block/io: skip head/tail requests on EINVAL

 block/file-posix.c | 56 +++++++++++++++++++++++++++++++++++++++++++++-
 block/io.c         |  6 ++++-
 2 files changed, 60 insertions(+), 2 deletions(-)

-- 
2.49.0


