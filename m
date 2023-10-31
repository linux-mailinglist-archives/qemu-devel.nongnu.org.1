Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AA57DC91F
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:09:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkf4-00046h-E2; Tue, 31 Oct 2023 05:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qxkez-0003ew-Eq
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qxkew-0007Dv-Eh
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698743017;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=psjah80H3K7eQBOfyGElxTAM0/FLjk8+5yfZ3LuV8EQ=;
 b=eqYmQ2xxNeRZAMEKs/ac5GjEXdhxfXFvZUDib2qBPdAz8qLEk8Sns61sgZbTkEBJHHzfUe
 fcgkd/fyUnq1qibjQhqzaozSMH/s5hbAC6etUpz9Ispt15+NgZyGKTXhcWzzY932pV7Wn+
 MoFEpD7HLLhAvlA9PFEZh2tcITF8pQ0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-BCDiUP6hMg69CwFLSpDWPw-1; Tue,
 31 Oct 2023 05:03:34 -0400
X-MC-Unique: BCDiUP6hMg69CwFLSpDWPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 944D43C1042E;
 Tue, 31 Oct 2023 09:03:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 088121121306;
 Tue, 31 Oct 2023 09:03:31 +0000 (UTC)
Date: Tue, 31 Oct 2023 09:03:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 28/29] migration: Add direct-io parameter
Message-ID: <ZUDC4aoPZZQAF6JU@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-29-farosas@suse.de>
 <878r7svapt.fsf@pond.sub.org> <87msw7ddfp.fsf@suse.de>
 <ZTjVg9NVTd0MT6mW@redhat.com> <87cyx2epsv.fsf@suse.de>
 <ZTkpllWQdLSMw3pP@redhat.com> <87cywvenbd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cywvenbd.fsf@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Oct 30, 2023 at 07:51:34PM -0300, Fabiano Rosas wrote:
> I could use some advice on how to solve this situation. The fdset code
> at monitor/fds.c and the add-fd command don't seem to be usable outside
> the original use-case of passing fds with different open flags.
> 
> There are several problems, the biggest one being that there's no way to
> manipulate the set of file descriptors aside from asking for duplication
> of an fd that matches a particular set of flags.
> 
> That doesn't work for us because the two fds we need (one for main
> channel, other for secondary channels) will have the same open flags. So
> the fdset code will always return the first one it finds in the set.

QEMU may want multiple FDs *internally*, but IMHO that fact should
not be exposed to mgmt applications. It would be valid for a QEMU
impl to share the same FD across multiple threads, or have a different
FD for each thread. All threads are using pread/pwrite, so it is safe
for them to use the same FD if they desire. It is a private impl choice
for QEMU at any given point in time and could change over time.

Thus from the POV of the mgmt app, QEMU is writing to a single file, no
matter how many threads are involved & thus it should only need to supply
a single FD for thta file. QEMU can then call 'dup()' on that FD as many
times as it desires, and use fcntl() to toggle O_DIRECT if and when
it needs to.

> Another problem (or feature) of the fdset code is that it only removes
> an fd when qmp_remove_fd() is called if the VM runstate is RUNNING,
> which means that the migration code cannot remove the fds after use
> reliably. We need to be able to remove them to make sure we use the
> correct fds in a subsequent migration.

The "easy" option is to just add a new API that does what you want.
Maybe during review someone will then point out why the orgianl
API works the way it does.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


