Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B48B7DCE24
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:47:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxp3u-0000yW-BV; Tue, 31 Oct 2023 09:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qxp3q-0000yK-RB
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qxp3n-0006mE-MC
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698759932;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uQWDpR4TinU24LtQ2KGlB4XgMsMBqc2kEHFduddV71s=;
 b=h7b8aFIqEDvTBWUQJsCPwOniDMsS0Vdbx4I6ixp6/q0VoE+4QnsjH2A0DvZNj1xjfu4fLs
 mk2M94pkGttY5ZJW8zWDtZhlGyrkXYLfrbvGdj8X+5q79a6VDfQNg5YjA5bylWtPFbu6XW
 3OTXfIbpuKyp5tay3xzpGUxXkXtSXhE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-hXE-DBKTNVyqkCz4-7iFtw-1; Tue, 31 Oct 2023 09:45:29 -0400
X-MC-Unique: hXE-DBKTNVyqkCz4-7iFtw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D468831501;
 Tue, 31 Oct 2023 13:45:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E81E40C6EB9;
 Tue, 31 Oct 2023 13:45:27 +0000 (UTC)
Date: Tue, 31 Oct 2023 13:45:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 28/29] migration: Add direct-io parameter
Message-ID: <ZUEE9XP4YTJkZTv7@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-29-farosas@suse.de>
 <878r7svapt.fsf@pond.sub.org> <87msw7ddfp.fsf@suse.de>
 <ZTjVg9NVTd0MT6mW@redhat.com> <87cyx2epsv.fsf@suse.de>
 <ZTkpllWQdLSMw3pP@redhat.com> <87cywvenbd.fsf@suse.de>
 <ZUDC4aoPZZQAF6JU@redhat.com> <878r7jdjrf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878r7jdjrf.fsf@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 31, 2023 at 10:05:56AM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Mon, Oct 30, 2023 at 07:51:34PM -0300, Fabiano Rosas wrote:
> >> I could use some advice on how to solve this situation. The fdset code
> >> at monitor/fds.c and the add-fd command don't seem to be usable outside
> >> the original use-case of passing fds with different open flags.
> >> 
> >> There are several problems, the biggest one being that there's no way to
> >> manipulate the set of file descriptors aside from asking for duplication
> >> of an fd that matches a particular set of flags.
> >> 
> >> That doesn't work for us because the two fds we need (one for main
> >> channel, other for secondary channels) will have the same open flags. So
> >> the fdset code will always return the first one it finds in the set.
> >
> > QEMU may want multiple FDs *internally*, but IMHO that fact should
> > not be exposed to mgmt applications. It would be valid for a QEMU
> > impl to share the same FD across multiple threads, or have a different
> > FD for each thread. All threads are using pread/pwrite, so it is safe
> > for them to use the same FD if they desire. It is a private impl choice
> > for QEMU at any given point in time and could change over time.
> >
> 
> Sure, I don't disagree. However up until last week we had a seemingly
> usable "add-fd" command that allows the user to provide a *set of file
> descriptors* to QEMU. It's just now that we're learning that interface
> serves only a special use-case.

AFAICT though we don't need add-fd to support passing many files
for our needs. Saving only requires a single FD. All others can
be opened by dup(), so the limitation of add-fd is irrelevant
surely ?

> 
> > Thus from the POV of the mgmt app, QEMU is writing to a single file, no
> > matter how many threads are involved & thus it should only need to supply
> > a single FD for thta file. QEMU can then call 'dup()' on that FD as many
> > times as it desires, and use fcntl() to toggle O_DIRECT if and when
> > it needs to.
> 
> Ok, so I think the way to go here is for QEMU to receive a file + offset
> instead of an FD. That way QEMU can have adequate control of the
> resources for the migration. I don't remember why we went on the FD
> tangent. Is it not acceptable for libvirt to provide the file name +
> offset?

FD passing means QEMU does not need privileges to open the file
which could be useful.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


