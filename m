Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
Delivered-To: lists+qemu-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOPDOaW8b2kOMQAAu9opvQ
	(envelope-from <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>)
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 18:34:29 +0100
X-Original-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0FB48A4D
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 18:34:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viFc1-0001Hl-H2; Tue, 20 Jan 2026 12:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1viFbv-0001Dk-NU
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:33:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1viFbt-0004JJ-Sm
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768930424;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6z5o9gAGs8H5+LI8KnlsS6b0H9K9FctS4WMUWFynuT4=;
 b=Xxcq6Ksz/BLRBL9ZIJ1ik5xH6WpYxBRARow8jKi+6AV0oxTEi8deC+p/E9bpF6vPrw2aIB
 dffwApYEG8m9IOEwrpO4tBSt6gSga4FnCvsYu5yKcRnDPV8RTgicp2116g187yMoMZkFw1
 i4PFbNEjGjSL7RPXjOxVIf/TsLjy+cg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-7vGlrE9hPgGH5s0dvdrsLw-1; Tue,
 20 Jan 2026 12:33:42 -0500
X-MC-Unique: 7vGlrE9hPgGH5s0dvdrsLw-1
X-Mimecast-MFC-AGG-ID: 7vGlrE9hPgGH5s0dvdrsLw_1768930420
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E6C518005B4; Tue, 20 Jan 2026 17:33:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.89])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7E9A18004D8; Tue, 20 Jan 2026 17:33:32 +0000 (UTC)
Date: Tue, 20 Jan 2026 17:33:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Ed Maste <emaste@freebsd.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 05/17] meson, mkvenv: add functests custom target
Message-ID: <aW-8aQPNysI45mYD@redhat.com>
References: <20260119212744.1275455-1-jsnow@redhat.com>
 <20260119212744.1275455-6-jsnow@redhat.com>
 <aW9CkQul663wzsVd@redhat.com>
 <CAFn=p-bJ9utH13oKfxp3YFiQ0n3CPaY7dzA84gna-DG-SJK+Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-bJ9utH13oKfxp3YFiQ0n3CPaY7dzA84gna-DG-SJK+Ow@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
X-Spamd-Result: default: False [0.29 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.20)[mailman];
	R_SPF_ALLOW(-0.20)[+ip4:209.51.188.0/24:c];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[lists,qemu-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jsnow@redhat.com,m:qemu-devel@nongnu.org,m:marcandre.lureau@redhat.com,m:vsementsov@yandex-team.ru,m:kwolf@redhat.com,m:davydov-max@yandex-team.ru,m:lwhsu@freebsd.org,m:armbru@redhat.com,m:thuth@redhat.com,m:mchehab+huawei@kernel.org,m:hreitz@redhat.com,m:crosa@redhat.com,m:michael.roth@amd.com,m:luoyonggang@gmail.com,m:emaste@freebsd.org,m:peterx@redhat.com,m:farosas@suse.de,m:pbonzini@redhat.com,m:qemu-block@nongnu.org,m:philmd@linaro.org,m:alex.bennee@linaro.org,m:mchehab@kernel.org,s:lists@lfdr.de];
	ARC_NA(0.00)[];
	FORWARDED(0.00)[qemu-devel@nongnu.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[berrange@redhat.com,qemu-devel-bounces@nongnu.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[instagram.com:url,functests.group:url,entangle-photo.org:url,lists.gnu.org:rdns,lists.gnu.org:helo];
	DKIM_TRACE(0.00)[redhat.com:+];
	HAS_REPLYTO(0.00)[berrange@redhat.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[berrange@redhat.com,qemu-devel-bounces@nongnu.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nongnu.org,redhat.com,yandex-team.ru,freebsd.org,kernel.org,amd.com,gmail.com,suse.de,linaro.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[qemu-devel,huawei];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:22989, ipnet:209.51.188.0/24, country:US];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 5C0FB48A4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 12:27:01PM -0500, John Snow wrote:
> On Tue, Jan 20, 2026 at 3:53 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Mon, Jan 19, 2026 at 04:27:31PM -0500, John Snow wrote:
> > > add the "pyvenv_functests_group" target to meson. This target will
> > > invoke mkvenv.py to install the associated dependency group to the
> > > build/pyvenv directory.
> > >
> > > A "pyvenv_tooling_group" is not included here as it is the plan to
> > > always install this group by default, so it will not need an on-demand
> > > trigger.
> > >
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >  meson.build        |  1 +
> > >  pyvenv/meson.build | 28 ++++++++++++++++++++++++++++
> > >  2 files changed, 29 insertions(+)
> > >  create mode 100644 pyvenv/meson.build
> > >
> > > diff --git a/meson.build b/meson.build
> > > index 3108f01e887..245f1bc2ec9 100644
> > > --- a/meson.build
> > > +++ b/meson.build
> > > @@ -4551,6 +4551,7 @@ subdir('scripts')
> > >  subdir('tools')
> > >  subdir('pc-bios')
> > >  subdir('docs')
> > > +subdir('pyvenv')
> > >  # Tests are disabled on emscripten because they rely on host features that aren't
> > >  # supported by emscripten (e.g. fork and unix socket).
> > >  if host_os != 'emscripten'
> > > diff --git a/pyvenv/meson.build b/pyvenv/meson.build
> > > new file mode 100644
> > > index 00000000000..2bfddeb4a52
> > > --- /dev/null
> > > +++ b/pyvenv/meson.build
> > > @@ -0,0 +1,28 @@
> > > +# Note that this file only controls "optional" dependency groups; groups
> > > +# *required* for the build are handled directly in configure instead:
> > > +# namely, meson and sphinx.
> > > +
> > > +# NB: This command may or may not include the "--online" flag, depending
> > > +# on the results of configure.
> > > +ensuregroup_cmd = config_host['MKVENV_ENSUREGROUP'].split()
> >
> > I'm confused because this implies that "ensuregroup_cmd" use of the
> > --online flag is supposed to be controlled by configure
> >
> >
> > > +
> > > +pyvenv_common_deps = files(
> > > +    meson.project_source_root() + '/pythondeps.toml',
> > > +    meson.project_source_root() + '/python/scripts/mkvenv.py'
> > > +)
> > > +pyvenv_wheel_dir = meson.project_source_root() + '/python/wheels'
> > > +
> > > +
> > > +# This group is allowed to rely on internet, to fetch from PyPI.
> > > +# If --online was not passed to configure, this could fail.
> >
> > ...and this also suggests --online is supposed to be controlled
> > by configure, but...
> >
> > > +pyvenv_functests_group = custom_target(
> > > +    'pyvenv_functests_group',
> > > +    output: 'functests.group',
> > > +    input: pyvenv_common_deps,
> > > +    command: ensuregroup_cmd + [
> > > +        '--online',
> >
> > now we just go ahead and hardcode use of --online regardless.
> 
> Whoops, leftover from when I had both groups. What is now the tooling
> group used to obey the flags, and I garbled the comments. My gut tells
> me that we should force --online here, and if it fails because we're
> actually in an isolated environment, then so be it.
> 
> On the other hand, if we were configured offline, the error message
> you get from mkvenv might be better.
> 
> Do you have an opinion?

IIUC, the later patch only adds pyvenv_functests_group to the thorough
functional tests, NOT the quick tests.  Given that the thorough tests
mandated online access to download assets, it feels reasonable to also
hardcode --online here for their code prereqs.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


