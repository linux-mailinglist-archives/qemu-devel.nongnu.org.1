Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FC6749982
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:30:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHMFD-00042Q-18; Thu, 06 Jul 2023 06:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qHMFA-00041B-Kx
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qHMF8-0005XC-IM
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688639385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PVdxRp3tgVnVCJCP+/YIuSiYFEaJkIvPHMPHDwsu7Wk=;
 b=KKqrm1iJkGyrcWySEN770UWl3piEMy0geJ+pfi0tgU0IWmP1KSwyMwJRBp7+UyKbdjDHqJ
 0rCGD6RBDmrKO66JWv1Fr0/zMRsMDRpOkXKKPo/F8ujI14P+qQrV+oNrUz37oOXe/C+WUP
 bkFhP9rHtluaEXP9b8lkK20ClXVXUzg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-nbX9QU5FP4a55y_AqRAFgg-1; Thu, 06 Jul 2023 06:29:42 -0400
X-MC-Unique: nbX9QU5FP4a55y_AqRAFgg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BA82800962;
 Thu,  6 Jul 2023 10:29:41 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.194.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 826B4F5CE3;
 Thu,  6 Jul 2023 10:29:40 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Cc: Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-trivial@nongnu.org
Subject: [PATCH 1/2] migration: factor out "resume_requested" in qmp_migrate()
Date: Thu,  6 Jul 2023 12:29:36 +0200
Message-Id: <20230706102937.82490-2-lersek@redhat.com>
In-Reply-To: <20230706102937.82490-1-lersek@redhat.com>
References: <20230706102937.82490-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

