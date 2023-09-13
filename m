Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D0379EB93
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 16:50:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgRC8-0000yu-8f; Wed, 13 Sep 2023 10:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qgRBy-0000xv-1X
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qgRBv-0000Jj-UL
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694616606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AKRth8lhbPWJAavdmDmnNwwUQ+gTIecmKcJgGwnKIrA=;
 b=Ow4n0I/0nwqvLFmElwiqJEf9RZrlCN6K3Xyla35pz+4tZpGT63AL0KVICZ/2VR7CqMyO4B
 oyrPf9YkBX2qpqT3P/OpN0kS8IWZoIh8Z92we5HiwM4zLpc55zeNAeOQCm3G+TUAKJK1xE
 OhT7FeqkcuuEd02e/4JUR4m7gef/NoU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-XsOzb-CsOpOGDgt_eE9eCw-1; Wed, 13 Sep 2023 10:50:03 -0400
X-MC-Unique: XsOzb-CsOpOGDgt_eE9eCw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F21C18056B3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 14:50:03 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.194.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E7F464671;
 Wed, 13 Sep 2023 14:50:02 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: lersek@redhat.com,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/4] ui/console: make qemu_console_is_multihead() static
Date: Wed, 13 Sep 2023 16:49:56 +0200
Message-Id: <20230913144959.41891-2-lersek@redhat.com>
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

cWVtdV9jb25zb2xlX2lzX211bHRpaGVhZCgpIGlzIG9ubHkgY2FsbGVkIGZyb20gd2l0aGluICJ1
aS9jb25zb2xlLmMiOwptYWtlIGl0IHN0YXRpYy4KCkNjOiAiTWFyYy1BbmRyw6kgTHVyZWF1IiA8
bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPiAob2RkIGZpeGVyOkdyYXBoaWNzKQpDYzogR2Vy
ZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+IChvZGQgZml4ZXI6R3JhcGhpY3MpClNpZ25l
ZC1vZmYtYnk6IExhc3psbyBFcnNlayA8bGVyc2VrQHJlZGhhdC5jb20+Ci0tLQogaW5jbHVkZS91
aS9jb25zb2xlLmggfCAxIC0KIHVpL2NvbnNvbGUuYyAgICAgICAgIHwgMiArLQogMiBmaWxlcyBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNs
dWRlL3VpL2NvbnNvbGUuaCBiL2luY2x1ZGUvdWkvY29uc29sZS5oCmluZGV4IDFjY2Q0MzJiNGQ2
NC4uZDcxNWY4OGIxYmUyIDEwMDY0NAotLS0gYS9pbmNsdWRlL3VpL2NvbnNvbGUuaAorKysgYi9p
bmNsdWRlL3VpL2NvbnNvbGUuaApAQCAtNTA2LDcgKzUwNiw2IEBAIGJvb2wgcWVtdV9jb25zb2xl
X2lzX3Zpc2libGUoUWVtdUNvbnNvbGUgKmNvbik7CiBib29sIHFlbXVfY29uc29sZV9pc19ncmFw
aGljKFFlbXVDb25zb2xlICpjb24pOwogYm9vbCBxZW11X2NvbnNvbGVfaXNfZml4ZWRzaXplKFFl
bXVDb25zb2xlICpjb24pOwogYm9vbCBxZW11X2NvbnNvbGVfaXNfZ2xfYmxvY2tlZChRZW11Q29u
c29sZSAqY29uKTsKLWJvb2wgcWVtdV9jb25zb2xlX2lzX211bHRpaGVhZChEZXZpY2VTdGF0ZSAq
ZGV2KTsKIGNoYXIgKnFlbXVfY29uc29sZV9nZXRfbGFiZWwoUWVtdUNvbnNvbGUgKmNvbik7CiBp
bnQgcWVtdV9jb25zb2xlX2dldF9pbmRleChRZW11Q29uc29sZSAqY29uKTsKIHVpbnQzMl90IHFl
bXVfY29uc29sZV9nZXRfaGVhZChRZW11Q29uc29sZSAqY29uKTsKZGlmZiAtLWdpdCBhL3VpL2Nv
bnNvbGUuYyBiL3VpL2NvbnNvbGUuYwppbmRleCBlNGQ2MTc5NGJiMmMuLmFkYWNjMzQ3MzE0MCAx
MDA2NDQKLS0tIGEvdWkvY29uc29sZS5jCisrKyBiL3VpL2NvbnNvbGUuYwpAQCAtMjM2NSw3ICsy
MzY1LDcgQEAgYm9vbCBxZW11X2NvbnNvbGVfaXNfZ2xfYmxvY2tlZChRZW11Q29uc29sZSAqY29u
KQogICAgIHJldHVybiBjb24tPmdsX2Jsb2NrOwogfQogCi1ib29sIHFlbXVfY29uc29sZV9pc19t
dWx0aWhlYWQoRGV2aWNlU3RhdGUgKmRldikKK3N0YXRpYyBib29sIHFlbXVfY29uc29sZV9pc19t
dWx0aWhlYWQoRGV2aWNlU3RhdGUgKmRldikKIHsKICAgICBRZW11Q29uc29sZSAqY29uOwogICAg
IE9iamVjdCAqb2JqOwoK


