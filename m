Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2444AB510C
	for <lists+qemu-devel@lfdr.de>; Tue, 13 May 2025 12:08:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmYq-0000u6-JC; Tue, 13 May 2025 06:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEmYo-0000qO-48
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:08:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEmYl-0007w0-2u
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747130904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nwrPNDMk/ikYJQeg8zdv5DeOIxVvyaxFEGUYmCXti9c=;
 b=UXK/eoOjQkENIvXrl0yEiLZkUb2giw5tWRFVBfHGeDkDVMJHORByJoHe5BWW8xXqF/jPag
 xRfxgDkQtfUN49HgocxMzW7AXvKGjS82jSxd3rwEAWMqIHQDzRxH8FndC9yM25uDoaa/QP
 iu+FnVC8grxs3cJgI52Z0Wf07dUqMWc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-O4w0_z4VPMKH-XAAIfr0fQ-1; Tue,
 13 May 2025 06:08:23 -0400
X-MC-Unique: O4w0_z4VPMKH-XAAIfr0fQ-1
X-Mimecast-MFC-AGG-ID: O4w0_z4VPMKH-XAAIfr0fQ_1747130902
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92F1219560AB
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:08:22 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 260D51955F56; Tue, 13 May 2025 10:08:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/3] ui/vnc: fix some endian problems
Date: Tue, 13 May 2025 11:08:16 +0100
Message-ID: <20250513100819.1179249-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

This fixes some edge cases in endian handling in the VNC server. These
bugs are rarely going to be visible by default, since most servers will
negotiate encoding formats / framebuffer formats that avoid hitting
the problem scenarios.

Daniel P. Berrangé (3):
  ui/vnc.c: replace big endian flag with byte order value
  ui/vnc: take account of client byte order in pixman format
  ui/vnc: fix tight palette pixel encoding for 8/16-bpp formats

 include/ui/qemu-pixman.h |  4 ++--
 ui/qemu-pixman.c         | 15 ++++++++-------
 ui/vnc-enc-tight.c       | 16 ++++++++++------
 ui/vnc-enc-zrle.c        |  2 +-
 ui/vnc-jobs.c            |  2 +-
 ui/vnc.c                 |  9 +++++----
 ui/vnc.h                 |  2 +-
 7 files changed, 28 insertions(+), 22 deletions(-)

-- 
2.49.0


