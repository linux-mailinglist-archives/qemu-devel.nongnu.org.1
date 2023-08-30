Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2D278D635
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:41:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLRR-0008CL-Fc; Wed, 30 Aug 2023 09:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbLRQ-0008C6-8c
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:41:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbLRN-0007os-Oq
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693402861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ef+vN8hHtxcX68UE8weV3Ql/OCwiPUonisa6+grW5lw=;
 b=UpeL1EZ/xSop/YaBiUcUimPlKVyei0TQfrKUiwJX8YCgbBfCJHzM6vtAf69r83kPQR1HiS
 E3fUNvclCEdi5zhJo27+hK7nRWoaUuJLKTiM3b2B1q1oPvycYIqAs7ahr9EbH6oIk4PP3c
 VQ+Xcwzlf8bxRs/I6bGNyfTls8BEnTM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-EeRa4a-iNRivW-yZqKVHlg-1; Wed, 30 Aug 2023 09:40:59 -0400
X-MC-Unique: EeRa4a-iNRivW-yZqKVHlg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8D60856DED;
 Wed, 30 Aug 2023 13:40:58 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3658D1121315;
 Wed, 30 Aug 2023 13:40:57 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 0/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Date: Wed, 30 Aug 2023 15:40:48 +0200
Message-Id: <20230830134055.106812-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

djE6CgotIGh0dHA6Ly9taWQubWFpbC1hcmNoaXZlLmNvbS8yMDIzMDgyNzE4MjkzNy4xNDY0NTAt
MS1sZXJzZWtAcmVkaGF0LmNvbQotIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVj
dC9xZW11LWRldmVsL2NvdmVyLzIwMjMwODI3MTgyOTM3LjE0NjQ1MC0xLWxlcnNla0ByZWRoYXQu
Y29tLwoKdjIgcGlja3MgdXAgdGFncyBmcm9tIFBoaWwgYW5kIFN0ZWZhbm8sIGFuZCBhZGRyZXNz
ZXMgZmVlZGJhY2sgZnJvbQpTdGVmYW5vLiBQbGVhc2Ugc2VlIHRoZSBOb3RlcyBzZWN0aW9uIG9u
IGVhY2ggcGF0Y2gsIGZvciB0aGUgdjIgY2hhbmdlcy4KCkkndmUgbm90IENDJ2QgdGhlIHN0YWJs
ZSBsaXN0LCBhcyB3ZSd2ZSBub3QgZmlndXJlZCBvdXQgd2hhdCBwcmlvcgpyZWxlYXNlcyB0byB0
YXJnZXQuIEFwcGx5aW5nIHRoZSBzZXJpZXMgdG8gOC4xIGlzIGVhc3k7IHRvIDguMCAtLSBub3Qg
c28KbXVjaC4KClJldGVzdGVkLgoKQ2M6ICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0
LmNvbT4gKHN1cHBvcnRlcjp2aG9zdCkKQ2M6IEV1Z2VuaW8gUGVyZXogTWFydGluIDxlcGVyZXpt
YUByZWRoYXQuY29tPgpDYzogR2VybWFuIE1hZ2xpb25lIDxnbWFnbGlvbmVAcmVkaGF0LmNvbT4K
Q2M6IExpdSBKaWFuZyA8Z2VycnlAbGludXguYWxpYmFiYS5jb20+CkNjOiBTZXJnaW8gTG9wZXog
UGFzY3VhbCA8c2xwQHJlZGhhdC5jb20+CkNjOiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJl
QHJlZGhhdC5jb20+CgpUaGFua3MsCkxhc3psbwoKTGFzemxvIEVyc2VrICg3KToKICB2aG9zdC11
c2VyOiBzdHJpcCBzdXBlcmZsdW91cyB3aGl0ZXNwYWNlCiAgdmhvc3QtdXNlcjogdGlnaHRlbiAi
cmVwbHlfc3VwcG9ydGVkIiBzY29wZSBpbiAic2V0X3ZyaW5nX2FkZHIiCiAgdmhvc3QtdXNlcjog
ZmFjdG9yIG91dCAidmhvc3RfdXNlcl93cml0ZV9zeW5jIgogIHZob3N0LXVzZXI6IGZsYXR0ZW4g
ImVuZm9yY2VfcmVwbHkiIGludG8gInZob3N0X3VzZXJfd3JpdGVfc3luYyIKICB2aG9zdC11c2Vy
OiBob2lzdCAid3JpdGVfc3luYyIsICJnZXRfZmVhdHVyZXMiLCAiZ2V0X3U2NCIKICB2aG9zdC11
c2VyOiBhbGxvdyAidmhvc3Rfc2V0X3ZyaW5nIiB0byB3YWl0IGZvciBhIHJlcGx5CiAgdmhvc3Qt
dXNlcjogY2FsbCBWSE9TVF9VU0VSX1NFVF9WUklOR19FTkFCTEUgc3luY2hyb25vdXNseQoKIGh3
L3ZpcnRpby92aG9zdC11c2VyLmMgfCAyMTYgKysrKysrKysrKy0tLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAxMDggaW5zZXJ0aW9ucygrKSwgMTA4IGRlbGV0aW9ucygtKQoKCmJhc2UtY29tbWl0
OiA4MTNiYWMzZDhkNzBkODVjYjc4MzVmNzk0NWViOWVlZDg0YzJkOGQwCg==


