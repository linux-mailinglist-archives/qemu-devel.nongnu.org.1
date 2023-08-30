Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E3978D63B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:41:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLRe-0008M5-3F; Wed, 30 Aug 2023 09:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbLRb-0008LM-LZ
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:41:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbLRZ-0007qi-FO
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693402872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5p0b5nURlJHXpHEozQMcDhYqdVz2TuCbLq5C4WviENA=;
 b=JlDWY/PKOnC5r7ub1g46Yxo222T9WyIRRMiQwKJh1duCsnBfwtj9Wnd+koQq1GbcxgjBXo
 sb+ULqg2IoR53S23zJqQkPIQIw+1Q7jRfZUUFtRnG8t/Yr4Eg1Q/CyTBgOnYdRtpqy/0TH
 NjaDlTcLIzSPmerINbDLtgyj4Lzy+Ds=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-Qyio8eOdO06T4jcctT7alw-1; Wed, 30 Aug 2023 09:41:11 -0400
X-MC-Unique: Qyio8eOdO06T4jcctT7alw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3391185A793;
 Wed, 30 Aug 2023 13:41:10 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76FFA1121315;
 Wed, 30 Aug 2023 13:41:09 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 6/7] vhost-user: allow "vhost_set_vring" to wait for a reply
Date: Wed, 30 Aug 2023 15:40:54 +0200
Message-Id: <20230830134055.106812-7-lersek@redhat.com>
In-Reply-To: <20230830134055.106812-1-lersek@redhat.com>
References: <20230830134055.106812-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
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

