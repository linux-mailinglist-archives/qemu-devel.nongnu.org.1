Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F75DA84C6D
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Apr 2025 20:50:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2wyJ-0005um-Sx; Thu, 10 Apr 2025 14:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2wxI-0005YX-5M
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 14:48:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2wxG-0006m1-OD
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 14:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744310929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FVSmhp6IFCXEP7+6IJNsynIcw6wfxJ/o98RZdj3I/N8=;
 b=Lz0a7WHxA0un1iNU5BCsPgp4P5au7zF4kwfD51o1YhbbkiaIHnZ6Bi7QJzY5aqKjT5fUMx
 ZfYtu3URQ0Ygt3LkgSb4pJN5EH9bCLi/ryGdnTkcMXqvFNz5JPSO1UTv0LlyWhyH/e5iZB
 ZgdEjY4ECaqtlHcpYmlH4MPuJGjUk3M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-xonTNwxBNY-kyGLIu1XUYA-1; Thu,
 10 Apr 2025 14:48:45 -0400
X-MC-Unique: xonTNwxBNY-kyGLIu1XUYA-1
X-Mimecast-MFC-AGG-ID: xonTNwxBNY-kyGLIu1XUYA_1744310924
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B845180035E; Thu, 10 Apr 2025 18:48:44 +0000 (UTC)
Received: from localhost (unknown [10.2.17.97])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D9A701955DCE; Thu, 10 Apr 2025 18:48:43 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 <qemu-block@nongnu.org>
Subject: [PATCH v2 0/2] block: discard alignment fixes
Date: Thu, 10 Apr 2025 14:41:01 -0400
Message-ID: <20250410184103.23385-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

v2:
- Fix inverted logic in alignment check [Qing Wang]

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


