Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 579BA7972C6
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:15:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEla-0001bt-ID; Thu, 07 Sep 2023 09:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qeElX-0001SL-JN
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:09:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qeElV-0001wH-37
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694092182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4UZQj2g5BgGhxEiVV5NBR7+2VGRgVS3K7B1EO+hrmFs=;
 b=hQv9QwQv0YDfvJboq+nmr4s6IiEmGRlHrWRWJA9ydVv7oNmvnhacRRLSAX4nENk15zVFdB
 XPFtkqflSnywQvPv5SB7UobpwOqOifvaictLqPG0YiLf/MnP0sMkWobjfK+Oa+Ap0QJ8XN
 n0trlkt80l5grOeOCTmpsuR/4YBBPV0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-hFwT-pkVNyyqBWp9e05gjQ-1; Thu, 07 Sep 2023 09:09:40 -0400
X-MC-Unique: hFwT-pkVNyyqBWp9e05gjQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FD82917843
 for <qemu-devel@nongnu.org>; Thu,  7 Sep 2023 13:09:40 +0000 (UTC)
Received: from localhost (unknown [10.39.208.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3A1263F6C;
 Thu,  7 Sep 2023 13:09:39 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 0/5] virtio-gpu: add blob migration support
Date: Thu,  7 Sep 2023 17:09:31 +0400
Message-ID: <20230907130936.767722-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Hi,

This is a follow-up of the previous patch "[PATCH] virtio-gpu: block migration
of VMs with blob=true". Now that migration support is implemented, we can decide
to drop the migration blocker patch, or apply and revert it, so that
backporting of a quick fix is made easier.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=2236353

Marc-André Lureau (5):
  virtio-gpu: block migration of VMs with blob=true
  virtio-gpu: factor out restore mapping
  virtio-gpu: move scanout restoration to post_load
  virtio-gpu: add virtio-gpu/blob vmstate subsection
  Revert "virtio-gpu: block migration of VMs with blob=true"

 hw/display/virtio-gpu.c | 174 +++++++++++++++++++++++++++++++++-------
 1 file changed, 146 insertions(+), 28 deletions(-)

-- 
2.41.0


