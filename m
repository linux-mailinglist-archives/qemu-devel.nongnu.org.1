Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 686FE773AD2
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:00:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTOBE-0002gz-3L; Tue, 08 Aug 2023 10:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qTOBC-0002gQ-9N
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:59:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qTOBA-0003tX-0D
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691506761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BaWdBayN+/XneRZ2rEWopSDSYzwiHS0GVLVdSuCFCH8=;
 b=IIopsSQs82xIBSOjQ0wTo/cIcXL08q6U7r3UxcivKGOFxX6l6szOCmlM0oO1GPEpzoEsol
 HtjqwAEzSOxMc+e0sFoo5S5Vvri94DEDDQZXv1R0vLd0+tFW29y5x2C/NloguyjvoGCQuO
 EgQEuPGquUdML1kUiS8f3+wVGVsg5+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-qDs4D1V-PMWNSXa-v5GpBw-1; Tue, 08 Aug 2023 10:59:19 -0400
X-MC-Unique: qDs4D1V-PMWNSXa-v5GpBw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C0B5800C78
 for <qemu-devel@nongnu.org>; Tue,  8 Aug 2023 14:59:19 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.194.241])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87E9E492C13;
 Tue,  8 Aug 2023 14:59:18 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: lersek@redhat.com,
	qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] vfio/pci: hide ROM BAR on SFC9220 10/40G Ethernet Controller
 PF
Date: Tue,  8 Aug 2023 16:59:16 +0200
Message-Id: <20230808145916.81657-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

