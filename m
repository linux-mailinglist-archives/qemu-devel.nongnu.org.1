Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2EA832CD1
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 17:08:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQrP5-0006dv-J2; Fri, 19 Jan 2024 11:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rQrOq-0006cB-79
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:07:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rQrOo-0006We-Cd
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705680436;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ScUZVvbjzNsvAC0zvA9F2wgKLTp6/1WjGK1cuWqgG50=;
 b=CxXzvEBeK+pERWQ3LMHo2Ytfq+o1GzzUQxcZwQo9E+IqrZShoHigLYv6eSt7okyzZaXy7u
 ZJJBMc621Xc0rcxbzMQXrGqDH3v0A4bMRU4oYY9MKdDI5N2ZdOgk1vJPMm7X+dqwWC35Ij
 3gFE8KZyGM0yVZ5MHf1TnEBX0pPqvuY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-ugO0kLUkOTa7r9sy2fDwBw-1; Fri, 19 Jan 2024 11:07:14 -0500
X-MC-Unique: ugO0kLUkOTa7r9sy2fDwBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 919F010B9350;
 Fri, 19 Jan 2024 16:07:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B50DB900;
 Fri, 19 Jan 2024 16:07:11 +0000 (UTC)
Date: Fri, 19 Jan 2024 16:07:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <th.huth@posteo.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Ryo ONODERA <ryoon@netbsd.org>, Brad Smith <brad@comstyle.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: QEMU's tests/unit/test-iov times out on NetBSD and OpenBSD
Message-ID: <ZaqeLbJ1YQIhuvJH@redhat.com>
References: <4e802a6d-fb97-4e49-ab78-2a75371e464d@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e802a6d-fb97-4e49-ab78-2a75371e464d@posteo.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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

On Fri, Jan 19, 2024 at 03:55:49PM +0000, Thomas Huth wrote:
> 
>  Hi,
> 
> since we recently introduced test timouts in QEMU's meson set up, I noticed
> that the tests/unit/test-iov times out when doing "make vm-build-netbsd
> BUILD_TARGET=check-unit" (or vm-build-openbsd).
> 
> And indeed, when increasing the timeout, you can see that the test-iov runs
> for multiple minutes on these BSDs while it finishes within few seconds on
> Linux.
> 
> I had a closer look at the test, and the problem seems to be the
> 
>  usleep(g_test_rand_int_range(0, 30));
> 
> in the test_io() function. If I get that right, the usleep() seems to be
> more or less precise on (modern) Linux, but it seems like it sleeps for
> multiple milliseconds (not microseconds) on the BSDs. Since it is used in a
> nested loop, these milliseconds add up to a long time in total during the
> test.
> 
> Does anybody have an idea how to fix that? Is there a more precise (but stil
> portable) way to sleep less long here? Or could we maybe remove the usleep()
> here completely (it does not seem to have a real benefit for testing as far
> as I can see)?

'g_usleep' has the same API contract, but is implemented in terms
of 'nanosleep' on *NIX. So as a quick test, try switching usleep
to g_usleep and see if we get lucky.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


