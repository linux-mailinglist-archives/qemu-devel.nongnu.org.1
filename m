Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A697D79EB99
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 16:50:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgRC9-000110-Ah; Wed, 13 Sep 2023 10:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qgRBy-0000yG-H1
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qgRBw-0000KC-9g
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694616607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4vZTivdXi5pRVkwl8cN/DGNi6t7j0fF1pSnYTruMtbQ=;
 b=NDT07nEJmqYZXiN7LjoEeuEOgTu76twh/XWywMCsSDSnSlc7Kfw49+EVU4xgzO8HN+qKWE
 7DUK2FEoAVCLuNB5KzdTiNcoqgE5BoPEbU/basqPqUC3dF6ZPAPVGFIMrt+2nWC0kfq07w
 dve+dNBbKpO98+3Ckyqh+X0AdQWiC6Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-jAdAjrasPMmnxNEwfZvDlg-1; Wed, 13 Sep 2023 10:50:05 -0400
X-MC-Unique: jAdAjrasPMmnxNEwfZvDlg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25EEB100BACB
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 14:50:05 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.194.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48C122904;
 Wed, 13 Sep 2023 14:50:04 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: lersek@redhat.com,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/4] ui/console: only walk QemuGraphicConsoles in
 qemu_console_is_multihead()
Date: Wed, 13 Sep 2023 16:49:57 +0200
Message-Id: <20230913144959.41891-3-lersek@redhat.com>
In-Reply-To: <20230913144959.41891-1-lersek@redhat.com>
References: <20230913144959.41891-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

cWVtdV9jb25zb2xlX2lzX211bHRpaGVhZCgpIGRlY2xhcmVzIHRoZSBjb25zb2xlICJjIiBhICJt
dWx0aWhlYWQiIGNvbnNvbGUKaWYgdGhlcmUgYXJlIHR3byBkaWZmZXJlbnQgY29uc29sZXMgaW4g
dGhlIHN5c3RlbSB0aGF0IChhKSBib3RoIHJlZmVyZW5jZQoiYy0+ZGV2aWNlIiwgYW5kIChiKSBo
YXZlIGRpZmZlcmVudCAiYy0+aGVhZCIgbnVtYmVycy4gSW4gZWZmZWN0LCBpZiBhdApsZWFzdCB0
d28gY29uc29sZXMgZXhpc3QgdGhhdCBhcmUgZGlmZmVyZW50IGhlYWRzIG9mIHRoZSBzYW1lIGRl
dmljZSB0aGF0CnVuZGVybGllcyAiYyIuCgpDb21taXQgNThkNTg3MDg0NWM2ICgidWkvY29uc29s
ZTogbW92ZSBncmFwaGljIGZpZWxkcyB0bwpRZW11R3JhcGhpY0NvbnNvbGUiLCAyMDIzLTA5LTA0
KSBwdXNoZWQgdGhlICJkZXZpY2UiIGFuZCAiaGVhZCIgbWVtYmVycwpmcm9tIHRoZSBRZW11Q29u
c29sZSBiYXNlIGNsYXNzIGRvd24gdG8gdGhlIFFlbXVHcmFwaGljQ29uc29sZSBzdWJjbGFzcywK
YWRqdXN0aW5nIHRoZSByZWZlcnJpbmcgUU9NIHByb3BlcnRpZXMgYWNjb3JkaW5nbHkgYXMgd2Vs
bC4gQXMgYSByZXN1bHQsCnRoZSAiZGV2aWNlIiBwcm9wZXJ0eSBsb29rdXAgaW4gcWVtdV9jb25z
b2xlX2lzX211bHRpaGVhZCgpIG5vdyBjcmFzaGVzLAppbiBjYXNlIHRoZSBjYW5kaWRhdGUgY29u
c29sZSBiZWluZyBpbnZlc3RpZ2F0ZWQgZm9yIGNyaXRlcmlvbiAoYSkgaXMgbm90CmEgUWVtdUdy
YXBoaWNDb25zb2xlIGluc3RhbmNlOgoKPiBVbmV4cGVjdGVkIGVycm9yIGluIG9iamVjdF9wcm9w
ZXJ0eV9maW5kX2VycigpIGF0IHFvbS9vYmplY3QuYzoxMzE0Ogo+IHFlbXU6IFByb3BlcnR5ICdx
ZW11LWZpeGVkLXRleHQtY29uc29sZS5kZXZpY2UnIG5vdCBmb3VuZAo+IEFib3J0ZWQgKGNvcmUg
ZHVtcGVkKQoKVGhpcyBpcyBlZmZlY3RpdmVseSBhbiB1bmNoZWNrZWQgZG93bmNhc3QuIE1ha2Ug
aXQgY2hlY2tlZDogb25seSBjb25zaWRlcgpzdWNoIGNvbnNvbGUgY2FuZGlkYXRlcyB0aGF0IGFy
ZSB0aGVtc2VsdmVzIFFlbXVHcmFwaGljQ29uc29sZSBpbnN0YW5jZXMuCgpDYzogIk1hcmMtQW5k
csOpIEx1cmVhdSIgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4gKG9kZCBmaXhlcjpHcmFw
aGljcykKQ2M6IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPiAob2RkIGZpeGVyOkdy
YXBoaWNzKQpGaXhlczogNThkNTg3MDg0NWM2ClNpZ25lZC1vZmYtYnk6IExhc3psbyBFcnNlayA8
bGVyc2VrQHJlZGhhdC5jb20+Ci0tLQogdWkvY29uc29sZS5jIHwgMyArKysKIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS91aS9jb25zb2xlLmMgYi91aS9jb25z
b2xlLmMKaW5kZXggYWRhY2MzNDczMTQwLi4yZWU2NTIwN2I0MzAgMTAwNjQ0Ci0tLSBhL3VpL2Nv
bnNvbGUuYworKysgYi91aS9jb25zb2xlLmMKQEAgLTIzNzMsNiArMjM3Myw5IEBAIHN0YXRpYyBi
b29sIHFlbXVfY29uc29sZV9pc19tdWx0aWhlYWQoRGV2aWNlU3RhdGUgKmRldikKICAgICB1aW50
MzJfdCBoOwogCiAgICAgUVRBSUxRX0ZPUkVBQ0goY29uLCAmY29uc29sZXMsIG5leHQpIHsKKyAg
ICAgICAgaWYgKCFRRU1VX0lTX0dSQVBISUNfQ09OU09MRShjb24pKSB7CisgICAgICAgICAgICBj
b250aW51ZTsKKyAgICAgICAgfQogICAgICAgICBvYmogPSBvYmplY3RfcHJvcGVydHlfZ2V0X2xp
bmsoT0JKRUNUKGNvbiksCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAi
ZGV2aWNlIiwgJmVycm9yX2Fib3J0KTsKICAgICAgICAgaWYgKERFVklDRShvYmopICE9IGRldikg
ewoK


