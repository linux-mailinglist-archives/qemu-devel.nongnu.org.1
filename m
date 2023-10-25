Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F29C7D70AF
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 17:21:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfgl-0008Nv-6g; Wed, 25 Oct 2023 11:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qvfgg-0008NN-GJ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qvfgd-0004xY-CV
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698247246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S5zPLrGVRbXs38xKezpOxwy66RiFCOX7+GEyWZ03jk4=;
 b=UB56kZtjaGtJB6UHHGb7HID61O4InpS+zpF5lmNApbVP4fygjfHpqMm0E5f5FdGQoG3qzV
 AXh5cpJeKjClAQefqHld2QCXeSJmRWbtAjI//ysP1BxYsj9u1uHpCA+RCdUIoTNPoshu/b
 C5/MrO1zZi+yBwHzxDAzPsTOhYRiiHk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-r-uDt3QmOCufmYuz1h6Fkw-1; Wed,
 25 Oct 2023 11:20:44 -0400
X-MC-Unique: r-uDt3QmOCufmYuz1h6Fkw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CD8A280017F;
 Wed, 25 Oct 2023 15:20:43 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7570C25C0;
 Wed, 25 Oct 2023 15:20:41 +0000 (UTC)
Date: Wed, 25 Oct 2023 17:20:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v3 0/9] mirror: allow switching from background to active
 mode
Message-ID: <ZTkySKEa4Lt5iNc9@redhat.com>
References: <20231013092143.365296-1-f.ebner@proxmox.com>
 <ZTEwzi8x6cFfP9+e@redhat.com>
 <b81617df-2a68-4a89-9518-8441e01aaa0f@proxmox.com>
 <3d4cfc31-beb9-4b89-b185-13c6e01ede49@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d4cfc31-beb9-4b89-b185-13c6e01ede49@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 25.10.2023 um 14:27 hat Fiona Ebner geschrieben:
> Am 23.10.23 um 13:39 schrieb Fiona Ebner:
> > Am 19.10.23 um 15:36 schrieb Kevin Wolf:
> >> Most of this series looks good to me. Apart from the comments I made in
> >> the individual patches, I would like to see iotests coverage of changing
> >> the mirroring mode. At the least to show that the query result changes,
> >> but ideally also that requests really block after switchting to active.
> >> I think with a throttled target node and immediately reading the target
> >> when the write request completes we should be able to check this.
> >>
> > 
> > I'll try to work something out for v4.
> > 
> 
> I'm having a bit of a hard time unfortunately. I created a throttle
> group with
> 
> >                 'iops-total': iops,
> >                 'iops-total-max': iops

I would have throttled only writes, because you need to do a read to
check the target and don't want that one to be throttled until the
writes have completed.

> and used that for the 'throttle' driver for the target. I then tried
> issuing requests via qemu_io
> 
> >             self.vm.hmp_qemu_io('mirror-top',
> >                                 f'aio_write -P 1 {req_size * i} {req_size * (i + 1)}')
> 
> but when I create more requests than the 'iops' limit (to ensure that
> not all are completed immediately), it will get stuck when draining the
> temporary BlockBackend used by qemu_io [0]. Note this is while still in
> background mode.

You should be able to get around this by using an existing named
BlockBackend (created with -drive if=none) instead of a node name.
mirror-top stays at the root of the tree, right?

> I also wanted to have request going on while the copy mode is changed
> and for that, I was able to work around the issue by creating an NBD
> export of the source like in iotest 151 and issuing the requests to the
> NBD socket instead.
> 
> But after I switch to active mode and when I issue more than the 'iops'
> limit requests to the NBD export then, it also seems to get stuck,
> visible during shutdown when it tries to close the export[1].

Because the NBD server still throttles the I/O that needs to complete
until QEMU can shut down? If this is a problem, I suppose you can
lift the limit on the NBD server side if you use QSD.

graph-changes-while-io is an example of a test cases that uses QSD.

Kevin


