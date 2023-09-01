Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 734EE790140
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 19:15:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc7iY-0001sW-9T; Fri, 01 Sep 2023 13:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qc7iW-0001rT-8s
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qc7iT-0005Ui-Lk
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693588432;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SP1z6HE/QGHMeSZdco0/IZ0jLt0cijLAcgqlxQ1LFHQ=;
 b=g3IcKKz+6bn7mPgrj5PweoeUofngraXXi6LLf7LxNuInP2+H0wWybcOhXKcMbA9o2RftLV
 pOs0eQ3vCC+T1fK33IbTodbOW6Xwx4ldVM2MV2eLb8geOKRwX0as4BMYfBtdfE4dSvelOn
 JDzF3daBGT8LjogE7B/9/ROn0S2gJ48=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-ekM_Xvl2P6WENPwxHnr2sA-1; Fri, 01 Sep 2023 13:13:51 -0400
X-MC-Unique: ekM_Xvl2P6WENPwxHnr2sA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0B3E1C18C77
 for <qemu-devel@nongnu.org>; Fri,  1 Sep 2023 17:13:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AC552012F37;
 Fri,  1 Sep 2023 17:13:49 +0000 (UTC)
Date: Fri, 1 Sep 2023 18:13:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 43/67] ui/vc: do not parse VC-specific options in Spice
 and GTK
Message-ID: <ZPIby+nDU9gvF53j@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-44-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230830093843.3531473-44-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

On Wed, Aug 30, 2023 at 01:38:17PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> In commit 6f974c843c ("gtk: overwrite the console.c char driver"), I
> shared the VC console parse handler with GTK. And later on in commit
> d8aec9d9 ("display: add -display spice-app launching a Spice client"),
> I also used it to handle spice-app VC.
> 
> This is not necessary, the VC console options (width/height/cols/rows)
> are specific, and unused by tty-level GTK/Spice VC.
> 
> This is not a breaking change, as those options are still being parsed
> by QAPI ChardevVC. Adjust the documentation about it.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/char.json         | 4 ++++
>  include/chardev/char.h | 3 ---
>  ui/console.c           | 4 ++--
>  ui/gtk.c               | 1 -
>  ui/spice-app.c         | 7 ++++++-
>  5 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/qapi/char.json b/qapi/char.json
> index 52aaff25eb..7e23fe3180 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -390,6 +390,10 @@
>  #
>  # @rows: console height, in chars
>  #
> +# Note: the options are only effective when using the built-in QEMU graphical VC
> +# (with the SDL display). When the VC is handled by the display backend (with
> +# GTK/VTE, Spice or D-Bus), they are simply ignored.

I don't find this explains the situation very well, I had to look at
the code to understand what's ultimately going on, as I didn't really
know what it meant by "built-in QEMU graphical VC". From the end user's
POV, they're just using '-chardev vc...'.

IIUC, the command line -chardev vc,..... will end up instantiating
TYPE_CHARDEV_VC.

We actually then have 4 completely different implementations
of TYPE_CHARDEV_VC, and depending on which display backend
is enabled, a different TYPE_CHARDEV_VC will get registered.

So what your comment is saying is that the width/height/rows/cols
properties will only get honoured if the TYPE_CHARDEV_VC that is
registered, is the one that maps to the SDL display backend.

Wow, is this situation confusing and gross in the code :-(

So for the comment I think we can just cut out a few words to
make it simpler

 # Note: the options are only effective when the SDL graphical
 # display backend is active. They are ignored with the GTK,
 # Spice, VNC and D-Bus display backends.

As a future exercise for anyone motiviated, I would say that
TYPE_CHARDEV_VC ought to be abstract and we then have subclasses
for each of the impls we have that are registered unconditionally
with type_init(), then pick the subclass to instantiate based
on the display backend. That way we can ultimately make the
QAPI schema reflect that we have multiple ChardevVC impls and
only expose the cols/width/etc for the SDL impl.


Anyway, if the comment is simplied/clarified then

 Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


