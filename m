Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 564E97B5C23
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 22:34:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnPb0-0003UL-Nv; Mon, 02 Oct 2023 16:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnPaz-0003U7-8J
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 16:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnPax-0001VS-M3
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 16:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696278767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0nYH5tmHEHaZsrcQqH9kYvHwI5zmEvvxHuX9nbtNjjc=;
 b=PlEQaCwPD3fKfswNiV7BqRotZ5vV5gB/io282AjwetvotjYlQxava3/tmhDsSoPqs+iE/0
 NvrwX6jRrMfuEWnQW8wCgMmJqablV4SjXi4Tm7IniuN2qcHY9Dwp7UzMBSRkjiDacf3RcV
 dvSQwMaXiRqLLzz1g1t6TuK6r9oWAew=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-vVKI9Q89OCuKwNlecfAj4A-1; Mon, 02 Oct 2023 16:32:45 -0400
X-MC-Unique: vVKI9Q89OCuKwNlecfAj4A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 077B0101A590;
 Mon,  2 Oct 2023 20:32:45 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA35D40C6EBF;
 Mon,  2 Oct 2023 20:32:42 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 6/7] vhost-user: allow "vhost_set_vring" to wait for a reply
Date: Mon,  2 Oct 2023 22:32:20 +0200
Message-Id: <20231002203221.17241-7-lersek@redhat.com>
In-Reply-To: <20231002203221.17241-1-lersek@redhat.com>
References: <20231002203221.17241-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
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
eTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgpUZXN0ZWQtYnk6IEFs
YmVydCBFc3RldmUgPGFlc3RldmVAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IEV1Z2VuaW8gUMOp
cmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgotLS0KCk5vdGVzOgogICAgdjM6CiAgICAKICAgIC0g
cGljayB1cCBSLWIgZnJvbSBFdWdlbmlvLCBULWIgZnJvbSBBbGJlcnQKICAgIAogICAgdjI6CiAg
ICAKICAgIC0gcGljayB1cCBSLWIncyBmcm9tIFBoaWwgYW5kIFN0ZWZhbm8KICAgIAogICAgLSBy
ZW5hbWUgInZob3N0X3VzZXJfd3JpdGVfbXNnIiB0byAidmhvc3RfdXNlcl93cml0ZV9zeW5jIiAo
aW4gY29kZSBhbmQKICAgICAgY29tbWl0IG1lc3NhZ2UpIFtTdGVmYW5vXQoKIGh3L3ZpcnRpby92
aG9zdC11c2VyLmMgfCAxMSArKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3QtdXNlci5j
IGIvaHcvdmlydGlvL3Zob3N0LXVzZXIuYwppbmRleCBjNzliNmY3N2NkY2EuLjE4ZTE1YTliYjM1
OSAxMDA2NDQKLS0tIGEvaHcvdmlydGlvL3Zob3N0LXVzZXIuYworKysgYi9ody92aXJ0aW8vdmhv
c3QtdXNlci5jCkBAIC0xMTcwLDcgKzExNzAsOCBAQCBzdGF0aWMgaW50IHZob3N0X3VzZXJfd3Jp
dGVfc3luYyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIFZob3N0VXNlck1zZyAqbXNnLAogCiBzdGF0
aWMgaW50IHZob3N0X3NldF92cmluZyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGludCByZXF1ZXN0LAotICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X3ZyaW5nX3N0YXRlICpyaW5nKQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X3ZyaW5nX3N0YXRlICpyaW5nLAorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYm9vbCB3YWl0X2Zvcl9yZXBseSkKIHsKICAgICBWaG9zdFVz
ZXJNc2cgbXNnID0gewogICAgICAgICAuaGRyLnJlcXVlc3QgPSByZXF1ZXN0LApAQCAtMTE3OSwx
MyArMTE4MCwxMyBAQCBzdGF0aWMgaW50IHZob3N0X3NldF92cmluZyhzdHJ1Y3Qgdmhvc3RfZGV2
ICpkZXYsCiAgICAgICAgIC5oZHIuc2l6ZSA9IHNpemVvZihtc2cucGF5bG9hZC5zdGF0ZSksCiAg
ICAgfTsKIAotICAgIHJldHVybiB2aG9zdF91c2VyX3dyaXRlKGRldiwgJm1zZywgTlVMTCwgMCk7
CisgICAgcmV0dXJuIHZob3N0X3VzZXJfd3JpdGVfc3luYyhkZXYsICZtc2csIHdhaXRfZm9yX3Jl
cGx5KTsKIH0KIAogc3RhdGljIGludCB2aG9zdF91c2VyX3NldF92cmluZ19udW0oc3RydWN0IHZo
b3N0X2RldiAqZGV2LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHZob3N0X3ZyaW5nX3N0YXRlICpyaW5nKQogewotICAgIHJldHVybiB2aG9zdF9zZXRfdnJpbmco
ZGV2LCBWSE9TVF9VU0VSX1NFVF9WUklOR19OVU0sIHJpbmcpOworICAgIHJldHVybiB2aG9zdF9z
ZXRfdnJpbmcoZGV2LCBWSE9TVF9VU0VSX1NFVF9WUklOR19OVU0sIHJpbmcsIGZhbHNlKTsKIH0K
IAogc3RhdGljIHZvaWQgdmhvc3RfdXNlcl9ob3N0X25vdGlmaWVyX2ZyZWUoVmhvc3RVc2VySG9z
dE5vdGlmaWVyICpuKQpAQCAtMTIxNiw3ICsxMjE3LDcgQEAgc3RhdGljIHZvaWQgdmhvc3RfdXNl
cl9ob3N0X25vdGlmaWVyX3JlbW92ZShWaG9zdFVzZXJIb3N0Tm90aWZpZXIgKm4sCiBzdGF0aWMg
aW50IHZob3N0X3VzZXJfc2V0X3ZyaW5nX2Jhc2Uoc3RydWN0IHZob3N0X2RldiAqZGV2LAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF92cmluZ19zdGF0
ZSAqcmluZykKIHsKLSAgICByZXR1cm4gdmhvc3Rfc2V0X3ZyaW5nKGRldiwgVkhPU1RfVVNFUl9T
RVRfVlJJTkdfQkFTRSwgcmluZyk7CisgICAgcmV0dXJuIHZob3N0X3NldF92cmluZyhkZXYsIFZI
T1NUX1VTRVJfU0VUX1ZSSU5HX0JBU0UsIHJpbmcsIGZhbHNlKTsKIH0KIAogc3RhdGljIGludCB2
aG9zdF91c2VyX3NldF92cmluZ19lbmFibGUoc3RydWN0IHZob3N0X2RldiAqZGV2LCBpbnQgZW5h
YmxlKQpAQCAtMTIzNCw3ICsxMjM1LDcgQEAgc3RhdGljIGludCB2aG9zdF91c2VyX3NldF92cmlu
Z19lbmFibGUoc3RydWN0IHZob3N0X2RldiAqZGV2LCBpbnQgZW5hYmxlKQogICAgICAgICAgICAg
Lm51bSAgID0gZW5hYmxlLAogICAgICAgICB9OwogCi0gICAgICAgIHJldCA9IHZob3N0X3NldF92
cmluZyhkZXYsIFZIT1NUX1VTRVJfU0VUX1ZSSU5HX0VOQUJMRSwgJnN0YXRlKTsKKyAgICAgICAg
cmV0ID0gdmhvc3Rfc2V0X3ZyaW5nKGRldiwgVkhPU1RfVVNFUl9TRVRfVlJJTkdfRU5BQkxFLCAm
c3RhdGUsIGZhbHNlKTsKICAgICAgICAgaWYgKHJldCA8IDApIHsKICAgICAgICAgICAgIC8qCiAg
ICAgICAgICAgICAgKiBSZXN0b3JpbmcgdGhlIHByZXZpb3VzIHN0YXRlIGlzIGxpa2VseSBpbmZl
YXNpYmxlLCBhcyB3ZWxsIGFzCgo=


