Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3043708371
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:02:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzeCH-0005mk-Ff; Thu, 18 May 2023 10:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzeCG-0005mT-9b
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzeCB-0003Eo-VP
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684418489;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iCVW5o0aCX7s5Jc1c8hq4NOHmdu17XQFpl6xg/2nWNk=;
 b=MWq1mSmr7ApA/EB2Q0dhQdeyoA4SsHDqjsRcDiciY62b/nmv5WyCu7CP0nUi1B31ngR14e
 rqVCodld2wzgT1YUIv8NZmSK5WmSUxMfzblTC9gynyL6KUm8lLaS4J+z+CS+9c5udA8wos
 HtbAw1/3sZ5VNerc0ecFG1Wjyycny7Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-Qu5T_t-pO7ybR7oROBmSBA-1; Thu, 18 May 2023 10:01:27 -0400
X-MC-Unique: Qu5T_t-pO7ybR7oROBmSBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D12718F024A
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 14:01:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 810A31121314;
 Thu, 18 May 2023 14:01:24 +0000 (UTC)
Date: Thu, 18 May 2023 15:01:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Subject: Re: [PATCH 2/2] meson: use subproject for keycodemapdb
Message-ID: <ZGYvsfw9k8s7wnPV@redhat.com>
References: <20230518124645.1011316-1-pbonzini@redhat.com>
 <20230518124645.1011316-3-pbonzini@redhat.com>
 <ZGYgNYaS5c4Yq8uh@redhat.com>
 <f8f06172-29fd-08ae-182e-193d139a878b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8f06172-29fd-08ae-182e-193d139a878b@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, May 18, 2023 at 03:00:44PM +0200, Paolo Bonzini wrote:
> On 5/18/23 14:55, Daniel P. Berrangé wrote:
> > On Thu, May 18, 2023 at 02:46:45PM +0200, Paolo Bonzini wrote:
> > > By using a subproject, our own meson.build can use variables from
> > > the subproject instead of hard-coded paths.  In the future, it may
> > > also be possible to use wrap to download the submodule.
> > > 
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >   .gitmodules                      | 4 ++--
> > >   configure                        | 4 ++--
> > >   scripts/archive-source.sh        | 2 +-
> > >   {ui => subprojects}/keycodemapdb | 0
> > >   ui/meson.build                   | 6 ++++--
> > >   5 files changed, 9 insertions(+), 7 deletions(-)
> > >   rename {ui => subprojects}/keycodemapdb (100%)
> > > 
> > > diff --git a/.gitmodules b/.gitmodules
> > > index 3ed5d073d630..f8b2ddf3877c 100644
> > > --- a/.gitmodules
> > > +++ b/.gitmodules
> > > @@ -25,8 +25,8 @@
> > >   [submodule "roms/QemuMacDrivers"]
> > >   	path = roms/QemuMacDrivers
> > >   	url = https://gitlab.com/qemu-project/QemuMacDrivers.git
> > > -[submodule "ui/keycodemapdb"]
> > > -	path = ui/keycodemapdb
> > > +[submodule "subprojects/keycodemapdb"]
> > > +	path = subprojects/keycodemapdb
> > >   	url = https://gitlab.com/qemu-project/keycodemapdb.git
> > >   [submodule "roms/seabios-hppa"]
> > >   	path = roms/seabios-hppa
> > > diff --git a/configure b/configure
> > > index 5bbca83d9a31..2b6995e16756 100755
> > > --- a/configure
> > > +++ b/configure
> > > @@ -254,7 +254,7 @@ else
> > >       git_submodules_action="ignore"
> > >   fi
> > > -git_submodules="ui/keycodemapdb"
> > > +git_submodules="subprojects/keycodemapdb"
> > >   git="git"
> > >   debug_tcg="no"
> > >   docs="auto"
> > > @@ -806,7 +806,7 @@ case $git_submodules_action in
> > >           fi
> > >       ;;
> > >       ignore)
> > > -        if ! test -f "$source_path/ui/keycodemapdb/README"
> > > +        if ! test -f "$source_path/subprojects/keycodemapdb/README"
> > >           then
> > >               echo
> > >               echo "ERROR: missing GIT submodules"
> > > diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> > > index b15f6fe6b8fe..a0a3153faa99 100755
> > > --- a/scripts/archive-source.sh
> > > +++ b/scripts/archive-source.sh
> > > @@ -26,7 +26,7 @@ sub_file="${sub_tdir}/submodule.tar"
> > >   # independent of what the developer currently has initialized
> > >   # in their checkout, because the build environment is completely
> > >   # different to the host OS.
> > > -submodules="subprojects/dtc meson ui/keycodemapdb"
> > > +submodules="subprojects/dtc meson subprojects/keycodemapdb"
> > >   submodules="$submodules tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
> > >   sub_deinit=""
> > > diff --git a/ui/keycodemapdb b/subprojects/keycodemapdb
> > > similarity index 100%
> > > rename from ui/keycodemapdb
> > > rename to subprojects/keycodemapdb
> > > diff --git a/ui/meson.build b/ui/meson.build
> > > index 330369707dd7..e24d52b89941 100644
> > > --- a/ui/meson.build
> > > +++ b/ui/meson.build
> > > @@ -162,13 +162,15 @@ keymaps = [
> > >   ]
> > >   if have_system or xkbcommon.found()
> > > +  keycodemapdb_proj = subproject('keycodemapdb', required: true)
> > > +  keymap_gen = find_program('keymap-gen', required: true)
> > 
> > This variable isn't used, is it ?
> 
> Hmm, no it isn't.  Do you prefer the code below and removing the assignment,
> or
> 
>     command: [python, keymap_gen.full_path(),
> 
> ?  find_program is nicer, but you have to peek with
> keycodemap_proj.get_variable() anyway to reach the CSV file, so...

I'm pretty ambivalent. If there's no functional reason to use
find_program, I guest we might as well stick with get_variable for
parity with the CSV file


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


