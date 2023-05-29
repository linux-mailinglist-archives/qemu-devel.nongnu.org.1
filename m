Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B745D7148C4
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 13:42:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3bGH-0000sS-OR; Mon, 29 May 2023 07:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1q3bFt-0000oz-O7
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:41:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1q3bFr-0002XT-54
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685360496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cxlvG+SKp/TJYyFvWUE7GPgQpUVIg7esatFIfNNbTyE=;
 b=D987wU1oEu8kyhJ031cfxYyR0Y6MZszrey89GWPU4ATJzhAbY/3OLaHeXkQIJDbQQusyl7
 TX3hzpU34F8cxrzroSCiXUL6wYca4txNYWh7TWvq7u66h0e8XnX5i6x/FF3CA6OtPyhp+D
 1nC6tB9noQRb4HD4rpRMOtr+O7EwJhw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-06__D_nNN9ihecOOvw6SBw-1; Mon, 29 May 2023 07:41:35 -0400
X-MC-Unique: 06__D_nNN9ihecOOvw6SBw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFEC28007D9;
 Mon, 29 May 2023 11:41:34 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.17.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B54035443;
 Mon, 29 May 2023 11:41:32 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Michael S Tsirkin <mst@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v2 1/2] vhost: release memory_listener object in error path
Date: Mon, 29 May 2023 17:13:32 +0530
Message-Id: <20230529114333.31686-2-ppandit@redhat.com>
In-Reply-To: <20230529114333.31686-1-ppandit@redhat.com>
References: <20230529114333.31686-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

vhost_dev_start function does not release memory_listener object
in case of an error. This may crash the guest when vhost is unable
to set memory table:

  stack trace of thread 125653:
  Program terminated with signal SIGSEGV, Segmentation fault
  #0  memory_listener_register (qemu-kvm + 0x6cda0f)
  #1  vhost_dev_start (qemu-kvm + 0x699301)
  #2  vhost_net_start (qemu-kvm + 0x45b03f)
  #3  virtio_net_set_status (qemu-kvm + 0x665672)
  #4  qmp_set_link (qemu-kvm + 0x548fd5)
  #5  net_vhost_user_event (qemu-kvm + 0x552c45)
  #6  tcp_chr_connect (qemu-kvm + 0x88d473)
  #7  tcp_chr_new_client (qemu-kvm + 0x88cf83)
  #8  tcp_chr_accept (qemu-kvm + 0x88b429)
  #9  qio_net_listener_channel_func (qemu-kvm + 0x7ac07c)
  #10 g_main_context_dispatch (libglib-2.0.so.0 + 0x54e2f)

Release memory_listener objects in the error path.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 hw/virtio/vhost.c | 3 +++
 1 file changed, 3 insertions(+)

v2: split a single patch into two. Mention about vhost set mem table failure
resulting in guest crash.

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 23da579ce2..6be4a0626a 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2004,6 +2004,9 @@ fail_vq:
     }

 fail_mem:
+    if (vhost_dev_has_iommu(hdev)) {
+        memory_listener_unregister(&hdev->iommu_listener);
+    }
 fail_features:
     vdev->vhost_started = false;
     hdev->started = false;
--
2.40.1


