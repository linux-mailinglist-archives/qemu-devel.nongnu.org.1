Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B90979EB9A
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 16:50:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgRC3-0000yH-DL; Wed, 13 Sep 2023 10:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qgRBw-0000xk-5f
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qgRBt-0000JG-Da
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694616604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kLuxwXMabIXjZuF6ObvAibxilK9PiG1oLtLYD4imoaE=;
 b=WbLo5iIe3UXqPk1kalMULpET0I7EfHd0NKrN/2pmQpkuCU3IrVPwNcsGceRRriR7cEruCg
 Dp40kAZTNGgpdZVGtWguzXz4vh3xTPLw7tUeZ24VmSicqdBvn4+dw9ASIUiw7WEkxVsIvC
 29ykx3S2jepN+/c52qRf7fgcj+bm6Bo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-QZakFFfhN8GB7zJoVATghw-1; Wed, 13 Sep 2023 10:50:02 -0400
X-MC-Unique: QZakFFfhN8GB7zJoVATghw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01CA8101FAA4
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 14:50:02 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.194.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19E8363A52;
 Wed, 13 Sep 2023 14:50:00 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: lersek@redhat.com,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 0/4] ui/console: multihead: fix crash, simplify logic
Date: Wed, 13 Sep 2023 16:49:55 +0200
Message-Id: <20230913144959.41891-1-lersek@redhat.com>
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

Rml4IGEgcmVjZW50IHJlZ3Jlc3Npb24gKGNyYXNoKSBpbiB0aGUgbXVsdGloZWFkIGNoZWNrOyBj
bGVhbiB1cCB0aGUKY29kZSBzb21lIG1vcmUuCgpDYzogIk1hcmMtQW5kcsOpIEx1cmVhdSIgPG1h
cmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4gKG9kZCBmaXhlcjpHcmFwaGljcykKQ2M6IEdlcmQg
SG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPiAob2RkIGZpeGVyOkdyYXBoaWNzKQoKVGhhbmtz
LApMYXN6bG8KCkxhc3psbyBFcnNlayAoNCk6CiAgdWkvY29uc29sZTogbWFrZSBxZW11X2NvbnNv
bGVfaXNfbXVsdGloZWFkKCkgc3RhdGljCiAgdWkvY29uc29sZTogb25seSB3YWxrIFFlbXVHcmFw
aGljQ29uc29sZXMgaW4KICAgIHFlbXVfY29uc29sZV9pc19tdWx0aWhlYWQoKQogIHVpL2NvbnNv
bGU6IGVsaW1pbmF0ZSBRT00gcHJvcGVydGllcyBmcm9tIHFlbXVfY29uc29sZV9pc19tdWx0aWhl
YWQoKQogIHVpL2NvbnNvbGU6IHNhbml0aXplIHNlYXJjaCBpbiBxZW11X2dyYXBoaWNfY29uc29s
ZV9pc19tdWx0aWhlYWQoKQoKIGluY2x1ZGUvdWkvY29uc29sZS5oIHwgIDEgLQogdWkvY29uc29s
ZS5jICAgICAgICAgfCAyNCArKysrKysrKystLS0tLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAx
MSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKCg==


