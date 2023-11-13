Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 758C37E9807
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 09:48:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Sb1-00036I-VB; Mon, 13 Nov 2023 03:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1r2San-00035m-Rm
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 03:46:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1r2Sal-0006iH-Bb
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 03:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699865205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FIHqABohFc3iH9ScVajPHOu8KdZtDhLVxU7upWsUjCU=;
 b=d48RYpgfIMjbB39TwEtmgLckSjUDKZvqtEMer+5RZiGdfyxlbGeJFDiQMyYQ6AxbAlmLMs
 JZZ2a75i7tXdBJ1ZFafiNommbUcAaHv1WTDGSCPbYV6sJRIUzMR0KjpbLgjOwsKADecYBO
 L0UqV9Wc14I1/oTYmfgUzwmlMLjqhtI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-7OycvpHLNCeIskhsjtUBfQ-1; Mon,
 13 Nov 2023 03:46:43 -0500
X-MC-Unique: 7OycvpHLNCeIskhsjtUBfQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48B802806048
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 08:46:43 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA983492BFA;
 Mon, 13 Nov 2023 08:46:42 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>
Subject: [GIT PULL 0/1] Host Memory Backends and Memory devices queue
 2023-11-13
Date: Mon, 13 Nov 2023 09:46:41 +0100
Message-ID: <20231113084642.150354-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit 69680740eafa1838527c90155a7432d51b8ff203:

  Merge tag 'qdev-array-prop' of https://repo.or.cz/qemu/kevin into staging (2023-11-11 11:23:25 +0800)

are available in the Git repository at:

  https://github.com/davidhildenbrand/qemu.git tags/mem-2023-11-13

for you to fetch changes up to 364eff6885a79869a074852d628dfa7a137ba492:

  virtio-mem: fix division by zero in virtio_mem_activate_memslots_to_plug() (2023-11-13 09:35:44 +0100)

----------------------------------------------------------------
Hi,

"Host Memory Backends" and "Memory devices" queue ("mem"):
- One virtio-mem fix leading to a QEMU crash in QEMU debug builds

----------------------------------------------------------------
David Hildenbrand (1):
      virtio-mem: fix division by zero in virtio_mem_activate_memslots_to_plug()

 hw/virtio/virtio-mem.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

-- 
2.41.0


