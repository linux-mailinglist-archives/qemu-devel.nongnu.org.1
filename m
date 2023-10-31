Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B1E7DD5C5
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 19:06:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxt77-0002dF-A8; Tue, 31 Oct 2023 14:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxt73-0002cP-WA
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxt71-00058m-U2
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698775510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gWeWr0XwsbaIWaAXEpYtYi6pH3q7IdQANy35AXMr5fE=;
 b=h97Rw+UVo2l5+/S9KQdS7Bhxq+HxNsPT3lkNxQpLDL8V928IINLQffQgLo9emz01gmdBjI
 PnqYRQD9puUJXxMRzlend2jV3/6lK4t994Xd3J40NOCWft2HElIEgM5kYkdwgcRZuMCeAf
 gsY+Px0m8N5TzuSUvhVoLzrbQrZdWGc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-8cANmtvSOGyg-8jJ57uRdg-1; Tue,
 31 Oct 2023 14:05:06 -0400
X-MC-Unique: 8cANmtvSOGyg-8jJ57uRdg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 542C51C0690B;
 Tue, 31 Oct 2023 18:05:06 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37D3240C6EBC;
 Tue, 31 Oct 2023 18:05:03 +0000 (UTC)
Date: Tue, 31 Oct 2023 19:05:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v4 00/10] mirror: allow switching from background to
 active mode
Message-ID: <ZUFBzvyNGKda0r1K@redhat.com>
References: <20231031135431.393137-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031135431.393137-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 31.10.2023 um 14:54 hat Fiona Ebner geschrieben:
> Changes in v4:
>     * add an iotest for the new functionality
>     * set actively_synced to false when setting dirty bitmap in
>       bdrv_mirror_top_do_write
>     * add comments describing requirements for accessing copy_mode and
>       actively_synced field
>     * add global state code annotation and comment about assumptions
>       in mirror_change method
>     * add comment that change callback can be called before the job
>       coroutine is running
>     * fix typo in QAPI description
> 
> Changes in v3:
>     * unlock the job mutex when calling the new block job driver
>       'query' handler
>     * squash patch adapting iotest output into patch that changes the
>       output
>     * turn accesses to copy_mode and actively_synced atomic
>     * slightly rework error handling in mirror_change
> 
> Changes in v2:
>     * move bitmap to filter which allows to avoid draining when
>       changing the copy mode
>     * add patch to determine copy_to_target only once
>     * drop patches returning redundant information upon query
>     * update QEMU version in QAPI
>     * update indentation in QAPI
>     * update indentation in QAPI (like in a937b6aa73 ("qapi: Reformat
>       doc comments to conform to current conventions"))
>     * add patch to adapt iotest output
> 
> Discussion of v3:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg04026.html
> 
> Discussion of v2:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg02290.html
> 
> Discussion of v1:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-02/msg07216.html
> 
> With active mode, the guest write speed is limited by the synchronous
> writes to the mirror target. For this reason, management applications
> might want to start out in background mode and only switch to active
> mode later, when certain conditions are met. This series adds a
> block-job-change QMP command to achieve that, as well as
> job-type-specific information when querying block jobs, which
> can be used to decide when the switch should happen.
> 
> For now, only the direction background -> active is supported.
> 
> The information added upon querying is whether the target is actively
> synced, the total data sent, and the remaining dirty bytes.
> 
> Initially, I tried to go for a more general 'job-change' command, but
> to avoid mutual inclusion of block-core.json and job.json, more
> preparation would be required. More details described here:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg02993.html
> 
> Fiona Ebner (10):
>   blockjob: introduce block-job-change QMP command
>   block/mirror: set actively_synced even after the job is ready
>   block/mirror: move dirty bitmap to filter
>   block/mirror: determine copy_to_target only once
>   mirror: implement mirror_change method
>   qapi/block-core: use JobType for BlockJobInfo's type
>   qapi/block-core: turn BlockJobInfo into a union
>   blockjob: query driver-specific info via a new 'query' driver method
>   mirror: return mirror-specific information upon query
>   iotests: add test for changing mirror's copy_mode

Thanks, applied to the block branch.

Kevin


