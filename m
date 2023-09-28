Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7407B1E2D
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:25:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqww-0003lw-D5; Thu, 28 Sep 2023 09:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwS-0003TP-3s
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwM-00088M-0n
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YHS9dDZ+FE/7bqdT9B3HJGX0TaYbjDZ1h4ax0HLxxhk=;
 b=EKv4CFyzlNbbOFufWx4HNKtL0WUpAfoh6DMTvt/5DmgnhaQGBqgU5tU26xA9L0DL/C1xlx
 R4Vt36lBFMNv7P3fHLnTGKrc8/RmToPBkLXyElhX/WiLQkG9udHsTAe6v1uGrZxYIQlqgH
 nQEtp0T7e5bN/CknE0TmzGLLtxm/jxg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-SDEj8gBhM_ye4ivZ3V4O2Q-1; Thu, 28 Sep 2023 09:20:21 -0400
X-MC-Unique: SDEj8gBhM_ye4ivZ3V4O2Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A00C280A9CA;
 Thu, 28 Sep 2023 13:20:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0445492B16;
 Thu, 28 Sep 2023 13:20:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C102821E6900; Thu, 28 Sep 2023 15:20:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 00/53] migration/rdma: Error handling fixes
Date: Thu, 28 Sep 2023 15:19:26 +0200
Message-ID: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Oh dear, where to start.  There's so much wrong, and in pretty obvious
ways.  This code should never have passed review.  I'm refraining from
saying more; see the commit messages instead.

Issues remaining after this series include:

* Terrible error messages

* Some error message cascades remain

* There is no written contract for QEMUFileHooks, and the
  responsibility for reporting errors is unclear

* There seem to be no tests whatsoever

PATCH 29 is arguably a matter of taste.  I made my case for it during
review of v1.  If maintainers don't want it, I'll drop it.

Related: [PATCH 1/7] migration/rdma: Fix save_page method to fail on
polling error

v2:
* PATCH 06: New
* PATCH 07: Tweak local variables in _readv() and _writev() for
  consistency [Fabiano]
* PATCH 13: Drop a comment that has become useless [Fabiano]
* PATCH 14: Fix spelling of qemu_rdma_buffer_mergeable() [Eric]
* PATCH 16: New; adding temporary FIXMEs
* PATCH 17: Fix typo in commit message [Li Zhijian]
* PATCH 26: Squash in old PATCH 23 [Li Zhijian]
* PATCH 27: Fix type of RDMAContext member @errored [Eric]
* PATCH 40: Resolve a temporary FIXME
* PATCH 44: Drop advice on qemu_rdma_alloc_pd_cq() failure in
  qemu_rdma_source_init() [Li Zhijian]
* PATCH 46+49: Resolve a temporary FIXME
* PATCH 51: Downgrade to warning instead of silence [Li Zhijian]
* PATCH 52: Resolve the last temporary FIXME
* PATCH 53: Convert to tracing instead [Li Zhijian]

Markus Armbruster (53):
  migration/rdma: Clean up qemu_rdma_poll()'s return type
  migration/rdma: Clean up qemu_rdma_data_init()'s return type
  migration/rdma: Clean up rdma_delete_block()'s return type
  migration/rdma: Drop fragile wr_id formatting
  migration/rdma: Consistently use uint64_t for work request IDs
  migration/rdma: Fix unwanted integer truncation
  migration/rdma: Clean up two more harmless signed vs. unsigned issues
  migration/rdma: Give qio_channel_rdma_source_funcs internal linkage
  migration/rdma: Fix qemu_rdma_accept() to return failure on errors
  migration/rdma: Put @errp parameter last
  migration/rdma: Eliminate error_propagate()
  migration/rdma: Drop rdma_add_block() error handling
  migration/rdma: Drop qemu_rdma_search_ram_block() error handling
  migration/rdma: Make qemu_rdma_buffer_mergeable() return bool
  migration/rdma: Use bool for two RDMAContext flags
  migration/rdma: Fix or document problematic uses of errno
  migration/rdma: Ditch useless numeric error codes in error messages
  migration/rdma: Fix io_writev(), io_readv() methods to obey contract
  migration/rdma: Replace dangerous macro CHECK_ERROR_STATE()
  migration/rdma: Fix qemu_rdma_broken_ipv6_kernel() to set error
  migration/rdma: Fix qemu_get_cm_event_timeout() to always set error
  migration/rdma: Drop dead qemu_rdma_data_init() code for !@host_port
  migration/rdma: Fix QEMUFileHooks method return values
  migration/rdma: Fix rdma_getaddrinfo() error checking
  migration/rdma: Return -1 instead of negative errno code
  migration/rdma: Dumb down remaining int error values to -1
  migration/rdma: Replace int error_state by bool errored
  migration/rdma: Drop superfluous assignments to @ret
  migration/rdma: Check negative error values the same way everywhere
  migration/rdma: Plug a memory leak and improve a message
  migration/rdma: Delete inappropriate error_report() in macro ERROR()
  migration/rdma: Retire macro ERROR()
  migration/rdma: Fix error handling around rdma_getaddrinfo()
  migration/rdma: Drop "@errp is clear" guards around error_setg()
  migration/rdma: Convert qemu_rdma_exchange_recv() to Error
  migration/rdma: Convert qemu_rdma_exchange_send() to Error
  migration/rdma: Convert qemu_rdma_exchange_get_response() to Error
  migration/rdma: Convert qemu_rdma_reg_whole_ram_blocks() to Error
  migration/rdma: Convert qemu_rdma_write_flush() to Error
  migration/rdma: Convert qemu_rdma_write_one() to Error
  migration/rdma: Convert qemu_rdma_write() to Error
  migration/rdma: Convert qemu_rdma_post_send_control() to Error
  migration/rdma: Convert qemu_rdma_post_recv_control() to Error
  migration/rdma: Convert qemu_rdma_alloc_pd_cq() to Error
  migration/rdma: Silence qemu_rdma_resolve_host()
  migration/rdma: Silence qemu_rdma_connect()
  migration/rdma: Silence qemu_rdma_reg_control()
  migration/rdma: Don't report received completion events as error
  migration/rdma: Silence qemu_rdma_block_for_wrid()
  migration/rdma: Silence qemu_rdma_register_and_get_keys()
  migration/rdma: Downgrade qemu_rdma_cleanup() errors to warnings
  migration/rdma: Use error_report() & friends instead of stderr
  migration/rdma: Replace flawed device detail dump by tracing

 migration/rdma.c       | 1026 ++++++++++++++++++++--------------------
 migration/trace-events |   10 +-
 2 files changed, 514 insertions(+), 522 deletions(-)

-- 
2.41.0