SXQgY3V0cyBiYWNrIG9uIHRob3NlIGF3a3dhcmQsIGR1cGxpY2F0ZWQgIShoYXNfcmVzdW1lICYm
IHJlc3VtZSkKZXhwcmVzc2lvbnMuCgpDYzogSnVhbiBRdWludGVsYSA8cXVpbnRlbGFAcmVkaGF0
LmNvbT4gKG1haW50YWluZXI6TWlncmF0aW9uKQpDYzogTGVvbmFyZG8gQnJhcyA8bGVvYnJhc0By
ZWRoYXQuY29tPiAocmV2aWV3ZXI6TWlncmF0aW9uKQpDYzogUGV0ZXIgWHUgPHBldGVyeEByZWRo
YXQuY29tPiAocmV2aWV3ZXI6TWlncmF0aW9uKQpDYzogcWVtdS10cml2aWFsQG5vbmdudS5vcmcK
QnVnemlsbGE6IGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MjAx
ODQwNApTaWduZWQtb2ZmLWJ5OiBMYXN6bG8gRXJzZWsgPGxlcnNla0ByZWRoYXQuY29tPgotLS0K
IG1pZ3JhdGlvbi9taWdyYXRpb24uYyB8IDEwICsrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL21p
Z3JhdGlvbi5jIGIvbWlncmF0aW9uL21pZ3JhdGlvbi5jCmluZGV4IDA5NmU4MTkxZDE1Yy4uYTYw
YTVhY2VlNTMzIDEwMDY0NAotLS0gYS9taWdyYXRpb24vbWlncmF0aW9uLmMKKysrIGIvbWlncmF0
aW9uL21pZ3JhdGlvbi5jCkBAIC0xNjM3LDYgKzE2MzcsNyBAQCB2b2lkIHFtcF9taWdyYXRlKGNv
bnN0IGNoYXIgKnVyaSwgYm9vbCBoYXNfYmxrLCBib29sIGJsaywKICAgICAgICAgICAgICAgICAg
Ym9vbCBoYXNfaW5jLCBib29sIGluYywgYm9vbCBoYXNfZGV0YWNoLCBib29sIGRldGFjaCwKICAg
ICAgICAgICAgICAgICAgYm9vbCBoYXNfcmVzdW1lLCBib29sIHJlc3VtZSwgRXJyb3IgKiplcnJw
KQogeworICAgIGJvb2wgcmVzdW1lX3JlcXVlc3RlZDsKICAgICBFcnJvciAqbG9jYWxfZXJyID0g
TlVMTDsKICAgICBNaWdyYXRpb25TdGF0ZSAqcyA9IG1pZ3JhdGVfZ2V0X2N1cnJlbnQoKTsKICAg
ICBjb25zdCBjaGFyICpwID0gTlVMTDsKQEAgLTE2NDYsMTMgKzE2NDcsMTQgQEAgdm9pZCBxbXBf
bWlncmF0ZShjb25zdCBjaGFyICp1cmksIGJvb2wgaGFzX2JsaywgYm9vbCBibGssCiAgICAgICAg
IHJldHVybjsKICAgICB9CiAKKyAgICByZXN1bWVfcmVxdWVzdGVkID0gaGFzX3Jlc3VtZSAmJiBy
ZXN1bWU7CiAgICAgaWYgKCFtaWdyYXRlX3ByZXBhcmUocywgaGFzX2JsayAmJiBibGssIGhhc19p
bmMgJiYgaW5jLAotICAgICAgICAgICAgICAgICAgICAgICAgIGhhc19yZXN1bWUgJiYgcmVzdW1l
LCBlcnJwKSkgeworICAgICAgICAgICAgICAgICAgICAgICAgIHJlc3VtZV9yZXF1ZXN0ZWQsIGVy
cnApKSB7CiAgICAgICAgIC8qIEVycm9yIGRldGVjdGVkLCBwdXQgaW50byBlcnJwICovCiAgICAg
ICAgIHJldHVybjsKICAgICB9CiAKLSAgICBpZiAoIShoYXNfcmVzdW1lICYmIHJlc3VtZSkpIHsK
KyAgICBpZiAoIXJlc3VtZV9yZXF1ZXN0ZWQpIHsKICAgICAgICAgaWYgKCF5YW5rX3JlZ2lzdGVy
X2luc3RhbmNlKE1JR1JBVElPTl9ZQU5LX0lOU1RBTkNFLCBlcnJwKSkgewogICAgICAgICAgICAg
cmV0dXJuOwogICAgICAgICB9CkBAIC0xNjcxLDcgKzE2NzMsNyBAQCB2b2lkIHFtcF9taWdyYXRl
KGNvbnN0IGNoYXIgKnVyaSwgYm9vbCBoYXNfYmxrLCBib29sIGJsaywKICAgICB9IGVsc2UgaWYg
KHN0cnN0YXJ0KHVyaSwgImZkOiIsICZwKSkgewogICAgICAgICBmZF9zdGFydF9vdXRnb2luZ19t
aWdyYXRpb24ocywgcCwgJmxvY2FsX2Vycik7CiAgICAgfSBlbHNlIHsKLSAgICAgICAgaWYgKCEo
aGFzX3Jlc3VtZSAmJiByZXN1bWUpKSB7CisgICAgICAgIGlmICghcmVzdW1lX3JlcXVlc3RlZCkg
ewogICAgICAgICAgICAgeWFua191bnJlZ2lzdGVyX2luc3RhbmNlKE1JR1JBVElPTl9ZQU5LX0lO
U1RBTkNFKTsKICAgICAgICAgfQogICAgICAgICBlcnJvcl9zZXRnKGVycnAsIFFFUlJfSU5WQUxJ
RF9QQVJBTUVURVJfVkFMVUUsICJ1cmkiLApAQCAtMTY4Myw3ICsxNjg1LDcgQEAgdm9pZCBxbXBf
bWlncmF0ZShjb25zdCBjaGFyICp1cmksIGJvb2wgaGFzX2JsaywgYm9vbCBibGssCiAgICAgfQog
CiAgICAgaWYgKGxvY2FsX2VycikgewotICAgICAgICBpZiAoIShoYXNfcmVzdW1lICYmIHJlc3Vt
ZSkpIHsKKyAgICAgICAgaWYgKCFyZXN1bWVfcmVxdWVzdGVkKSB7CiAgICAgICAgICAgICB5YW5r
X3VucmVnaXN0ZXJfaW5zdGFuY2UoTUlHUkFUSU9OX1lBTktfSU5TVEFOQ0UpOwogICAgICAgICB9
CiAgICAgICAgIG1pZ3JhdGVfZmRfZXJyb3IocywgbG9jYWxfZXJyKTsKCg==


