Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EF87B034D
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 13:47:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlT0P-0001nV-Tb; Wed, 27 Sep 2023 07:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlT0G-0001iE-UK
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:46:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlT0C-0001St-V9
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695815204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0GhUIXt6qAnvJmw9oyTeq3BVbXnYznVDmDu5poktc3Q=;
 b=hSquYBu2uTkqbpRSie1E/ufY1DhD6s9grWEaKdXCgJux/NVODR+QwHx1PqlcXWBXxdkUcq
 DcsAItMMbHF1cuYYqml7eKvv49B7OVDrw0E+t98PR5Pu7VXkU9H7P+x5eYiqUQVcYDQC+N
 msGy5OO4HKKWXVKsyoBS1b403eOB2GY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-sMjhnHSuOuSjpaV1w0MbAA-1; Wed, 27 Sep 2023 07:46:42 -0400
X-MC-Unique: sMjhnHSuOuSjpaV1w0MbAA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2155B80349C;
 Wed, 27 Sep 2023 11:46:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F0D9F176C3;
 Wed, 27 Sep 2023 11:46:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DE09921E6900; Wed, 27 Sep 2023 13:46:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  "quintela@redhat.com"
 <quintela@redhat.com>,  "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 39/52] migration/rdma: Convert qemu_rdma_write_one() to
 Error
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-40-armbru@redhat.com>
 <9e117d0c-cf2b-dd01-7fef-55d1c41d254c@fujitsu.com>
 <b8f8ed5d-f20e-4309-f29c-960321ecad83@fujitsu.com>
 <87ttrhgu9e.fsf@pond.sub.org>
Date: Wed, 27 Sep 2023 13:46:40 +0200
In-Reply-To: <87ttrhgu9e.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 26 Sep 2023 11:26:37 +0200")
Message-ID: <87zg17dejj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

migration/rdma.c uses errno directly or via perror() after the following
functions:

* poll()

  POSIX specifies errno is set on error.  Good.

* rdma_get_cm_event(), rdma_connect(), rdma_get_cm_event()

  Manual page promises "if an error occurs, errno will be set".  Good.

* ibv_open_device()

  Manual page does not mention errno.  Using it seems ill-advised.

  qemu_rdma_broken_ipv6_kernel() recovers from EPERM by trying the next
  device.  Wrong if ibv_open_device() doesn't actually set errno.

  What is to be done here?

* ibv_reg_mr()

  Manual page does not mention errno.  Using it seems ill-advised.

  qemu_rdma_reg_whole_ram_blocks() and qemu_rdma_register_and_get_keys()
  recover from errno = ENOTSUP by retrying with modified @access
  argument.  Wrong if ibv_reg_mr() doesn't actually set errno.

  What is to be done here?

* ibv_get_cq_event()

  Manual page does not mention errno.  Using it seems ill-advised.

  qemu_rdma_block_for_wrid() calls perror().  Removed in PATCH 48.  Good
  enough.

* ibv_post_send()

  Manual page has the function return "the value of errno on failure".
  Sounds like it sets errno to the value it returns.  However, the
  rdma-core repository defines it as

    static inline int ibv_post_send(struct ibv_qp *qp, struct ibv_send_wr *wr,
                                    struct ibv_send_wr **bad_wr)
    {
            return qp->context->ops.post_send(qp, wr, bad_wr);
    }

  and at least one of the methods fails without setting errno:

    static int mana_post_send(struct ibv_qp *ibqp, struct ibv_send_wr *wr,
                              struct ibv_send_wr **bad)
    {
            /* This version of driver supports RAW QP only.
             * Posting WR is done directly in the application.
             */
            return EOPNOTSUPP;
    }

  qemu_rdma_write_one() calls perror().  PATCH 39 (this one) replaces it
  by error_setg(), not error_setg_errno().  Seems prudent, but should be
  called out in the commit message.

* ibv_advise_mr()

  Manual page has the function return "the value of errno on failure".
  Sounds like it sets errno to the value it returns, but my findings for
  ibv_post_send() make me doubt it.

  qemu_rdma_advise_prefetch_mr() traces strerror(errno).  Could be
  misleading.  Drop that part?

* ibv_dereg_mr()

  Manual page has the function return "the value of errno on failure".
  Sounds like it sets errno to the value it returns, but my findings for
  ibv_post_send() make me doubt it.

  qemu_rdma_unregister_waiting() calls perror().  Removed in PATCH 51.
  Good enough.

* qemu_get_cm_event_timeout()

  Can fail without setting errno.

  qemu_rdma_connect() calls perror().  Removed in PATCH 45.  Good
  enough.

Thoughts?


[...]

[*] https://github.com/linux-rdma/rdma-core.git
    commit 55fa316b4b18f258d8ac1ceb4aa5a7a35b094dcf