VGhlIFNvbGFyZmxhcmUgQ29tbXVuaWNhdGlvbnMgU0ZDOTIyMCBOSUMncyBwaHlzaWNhbCBmdW5j
dGlvbiAoUEYpIGFwcGVhcnMKdG8gZXhwb3NlIGFuIGV4cGFuc2lvbiBST00gd2l0aCB0aGUgZm9s
bG93aW5nIGNoYXJhY3RlcmlzdGljczoKCigxKSBTaW5nbGUtaW1hZ2UgUk9NLCB3aXRoIG9ubHkg
YSBsZWdhY3kgQklPUyBpbWFnZSAobm8gVUVGSSBkcml2ZXIpLgpBbGV4J3Mgcm9tLXBhcnNlciB1
dGlsaXR5IGR1bXBzIGl0IGxpa2UgdGhpczoKCj4gVmFsaWQgUk9NIHNpZ25hdHVyZSBmb3VuZCBA
MGgsIFBDSVIgb2Zmc2V0IDIwaAo+ICAgICAgICAgUENJUjogdHlwZSAwICh4ODYgUEMtQVQpLCB2
ZW5kb3I6IDE5MjQsIGRldmljZTogMGEwMywgY2xhc3M6IDAwMDAwMgo+ICAgICAgICAgUENJUjog
cmV2aXNpb24gMywgdmVuZG9yIHJldmlzaW9uOiAxCj4gICAgICAgICBMYXN0IGltYWdlCgooMikg
VGhlIEJJT1MgaW1hZ2UgY3Jhc2hlcyB3aGVuIGJvb3RlZCBvbiBpNDQwZnguCgooMykgVGhlIEJJ
T1MgaW1hZ2UgcHJpbnRzIHRoZSBmb2xsb3dpbmcgbWVzc2FnZXMgb24gcTM1OgoKPiBTb2xhcmZs
YXJlIEJvb3QgTWFuYWdlciAodjUuMi4yLjEwMDYpCj4gU29sYXJmbGFyZSBDb21tdW5pY2F0aW9u
cyAyMDA4LTIwMTkKPiBnUFhFIChodHRwOi8vZXRoZXJib290Lm9yZykgLSBbLi4uXSBQQ0lbLi4u
XSBQblAgUE1NWy4uLl0KClNvIGl0IGFwcGVhcnMgbGlrZSBhIG1vZGlmaWVkIGRlcml2YXRpdmUg
b2Ygb2xkIGdQWEUuCgpBbGV4IHN1cm1pc2VkIGluIGFkdmFuY2UgdGhhdCB0aGUgQklPUyBpbWFn
ZSBjb3VsZCBiZSBhY2Nlc3NpbmcKaG9zdC1waHlzaWNhbCBhZGRyZXNzZXMgcmF0aGVyIHRoYW4g
Z3Vlc3QtcGh5cyBvbmVzLCBsZWFkaW5nIHRvIHRoZSBjcmFzaApvbiBpNDQwZnguCgpEb24ndCBl
eHBvc2UgdGhlIG9wdGlvbiBST00gQkFSIHRvIHRoZSBWTSBieSBkZWZhdWx0LiBXaGlsZSB0aGlz
IHByZXZlbnRzCm5ldGJvb3RpbmcgdGhlIFZNIG9mZiB0aGUgUEYgb24gcTM1L1NlYUJJT1MgKGEg
cmVsYXRpdmVseSByYXJlIHNjZW5hcmlvKSwKaXQgZG9lcyBub3QgbWFrZSBhbnkgZGlmZmVyZW5j
ZSBmb3IgVUVGSSwgYW5kIGF0IGxlYXN0IHRoZSBWTSBkb2Vzbid0CmNyYXNoIGR1cmluZyBib290
IG9uIGk0NDBmeC9TZWFCSU9TIChhIHJlbGF0aXZlbHkgZnJlcXVlbnQgc2NlbmFyaW8pLgpVc2Vy
cyBjYW4gcmVzdG9yZSB0aGUgb3JpZ2luYWwgYmVoYXZpb3IgdmlhIHRoZSBRRU1VIGNtZGxpbmUg
YW5kIHRoZQpsaWJ2aXJ0IGRvbWFpbiBYTUwuCgooSW4gdHdvIHllYXJzLCB3ZSd2ZSBub3Qgc2Vl
biBhbnkgY3VzdG9tZXIgaW50ZXJlc3QgaW4gdGhpcyBidWcsIGhlbmNlCnRoZXJlJ3Mgbm8gaW5j
ZW50aXZlIHRvIGludmVzdGlnYXRlICgyKS4pCgpDYzogQWxleCBXaWxsaWFtc29uIDxhbGV4Lndp
bGxpYW1zb25AcmVkaGF0LmNvbT4gKHN1cHBvcnRlcjpWRklPKQpDYzogIkPDqWRyaWMgTGUgR29h
dGVyIiA8Y2xnQHJlZGhhdC5jb20+IChzdXBwb3J0ZXI6VkZJTykKQnVnemlsbGE6IGh0dHBzOi8v
YnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTk3NTc3NgpTaWduZWQtb2ZmLWJ5
OiBMYXN6bG8gRXJzZWsgPGxlcnNla0ByZWRoYXQuY29tPgotLS0KIGh3L3ZmaW8vcGNpLXF1aXJr
cy5jIHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvaHcvdmZpby9wY2ktcXVpcmtzLmMgYi9ody92ZmlvL3BjaS1xdWlya3MuYwppbmRleCBmNGZm
ODM2ODA1NzIuLjI3MGViMTZiOTFmYSAxMDA2NDQKLS0tIGEvaHcvdmZpby9wY2ktcXVpcmtzLmMK
KysrIGIvaHcvdmZpby9wY2ktcXVpcmtzLmMKQEAgLTQ1LDYgKzQ1LDEwIEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgewogICAgIHVpbnQzMl90IGRldmljZTsKIH0gcm9tX2RlbnlsaXN0W10gPSB7CiAg
ICAgeyAweDE0ZTQsIDB4MTY4ZSB9LCAvKiBCcm9hZGNvbSBCQ00gNTc4MTAgKi8KKyAgICB7IDB4
MTkyNCwgMHgwYTAzIH0sIC8qIFNvbGFyZmxhcmUgQ29tbXVuaWNhdGlvbnMKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAqIFNGQzkyMjAgMTAvNDBHIEV0aGVybmV0IENvbnRyb2xsZXIKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAqIGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1
Zy5jZ2k/aWQ9MTk3NTc3NgorICAgICAgICAgICAgICAgICAgICAgICAgICovCiB9OwogCiBib29s
IHZmaW9fb3B0X3JvbV9pbl9kZW55bGlzdChWRklPUENJRGV2aWNlICp2ZGV2KQo=


