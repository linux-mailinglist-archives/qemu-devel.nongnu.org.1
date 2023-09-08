Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B1D7986DB
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:10:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeaJN-0000rV-1k; Fri, 08 Sep 2023 08:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeaJ8-0000nP-36
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:09:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeaJ2-0002XA-8y
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694174986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RammnBa47Se9pK2YVoeEL/y0aA+bVFAk6M5JvfkJ65w=;
 b=KflqNzlQJydteL/CWVFdPuDj7ZcMC0ze2zFTOudTquTJQimWK8NuMR3+dARcsMaDyTT3pi
 vMddtoACrydnA/A8aSQkSMDkLkey/5tbpoG+1CMQkCfVVK4ZUtmFUuQB55rVdNy1d52TXL
 xBj5zyMsjMSCqeqNl67XO5e+2bXIU0Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-v3Zd-3G4MDCyKe4XLfOJ5w-1; Fri, 08 Sep 2023 08:09:42 -0400
X-MC-Unique: v3Zd-3G4MDCyKe4XLfOJ5w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C70F2101A529;
 Fri,  8 Sep 2023 12:09:41 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3E4D403171;
 Fri,  8 Sep 2023 12:09:40 +0000 (UTC)
Date: Fri, 8 Sep 2023 07:09:39 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, 
 "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, 
 Mike Maslenkin <mike.maslenkin@gmail.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Subject: Re: [PULL 12/13] qemu-nbd: Restore "qemu-nbd -v --fork" output
Message-ID: <lvv73ne7fn7blrymkq4dcw6vxa7i3dcuh6cyfrdvrsail2q5zy@me7cx6ig7fjq>
References: <20230908013535.990731-15-eblake@redhat.com>
 <20230908013535.990731-27-eblake@redhat.com>
 <CAJSP0QWYDPU-26Jt7-SN4s-hyL1jg4-_eXz+9huCfzO+nL8D=w@mail.gmail.com>
 <15abbb9a-eeff-1468-c512-97497c682a67@virtuozzo.com>
 <d87989e9-a14f-0236-b673-f7927293546f@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d87989e9-a14f-0236-b673-f7927293546f@virtuozzo.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

On Fri, Sep 08, 2023 at 01:42:00PM +0200, Denis V. Lunev wrote:
> On 9/8/23 13:24, Denis V. Lunev wrote:
> > On 9/8/23 13:03, Stefan Hajnoczi wrote:
> > > Please resolve the following CI failure:
> > > 
> > > https://gitlab.com/qemu-project/qemu/-/jobs/5045998355
> > > 
> > > ../qemu-nbd.c: In function 'nbd_client_thread':
> > > ../qemu-nbd.c:340:39: error: expected identifier before '(' token
> > > 340 | nbd_client_release_pipe(opts->stderr);
> > > | ^~~~~~

> The only possible reason I could imagine is that 'stderr'
> word is defined under by pre-processor.

Indeed, that is a common implementation; the obvious fix is to use a
different name.  v2 coming up with that change made.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


