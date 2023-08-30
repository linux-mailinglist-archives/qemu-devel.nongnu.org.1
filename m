Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC28578D637
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:41:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLRT-0008EU-3k; Wed, 30 Aug 2023 09:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbLRR-0008CU-5V
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:41:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbLRP-0007pB-2X
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693402862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dAiBNQ4x0WuXIAu2+bbjdgMkz3IXssOxBpt9Y4diNsM=;
 b=HkFY3XJzetBkGqqmiIxByLI5d5CnLyH9ApwJ7bReKcxCxJLy5BO1TLLNe+CTKmBo2Al4Xd
 0l8JBYRLzfbWHW1EbS6+IZaEKJWnm2s9Opo5XChgow4e2aFOgU3cBHptBoSynaQKkekPUJ
 +sOfkM93fdqqChIN1YRmDV4wYAB/O/Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-yrsOX4YBPh-OB3VpgXhx8A-1; Wed, 30 Aug 2023 09:41:00 -0400
X-MC-Unique: yrsOX4YBPh-OB3VpgXhx8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8532A185A793;
 Wed, 30 Aug 2023 13:41:00 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15DE5112131B;
 Wed, 30 Aug 2023 13:40:58 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 1/7] vhost-user: strip superfluous whitespace
Date: Wed, 30 Aug 2023 15:40:49 +0200
Message-Id: <20230830134055.106812-2-lersek@redhat.com>
In-Reply-To: <20230830134055.106812-1-lersek@redhat.com>
References: <20230830134055.106812-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Q2M6ICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNvbT4gKHN1cHBvcnRlcjp2aG9z
dCkKQ2M6IEV1Z2VuaW8gUGVyZXogTWFydGluIDxlcGVyZXptYUByZWRoYXQuY29tPgpDYzogR2Vy
bWFuIE1hZ2xpb25lIDxnbWFnbGlvbmVAcmVkaGF0LmNvbT4KQ2M6IExpdSBKaWFuZyA8Z2VycnlA
bGludXguYWxpYmFiYS5jb20+CkNjOiBTZXJnaW8gTG9wZXogUGFzY3VhbCA8c2xwQHJlZGhhdC5j
b20+CkNjOiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+ClNpZ25lZC1v
ZmYtYnk6IExhc3psbyBFcnNlayA8bGVyc2VrQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBTdGVm
YW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Ci0tLQoKTm90ZXM6CiAgICB2MjoK
ICAgIAogICAgLSBwaWNrIHVwIFN0ZWZhbm8ncyBSLWIKCiBody92aXJ0aW8vdmhvc3QtdXNlci5j
IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXVzZXIuYyBiL2h3L3ZpcnRpby92aG9zdC11c2Vy
LmMKaW5kZXggOGRjZjA0OWQ0MjJiLi5iNGI2NzdjMWNlNjYgMTAwNjQ0Ci0tLSBhL2h3L3ZpcnRp
by92aG9zdC11c2VyLmMKKysrIGIvaHcvdmlydGlvL3Zob3N0LXVzZXIuYwpAQCAtMzk4LDcgKzM5
OCw3IEBAIHN0YXRpYyBpbnQgdmhvc3RfdXNlcl93cml0ZShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYs
IFZob3N0VXNlck1zZyAqbXNnLAogICAgICAqIG9wZXJhdGlvbnMgc3VjaCBhcyBjb25maWd1cmlu
ZyBkZXZpY2UgbWVtb3J5IG1hcHBpbmdzIG9yIGlzc3VpbmcgZGV2aWNlCiAgICAgICogcmVzZXRz
LCB3aGljaCBhZmZlY3QgdGhlIHdob2xlIGRldmljZSBpbnN0ZWFkIG9mIGluZGl2aWR1YWwgVlFz
LAogICAgICAqIHZob3N0LXVzZXIgbWVzc2FnZXMgc2hvdWxkIG9ubHkgYmUgc2VudCBvbmNlLgot
ICAgICAqIAorICAgICAqCiAgICAgICogRGV2aWNlcyB3aXRoIG11bHRpcGxlIHZob3N0X2RldnMg
YXJlIGdpdmVuIGFuIGFzc29jaWF0ZWQgZGV2LT52cV9pbmRleAogICAgICAqIHNvIHBlcl9kZXZp
Y2UgcmVxdWVzdHMgYXJlIG9ubHkgc2VudCBpZiB2cV9pbmRleCBpcyAwLgogICAgICAqLwoK


