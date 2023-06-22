Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB66A739DF1
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 12:00:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCH6o-0006Mb-Iv; Thu, 22 Jun 2023 06:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qCH6m-0006MP-0j
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qCH6k-0002I1-4v
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687428004;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8/qsvRSxK1CCHMBPieHgoKt5txYjc1cTEK/RDXwGsrc=;
 b=b3XRBq4YIxckatlNBC/Vf3P6edTa2trLmNMWWvlYFGcrlZM5LsOS36i98S7BciC/ZHew5h
 ClgUZ66gB1HaTDlraYhIUo4PT/cUL3SGZXZpFYBln0enwwpCDP8neC0gleXUw0poB9IyjG
 p0T1faGOh3xd5F2veEcSMcNYJN95qOU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-9oda4wYvMRCsfCF1gd-KMA-1; Thu, 22 Jun 2023 06:00:02 -0400
X-MC-Unique: 9oda4wYvMRCsfCF1gd-KMA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8887185A7A9;
 Thu, 22 Jun 2023 10:00:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 465781402C06;
 Thu, 22 Jun 2023 10:00:00 +0000 (UTC)
Date: Thu, 22 Jun 2023 10:59:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
Message-ID: <ZJQbnmbFZkY51bSy@redhat.com>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica>
 <d88c707a-abd9-6c8e-907c-13a3fa9a0219@redhat.com>
 <87wmzv7ubn.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmzv7ubn.fsf@secure.mitica>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jun 22, 2023 at 10:52:12AM +0200, Juan Quintela wrote:
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> > On 6/12/23 22:51, Juan Quintela wrote:
> >>> Shall we just leave it there?  Or is deprecating it helps us in any form?
> >> See the patches two weeks ago when people complained that lisen(.., num)
> >> was too low.  And there are other parameters that work the same way
> >> (that I convenientely had forgotten).  So the easiest way to get things
> >> right is to use "defer" always.  Using -incoming "uri" should only be
> >> for people that "know what they are doing", so we had to ways to do it:
> >> - review all migration options and see which ones work without defer
> >>    and document it
> >> - deprecate everything that is not defer.
> >
> > "-incoming <uri>" is literally the same as running "migrate-incoming"
> > as the first thing on the monitor:
> >
> >     if (incoming) {
> >         Error *local_err = NULL;
> >         if (strcmp(incoming, "defer") != 0) {
> >             qmp_migrate_incoming(incoming, &local_err);
> >             if (local_err) {
> >                 error_reportf_err(local_err, "-incoming %s: ", incoming);
> >                 exit(1);
> >             }
> >         }
> >     } else if (autostart) {
> >         qmp_cont(NULL);
> >     }
> >
> > It's the only piece of code which distinguishes "-incoming defer" from
> > "-incoming <uri>".
> >
> > So I'm not sure what the problem would be with keeping it?
> 
> User friendliness.
> 
> First of all, I use it all the time.  And I know that it is useful for
> developers.  I was the one asking peter to implement -global
> migration.foo to be able to test multifd with it.
> 
> The problem is that if you use more than two channels with multifd, on
> the incoming side, you need to do:
> 
> - migrate_set_parameter multifd-channels 16
> - migrate_incoming <uri>
> 
> And people continue to do:
> 
> - qemu -incoming <uri>
> - migrate_set_parameter multifd-channels 16 (on the command line)
> 
> And they complain that it fails, because we are calling listen with the
> wrong value.

IMHO if we want to improve user friendliness then arguing about use
of the CLI vs QMP for migration is completely missing the bigger
picture IMHO.

I've mentioned several times before that the user should never need to
set this multifd-channels parameter (nor many other parameters) on the
destination in the first place.

The QEMU migration stream should be changed to add a full
bi-directional handshake, with negotiation of most parameters.
IOW, the src QEMU should be configured with 16 channels, and
it should connect the primary control channel, and then directly
tell the dest that it wants to use 16 multifd channels.

If we're expecting the user to pass this info across to the dest
manually we've already spectacularly failed wrt user friendliness.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


