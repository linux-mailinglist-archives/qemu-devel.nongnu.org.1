Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 705507A44CB
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:33:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9hP-0007z8-Fd; Mon, 18 Sep 2023 04:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qi9gK-0006ML-7H
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:32:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qi9gF-0004Ev-BQ
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695025949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r4OySs/MlLnhS4aHMYzmzTaVrGn4YZ/1dItiYGgCXgg=;
 b=DWxBeGIcLpduop4V8vC2A4CDQjRBnYyy3ZE1UnSuzS4PeUdnsaBjbAiZgGcSo5tW611c6i
 QMvwR3O5+L5Xvt86+aAPzbB8wnWPsK7YnwLHb/gikibBXsICxK0ISMfb8QyM8eyHNVVd90
 EE22eO9qLINKF+ImvZJC0KsB6ilBx0M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-7YkuCCHPP2CSqpJKk4sd0A-1; Mon, 18 Sep 2023 04:32:25 -0400
X-MC-Unique: 7YkuCCHPP2CSqpJKk4sd0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B4C23806706;
 Mon, 18 Sep 2023 08:32:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78D8C2156701;
 Mon, 18 Sep 2023 08:32:23 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL V2 17/17] net/tap: Avoid variable-length array
Date: Mon, 18 Sep 2023 16:31:32 +0800
Message-Id: <20230918083132.55423-18-jasowang@redhat.com>
In-Reply-To: <20230918083132.55423-1-jasowang@redhat.com>
References: <20230918083132.55423-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

From: Peter Maydell <peter.maydell@linaro.org>

Use a heap allocation instead of a variable length array in
tap_receive_iov().

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tap.c b/net/tap.c
index bcea8d0..c23d032 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -118,10 +118,11 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
     const struct iovec *iovp = iov;
-    struct iovec iov_copy[iovcnt + 1];
+    g_autofree struct iovec *iov_copy = NULL;
     struct virtio_net_hdr_mrg_rxbuf hdr = { };
 
     if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
+        iov_copy = g_new(struct iovec, iovcnt + 1);
         iov_copy[0].iov_base = &hdr;
         iov_copy[0].iov_len =  s->host_vnet_hdr_len;
         memcpy(&iov_copy[1], iov, iovcnt * sizeof(*iov));
-- 
2.7.4


