Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7651480E872
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 11:01:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCzY9-0008E9-8c; Tue, 12 Dec 2023 04:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rCzY7-0008DV-FG
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 04:59:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rCzY4-0006ZC-E9
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 04:59:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702375171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bAwOFBEa2m16I6Aa8UQ3WzBVGe0tz748i0urIwu5Hhs=;
 b=FewTHV7F5cDm2zTSde7IZ2XSaFGyPPEKY3Wx+L+09XD1Q6rRW+E7VilUWNjXfQgmo7t2dl
 ROAue1ccDzSbIK9kMrde0BT7m+upUu8HormGzJqPZTT0qYmXZ0ckAfw97qepNxSAwYarmx
 y0vmwekucB3cEl9rlG4Qu2wFCiHcgRw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639--Z4_dCAQO3au4hND9pOsZw-1; Tue,
 12 Dec 2023 04:59:27 -0500
X-MC-Unique: -Z4_dCAQO3au4hND9pOsZw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3194D3C100AD;
 Tue, 12 Dec 2023 09:59:27 +0000 (UTC)
Received: from redhat.com (dhcp-192-205.str.redhat.com [10.33.192.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9236A2166B31;
 Tue, 12 Dec 2023 09:59:25 +0000 (UTC)
Date: Tue, 12 Dec 2023 10:59:24 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Michal Privoznik <mprivozn@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, aliang@redhat.com, qinwang@redhat.com
Subject: Re: [PATCH v2 1/2] qdev: add IOThreadVirtQueueMappingList property
 type
Message-ID: <ZXgu_AFqwr4Dthkk@redhat.com>
References: <20230918161604.1400051-1-stefanha@redhat.com>
 <20230918161604.1400051-2-stefanha@redhat.com>
 <ZXcVCMU7hYZ6jhp3@redhat.com> <87msugah6x.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msugah6x.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 11.12.2023 um 16:32 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 18.09.2023 um 18:16 hat Stefan Hajnoczi geschrieben:
> >> virtio-blk and virtio-scsi devices will need a way to specify the
> >> mapping between IOThreads and virtqueues. At the moment all virtqueues
> >> are assigned to a single IOThread or the main loop. This single thread
> >> can be a CPU bottleneck, so it is necessary to allow finer-grained
> >> assignment to spread the load.
> >> 
> >> Introduce DEFINE_PROP_IOTHREAD_VQ_MAPPING_LIST() so devices can take a
> >> parameter that maps virtqueues to IOThreads. The command-line syntax for
> >> this new property is as follows:
> >> 
> >>   --device '{"driver":"foo","iothread-vq-mapping":[{"iothread":"iothread0","vqs":[0,1,2]},...]}'
> >> 
> >> IOThreads are specified by name and virtqueues are specified by 0-based
> >> index.
> >> 
> >> It will be common to simply assign virtqueues round-robin across a set
> >> of IOThreads. A convenient syntax that does not require specifying
> >> individual virtqueue indices is available:
> >> 
> >>   --device '{"driver":"foo","iothread-vq-mapping":[{"iothread":"iothread0"},{"iothread":"iothread1"},...]}'
> >> 
> >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >
> > When testing this, Qing Wang noticed that "info qtree" crashes. This is
> > because the string output visitor doesn't support structs. I suppose
> > IOThreadVirtQueueMapping is the first struct type that is used in a qdev
> > property type.
> >
> > So we'll probably have to add some kind of struct support to the string
> > output visitor before we can apply this. Even if it's as stupid as just
> > printing "<struct IOThreadVirtQueueMapping>" without actually displaying
> > the value.
> 
> The string visitors have been nothing but trouble.
> 
> For input, we can now use keyval_parse() and the QObject input visitor
> instead.  Comes with restrictions, but I'd argue it's a more solid base
> than the string input visitor.
> 
> Perhaps we can do something similar for output: create a suitable
> formatter for use it with the QObject output visitor, replacing the
> string output visitor.

dump_qobject() frm block/qapi.c?

But I wouldn't like to block this series for a major rework of "info
qtree", so I think we need to make sure that the string input visitor
doesn't crash at least.

Kevin


