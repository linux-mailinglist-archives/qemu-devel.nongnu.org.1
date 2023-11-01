Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7B77DDE6F
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 10:31:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy7Ys-0005ZX-JB; Wed, 01 Nov 2023 05:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qy7Yq-0005ZP-Ui
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 05:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qy7Ym-0004H5-GA
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 05:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698831047;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9q1dXugD+IvA8nZ8zxDNF3WwnZ4sbRQUi8H6md4yIME=;
 b=cuGZq3+Stff3FOUpKMJ6Tc42A4pCNrvK4mJJl0DZjyLpTbalBfxAvE/UO12hFWHeikae23
 /tbBsTGTNSzKhnFD7VV20PquDEsOffpzk6Sbg1ZzGqyZU0egzOSZ7Ik69MRxskqauOFUe6
 qUVVXdAmDHDC5uJjup5nGPcmkEvOddA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-EsxNyRX1PEmshtTZCMSmwA-1; Wed,
 01 Nov 2023 05:30:43 -0400
X-MC-Unique: EsxNyRX1PEmshtTZCMSmwA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7886F3C025A1;
 Wed,  1 Nov 2023 09:30:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48848134;
 Wed,  1 Nov 2023 09:30:41 +0000 (UTC)
Date: Wed, 1 Nov 2023 09:30:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 28/29] migration: Add direct-io parameter
Message-ID: <ZUIav68fksPZpIJm@redhat.com>
References: <ZTkpllWQdLSMw3pP@redhat.com> <87cywvenbd.fsf@suse.de>
 <ZUDC4aoPZZQAF6JU@redhat.com> <878r7jdjrf.fsf@suse.de>
 <ZUEE9XP4YTJkZTv7@redhat.com> <875y2meua3.fsf@suse.de>
 <ZUEbzvRLdGjl4gl+@redhat.com> <8734xqeqly.fsf@suse.de>
 <ZUEkOb8M4fgfEITi@redhat.com> <87wmv2d33p.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wmv2d33p.fsf@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 31, 2023 at 04:05:46PM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Oct 31, 2023 at 12:52:41PM -0300, Fabiano Rosas wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> >
> >> > I guess I'm not seeing the problem still.  A single FD is passed across
> >> > from libvirt, but QEMU is free to turn that into *many* FDs for its
> >> > internal use, using dup() and then setting O_DIRECT on as many/few of
> >> > the dup()d FDs as its wants to.
> >> 
> >> The problem is that duplicated FDs share the file status flags. If we
> >> set O_DIRECT on the multifd channels and the main thread happens to do
> >> an unaligned write with qemu_file_put* then the filesystem will fail
> >> that write.
> >
> > Doh, I had forgotten that sharing.
> >
> > Do we have any synchronization between multifd  channels and the main
> > thread ?  eg does the main thread wait for RAM sending completion
> > before carrying on writing other non-RAM data ?
> 
> We do have, but the issue with that approach is that there are no rules
> for adding data into the stream. Anyone could add a qemu_put_* call
> right in the middle of the section for whatever reason.
> 
> That is almost a separate matter due to our current compatibility model
> being based on capabilities rather than resilience of the stream
> format. So extraneous data in the stream always causes the migration to
> break.
> 
> But with the O_DIRECT situation we'd be adding another aspect to
> this. Not only changing the code requires syncing capabilities (as it
> does today), but it would also require knowing which parts of the stream
> can be interrupted by new data and which cannot.
> 
> So while it would probably work, it's also a little fragile. If QEMU
> were given 2 FDs or given access to the file, then only the multifd
> channels would get O_DIRECT and they are guaranteed to not have
> extraneous unaligned data showing up.

So the problem with add-fd is that when requesting a FD, the monitor
code masks flags with O_ACCMODE.  What if we extended it such that
the monitor masked with O_ACCMODE | O_DIRECT.

That would let us pass 1 plain FD and one O_DIRECT fd, and be able
to ask for each separately by setting O_DIRECT or not.

Existing users of add-fd are not likely to be affected since none of
them will be using O_DIRECT.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


