Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA52753F2D
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 17:41:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKKtv-0002z0-R0; Fri, 14 Jul 2023 11:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1qKKtu-0002xy-6G
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:40:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1qKKtr-00052F-I5
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689349205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=w86eSRICVFo0/94ibE7GBiPCjUSSVn+9hd9Yw2qgaeY=;
 b=MJuWRlEnV5QZzesNuk4mGPcbc9hdOZcz6YD3xYBrWjY06BRg7bxLz79LgrGB6K3S5E2R4q
 rB4BvIoFwiGSdsNz9+yYJUtVneOeO6EwayO4bJ7wPDrBWvF78lFzNVfN/wSdwbI2GSJttx
 f8Zrd65tWoc3fUZTYrVBp/4UYuQ2EEI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-boHiPCv0M16lZxBfu-8PFg-1; Fri, 14 Jul 2023 11:40:01 -0400
X-MC-Unique: boHiPCv0M16lZxBfu-8PFg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4CE01C05132
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 15:40:01 +0000 (UTC)
Received: from centennial.enunes.eu (unknown [10.43.17.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9E5DC57963;
 Fri, 14 Jul 2023 15:40:00 +0000 (UTC)
From: Erico Nunes <ernunes@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, slp@redhat.com,
 Erico Nunes <ernunes@redhat.com>
Subject: [PATCH 0/3] vhost-user-gpu: support dmabuf modifiers
Date: Fri, 14 Jul 2023 17:38:57 +0200
Message-Id: <20230714153900.475857-1-ernunes@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ernunes@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

virglrenderer recently added virgl_renderer_resource_get_info_ext as a
new api, which gets resource information, including dmabuf modifiers.
https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1024

We have to support dmabuf modifiers since the driver may choose to
allocate buffers with these modifiers to improve performance, and
importing buffers without modifiers information may result in completely
broken rendering.

Currently trying to use vhost-user-gpu for rendering backend and using
the qemu dbus ui as a ui backend results in a broken framebuffer with
Intel GPUs as the buffer is allocated with a modifier. With this
patchset, that is fixed.


It is tricky to support since it requires to keep compatibility at the
same time with:
(1) build against older virglrenderer which do not provide
virgl_renderer_resource_get_info_ext;
(2) runtime between frontend (qemu) and backend (vhost-user-gpu) due to
increased size and a new field in the VHOST_USER_GPU_DMABUF_SCANOUT
message.

I tried to reach a compromise here by not defining a completely new
message and duplicate VHOST_USER_GPU_DMABUF_SCANOUT but it still feels
like a bit of a hack, so I appreciate feedback if there is a better way
(or naming) to handle it.


Erico Nunes (3):
  docs: vhost-user-gpu: add protocol changes for dmabuf modifiers
  contrib/vhost-user-gpu: add support for sending dmabuf modifiers
  vhost-user-gpu: support dmabuf modifiers

 contrib/vhost-user-gpu/vhost-user-gpu.c |  5 ++-
 contrib/vhost-user-gpu/virgl.c          | 51 +++++++++++++++++++++++--
 contrib/vhost-user-gpu/vugpu.h          |  9 +++++
 docs/interop/vhost-user-gpu.rst         | 26 ++++++++++++-
 hw/display/vhost-user-gpu.c             | 17 ++++++++-
 5 files changed, 102 insertions(+), 6 deletions(-)

-- 
2.40.1


