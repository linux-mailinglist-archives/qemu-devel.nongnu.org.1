Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3959F70933C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:33:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwTf-0002ts-3x; Fri, 19 May 2023 05:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzwTX-0002tN-AW
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzwTV-00062f-MQ
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684488756;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=otynnN8wBxcQ/ue+uCgyibLyY2h/coq+F4k5zH2C4uo=;
 b=ex9cNnA1605DQa9aqtS4kWSFbhRKl4VyKKCXOkwhJ4x/HXYlPLKJ9TND9s89x6wUC2MqLC
 RslLMhkyPW0pkzh/vdbzK9c9qWnbr0qpOkztYTIpRH9T3UMLmJQSbH6tEwSQDfMYxgV+va
 8CJlHyupaEFbKZLUxAR+4G2eoKgl8yE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-NNENRkOFMTezb50zOqC_pw-1; Fri, 19 May 2023 05:32:35 -0400
X-MC-Unique: NNENRkOFMTezb50zOqC_pw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 390EA800B2A;
 Fri, 19 May 2023 09:32:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4904640D1B61;
 Fri, 19 May 2023 09:32:34 +0000 (UTC)
Date: Fri, 19 May 2023 10:32:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH v2 0/6] meson: use subprojects for bundled projects
Message-ID: <ZGdCL3Ka2JSeo+XD@redhat.com>
References: <20230519085647.1104775-1-pbonzini@redhat.com>
 <CAFEAcA-nMG_5u4pADASoQNF_MCCXHMCB3APTtVLohzTzCmJ3cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-nMG_5u4pADASoQNF_MCCXHMCB3APTtVLohzTzCmJ3cQ@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, May 19, 2023 at 10:21:03AM +0100, Peter Maydell wrote:
> On Fri, 19 May 2023 at 09:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > QEMU bundles a copy of dtc and keycodemapdb.  They both support meson,
> > so we can run their build system via subproject() instead of hardcoding
> > their contents.
> >
> > In fact, now that QEMU's configure script knows how to install missing
> > Python dependencies, we can replace submodules altogether with .wrap
> > files, which have several advantages, either immediate or potential:
> 
> So do we have a path for getting rid of submodules entirely?
> I'd be all in favour of that, but I'm somewhat less in favour
> of "some things are submodules and some things are this new
> .wrap file setup"...

I think we can ignore 'roms' submodules on the basis they are never used
during a normal build, they're mostly just a maintainer convenience and
for release archive source bundling. That would leave us with

$ grep submodule .gitmodules  | sort | grep -v roms
[submodule "dtc"]
[submodule "subprojects/libvfio-user"]
[submodule "tests/fp/berkeley-softfloat-3"]
[submodule "tests/fp/berkeley-testfloat-3"]
[submodule "tests/lcitool/libvirt-ci"]
[submodule "ui/keycodemapdb"]


as submodules which are commonly used. This series handles dtc, libvfio-user
and keycodemapdb leaving the float tests and the libvirt-ci module. The
libvirt-ci module isn't used by meson, so I guess that doesn't directly
fit into its wrap handling.

Maybe we can none the less wire up libvirt-ci into wrap, or alternatively
since its python, could we make our new venv setup tools put libvirt-ci
into the venv ?

Paolo mentioned the float stuff as future work, but not sure what his
plans are specifically?

Feels like we should be able to figure out some way to get rid of all
the submodules though, except for the roms, which are special and ok to
leave IMHO

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


