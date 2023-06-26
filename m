Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C485C73DF54
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:35:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlP4-00086i-78; Mon, 26 Jun 2023 08:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlN7-00063d-3p
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlMX-0003eo-Fr
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MfTq664tRB0XDVL6rfL33AvwxgaTAAG2vIPXXYsJwuY=;
 b=iB7XZWaxfpCIC20YmqucYb3xirafvqQfCPcjYxQzqpniGt1xmLoywSXSPW1wIvg8DpQWM2
 k+UMmM1SsMpLH+OmL3PUjptmnAnIPJDHNM7OR6mcnHUYddZMEZRKFfiqQZGs/bGWVhU8lZ
 Mq7vSxnEO2eJzYflWdsdWkgzzhyyUVA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-et-ELGxhOtG4l6PVzi19bw-1; Mon, 26 Jun 2023 08:30:31 -0400
X-MC-Unique: et-ELGxhOtG4l6PVzi19bw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f9b8c230f5so13106525e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782630; x=1690374630;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MfTq664tRB0XDVL6rfL33AvwxgaTAAG2vIPXXYsJwuY=;
 b=LANqjrLp0cGOEUc9wha4hXPIqTB4XClITnhDReOwe3xp+O8emHxX2LWDlMhHNPeHFb
 TB4YdMQ1yHgbD8qNYoN3bZheOhqEKXq9euwRoCStYIikhDJIMppBBkWMVcGMLj6c2WQ6
 qAWbYbmBh+ta0Z4B+UsdkCcEewdNi5Yii4LjpN22xNs54Zm9wNP0YhwIp1XHbbJbxs8T
 cao5/KGbIN9bnIF9+seoN9DrtYixhTS6OpB6Z+W7vr9x1N7ETf6PmPrykUyUP7WHZUOq
 M18HXrs152M6xEnuw6E78+0UGnY+t4/T1VZOpsFh04OO6bjbSlW7jhYEgbiRVV7roawr
 RCMA==
X-Gm-Message-State: AC+VfDyQ6l9+WPVnjAOnlfnYkYt6leuARl9mFbCF8hBWQHTOlnxyE/KB
 /JTlBxj0QDrH4u2UKBPfUq1hGY702wf2GfSEhhkQyS6OITTikP3IoVEs11Cror7AYKOiZ9f6Z+M
 oJggGFAo+JnYFWgRRmW8jQbt3BYzsa0C0LiH/9LmlRTHwjhUzDiiJpw0JFQ8lGszwR1ML
X-Received: by 2002:a05:600c:2054:b0:3fb:973:fdba with SMTP id
 p20-20020a05600c205400b003fb0973fdbamr832632wmg.31.1687782629886; 
 Mon, 26 Jun 2023 05:30:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zlzT7rY2Ldb/qpiQYWXjDADGuVI508JSgE89n+Who07mFzNZyaRQCqbsd/+Ne0nduWb1JpQ==
X-Received: by 2002:a05:600c:2054:b0:3fb:973:fdba with SMTP id
 p20-20020a05600c205400b003fb0973fdbamr832616wmg.31.1687782629590; 
 Mon, 26 Jun 2023 05:30:29 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 m19-20020a7bce13000000b003f41bb52834sm10466606wmc.38.2023.06.26.05.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:30:29 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:30:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, imammedo@redhat.com,
 jusual@redhat.com, mst@redhat.com, Jason Wang <jasowang@redhat.com>
Subject: [PULL 53/53] vhost-vdpa: do not cleanup the vdpa/vhost-net
 structures if peer nic is present
Message-ID: <3d90d47995b83bd1edf6e756c00e74fd5ec16aee.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Ani Sinha <anisinha@redhat.com>

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
Fixes: CVE-2023-3301
Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Message-Id: <20230619065209.442185-1-anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 9e92b3558c..e19ab063fa 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -207,6 +207,14 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
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
     munmap(s->cvq_cmd_out_buffer, vhost_vdpa_net_cvq_cmd_page_len());
     munmap(s->status, vhost_vdpa_net_cvq_cmd_page_len());
     if (s->vhost_net) {
-- 
MST


