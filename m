Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE9472E66A
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 16:59:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q95TL-00067e-G6; Tue, 13 Jun 2023 10:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TC-00067C-6b
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TA-0007Vm-I6
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686668282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pLBH1sHYqt72KY+62bRvUut4aYkv2oDuULx19KyDGkE=;
 b=Tr6J5iX9AIW1Bi83uOG5iwMjb53sG+Y3nlmQs1inE1q9Jvl4FdTyVVymc2kypjWL4sKpnt
 2222YDJvwrWVayNsguAHuHwqrjomEfArKioj24GMX8pzaUQnn7acXMffJxTYcFB3UyMubi
 /J8NrVyWcyMFk8tc59RXLePbsKFxfKY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-IZ8Nc-BWPXyoAW8TgsosIQ-1; Tue, 13 Jun 2023 10:58:01 -0400
X-MC-Unique: IZ8Nc-BWPXyoAW8TgsosIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74DF78030DF;
 Tue, 13 Jun 2023 14:57:59 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6118F40C6F5C;
 Tue, 13 Jun 2023 14:57:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH 00/18] Migration compression cleanup
Date: Tue, 13 Jun 2023 16:57:39 +0200
Message-Id: <20230613145757.10131-1-quintela@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi

On this series:

- We got errors when setting incompatible migration methods
  (i.e. compression and RDMA)

- Remove the posibility of running COMPRESSION and XBZRLE together
  (remember that compression don't work)

- This series is the preliminar work to be able to compile out
  compression (almost there, but wanted to get this first)

- Move everyting that touches compression_counters to ram-compress.c

- simplify pass of block/file parameter.  We can get them trough the
  pss.

Please, review.

Juan Quintela (18):
  migration: Give one error if trying to set MULTIFD and XBZRLE
  migration: Give one error if trying to set COMPRESSION and XBZRLE
  migration: RDMA is not compatible with anything else
  migration: Remove save_page_use_compression()
  migration: Move compression_counters cleanup ram-compress.c
  migration: Create populate_compress()
  migration: Create ram_compressed_pages()
  migration: Move update_compress_threads_counts() to ram-compress.c
  migration: Make compress_data_with_multithreads return bool
  migration: Simplify compress_page_with_multithread()
  migration: Move busy++ to migrate_with_multithread
  migration: Create compression_update_rates()
  migration: Simplify decompress_data_with_multi_threads()
  migration: Use "i" as an for index in ram-compress.c
  migration: save_compress_page() can take block through pss
  migration: control_save_page() can take block through pss
  migration: Remove not needed block parameter for save_zero_page*
  migration: Remove not needed file parameter for save_zero_page*

 migration/ram-compress.h |  10 +-
 migration/ram.h          |   1 -
 migration/migration.c    |  27 +++---
 migration/options.c      |  14 +++
 migration/ram-compress.c | 198 +++++++++++++++++++++++++++------------
 migration/ram.c          | 121 +++++-------------------
 migration/savevm.c       |   1 -
 7 files changed, 198 insertions(+), 174 deletions(-)

-- 
2.40.1


