Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF27030C3
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 16:59:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyZem-00010A-4h; Mon, 15 May 2023 10:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pyZek-0000zj-Fq
 for qemu-devel@nongnu.org; Mon, 15 May 2023 10:58:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pyZeh-0003Pl-2u
 for qemu-devel@nongnu.org; Mon, 15 May 2023 10:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684162710;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LtEeD1lZdj/JRM4eeIhOQLuHrkKi82+Ry6jE6QeODg8=;
 b=OqMhechHh/B5iIdg/8ypQmn8DI6TUMwfK34ys8xb2plahO4R+cd+/bW90E3w+QbzLoSZga
 73hb3NFcMVNfaM0KB6p3NUK8xPeOzoE8oHf/JG5ujRiAgJXgJvCWejeBZR8pklfWpnSVfB
 sxNR/6H+OloY0Mbh4qcQFEc6ZuoqD6o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-5YioyWUsMu6YlhfFZmeaYg-1; Mon, 15 May 2023 10:58:27 -0400
X-MC-Unique: 5YioyWUsMu6YlhfFZmeaYg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4CB686BF46;
 Mon, 15 May 2023 14:58:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D98E3492B00;
 Mon, 15 May 2023 14:58:20 +0000 (UTC)
Date: Mon, 15 May 2023 15:58:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v4 4/8] migration: converts rdma backend to accept
 MigrateAddress struct
Message-ID: <ZGJIiJADoEOrLUVn@redhat.com>
References: <20230512143240.192504-1-het.gala@nutanix.com>
 <20230512143240.192504-5-het.gala@nutanix.com>
 <ZGIIVc83VbEMgUhB@redhat.com>
 <ae609793-7d9b-a305-d0bf-e8e9eb59d66c@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae609793-7d9b-a305-d0bf-e8e9eb59d66c@nutanix.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, May 15, 2023 at 08:08:57PM +0530, Het Gala wrote:
> 
> On 15/05/23 3:54 pm, Daniel P. Berrangé wrote:
> > On Fri, May 12, 2023 at 02:32:36PM +0000, Het Gala wrote:
> > > RDMA based transport backend for 'migrate'/'migrate-incoming' QAPIs
> > > accept new wire protocol of MigrateAddress struct.
> > > 
> > > It is achived by parsing 'uri' string and storing migration parameters
> > > required for RDMA connection into well defined InetSocketAddress struct.
> > > 
> > > Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> > > Signed-off-by: Het Gala <het.gala@nutanix.com>
> > > ---
> > >   migration/migration.c |  8 ++++----
> > >   migration/rdma.c      | 38 ++++++++++++++++----------------------
> > >   migration/rdma.h      |  6 ++++--
> > >   3 files changed, 24 insertions(+), 28 deletions(-)
> > > 
> > > @@ -3360,10 +3346,12 @@ static int qemu_rdma_accept(RDMAContext *rdma)
> > >                                               .private_data_len = sizeof(cap),
> > >                                            };
> > >       RDMAContext *rdma_return_path = NULL;
> > > +    InetSocketAddress *isock = g_new0(InetSocketAddress, 1);
> > >       struct rdma_cm_event *cm_event;
> > >       struct ibv_context *verbs;
> > >       int ret = -EINVAL;
> > >       int idx;
> > > +    char arr[8];
> > >       ret = rdma_get_cm_event(rdma->channel, &cm_event);
> > >       if (ret) {
> > > @@ -3375,13 +3363,17 @@ static int qemu_rdma_accept(RDMAContext *rdma)
> > >           goto err_rdma_dest_wait;
> > >       }
> > > +    isock->host = rdma->host;
> > > +    sprintf(arr,"%d", rdma->port);
> > > +    isock->port = arr;
> > While Inet ports are 16-bit, and so 65535 fits in a char[8], nothing
> > at the QAPI parser level is enforcing this.
> > 
> > IOW, someone can pass QEMU a QAPI config with port = 235252353253253253232
> > and casue this sprintf to smash the stack.
> > 
> > Also this is assigning a stack variable to isock->port which
> > expects a heap variable. qapi_free_InetSocketAddress() will
> > call free(isock->port) which will again crash.
> > 
> > Just do
> > 
> >    g_autoptr(InetSocketAddress) isock = g_new0(InetSocketAddress, 1);
> > 
> >    isock->port = g_strdup_printf("%d", rdma->port);
> Thanks Daniel. Will change this in next version of patchset. Is a protection
> for isock->host and isock->port needed here ?

This will be validated later by getaddrinfo() so IMHO QEMU doesn't
need todo anythgin


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


