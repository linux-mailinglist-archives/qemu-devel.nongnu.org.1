Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CBD7D384D
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 15:43:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quvCp-0000W4-0s; Mon, 23 Oct 2023 09:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1quvCl-0000P2-0Z
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1quvCj-0007MJ-Be
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698068568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3srV4Gm1ksQiJrOJIhacCwt8+4D8AOhsm6+o+iJiYy4=;
 b=ZTftTwENYzc8VGOuBiNrodOAk1vApM7m4pi5EQ5ad4Pqbm9HzUIjv7xTw9yniXG/VuhXD+
 GBnsiRPBW8K9oXSU87HpyBGfIfwuhR8HLeFlhUI3JmQsfWDTAnsDBb4pzeBbzLbSKc+IlK
 ihYkIXIE4rrTVJ/t+HRE2VfGb8NwtHA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-_npB_AAzOa6YZrvrrqLf9Q-1; Mon, 23 Oct 2023 09:42:43 -0400
X-MC-Unique: _npB_AAzOa6YZrvrrqLf9Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77A9F802896;
 Mon, 23 Oct 2023 13:42:41 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.144])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA86B2166B26;
 Mon, 23 Oct 2023 13:42:39 +0000 (UTC)
Date: Mon, 23 Oct 2023 15:42:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v3 1/9] blockjob: introduce block-job-change QMP command
Message-ID: <ZTZ4TlOwFNZgb9pq@redhat.com>
References: <20231013092143.365296-1-f.ebner@proxmox.com>
 <20231013092143.365296-2-f.ebner@proxmox.com>
 <ZS//MVrI7XeJT0Bq@redhat.com>
 <64667e64-0b32-4cb4-b76a-4bd444964e3d@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64667e64-0b32-4cb4-b76a-4bd444964e3d@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 23.10.2023 um 11:31 hat Fiona Ebner geschrieben:
> Am 18.10.23 um 17:52 schrieb Kevin Wolf:
> > Am 13.10.2023 um 11:21 hat Fiona Ebner geschrieben:
> >> which will allow changing job-type-specific options after job
> >> creation.
> >>
> >> In the JobVerbTable, the same allow bits as for set-speed are used,
> >> because set-speed can be considered an existing change command.
> >>
> >> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> >> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > 
> >> diff --git a/job.c b/job.c
> >> index 72d57f0934..99a2e54b54 100644
> >> --- a/job.c
> >> +++ b/job.c
> >> @@ -80,6 +80,7 @@ bool JobVerbTable[JOB_VERB__MAX][JOB_STATUS__MAX] = {
> >>      [JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0},
> >>      [JOB_VERB_FINALIZE]             = {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
> >>      [JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
> >> +    [JOB_VERB_CHANGE]               = {0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0},
> >>  };
> > 
> > I'm not sure if I would have included JOB_STATUS_CREATED, i.e. before
> > the job has even started, but it's not necessarily a problem. The
> > implementation just need to be careful to work even in early stages. But
> > probably the early stages include some part of JOB_STATUS_RUNNING, too,
> > so they'd have to do this anyway.
> > 
> 
> As mentioned in the commit message, I copied the bits from
> JOB_VERB_SET_SPEED, because that seemed to be very similar, as it can
> also be seen as a change operation (and who knows, maybe it can be
> merged into JOB_VERB_CHANGE at some point in the future). But I can
> remove the bit if you want me to.

I think it's fine as it is, just something to keep in mind while
reviewing implementations.

What you could do is adding something to the comment for the change
callback in blockjob_int.h, like "Note that this can already be called
before the job coroutine is running".

Kevin


