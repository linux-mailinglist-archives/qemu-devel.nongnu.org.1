Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7628F7DE0BA
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 13:24:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyAG9-0001aY-GB; Wed, 01 Nov 2023 08:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qyAG6-0001a4-6N
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 08:23:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qyAG4-00014A-9s
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 08:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698841418;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/bjzvCrVUGJH/3qSxK3PgLvXrgbsOYW75cN+w4K4UCk=;
 b=eTiJzJU4fnizuqHfMcOCuRg29uEjZnCe7/Ry5N4Kawh7mCqFT2fjXzyAvb+iT9T4hYv/c/
 RDpxOl63rBqQF5N74EhlXN1jNXIUGY0TeF0biW+RNKsIiEuuOWlytOnYiUhMjAS1letuAZ
 ZPyUmzmLscSnNciEr1NgnwcbCaHQm1A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-IJfejrqQMdWzu6i97YLy5g-1; Wed, 01 Nov 2023 08:23:31 -0400
X-MC-Unique: IJfejrqQMdWzu6i97YLy5g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 906C585A58A;
 Wed,  1 Nov 2023 12:23:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68ADA492BE0;
 Wed,  1 Nov 2023 12:23:30 +0000 (UTC)
Date: Wed, 1 Nov 2023 12:23:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 28/29] migration: Add direct-io parameter
Message-ID: <ZUJDQKsg5mMqiMP0@redhat.com>
References: <ZUDC4aoPZZQAF6JU@redhat.com> <878r7jdjrf.fsf@suse.de>
 <ZUEE9XP4YTJkZTv7@redhat.com> <875y2meua3.fsf@suse.de>
 <ZUEbzvRLdGjl4gl+@redhat.com> <8734xqeqly.fsf@suse.de>
 <ZUEkOb8M4fgfEITi@redhat.com> <87wmv2d33p.fsf@suse.de>
 <ZUIav68fksPZpIJm@redhat.com> <87zfzxfz32.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zfzxfz32.fsf@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

On Wed, Nov 01, 2023 at 09:16:33AM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> >
> > So the problem with add-fd is that when requesting a FD, the monitor
> > code masks flags with O_ACCMODE.  What if we extended it such that
> > the monitor masked with O_ACCMODE | O_DIRECT.
> >
> > That would let us pass 1 plain FD and one O_DIRECT fd, and be able
> > to ask for each separately by setting O_DIRECT or not.
> 
> That would likely work. The usage gets a little more complicated, but
> we'd be using fdset as it was intended.
> 
> Should we keep the direct-io capability? If the user now needs to set
> O_DIRECT and also set the cap, that seems a little redundant. I could
> keep O_DIRECT in the flags (when supported) and test after open if we
> got the flag set. If it's not set, then we remove O_DIRECT from the
> flags and retry.

While it is redundant, I like the idea of always requireing the
direct-io capabilty to be set, as a statement of intent. There's
a decent chance for apps to mess up with FD passing, and so by
seeing the 'direct-io' capability we know what the app intended
todo.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


