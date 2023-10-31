Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A03D7DD074
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:24:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqaL-0001OZ-B7; Tue, 31 Oct 2023 11:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qxqaJ-0001O0-1J
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qxqaH-0000Ya-64
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698765790;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V0LeFM5hxhBXUCYD++t+ECZ0OntMAcqB16zdfe7y99o=;
 b=Evk6x9gtydg/8vbGgo2OzWkM0r8DIcoKNkZ/enh7PGpO8Kg+rIpa5quwYD3LxgXmmfs/7B
 QYRnFTtMo2Ru96uIeqorUS0OZmMoDP2ADEnqmj401ezxyeuuqW027EDrAAro2TdYVu2Nwq
 APQMneyF4g9UAetml0+m6KQb92yITSQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-46-CtOkN51UN_-JGvkigN97wQ-1; Tue,
 31 Oct 2023 11:23:07 -0400
X-MC-Unique: CtOkN51UN_-JGvkigN97wQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 905FF3C1E9DB;
 Tue, 31 Oct 2023 15:22:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D67B2026D4C;
 Tue, 31 Oct 2023 15:22:56 +0000 (UTC)
Date: Tue, 31 Oct 2023 15:22:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 28/29] migration: Add direct-io parameter
Message-ID: <ZUEbzvRLdGjl4gl+@redhat.com>
References: <878r7svapt.fsf@pond.sub.org> <87msw7ddfp.fsf@suse.de>
 <ZTjVg9NVTd0MT6mW@redhat.com> <87cyx2epsv.fsf@suse.de>
 <ZTkpllWQdLSMw3pP@redhat.com> <87cywvenbd.fsf@suse.de>
 <ZUDC4aoPZZQAF6JU@redhat.com> <878r7jdjrf.fsf@suse.de>
 <ZUEE9XP4YTJkZTv7@redhat.com> <875y2meua3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875y2meua3.fsf@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

On Tue, Oct 31, 2023 at 11:33:24AM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Oct 31, 2023 at 10:05:56AM -0300, Fabiano Rosas wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > On Mon, Oct 30, 2023 at 07:51:34PM -0300, Fabiano Rosas wrote:
> >> >> I could use some advice on how to solve this situation. The fdset code
> >> >> at monitor/fds.c and the add-fd command don't seem to be usable outside
> >> >> the original use-case of passing fds with different open flags.
> >> >> 
> >> >> There are several problems, the biggest one being that there's no way to
> >> >> manipulate the set of file descriptors aside from asking for duplication
> >> >> of an fd that matches a particular set of flags.
> >> >> 
> >> >> That doesn't work for us because the two fds we need (one for main
> >> >> channel, other for secondary channels) will have the same open flags. So
> >> >> the fdset code will always return the first one it finds in the set.
> >> >
> >> > QEMU may want multiple FDs *internally*, but IMHO that fact should
> >> > not be exposed to mgmt applications. It would be valid for a QEMU
> >> > impl to share the same FD across multiple threads, or have a different
> >> > FD for each thread. All threads are using pread/pwrite, so it is safe
> >> > for them to use the same FD if they desire. It is a private impl choice
> >> > for QEMU at any given point in time and could change over time.
> >> >
> >> 
> >> Sure, I don't disagree. However up until last week we had a seemingly
> >> usable "add-fd" command that allows the user to provide a *set of file
> >> descriptors* to QEMU. It's just now that we're learning that interface
> >> serves only a special use-case.
> >
> > AFAICT though we don't need add-fd to support passing many files
> > for our needs. Saving only requires a single FD. All others can
> > be opened by dup(), so the limitation of add-fd is irrelevant
> > surely ?
> 
> Only once we decide to use one FD. If we had a generic add-fd backend,
> then that's already a user-facing API, so the "implementation detail"
> argument becomes weaker.
> 
> With a single FD we'll need to be very careful about what code is
> allowed to run while the multifd channels are doing IO. Since O_DIRECT
> is not widely supported, now we have to also be careful about someone
> using that QEMUFile handle to do unaligned writes and not even noticing
> that it breaks direct IO. None of this in unworkable, of course, I just
> find the design way clearer with just the file name + offset.

I guess I'm not seeing the problem still.  A single FD is passed across
from libvirt, but QEMU is free to turn that into *many* FDs for its
internal use, using dup() and then setting O_DIRECT on as many/few of
the dup()d FDs as its wants to.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


