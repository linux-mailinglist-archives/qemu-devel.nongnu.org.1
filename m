Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE37A715BEA
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 12:35:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3wgZ-0005WI-BM; Tue, 30 May 2023 06:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q3wgQ-0005Va-Pj
 for qemu-devel@nongnu.org; Tue, 30 May 2023 06:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q3wgO-00060E-LL
 for qemu-devel@nongnu.org; Tue, 30 May 2023 06:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685442868;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=LyRpqIFTVareTZZ9IlTI+0kaYp2a6jO/RXJAdfuxOPA=;
 b=MxAf83VO0rWC5HWD4lIsQFoL3dyXhMGmoS9KQKctq9OzD7y8HiQuLp2SlVePwt+4QBFL5J
 Ou2he1Y7qn1B2n6CQVMx2HVYq89fx9kpafLXd5ECifA/0kmReLbBIvb2nmooIH2eehNNFf
 N1blmLukkRO04hC494cjCrpx5HmcGKA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-EnkmRWsfNvaSNgI3BiEOuQ-1; Tue, 30 May 2023 06:34:26 -0400
X-MC-Unique: EnkmRWsfNvaSNgI3BiEOuQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F58285A5AA;
 Tue, 30 May 2023 10:34:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 249A8140EBB8;
 Tue, 30 May 2023 10:34:24 +0000 (UTC)
Date: Tue, 30 May 2023 11:34:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v5 1/9] migration: introduced 'MigrateAddress' in QAPI
 for migration wire protocol.
Message-ID: <ZHXRLlL67vK8w32B@redhat.com>
References: <20230519094617.7078-1-het.gala@nutanix.com>
 <20230519094617.7078-2-het.gala@nutanix.com>
 <87sfbkjow3.fsf@pond.sub.org>
 <af2e5fbe-75f5-d6dd-df8c-8894cc5b0056@nutanix.com>
 <87edmyuwzc.fsf@pond.sub.org>
 <99b3e516-2a4a-aa48-8bc2-7bb886b8db52@nutanix.com>
 <878rd6tfqi.fsf@pond.sub.org>
 <fde7d182-0744-d907-5c1d-3f60f9a5d19c@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fde7d182-0744-d907-5c1d-3f60f9a5d19c@nutanix.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
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

On Tue, May 30, 2023 at 02:26:23PM +0530, Het Gala wrote:
> 
> On 30/05/23 1:26 pm, Markus Armbruster wrote:
> > Het Gala <het.gala@nutanix.com> writes:
> > 
> > > On 30/05/23 12:28 pm, Markus Armbruster wrote:
> > > > Het Gala<het.gala@nutanix.com>  writes:
> > > > 
> > > > > On 25/05/23 11:04 pm, Markus Armbruster wrote:
> > [...]
> > 
> > > > > > Aside: a more powerful type system would let us extend SocketAddress
> > > > > > with additional variants instead of wrapping it in a union.
> > > > > Markus, what do you mean by additional variants here in context of socket? Can you give a small example.
> > > > As is, we have a nest of two unions:
> > > > 
> > > > * The outer union has branches @socket, @exec, @rdma.
> > > > 
> > > > * Branch @socket is the inner union, it has branches @inet, @unix, ...
> > > > 
> > > > A more powerful type system would let us extend SocketAddress instead,
> > > > so MigrateAddress has everything SocketAddress has, plus additional
> > > > branches @exec, @rdma.  Naturally, the type of the discriminator also
> > > > needs to be extended, so that it has everything SocketAddress's
> > > > discriminator type has, plus additional members @exec, @rdma.
> > > Okay, so you mean something like :
> > > 
> > > +# Since 8.1
> > > +##
> > > +{ 'union': 'MigrateAddress',
> > > +  'base': { 'transport' : 'MigrateTransport'},
> > > +  'discriminator': 'transport',
> > > +  'data': {
> > > +    'inet': 'InetSocketAddress',
> > > +    'unix': 'UnixSocketAddress',
> > > +    'vsock': 'VsockSocketAddress',
> > > +    'fd': 'str',
> > > +    'exec': 'MigrateExecCommand',
> > > +    'rdma': 'InetSocketAddress' } }
> > > 
> > > Even I agree that directly leveraging this is the best option, but then wouldn't it introduce redundancy ? we would not be able to leverage socket union right in that case or am I missing something.
> > Yes, there's redundancy, due to QAPI's insufficient expressive power.
> > 
> > Is the cleaner external interface worth the (internal) redundancy, and
> > possibly coding complications that go with it?
> 
> Honestly, I would like to have it this way, where the user is aware of all
> the transport mechanisms available. But I guess for external interface
> problem statement, the migration code flow has similar path for
> SocketAddress and non-socketAddress (exec and rdma). So even if on the QAPI
> side we express explicitly all the transport mechanisms, while implementing
> it we either would need to brinf them under a single umbrella. For now, I
> would keep the implementation as it is (union inside a union) but would want
> to have a more powerful and better appraoch out there if possible.

IMHO, unpacking the SocketAddress types into the two level is not something
we need to do. The main (perhaps even only) reason it arises as a design
question is because historically the migration public interface has NOT
used SocketAddress, and exposed unix/inet/vsock as distinct top level 
options, and this taints our thoughts.

If the "migrate" command didn't already exist and we were adding it now
IMHO we would just expose 'socket': 'SocketAdress' as a top level type,
in parallel with 'exec' and 'rdma', and not even discuss the idea of
unpacking 'SocketAddress'.

IMHO the compelling reason to NOT unpack 'SocketAddress' is that it lets
the migration code seemlessly benefit from any new 'SocketAddress' types
that gets implemented. eg consider when 'vsock' was added to QEMU. Any
command that took a 'SocketAddress' parameter needed no QAPI changes
and usually no code changes either.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


