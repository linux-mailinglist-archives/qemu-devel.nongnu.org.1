Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A455D79EB98
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 16:50:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgRCD-00013p-0U; Wed, 13 Sep 2023 10:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qgRC0-0000yb-16
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:50:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qgRBx-0000Nd-BU
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694616608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LdBQKAgdJ5RGJSg/p8MMXcwHuyc4f7F3/mgOa1f4Lc0=;
 b=drfh11yABfIfOTG4ABn8y+4G5YPzg4J13dIjA9viYfvRbLvA5V4hBj2vyLZzTg+kdjH+b2
 Xn+svn19oYJu9W+eiOugv78SY2SjJoNm0fX7WPulw4Ft5XbbpNkK+RLYot55BoQ0Wxw3Mz
 /TuNM1LFxjjEMknx49pg8CdjtqOTVTc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-MRI5cd7RPCqjq5WZh5RDAA-1; Wed, 13 Sep 2023 10:50:06 -0400
X-MC-Unique: MRI5cd7RPCqjq5WZh5RDAA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 423AC100B36E
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 14:50:06 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.194.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6322663A52;
 Wed, 13 Sep 2023 14:50:05 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: lersek@redhat.com,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 3/4] ui/console: eliminate QOM properties from
 qemu_console_is_multihead()
Date: Wed, 13 Sep 2023 16:49:58 +0200
Message-Id: <20230913144959.41891-4-lersek@redhat.com>
In-Reply-To: <20230913144959.41891-1-lersek@redhat.com>
References: <20230913144959.41891-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

