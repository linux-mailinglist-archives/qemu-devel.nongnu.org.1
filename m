Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0707B8712
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:57:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo671-00051H-Vv; Wed, 04 Oct 2023 13:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qo66y-000501-Rk
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qo66v-0002Fl-UP
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696442197;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJw5rz3B3VR+Q39ZHiofKtI64P+c873N9o5Y0sg9EaE=;
 b=KZIBJBHDr97f29nJB3M5qzaOGki/d4h37Kqu2FsTcYutL2Nbw5gCvu/qUpoeSI5s8kSQRI
 ChEqtJr1SZoWPzZvgDbdCFAOz0hGe66lB5F4IUTd/pmKxaYUke8w2pvYyIDxvDPQTV+jw0
 U9pui+3gX0fhAjH/SlPOhY7CIHL/hgc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-Zi6K4o3xO9O-CT1-bXLKAQ-1; Wed, 04 Oct 2023 13:56:35 -0400
X-MC-Unique: Zi6K4o3xO9O-CT1-bXLKAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68BE0858F1C;
 Wed,  4 Oct 2023 17:56:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ECE0340C2015;
 Wed,  4 Oct 2023 17:56:32 +0000 (UTC)
Date: Wed, 4 Oct 2023 18:56:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: quintela@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 1/1] qtest/migration: Support more than one QEMU binary
Message-ID: <ZR2nTmmf8AaUV1g2@redhat.com>
References: <20231003141932.2367-1-farosas@suse.de>
 <20231003141932.2367-2-farosas@suse.de>
 <3dd8e410-982b-3ea6-78aa-08c1ba26f8da@linaro.org>
 <ZRw5Myc/joWb6why@redhat.com> <874jj7u11d.fsf@suse.de>
 <87wmw24vzg.fsf@secure.mitica> <8734yqpedm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734yqpedm.fsf@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 04, 2023 at 12:59:49PM -0300, Fabiano Rosas wrote:
> Juan Quintela <quintela@redhat.com> writes:
> 
> > Fabiano Rosas <farosas@suse.de> wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >>
> >>> On Tue, Oct 03, 2023 at 05:24:50PM +0200, Philippe Mathieu-Daudé wrote:
> > [...]
> >
> >>> $ cat myqemu.dkr 
> >>> FROM fedora:38
> >>>
> >>> RUN dnf -y install qemu-kvm
> >>>
> >>> $ podman build -f myqemu.dkr --tag myqemu .
> >>>
> >>> $ cat > myqemu <<EOF
> >>> #!/bin/sh
> >>> exec podman run --volume /tmp=/tmp --security-opt label=disable myqemu qemu-system-x86_64 "$@"
> >>>
> >>> $ chmod +x myqemu
> >>>
> >>> $ QTEST_QEMU_BINARY=./myqemu.sh  ./build/tests/qtest/rtc-test
> >>
> >> I'm favor of this. I usually set that variable to something like 'gdb
> >> --args ...' and it works just fine.
> >>
> >>> Except we fail on the last step, because bind mounts don't make UNIX domain
> >>> sockets accessible. So we can see the /tmp/qtest-$PID.sock in the container,
> >>> but it can't be used.
> >>>
> >>> UNIX domain sockets in the filesystem are tied to the mount namespace, and
> >>> podman/docker inherantly creates a new mount namespace making the UNIX
> >>> domani socket inaccessible.
> >>>
> >>> UNIX domain sockets in the abstract namespace, however, are tied to the
> >>> network namespace, so if you used podman --network host, they should be
> >>> accessible.
> >>>
> >>> libqtest could be changed to use abstract UNIX domain sockets on Linux
> >>> only, and likely unlock the use of podman for QEMU.
> >
> > That is one idea, but why can't we convince a container to compile
> > _both_ qemus?
> >
> > I am not familiar with containers, but:
> > - We already know how to compile a qemu inside a container
> > - We can teach it to compile $HEAD and v8.0.0 (or whatever)
> >
> > And do the test inside, right?
> >
> > On the other hand, your approach has the advantage that one can test
> > opensuse qemu against fedora qemu, and similar.  Not sure how useful is
> > that, though.
> >
> > [lots of code to find common machine types]
> 
> I'm working on a cleanup of this patch to make it more integrated with
> libqtest. If we teach qtest_get_machines() to sometimes refresh the list
> of machines then it becomes way less code.
> 
> > I think that it is just easier to pass the machine type we want to test
> > to whatever script we have.  Specially where [sane] architectures like
> > arm don't have a default machine type (no, I haven't double checked if
> > that has changed lately).
> 
> We still need to enforce the same machine type for both binaries and a
> sane range of QEMU versions. I think our docs state that we only support
> migration from QEMU n->n+1 and vice versa? If the test will know what
> combinations are allowed, it could just go ahead and use those.

Query the 'pc' (or 'q35' as appropriate) alias on both QEMU versions,
to resolve them into versioned machines.

Then find which resolved machine version(s) exist in both QEMUs, and
prefer the src machine if multiple matches exist.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


