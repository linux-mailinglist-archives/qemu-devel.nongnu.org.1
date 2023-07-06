Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B07749980
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:30:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHMFB-00041a-Fv; Thu, 06 Jul 2023 06:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qHMF9-00040r-Cd
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qHMF6-0005UC-F3
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688639383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1FH8fc3JHx5q6sniT6A1fun6+ZU+GvwHJq/9vpECM6A=;
 b=Cawe6EmTas2sOWxhFa1ddasfsAEHTmzb5gD71V3MFimbkNrqxBEgf4kcljYATcWhO8hSip
 Ow6XQy2P3cTq0DOO7VxAyVvz3gmcUYbsxabJWyTTEmJgQgD7X9sfI20AsnGvdVn6QOOU1+
 GhKkZVhBH/wPua/6VzD8FaIAPjGQPAI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-v49gfcoSNySPjVcaVSR6Pw-1; Thu, 06 Jul 2023 06:29:40 -0400
X-MC-Unique: v49gfcoSNySPjVcaVSR6Pw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 442FA1C29AE6;
 Thu,  6 Jul 2023 10:29:40 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.194.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DBA9F5CE3;
 Thu,  6 Jul 2023 10:29:38 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Cc: Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-trivial@nongnu.org
Subject: [PATCH 0/2] migration: trivialities
Date: Thu,  6 Jul 2023 12:29:35 +0200
Message-Id: <20230706102937.82490-1-lersek@redhat.com>
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

U1NJQTsgb3JpZ2luYWxseSBmb3IgUkhCWiMyMDE4NDA0IChoZW5jZSB0aGUgbGlua3MgaW4gdGhl
IGNvbW1pdAptZXNzYWdlcykuCgpDYzogSnVhbiBRdWludGVsYSA8cXVpbnRlbGFAcmVkaGF0LmNv
bT4gKG1haW50YWluZXI6TWlncmF0aW9uKQpDYzogTGVvbmFyZG8gQnJhcyA8bGVvYnJhc0ByZWRo
YXQuY29tPiAocmV2aWV3ZXI6TWlncmF0aW9uKQpDYzogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQu
Y29tPiAocmV2aWV3ZXI6TWlncmF0aW9uKQpDYzogcWVtdS10cml2aWFsQG5vbmdudS5vcmcKCkxh
c3psbyBFcnNlayAoMik6CiAgbWlncmF0aW9uOiBmYWN0b3Igb3V0ICJyZXN1bWVfcmVxdWVzdGVk
IiBpbiBxbXBfbWlncmF0ZSgpCiAgbWlncmF0aW9uOiB1bmV4cG9ydCBtaWdyYXRlX2ZkX2Vycm9y
KCkKCiBtaWdyYXRpb24vbWlncmF0aW9uLmggfCAgMSAtCiBtaWdyYXRpb24vbWlncmF0aW9uLmMg
fCAxMiArKysrKysrLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQoKCmJhc2UtY29tbWl0OiAyYTZhZTY5MTU0NTQyY2FhOTFkZDE3YzQwZmQzZjVm
ZmJlYzMwMGRlCg==


