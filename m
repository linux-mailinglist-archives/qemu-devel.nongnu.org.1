Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FDB70D535
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:36:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MYp-0007kf-EB; Tue, 23 May 2023 03:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MYI-0005Yt-Be
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:35:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MYF-0004k6-NM
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WpRqpPzJbKKJ90wTcylXZKboou+iQEtaWeBrXtENhe0=;
 b=NyGHbqfPOB2PWrOmv7HuRAZdrA+R+9YgRoZnN0j+K4g1fY95FDZgauQM6mzoFQHxtKf5WC
 50DkmH6bMnIj9jhuaz+NYmQntigEpLOl7oq2pdpJ3nG6ECRJovkGsaBnztoFo1wPqvCQ8P
 Qxz7LRdvSaHmgIf6+sLSrvF1qlh44wE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-Q534aJtzNbeNLy0zZe1ZRA-1; Tue, 23 May 2023 03:35:10 -0400
X-MC-Unique: Q534aJtzNbeNLy0zZe1ZRA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EA3E8032EF;
 Tue, 23 May 2023 07:35:10 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17BFF2166B25;
 Tue, 23 May 2023 07:35:07 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 49/50] docs/system/devices/igb: Note igb is tested for DPDK
Date: Tue, 23 May 2023 15:32:37 +0800
Message-Id: <20230523073238.54236-50-jasowang@redhat.com>
In-Reply-To: <20230523073238.54236-1-jasowang@redhat.com>
References: <20230523073238.54236-1-jasowang@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 docs/system/devices/igb.rst | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/docs/system/devices/igb.rst b/docs/system/devices/igb.rst
index 07d95dd..04e79df 100644
--- a/docs/system/devices/igb.rst
+++ b/docs/system/devices/igb.rst
@@ -14,7 +14,8 @@ Limitations
 ===========
 
 This igb implementation was tested with Linux Test Project [2]_ and Windows HLK
-[3]_ during the initial development. The command used when testing with LTP is:
+[3]_ during the initial development. Later it was also tested with DPDK Test
+Suite [4]_. The command used when testing with LTP is:
 
 .. code-block:: shell
 
@@ -22,8 +23,8 @@ This igb implementation was tested with Linux Test Project [2]_ and Windows HLK
 
 Be aware that this implementation lacks many functionalities available with the
 actual hardware, and you may experience various failures if you try to use it
-with a different operating system other than Linux and Windows or if you try
-functionalities not covered by the tests.
+with a different operating system other than DPDK, Linux, and Windows or if you
+try functionalities not covered by the tests.
 
 Using igb
 =========
@@ -32,7 +33,7 @@ Using igb should be nothing different from using another network device. See
 :ref:`Network_emulation` in general.
 
 However, you may also need to perform additional steps to activate SR-IOV
-feature on your guest. For Linux, refer to [4]_.
+feature on your guest. For Linux, refer to [5]_.
 
 Developing igb
 ==============
@@ -68,4 +69,5 @@ References
 .. [1] https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/82576eb-gigabit-ethernet-controller-datasheet.pdf
 .. [2] https://github.com/linux-test-project/ltp
 .. [3] https://learn.microsoft.com/en-us/windows-hardware/test/hlk/
-.. [4] https://docs.kernel.org/PCI/pci-iov-howto.html
+.. [4] https://doc.dpdk.org/dts/gsg/
+.. [5] https://docs.kernel.org/PCI/pci-iov-howto.html
-- 
2.7.4


