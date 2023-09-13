Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B5A79EB9C
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 16:51:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgRCA-00012C-7V; Wed, 13 Sep 2023 10:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qgRC0-0000yc-8f
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:50:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qgRBy-0000Uu-0s
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694616609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=otjEfooNuOif7HkdZH8mcdrv7l5FqBVatZP1E7Xnp/c=;
 b=NYqqjW5tLF9B6zFUAEAb+svqYq77+WQ/IE6fvuKl5jsS+ShmEGQiNp8jxcvLocfj5nrMEj
 1YsaOF7S1h8f0xD5Y07UWDXRlGHF/YHTHXhsgOd2RUCsTTjbDdjlYno3vjixG+/ZLTCpSH
 nEzxxSQkiJrlkBMU94TAVqgm6tF0QsU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-y7iLPsbcMKmAMtYbXxdYiA-1; Wed, 13 Sep 2023 10:50:07 -0400
X-MC-Unique: y7iLPsbcMKmAMtYbXxdYiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B5D5100AF29
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 14:50:07 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.194.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E06A7D4E4;
 Wed, 13 Sep 2023 14:50:06 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: lersek@redhat.com,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 4/4] ui/console: sanitize search in
 qemu_graphic_console_is_multihead()
Date: Wed, 13 Sep 2023 16:49:59 +0200
Message-Id: <20230913144959.41891-5-lersek@redhat.com>
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

cWVtdV9ncmFwaGljX2NvbnNvbGVfaXNfbXVsdGloZWFkKCkgZGVjbGFyZXMgdGhlIGdyYXBoaWNh
bCBjb25zb2xlICJjIiBhCiJtdWx0aWhlYWQiIGNvbnNvbGUgaWYgdGhlcmUgYXJlIHR3byBkaWZm
ZXJlbnQgZ3JhcGhpY2FsIGNvbnNvbGVzIGluIHRoZQpzeXN0ZW0gdGhhdCAoYSkgYm90aCByZWZl
cmVuY2UgImMtPmRldmljZSIsIGFuZCAoYikgaGF2ZSBkaWZmZXJlbnQKImMtPmhlYWQiIG51bWJl
cnMuIEluIGVmZmVjdCwgaWYgYXQgbGVhc3QgdHdvIGdyYXBoaWNhbCBjb25zb2xlcyBleGlzdAp0
aGF0IGFyZSBkaWZmZXJlbnQgaGVhZHMgb2YgdGhlIHNhbWUgZGV2aWNlIHRoYXQgdW5kZXJsaWVz
ICJjIi4gSW4gZmFjdCwKImMiIG1heSBiZSBvbmUgb2YgdGhlc2UgdHdvIGdyYXBoaWNhbCBjb25z
b2xlcywgb3IgImMiIG1heSBkaWZmZXIgZnJvbQpib3RoIG9mIHRob3NlIGNvbnNvbGVzIChpbiBj
YXNlICJjLT5kZXZpY2UiIGhhcyBhdCBsZWFzdCB0aHJlZSBoZWFkcykuCgpUaGUgbG9vcCBjdXJy
ZW50bHkgdXNlcyB0aGlzIGF3a3dhcmQgInR3byBkaWZmZXJlbnQgY29uc29sZXMiIGFwcHJvYWNo
CmJlY2F1c2UgdGhlIGZ1bmN0aW9uIHVzZWQgbm90IHRvIGhhdmUgYWNjZXNzIHRvICJjIiwgb25s
eSB0byAiYy0+ZGV2aWNlIiwKd2hpY2ggZGlkbid0IGFsbG93IGZvciBmZXRjaGluZyAoYW5kIGNv
bXBhcmluZykgImMtPmhlYWQiLiBCdXQsIHdlJ3ZlCmNoYW5nZWQgdGhhdCBpbiB0aGUgbGFzdCBw
YXRjaDsgd2Ugbm93IHBhc3MgYWxsIG9mICJjIiB0bwpxZW11X2dyYXBoaWNfY29uc29sZV9pc19t
dWx0aWhlYWQoKS4KClRodXMsIGxvb2sgZm9yIHRoZSAqZmlyc3QqIChhbmQgcG9zc2libHkgKm9u
bHkqKSBncmFwaGljYWwgY29uc29sZSwgaWYKYW55LCB0aGF0IHJlZmVycyB0byB0aGUgc2FtZSAi
ZGV2aWNlIiBhcyAiYyIsIGJ1dCBieSBhIGRpZmZlcmVudCAiaGVhZCIKbnVtYmVyLgoKQ2M6ICJN
YXJjLUFuZHLDqSBMdXJlYXUiIDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+IChvZGQgZml4
ZXI6R3JhcGhpY3MpCkNjOiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxAcmVkaGF0LmNvbT4gKG9kZCBm
aXhlcjpHcmFwaGljcykKU2lnbmVkLW9mZi1ieTogTGFzemxvIEVyc2VrIDxsZXJzZWtAcmVkaGF0
LmNvbT4KLS0tCgpOb3RlczoKICAgIGNvbnRleHQ6LVU0CgogdWkvY29uc29sZS5jIHwgNyArLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDYgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvdWkvY29uc29sZS5jIGIvdWkvY29uc29sZS5jCmluZGV4IDY0MjQ4MjBjODUyMS4u
OWNlM2MxMjQ4YzdjIDEwMDY0NAotLS0gYS91aS9jb25zb2xlLmMKKysrIGIvdWkvY29uc29sZS5j
CkBAIC0yMzY3LDEwICsyMzY3LDggQEAgYm9vbCBxZW11X2NvbnNvbGVfaXNfZ2xfYmxvY2tlZChR
ZW11Q29uc29sZSAqY29uKQogCiBzdGF0aWMgYm9vbCBxZW11X2dyYXBoaWNfY29uc29sZV9pc19t
dWx0aWhlYWQoUWVtdUdyYXBoaWNDb25zb2xlICpjKQogewogICAgIFFlbXVDb25zb2xlICpjb247
Ci0gICAgdWludDMyX3QgZiA9IDB4ZmZmZmZmZmY7Ci0gICAgdWludDMyX3QgaDsKIAogICAgIFFU
QUlMUV9GT1JFQUNIKGNvbiwgJmNvbnNvbGVzLCBuZXh0KSB7CiAgICAgICAgIFFlbXVHcmFwaGlj
Q29uc29sZSAqY2FuZGlkYXRlOwogCkBAIC0yMzgyLDEyICsyMzgwLDkgQEAgc3RhdGljIGJvb2wg
cWVtdV9ncmFwaGljX2NvbnNvbGVfaXNfbXVsdGloZWFkKFFlbXVHcmFwaGljQ29uc29sZSAqYykK
ICAgICAgICAgaWYgKGNhbmRpZGF0ZS0+ZGV2aWNlICE9IGMtPmRldmljZSkgewogICAgICAgICAg
ICAgY29udGludWU7CiAgICAgICAgIH0KIAotICAgICAgICBoID0gY2FuZGlkYXRlLT5oZWFkOwot
ICAgICAgICBpZiAoZiA9PSAweGZmZmZmZmZmKSB7Ci0gICAgICAgICAgICBmID0gaDsKLSAgICAg
ICAgfSBlbHNlIGlmIChoICE9IGYpIHsKKyAgICAgICAgaWYgKGNhbmRpZGF0ZS0+aGVhZCAhPSBj
LT5oZWFkKSB7CiAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKICAgICAgICAgfQogICAgIH0KICAg
ICByZXR1cm4gZmFsc2U7Cg==