VGhlICJ2aG9zdF9zZXRfdnJpbmciIGZ1bmN0aW9uIGFscmVhZHkgY2VudHJhbGl6ZXMgdGhlIGNv
bW1vbiBwYXJ0cyBvZgoidmhvc3RfdXNlcl9zZXRfdnJpbmdfbnVtIiwgInZob3N0X3VzZXJfc2V0
X3ZyaW5nX2Jhc2UiIGFuZAoidmhvc3RfdXNlcl9zZXRfdnJpbmdfZW5hYmxlIi4gV2UnbGwgd2Fu
dCB0byBhbGxvdyBzb21lIG9mIHRob3NlIGNhbGxlcnMKdG8gd2FpdCBmb3IgYSByZXBseS4KClRo
ZXJlZm9yZSwgcmViYXNlICJ2aG9zdF9zZXRfdnJpbmciIGZyb20ganVzdCAidmhvc3RfdXNlcl93
cml0ZSIgdG8KInZob3N0X3VzZXJfd3JpdGVfc3luYyIsIGV4cG9zaW5nIHRoZSAid2FpdF9mb3Jf
cmVwbHkiIHBhcmFtZXRlci4KClRoaXMgaXMgcHVyZWx5IHJlZmFjdG9yaW5nIC0tIHRoZXJlIGlz
IG5vIG9ic2VydmFibGUgY2hhbmdlLiBUaGF0J3MKYmVjYXVzZToKCi0gYWxsIHRocmVlIGNhbGxl
cnMgcGFzcyBpbiAiZmFsc2UiIGZvciAid2FpdF9mb3JfcmVwbHkiLCB3aGljaCBkaXNhYmxlcwog
IGFsbCBsb2dpYyBpbiAidmhvc3RfdXNlcl93cml0ZV9zeW5jIiBleGNlcHQgdGhlIGNhbGwgdG8K
ICAidmhvc3RfdXNlcl93cml0ZSI7CgotIHRoZSBmZHM9TlVMTCBhbmQgZmRfbnVtPTAgYXJndW1l
bnRzIG9mIHRoZSBvcmlnaW5hbCAidmhvc3RfdXNlcl93cml0ZSIKICBjYWxsIGluc2lkZSAidmhv
c3Rfc2V0X3ZyaW5nIiBhcmUgaGFyZC1jb2RlZCB3aXRoaW4KICAidmhvc3RfdXNlcl93cml0ZV9z
eW5jIi4KCkNjOiAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+IChzdXBwb3J0
ZXI6dmhvc3QpCkNjOiBFdWdlbmlvIFBlcmV6IE1hcnRpbiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4K
Q2M6IEdlcm1hbiBNYWdsaW9uZSA8Z21hZ2xpb25lQHJlZGhhdC5jb20+CkNjOiBMaXUgSmlhbmcg
PGdlcnJ5QGxpbnV4LmFsaWJhYmEuY29tPgpDYzogU2VyZ2lvIExvcGV6IFBhc2N1YWwgPHNscEBy
ZWRoYXQuY29tPgpDYzogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgpT
aWduZWQtb2ZmLWJ5OiBMYXN6bG8gRXJzZWsgPGxlcnNla0ByZWRoYXQuY29tPgpSZXZpZXdlZC1i
eTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPgpSZXZpZXdlZC1i
eTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgotLS0KCk5vdGVzOgog
ICAgdjI6CiAgICAKICAgIC0gcGljayB1cCBSLWIncyBmcm9tIFBoaWwgYW5kIFN0ZWZhbm8KICAg
IAogICAgLSByZW5hbWUgInZob3N0X3VzZXJfd3JpdGVfbXNnIiB0byAidmhvc3RfdXNlcl93cml0
ZV9zeW5jIiAoaW4gY29kZSBhbmQKICAgICAgY29tbWl0IG1lc3NhZ2UpIFtTdGVmYW5vXQoKIGh3
L3ZpcnRpby92aG9zdC11c2VyLmMgfCAxMSArKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhv
c3QtdXNlci5jIGIvaHcvdmlydGlvL3Zob3N0LXVzZXIuYwppbmRleCBjNzliNmY3N2NkY2EuLjE4
ZTE1YTliYjM1OSAxMDA2NDQKLS0tIGEvaHcvdmlydGlvL3Zob3N0LXVzZXIuYworKysgYi9ody92
aXJ0aW8vdmhvc3QtdXNlci5jCkBAIC0xMTcwLDcgKzExNzAsOCBAQCBzdGF0aWMgaW50IHZob3N0
X3VzZXJfd3JpdGVfc3luYyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIFZob3N0VXNlck1zZyAqbXNn
LAogCiBzdGF0aWMgaW50IHZob3N0X3NldF92cmluZyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGludCByZXF1ZXN0LAotICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X3ZyaW5nX3N0YXRlICpyaW5nKQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X3ZyaW5nX3N0YXRlICpyaW5n
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCB3YWl0X2Zvcl9yZXBseSkKIHsKICAg
ICBWaG9zdFVzZXJNc2cgbXNnID0gewogICAgICAgICAuaGRyLnJlcXVlc3QgPSByZXF1ZXN0LApA
QCAtMTE3OSwxMyArMTE4MCwxMyBAQCBzdGF0aWMgaW50IHZob3N0X3NldF92cmluZyhzdHJ1Y3Qg
dmhvc3RfZGV2ICpkZXYsCiAgICAgICAgIC5oZHIuc2l6ZSA9IHNpemVvZihtc2cucGF5bG9hZC5z
dGF0ZSksCiAgICAgfTsKIAotICAgIHJldHVybiB2aG9zdF91c2VyX3dyaXRlKGRldiwgJm1zZywg
TlVMTCwgMCk7CisgICAgcmV0dXJuIHZob3N0X3VzZXJfd3JpdGVfc3luYyhkZXYsICZtc2csIHdh
aXRfZm9yX3JlcGx5KTsKIH0KIAogc3RhdGljIGludCB2aG9zdF91c2VyX3NldF92cmluZ19udW0o
c3RydWN0IHZob3N0X2RldiAqZGV2LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IHZob3N0X3ZyaW5nX3N0YXRlICpyaW5nKQogewotICAgIHJldHVybiB2aG9zdF9z
ZXRfdnJpbmcoZGV2LCBWSE9TVF9VU0VSX1NFVF9WUklOR19OVU0sIHJpbmcpOworICAgIHJldHVy
biB2aG9zdF9zZXRfdnJpbmcoZGV2LCBWSE9TVF9VU0VSX1NFVF9WUklOR19OVU0sIHJpbmcsIGZh
bHNlKTsKIH0KIAogc3RhdGljIHZvaWQgdmhvc3RfdXNlcl9ob3N0X25vdGlmaWVyX2ZyZWUoVmhv
c3RVc2VySG9zdE5vdGlmaWVyICpuKQpAQCAtMTIxNiw3ICsxMjE3LDcgQEAgc3RhdGljIHZvaWQg
dmhvc3RfdXNlcl9ob3N0X25vdGlmaWVyX3JlbW92ZShWaG9zdFVzZXJIb3N0Tm90aWZpZXIgKm4s
CiBzdGF0aWMgaW50IHZob3N0X3VzZXJfc2V0X3ZyaW5nX2Jhc2Uoc3RydWN0IHZob3N0X2RldiAq
ZGV2LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF92
cmluZ19zdGF0ZSAqcmluZykKIHsKLSAgICByZXR1cm4gdmhvc3Rfc2V0X3ZyaW5nKGRldiwgVkhP
U1RfVVNFUl9TRVRfVlJJTkdfQkFTRSwgcmluZyk7CisgICAgcmV0dXJuIHZob3N0X3NldF92cmlu
ZyhkZXYsIFZIT1NUX1VTRVJfU0VUX1ZSSU5HX0JBU0UsIHJpbmcsIGZhbHNlKTsKIH0KIAogc3Rh
dGljIGludCB2aG9zdF91c2VyX3NldF92cmluZ19lbmFibGUoc3RydWN0IHZob3N0X2RldiAqZGV2
LCBpbnQgZW5hYmxlKQpAQCAtMTIzNCw3ICsxMjM1LDcgQEAgc3RhdGljIGludCB2aG9zdF91c2Vy
X3NldF92cmluZ19lbmFibGUoc3RydWN0IHZob3N0X2RldiAqZGV2LCBpbnQgZW5hYmxlKQogICAg
ICAgICAgICAgLm51bSAgID0gZW5hYmxlLAogICAgICAgICB9OwogCi0gICAgICAgIHJldCA9IHZo
b3N0X3NldF92cmluZyhkZXYsIFZIT1NUX1VTRVJfU0VUX1ZSSU5HX0VOQUJMRSwgJnN0YXRlKTsK
KyAgICAgICAgcmV0ID0gdmhvc3Rfc2V0X3ZyaW5nKGRldiwgVkhPU1RfVVNFUl9TRVRfVlJJTkdf
RU5BQkxFLCAmc3RhdGUsIGZhbHNlKTsKICAgICAgICAgaWYgKHJldCA8IDApIHsKICAgICAgICAg
ICAgIC8qCiAgICAgICAgICAgICAgKiBSZXN0b3JpbmcgdGhlIHByZXZpb3VzIHN0YXRlIGlzIGxp
a2VseSBpbmZlYXNpYmxlLCBhcyB3ZWxsIGFzCgo=


