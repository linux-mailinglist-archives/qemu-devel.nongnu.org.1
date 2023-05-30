Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 560E57160C7
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:58:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yv1-0005NG-GS; Tue, 30 May 2023 08:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q3yuj-0005D1-EZ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q3yuh-00006O-Qe
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685451442;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=aSkHtp5+EowbfYVMfe59yvYLjZtoibUzDR4eyTIajJE=;
 b=J15luieRII1uTIaWf47Ut6iVRIKDDMs7rzwPN+/gLzappVY2izrPTcjbOxh+Ee3hCFKmGl
 ltTX1DHgh2WY+ET7yumSExQ57RC2bST3FQx4iNRGp6K9xKGCufUzgjkbHf5LeNh8Ouek4O
 mTzDvKHf7vQH2o6o5KLtxZDxqkY1Z98=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-94V7GiyAOxKp4cAg758AhA-1; Tue, 30 May 2023 08:57:19 -0400
X-MC-Unique: 94V7GiyAOxKp4cAg758AhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 820693C0C88A;
 Tue, 30 May 2023 12:57:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B25C2166B25;
 Tue, 30 May 2023 12:57:15 +0000 (UTC)
Date: Tue, 30 May 2023 13:57:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: [PATCH 0/5] meson: replace submodules with wrap files
Message-ID: <ZHXyqdwAW38ZWk7Y@redhat.com>
References: <20230527092851.705884-1-pbonzini@redhat.com>
 <3188708d-f7ae-27c2-7bb2-0ac50b08c79a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3188708d-f7ae-27c2-7bb2-0ac50b08c79a@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, May 30, 2023 at 02:18:30PM +0200, Thomas Huth wrote:
> On 27/05/2023 11.28, Paolo Bonzini wrote:
> > This series replaces git submodules for bundled libraries with .wrap
> > files that can be used directly by meson for subprojects.
> ...
> > The remaining submodules consist of tests/lcitool/libvirt-ci and the
> > firmware in roms/.
> 
> We talked about moving the contents of roms/ to a separate repository a
> couple of times ... maybe it's time now that we really do it?
> 
> (However, when I tried to tackle the "do we need to ship the firmware
> sources with the main tarball" problem the last time, there was no consensus
> how to do it best, see
> https://lore.kernel.org/qemu-devel/20221128092555.37102-1-thuth@redhat.com/
> ... maybe something to discuss at KVM forum...)
> 
> > The former is only used in very specific cases,
> > while the latter is mostly used only as a pointer used to create the QEMU
> > tarball.  Unfortunately, git-submodule.sh is still needed for roms/SLOF,
> > parts of which are used in the QEMU build process for pc-bios/s390-ccw;
> > more on this later in this cover letter.
> > 
> > I'm not sure what's the best way to proceed for roms/SLOF.  Some
> > possibilities, in no particular order, include:
> > 
> > * doing nothing
> > 
> > * merging --with-git-submodules with --enable-download, and
> >    moving the git-submodule.sh rules from the main Makefile to
> >    pc-bios/s390-ccw/ (my favorite option)
> > 
> > * copying the relevant SLOF files into pc-bios/
> 
> Considering that SLOF is also rather on life support already (there is now
> VOF for the sPAPR machine instead, Alexey left IBM, ...), I also wouldn't
> mind the third option, I think.
> 
> But of course we can also start with option 2 and go for option 3 later.

My inclination would be for option 3 too, just copy the relevant files
into s390-ccw dir, so the two distinct ROMs are fully separated from
each other.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


