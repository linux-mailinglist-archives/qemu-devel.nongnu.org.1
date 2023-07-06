Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1678D749983
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:30:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHMFE-00042h-3R; Thu, 06 Jul 2023 06:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qHMFB-000424-V7
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qHMFA-0005kD-AI
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688639387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yneCRGnjlUmK48pVddgtU/fz9n92Tm4sARTWN1JZB5o=;
 b=ZNrzPQYfdFray2Et9YQoiCah8bFvtZOHRxTdsF+sGnI2BiKy2hAOm+iDK8WRsas58OMp2O
 lFspKEd2O7Wwgsz9HRYU64YIqQiSaKPQJEW+q+w2aS+tagQlXLBNkRj2Y9K43Bp1hLU+fm
 V+fIeEWNx4zLqVfdrmwTpukPVBofshs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-8k7ItHdEOMOe_W4TUl8R-w-1; Thu, 06 Jul 2023 06:29:46 -0400
X-MC-Unique: 8k7ItHdEOMOe_W4TUl8R-w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F12BD1C29AEB;
 Thu,  6 Jul 2023 10:29:45 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.194.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6547F6403;
 Thu,  6 Jul 2023 10:29:44 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Cc: Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-trivial@nongnu.org
Subject: [PATCH 2/2] migration: unexport migrate_fd_error()
Date: Thu,  6 Jul 2023 12:29:37 +0200
Message-Id: <20230706102937.82490-3-lersek@redhat.com>
In-Reply-To: <20230706102937.82490-1-lersek@redhat.com>
References: <20230706102937.82490-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

VGhlIG9ubHkgbWlncmF0ZV9mZF9lcnJvcigpIGNhbGwgc2l0ZXMgYXJlIGluICJtaWdyYXRpb24v
bWlncmF0aW9uLmMiLAp3aGljaCBpcyBhbHNvIHdoZXJlIHdlIGRlZmluZSBtaWdyYXRlX2ZkX2Vy
cm9yKCkuIE1ha2UgdGhlIGZ1bmN0aW9uCnN0YXRpYywgYW5kIHJlbW92ZSBpdHMgZGVjbGFyYXRp
b24gZnJvbSAibWlncmF0aW9uL21pZ3JhdGlvbi5oIi4KCkNjOiBKdWFuIFF1aW50ZWxhIDxxdWlu
dGVsYUByZWRoYXQuY29tPiAobWFpbnRhaW5lcjpNaWdyYXRpb24pCkNjOiBMZW9uYXJkbyBCcmFz
IDxsZW9icmFzQHJlZGhhdC5jb20+IChyZXZpZXdlcjpNaWdyYXRpb24pCkNjOiBQZXRlciBYdSA8
cGV0ZXJ4QHJlZGhhdC5jb20+IChyZXZpZXdlcjpNaWdyYXRpb24pCkNjOiBxZW11LXRyaXZpYWxA
bm9uZ251Lm9yZwpCdWd6aWxsYTogaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVn
LmNnaT9pZD0yMDE4NDA0ClNpZ25lZC1vZmYtYnk6IExhc3psbyBFcnNlayA8bGVyc2VrQHJlZGhh
dC5jb20+Ci0tLQogbWlncmF0aW9uL21pZ3JhdGlvbi5oIHwgMSAtCiBtaWdyYXRpb24vbWlncmF0
aW9uLmMgfCAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9taWdyYXRpb24uaCBiL21pZ3JhdGlvbi9taWdy
YXRpb24uaAppbmRleCBhODBiMjJiNzAzY2QuLmI3YzhiNjc1NDJiOCAxMDA2NDQKLS0tIGEvbWln
cmF0aW9uL21pZ3JhdGlvbi5oCisrKyBiL21pZ3JhdGlvbi9taWdyYXRpb24uaApAQCAtNDY2LDcg
KzQ2Niw2IEBAIGJvb2wgIG1pZ3JhdGlvbl9oYXNfYWxsX2NoYW5uZWxzKHZvaWQpOwogdWludDY0
X3QgbWlncmF0ZV9tYXhfZG93bnRpbWUodm9pZCk7CiAKIHZvaWQgbWlncmF0ZV9zZXRfZXJyb3Io
TWlncmF0aW9uU3RhdGUgKnMsIGNvbnN0IEVycm9yICplcnJvcik7Ci12b2lkIG1pZ3JhdGVfZmRf
ZXJyb3IoTWlncmF0aW9uU3RhdGUgKnMsIGNvbnN0IEVycm9yICplcnJvcik7CiAKIHZvaWQgbWln
cmF0ZV9mZF9jb25uZWN0KE1pZ3JhdGlvblN0YXRlICpzLCBFcnJvciAqZXJyb3JfaW4pOwogCmRp
ZmYgLS1naXQgYS9taWdyYXRpb24vbWlncmF0aW9uLmMgYi9taWdyYXRpb24vbWlncmF0aW9uLmMK
aW5kZXggYTYwYTVhY2VlNTMzLi45MWJiYTYzMGE4MjggMTAwNjQ0Ci0tLSBhL21pZ3JhdGlvbi9t
aWdyYXRpb24uYworKysgYi9taWdyYXRpb24vbWlncmF0aW9uLmMKQEAgLTEyMjAsNyArMTIyMCw3
IEBAIHN0YXRpYyB2b2lkIG1pZ3JhdGVfZXJyb3JfZnJlZShNaWdyYXRpb25TdGF0ZSAqcykKICAg
ICB9CiB9CiAKLXZvaWQgbWlncmF0ZV9mZF9lcnJvcihNaWdyYXRpb25TdGF0ZSAqcywgY29uc3Qg
RXJyb3IgKmVycm9yKQorc3RhdGljIHZvaWQgbWlncmF0ZV9mZF9lcnJvcihNaWdyYXRpb25TdGF0
ZSAqcywgY29uc3QgRXJyb3IgKmVycm9yKQogewogICAgIHRyYWNlX21pZ3JhdGVfZmRfZXJyb3Io
ZXJyb3JfZ2V0X3ByZXR0eShlcnJvcikpOwogICAgIGFzc2VydChzLT50b19kc3RfZmlsZSA9PSBO
VUxMKTsK


