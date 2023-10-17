Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 281BA7CC743
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:18:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qslpT-0006Ir-48; Tue, 17 Oct 2023 11:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qslpP-0006HC-8w
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qslpN-0004sw-PA
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697555869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ijBH2yebat/L/G7HXKYN85MnLnvuPghx1D7FJzbKYwE=;
 b=BJKA/gj/nVnkHt6Mhx/LWrsMPRah9FXhoTq558dDWzrkqbC/IgSaZetgFnpcqli1thilzv
 XqBQV+61aZp1YaQTTMxTXshTeNRNQQFe5dDbDyrQMZGPEqRj+M8QjiTq3yu6+YZ0nyv6ys
 WUmtHnC668OnIGDQv/ESWhmN44hTxBQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-180-uIBlHonSMUyZpNNCqY_j3Q-1; Tue, 17 Oct 2023 11:17:42 -0400
X-MC-Unique: uIBlHonSMUyZpNNCqY_j3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EC6A1C05B1C;
 Tue, 17 Oct 2023 15:17:42 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 24BBC40C6F79;
 Tue, 17 Oct 2023 15:17:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Jason Wang <jasowang@redhat.com>
Cc: qemu-trivial@nongnu.org, Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: [PATCH] MAINTAINERS: Add docs/devel/ebpf_rss.rst to the EBPF section
Date: Tue, 17 Oct 2023 17:17:40 +0200
Message-ID: <20231017151740.213679-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This doc file obviously belongs to the EBPF section.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 836d8e347c..04e1ddfc49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3942,6 +3942,7 @@ M: Jason Wang <jasowang@redhat.com>
 R: Andrew Melnychenko <andrew@daynix.com>
 R: Yuri Benditovich <yuri.benditovich@daynix.com>
 S: Maintained
+F: docs/devel/ebpf_rss.rst
 F: ebpf/*
 F: tools/ebpf/*
 
-- 
2.41.0