QWNjb3JkaW5nIHRvIE1hcmMtQW5kcsOpJ3MgYW5kIEdlcmQncyBkZXNjcmlwdGlvbnMsIHRoZSAi
ZGV2aWNlIiBhbmQKImhlYWQiIG1lbWJlcnMgb2YgUWVtdUdyYXBoaWNDb25zb2xlIGFyZSBleHBv
c2VkIGFzIFFPTSBwcm9wZXJ0aWVzIGZvciB0d28KcHVycG9zZXM6CgooMSkgSW50cm9zcGVjdGlv
biAoZS5nLiwgInFvbS1nZXQiIG1vbml0b3IgY29tbWFuZCkuCgooMikgQSBWTkMgc2VydmVyIGNh
biBkaXNwbGF5IGEgc3BlY2lmaWMgZGV2aWNlICsgaGVhZC4gVGhpcyBsZXRzIHVzIHJ1biBhCiAg
ICBtdWx0aWhlYWQgY29uZmlndXJhdGlvbiBieSB1c2luZyBtdWx0aXBsZSBWTkMgc2VydmVycyAo
b25lIGZvciBlYWNoCiAgICBoZWFkKS4KCiAgICBGdXJ0aGVyLCB3ZSBjYW4gbGluayBpbnB1dCBk
ZXZpY2VzIHRvIGRldmljZSArIGhlYWQsIHNvIGlucHV0IGV2ZW50cwogICAgYXJlIHJvdXRlZCB0
byBkaWZmZXJlbnQgZGV2aWNlcyBkZXBlbmRlbnQgb24gd2hlcmUgdGhleSBhcmUgY29taW5nCiAg
ICBmcm9tLiBXaGljaCBpcyBtb3N0IHVzZWZ1bCBmb3IgdGFibGV0IGRldmljZXMgaW4gYSBWTkMg
bXVsdGloZWFkCiAgICBzZXR1cCwgZWFjaCBoZWFkIGhhcyBpdHMgb3duIHRhYmxldCBkZXZpY2Ug
dGhlbi4gVGhpcyBkb2VzIHJlcXVpcmVzCiAgICBtYW51YWwgZ3Vlc3Qtc2lkZSBjb25maWd1cmF0
aW9uLCBmb3IgZXN0YWJsaXNoaW5nIHRoZSBzYW1lIHRhYmxldCA8LT4KICAgIGhlYWQgcmVsYXRp
b25zaGlwLgoKSG93ZXZlciwgbmVpdGhlciBnb2FsIHNlZW1zIHRvIGp1c3RpZnkgdGhlIGNvbXBs
aWNhdGVkIFFPTSBwcm9wZXJ0eSBsb29rdXAKdGhhdCdzIGludGVybmFsIHRvIHFlbXVfY29uc29s
ZV9pc19tdWx0aWhlYWQoKS4KClJld29yayBxZW11X2NvbnNvbGVfaXNfbXVsdGloZWFkKCkgd2l0
aCBwbGFpbiBvbGQgQyBsYW5ndWFnZSBmaWVsZAphY2Nlc3Nlcy4KCkNjOiAiTWFyYy1BbmRyw6kg
THVyZWF1IiA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPiAob2RkIGZpeGVyOkdyYXBoaWNz
KQpDYzogR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+IChvZGQgZml4ZXI6R3JhcGhp
Y3MpClNpZ25lZC1vZmYtYnk6IExhc3psbyBFcnNlayA8bGVyc2VrQHJlZGhhdC5jb20+Ci0tLQog
dWkvY29uc29sZS5jIHwgMTYgKysrKysrKystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS91aS9jb25zb2xlLmMgYi91
aS9jb25zb2xlLmMKaW5kZXggMmVlNjUyMDdiNDMwLi42NDI0ODIwYzg1MjEgMTAwNjQ0Ci0tLSBh
L3VpL2NvbnNvbGUuYworKysgYi91aS9jb25zb2xlLmMKQEAgLTIzNjUsMjUgKzIzNjUsMjUgQEAg
Ym9vbCBxZW11X2NvbnNvbGVfaXNfZ2xfYmxvY2tlZChRZW11Q29uc29sZSAqY29uKQogICAgIHJl
dHVybiBjb24tPmdsX2Jsb2NrOwogfQogCi1zdGF0aWMgYm9vbCBxZW11X2NvbnNvbGVfaXNfbXVs
dGloZWFkKERldmljZVN0YXRlICpkZXYpCitzdGF0aWMgYm9vbCBxZW11X2dyYXBoaWNfY29uc29s
ZV9pc19tdWx0aWhlYWQoUWVtdUdyYXBoaWNDb25zb2xlICpjKQogewogICAgIFFlbXVDb25zb2xl
ICpjb247Ci0gICAgT2JqZWN0ICpvYmo7CiAgICAgdWludDMyX3QgZiA9IDB4ZmZmZmZmZmY7CiAg
ICAgdWludDMyX3QgaDsKIAogICAgIFFUQUlMUV9GT1JFQUNIKGNvbiwgJmNvbnNvbGVzLCBuZXh0
KSB7CisgICAgICAgIFFlbXVHcmFwaGljQ29uc29sZSAqY2FuZGlkYXRlOworCiAgICAgICAgIGlm
ICghUUVNVV9JU19HUkFQSElDX0NPTlNPTEUoY29uKSkgewogICAgICAgICAgICAgY29udGludWU7
CiAgICAgICAgIH0KLSAgICAgICAgb2JqID0gb2JqZWN0X3Byb3BlcnR5X2dldF9saW5rKE9CSkVD
VChjb24pLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImRldmljZSIs
ICZlcnJvcl9hYm9ydCk7Ci0gICAgICAgIGlmIChERVZJQ0Uob2JqKSAhPSBkZXYpIHsKKworICAg
ICAgICBjYW5kaWRhdGUgPSBRRU1VX0dSQVBISUNfQ09OU09MRShjb24pOworICAgICAgICBpZiAo
Y2FuZGlkYXRlLT5kZXZpY2UgIT0gYy0+ZGV2aWNlKSB7CiAgICAgICAgICAgICBjb250aW51ZTsK
ICAgICAgICAgfQogCi0gICAgICAgIGggPSBvYmplY3RfcHJvcGVydHlfZ2V0X3VpbnQoT0JKRUNU
KGNvbiksCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImhlYWQiLCAmZXJy
b3JfYWJvcnQpOworICAgICAgICBoID0gY2FuZGlkYXRlLT5oZWFkOwogICAgICAgICBpZiAoZiA9
PSAweGZmZmZmZmZmKSB7CiAgICAgICAgICAgICBmID0gaDsKICAgICAgICAgfSBlbHNlIGlmICho
ICE9IGYpIHsKQEAgLTI0MDIsNyArMjQwMiw3IEBAIGNoYXIgKnFlbXVfY29uc29sZV9nZXRfbGFi
ZWwoUWVtdUNvbnNvbGUgKmNvbikKICAgICAgICAgICAgIGJvb2wgbXVsdGloZWFkOwogCiAgICAg
ICAgICAgICBkZXYgPSBERVZJQ0UoYy0+ZGV2aWNlKTsKLSAgICAgICAgICAgIG11bHRpaGVhZCA9
IHFlbXVfY29uc29sZV9pc19tdWx0aWhlYWQoZGV2KTsKKyAgICAgICAgICAgIG11bHRpaGVhZCA9
IHFlbXVfZ3JhcGhpY19jb25zb2xlX2lzX211bHRpaGVhZChjKTsKICAgICAgICAgICAgIGlmICht
dWx0aWhlYWQpIHsKICAgICAgICAgICAgICAgICByZXR1cm4gZ19zdHJkdXBfcHJpbnRmKCIlcy4l
ZCIsIGRldi0+aWQgPwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2
LT5pZCA6Cgo=


