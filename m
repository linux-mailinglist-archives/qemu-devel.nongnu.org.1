Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6860479AA00
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:55:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfiE1-0001mq-99; Mon, 11 Sep 2023 10:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qfiDr-0001mZ-WA
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qfiDp-0008Cb-Ow
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694443744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=szM0RYa6oDveKBx3wtLXNLaJ6HUp/rUla8wNfsMmXEE=;
 b=h0UoEIS/13xcB1gmEu5CMTB1/ARriDgCqvZ5jhNoCcuQwn6RZ4ZXvaqTFn7QLb7OnLSk/u
 MnGn5+TjE7gp275o5PM9D9BzMHGD0EcH7TtNbCVpJWqpfCjNmJFiHBnBR3AS4G4uxRcORw
 bATqB0jKJzHluvmpn4R/vqZ8TzBBCS0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-31wJNjY5M6qoQiedpab4Dw-1; Mon, 11 Sep 2023 10:49:01 -0400
X-MC-Unique: 31wJNjY5M6qoQiedpab4Dw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9880629ABA37;
 Mon, 11 Sep 2023 14:49:00 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2E152027045;
 Mon, 11 Sep 2023 14:48:58 +0000 (UTC)
Date: Mon, 11 Sep 2023 09:48:57 -0500
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: 20230825192940.35364-1-den@openvz.org, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, qemu-block@nongnu.org,
 "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Hanna Reitz <hreitz@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: Re: [PATCH vOther2 1/1] qemu-nbd: Restore "qemu-nbd -v --fork" output
Message-ID: <os3u4ybi7tuw7qfswicn3of4lpthvx2wyuzaajfefqtzaelwmq@3o4l6vybdiyo>
References: <20230825200838.39994-1-den@openvz.org>
 <38d13ff4-42ab-655a-00e8-51f977117d3c@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38d13ff4-42ab-655a-00e8-51f977117d3c@tls.msk.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Sun, Sep 10, 2023 at 11:40:25AM +0300, Michael Tokarev wrote:
> 25.08.2023 23:08, Denis V. Lunev wrote:
> > +            /* Remember parent's stderr if we will be restoring it. */
> > +            if (verbose /* fork_process is set */) {
> > +                opts.stderr = dup(STDERR_FILENO);
> > +                if (opts.stderr < 0) {
> > +                    error_report("Could not dup stdedd: %s", strerror(errno));
> > +                    exit(EXIT_FAILURE);
> > +                }
> > +            }
> > +
> >               ret = qemu_daemon(1, 0);
> 
> I haven't looked closely to this development.
> 
> To me it all looks.. backwards.
> 
> Instead of saving stderr around qemu_daemon() call, it might be more
> productive to tell qemu_daemon() to stop redirecting stderr (and maybe
> instrumenting it to do so).

I tried to do that in an earlier revision of this patch, but it
changed iotest output.  We've already had a lot of churn on patches
that were supposed to fix a regression but in turn caused another
regression.

> 
> Besides, qemu has 2 daemon implementations, one is qemu_daemon()
> in util/oslib-posix.c and another is os_daemonize() in os-posix.c.
> Note os_daemonize() does the right thing wrt logging already, -
> 
>         /* In case -D is given do not redirect stderr to /dev/null */
>         if (!qemu_log_enabled()) {
>             dup2(fd, 2);
>         }
> 
> but I guess nbd does not use qemu_log_enabled() et al.
> 
> Also, qemu-nbd can benefit from using -runas/-chroot too.
> 
> Ideally this whole thing should be consolidated.  I already took a
> step towards this by moving softmmu-specific stuff from os-posix.c
> to softmmu/, this work should continue. When it's done, we can
> revert this band-aid change for a real solution.

Indeed, there may still be further cleanups to do once the os-posix.c
cleanups are in.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


