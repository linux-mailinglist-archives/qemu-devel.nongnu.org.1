Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1312F78A0FB
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 20:30:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaKWE-000707-Tt; Sun, 27 Aug 2023 14:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qaKWC-0006zJ-Cf
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 14:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qaKW9-0004Xq-TD
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 14:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693160984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HkQAWdb6Mx3Xv/DY+8HeqrKfNXKX8GSHRCU9gcglP+k=;
 b=IR27bOwtB6YaIJISoaui2ZRaZep+PB0B7gXuMYJeLse6U7bjHn5PV3V+XuLzFi+5XnTHtM
 3BriRCnrNqcEHFe8KFcLgpyw9yjOH85LD3yDSKu8QH618mLELvN5PdYwDUX3L/Yo/5qO7z
 sFQX0bnIqV0I4w20jSjq0GlVhGeXewo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-HfFdsVS5NfaBQNiLvnLKiA-1; Sun, 27 Aug 2023 14:29:43 -0400
X-MC-Unique: HfFdsVS5NfaBQNiLvnLKiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5AB6101A528;
 Sun, 27 Aug 2023 18:29:42 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5487A140E950;
 Sun, 27 Aug 2023 18:29:41 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 1/7] vhost-user: strip superfluous whitespace
Date: Sun, 27 Aug 2023 20:29:31 +0200
Message-Id: <20230827182937.146450-2-lersek@redhat.com>
In-Reply-To: <20230827182937.146450-1-lersek@redhat.com>
References: <20230827182937.146450-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
ZmYtYnk6IExhc3psbyBFcnNlayA8bGVyc2VrQHJlZGhhdC5jb20+Ci0tLQogaHcvdmlydGlvL3Zo
b3N0LXVzZXIuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC11c2VyLmMgYi9ody92aXJ0aW8v
dmhvc3QtdXNlci5jCmluZGV4IDhkY2YwNDlkNDIyYi4uYjRiNjc3YzFjZTY2IDEwMDY0NAotLS0g
YS9ody92aXJ0aW8vdmhvc3QtdXNlci5jCisrKyBiL2h3L3ZpcnRpby92aG9zdC11c2VyLmMKQEAg
LTM5OCw3ICszOTgsNyBAQCBzdGF0aWMgaW50IHZob3N0X3VzZXJfd3JpdGUoc3RydWN0IHZob3N0
X2RldiAqZGV2LCBWaG9zdFVzZXJNc2cgKm1zZywKICAgICAgKiBvcGVyYXRpb25zIHN1Y2ggYXMg
Y29uZmlndXJpbmcgZGV2aWNlIG1lbW9yeSBtYXBwaW5ncyBvciBpc3N1aW5nIGRldmljZQogICAg
ICAqIHJlc2V0cywgd2hpY2ggYWZmZWN0IHRoZSB3aG9sZSBkZXZpY2UgaW5zdGVhZCBvZiBpbmRp
dmlkdWFsIFZRcywKICAgICAgKiB2aG9zdC11c2VyIG1lc3NhZ2VzIHNob3VsZCBvbmx5IGJlIHNl
bnQgb25jZS4KLSAgICAgKiAKKyAgICAgKgogICAgICAqIERldmljZXMgd2l0aCBtdWx0aXBsZSB2
aG9zdF9kZXZzIGFyZSBnaXZlbiBhbiBhc3NvY2lhdGVkIGRldi0+dnFfaW5kZXgKICAgICAgKiBz
byBwZXJfZGV2aWNlIHJlcXVlc3RzIGFyZSBvbmx5IHNlbnQgaWYgdnFfaW5kZXggaXMgMC4KICAg
ICAgKi8KCg==


