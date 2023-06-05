Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEA87222DB
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:04:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6740-0004aB-Vg; Mon, 05 Jun 2023 06:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q673y-0004X8-H0
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q673x-0000Tp-0F
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685959423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+tZFA7O9Hezpf4v8slBwetC9ufodCKLDkzRj52ho6QY=;
 b=Z0pSWkoqvZcOe+ixcjpsdNR1vYbSKdDkL6dyNYz8X5DOmWFZeeyYzaI1j6zZ+kny6rYzol
 uz4YDpc1BuIoBkCkMdnjnX/DymXfVPsowd1bv3bl3a47W5pv57Ng5jjuUlSQLuAQyfTciF
 qHt+MKK4Kri+ZVdVgjhfmo/aFlr1Ni4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-qemsh4oJP4WnT4jJ3oyyfw-1; Mon, 05 Jun 2023 06:03:41 -0400
X-MC-Unique: qemsh4oJP4WnT4jJ3oyyfw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6043A1C02D34;
 Mon,  5 Jun 2023 10:03:41 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B909C0448E;
 Mon,  5 Jun 2023 10:03:40 +0000 (UTC)
Date: Mon, 5 Jun 2023 12:03:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 11/11] Revert "graph-lock: Disable locking for now"
Message-ID: <ZH2y+zAgThSJ67oZ@redhat.com>
References: <20230605085711.21261-1-kwolf@redhat.com>
 <20230605085711.21261-12-kwolf@redhat.com>
 <fbcb21e3-9544-eea2-ab5b-9bb84ac7c90b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbcb21e3-9544-eea2-ab5b-9bb84ac7c90b@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 05.06.2023 um 11:06 hat Paolo Bonzini geschrieben:
> On 6/5/23 10:57, Kevin Wolf wrote:
> >   void bdrv_graph_rdlock_main_loop(void)
> > @@ -296,18 +276,13 @@ void assert_bdrv_graph_readable(void)
> >   {
> >       /* reader_count() is slow due to aio_context_list_lock lock contention */
> >       /* TODO Reenable when wrlock is reenabled */
> 
> There's still a TODO here.

Thanks for catching that. If I don't have to respin for something else,
I'll fix it up before applying.

Keviun


