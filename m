Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 095C9734BE4
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 08:53:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB8kg-0007LM-3T; Mon, 19 Jun 2023 02:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qB8kd-0007L1-KS
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 02:52:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qB8kb-0002XG-6Y
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 02:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687157552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5m2P3wcvvjG8v5suCZN3jqQeQerTlx7tlf8rrtXx3Rc=;
 b=eU3h9tciY3XQ+/cobz7K0hTbTwZ7PosTVsiUl1MvIxxyjB7h1Nw+4W3nxgs9zZb2AWTEDs
 XBdxR686WAe7PCnZvnzsQ2WbqndqBgotsIAwstYRG2CENUBw5yCLuphyr9LL8imdgXWViv
 N3yK5YiTSh9vchuWJWXsCvyezy3JnIY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-zYN453lsNlmuYgGYvvkJXQ-1; Mon, 19 Jun 2023 02:52:30 -0400
X-MC-Unique: zYN453lsNlmuYgGYvvkJXQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-260a18f1b43so144232a91.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 23:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687157549; x=1689749549;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5m2P3wcvvjG8v5suCZN3jqQeQerTlx7tlf8rrtXx3Rc=;
 b=C1LquAU8njSR+aBi9LBH+ZevB874PYjNGYUFdJanPrY9bLF7mgpIOACi1IDbnDCkTe
 Lp+Cc28QjUaKH8zxc7EdPpojiC3G9+Vb2KQF52BIZlB9ezSOhJCnDcPsNRtXDRUVmJb9
 7D9P3GOyu1RbtNht0Rip/Ih0SbM0k5V830H4zznbgSYNOqw2MbzAN9PFQ/26Q/YErCkL
 8X8T2UI+VviIfD00cLI6L+SfwVl6QjdwV6prVopCZLJ1o/TasboDWMZrDYG30nVxEWBW
 aMjI8IICKkvIg0cZVzpH7bpAy7PZHfq9HqfyQ8rVBeKPUYy3eGDvhM4JDJvl11izHoVh
 azbA==
X-Gm-Message-State: AC+VfDxIWMe6dJa+3EAelY37RYtysNyO5hhnyWWFXKgsfV02BqRZ9txu
 BvCrEFXE3Mw5rmHw/L5Djy/q17eUZeHcf1XscQeUto8NMOFqh1fIXe9vneO17UEJn67bBFS9Spr
 1BeaiqLrA+k7+hjY=
X-Received: by 2002:a17:90b:1643:b0:256:5174:f58b with SMTP id
 il3-20020a17090b164300b002565174f58bmr4338141pjb.46.1687157548978; 
 Sun, 18 Jun 2023 23:52:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7TU0Z80Gy5B/+fNv+VaHcu4nfLhXjrGFUF3IwiXlfM/KkvUL8jtKS6Lziu8+G7WUCPK7KxIQ==
X-Received: by 2002:a17:90b:1643:b0:256:5174:f58b with SMTP id
 il3-20020a17090b164300b002565174f58bmr4338133pjb.46.1687157548623; 
 Sun, 18 Jun 2023 23:52:28 -0700 (PDT)
Received: from localhost.localdomain ([115.96.121.2])
 by smtp.googlemail.com with ESMTPSA id
 qa2-20020a17090b4fc200b0025bf0d7c186sm4895501pjb.29.2023.06.18.23.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jun 2023 23:52:28 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, imammedo@redhat.com, jusual@redhat.com,
 mst@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH] vhost-vdpa: do not cleanup the vdpa/vhost-net structures if
 peer nic is present
Date: Mon, 19 Jun 2023 12:22:09 +0530
Message-Id: <20230619065209.442185-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

When a peer nic is still attached to the vdpa backend, it is too early to free
up the vhost-net and vdpa structures. If these structures are freed here, then
QEMU crashes when the guest is being shut down. The following call chain
would result in an assertion failure since the pointer returned from
vhost_vdpa_get_vhost_net() would be NULL:

do_vm_stop() -> vm_state_notify() -> virtio_set_status() ->
virtio_net_vhost_status() -> get_vhost_net().

Therefore, we defer freeing up the structures until at guest shutdown
time when qemu_cleanup() calls net_cleanup() which then calls
qemu_del_net_client() which would eventually call vhost_vdpa_cleanup()
again to free up the structures. This time, the loop in net_cleanup()
ensures that vhost_vdpa_cleanup() will be called one last time when
all the peer nics are detached and freed.

All unit tests pass with this change.

CC: imammedo@redhat.com
CC: jusual@redhat.com
CC: mst@redhat.com

Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 net/vhost-vdpa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 37cdc84562..ef9dd0afdb 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -185,6 +185,14 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
 
+    /*
+     * If a peer NIC is attached, do not cleanup anything.
+     * Cleanup will happen as a part of qemu_cleanup() -> net_cleanup()
+     * when the guest is shutting down.
+     */
+    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_NIC) {
+        return;
+    }
     qemu_vfree(s->cvq_cmd_out_buffer);
     qemu_vfree(s->status);
     if (s->vhost_net) {
-- 
2.39.1


