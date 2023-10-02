Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEF97B5C24
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 22:34:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnPat-0003SD-Bh; Mon, 02 Oct 2023 16:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnPas-0003S0-0p
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 16:32:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnPan-0001Ta-O2
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 16:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696278756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M/vo4rdivaTq2NjcL0CveaWACeIQM5+4hL0thIMr9qM=;
 b=ZjZwedODmvJUdEOWPswvyfbXEV8i3UuclS8aLPaojJtYEPSQCseDnvTVg4uGUuQCEl/lGm
 EQ2/CnTItCyOsnKCqRlNNSzRt3DLb/a1ILg64tv5yYgKxXakUMkppgKZSh1vZ/Sl/CxWAx
 CzU8MmOuC0HSx9h0uH1DE/haNWySI6o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-rFbEjnsqMgme07_9rhWvzQ-1; Mon, 02 Oct 2023 16:32:30 -0400
X-MC-Unique: rFbEjnsqMgme07_9rhWvzQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13A84811E7B
 for <qemu-devel@nongnu.org>; Mon,  2 Oct 2023 20:32:30 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42A2E40C6EBF;
 Mon,  2 Oct 2023 20:32:29 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Subject: [PATCH v3 0/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Date: Mon,  2 Oct 2023 22:32:14 +0200
Message-Id: <20231002203221.17241-1-lersek@redhat.com>
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

djI6CgotIGh0dHA6Ly9taWQubWFpbC1hcmNoaXZlLmNvbS8yMDIzMDgzMDEzNDA1NS4xMDY4MTIt
MS1sZXJzZWtAcmVkaGF0LmNvbQotIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVj
dC9xZW11LWRldmVsL2NvdmVyLzIwMjMwODMwMTM0MDU1LjEwNjgxMi0xLWxlcnNla0ByZWRoYXQu
Y29tLwoKdjMgcGlja3MgdXAgdGFncyBmcm9tIFBoaWwsIEV1Z2VuaW8gYW5kIEFsYmVydCwgYW5k
IHVwZGF0ZXMgdGhlIGNvbW1pdAptZXNzYWdlIG9uIHBhdGNoIzcgYWNjb3JkaW5nIHRvIEV1Z2Vu
aW8ncyBjb21tZW50cy4KClJldGVzdGVkLgoKTGFzemxvIEVyc2VrICg3KToKICB2aG9zdC11c2Vy
OiBzdHJpcCBzdXBlcmZsdW91cyB3aGl0ZXNwYWNlCiAgdmhvc3QtdXNlcjogdGlnaHRlbiAicmVw
bHlfc3VwcG9ydGVkIiBzY29wZSBpbiAic2V0X3ZyaW5nX2FkZHIiCiAgdmhvc3QtdXNlcjogZmFj
dG9yIG91dCAidmhvc3RfdXNlcl93cml0ZV9zeW5jIgogIHZob3N0LXVzZXI6IGZsYXR0ZW4gImVu
Zm9yY2VfcmVwbHkiIGludG8gInZob3N0X3VzZXJfd3JpdGVfc3luYyIKICB2aG9zdC11c2VyOiBo
b2lzdCAid3JpdGVfc3luYyIsICJnZXRfZmVhdHVyZXMiLCAiZ2V0X3U2NCIKICB2aG9zdC11c2Vy
OiBhbGxvdyAidmhvc3Rfc2V0X3ZyaW5nIiB0byB3YWl0IGZvciBhIHJlcGx5CiAgdmhvc3QtdXNl
cjogY2FsbCBWSE9TVF9VU0VSX1NFVF9WUklOR19FTkFCTEUgc3luY2hyb25vdXNseQoKIGh3L3Zp
cnRpby92aG9zdC11c2VyLmMgfCAyMTYgKysrKysrKysrKy0tLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCAxMDggaW5zZXJ0aW9ucygrKSwgMTA4IGRlbGV0aW9ucygtKQoKCmJhc2UtY29tbWl0OiAz
NmU5YWFiM2M1NjlkNGM5YWQ3ODA0NzM1OTZlMTg0Nzk4MzhkMWFhCg==


