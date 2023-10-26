Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0737D8046
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:07:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxFk-0004gW-NE; Thu, 26 Oct 2023 06:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvxFi-0004fH-41
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvxFg-0001A6-6s
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698314766;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SYRn/gmIoy84VYTBUmF36qm0W/eFDivYjCawEItn12I=;
 b=BSqfqTichbmZ2UB9eSkGHNymfs2v1Me7FvNAizXUqClA3KYfMAJN0XPhWfo+tyBXZgzEF5
 i/feh7/8XQaTXzpOzMS/JWOgXLWyMi2EH5HHkEyVg6tSVy4SWhUDqO91Ta0Br+WDXPnAWw
 OqfWBzFnJYaGcsa2Xv08v1Lom9JelpQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-i3Yq_qElPWqrGdx6Xi9Ahw-1; Thu, 26 Oct 2023 06:06:03 -0400
X-MC-Unique: i3Yq_qElPWqrGdx6Xi9Ahw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49F1D811E8E;
 Thu, 26 Oct 2023 10:06:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7F8A1121319;
 Thu, 26 Oct 2023 10:06:01 +0000 (UTC)
Date: Thu, 26 Oct 2023 11:05:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, thuth@redhat.com,
 bcain@quicinc.com, imp@bsdimp.com, stefanha@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/1] meson: Enable -Wshadow=local
Message-ID: <ZTo6B0JKpNqZgPhU@redhat.com>
References: <20231026053115.2066744-1-armbru@redhat.com>
 <20231026053115.2066744-2-armbru@redhat.com>
 <148731e1-7734-6f87-5b7c-e91e0e121880@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <148731e1-7734-6f87-5b7c-e91e0e121880@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

On Thu, Oct 26, 2023 at 07:58:42AM +0200, Philippe Mathieu-Daudé wrote:
> On 26/10/23 07:31, Markus Armbruster wrote:
> > Local variables shadowing other local variables or parameters make the
> > code needlessly hard to understand.  Bugs love to hide in such code.
> > Evidence: commit bbde656263d (migration/rdma: Fix save_page method to
> > fail on polling error).
> > 
> > Enable -Wshadow=local to prevent such issues.  Possible thanks to
> > recent cleanups.  Enabling -Wshadow would prevent more issues, but
> > we're not yet ready for that.
> > 
> > As usual, the warning is only enabled when the compiler recognizes it.
> > GCC does, Clang doesn't.
> > 
> > Some shadowed locals remain in bsd-user.  Since BSD prefers Clang,
> > let's not wait for its cleanup.
> > 
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >   meson.build | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/meson.build b/meson.build
> > index dcef8b1e79..89220443b8 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -462,6 +462,7 @@ warn_flags = [
> >     '-Wno-tautological-type-limit-compare',
> >     '-Wno-psabi',
> >     '-Wno-gnu-variable-sized-type-not-at-end',
> > +  '-Wshadow=local',
> >   ]
> >   if targetos != 'darwin'
> 
> Now don't blame me for posting patches with trigger shadow=local
> warnings because I am not testing that locally.
> 
> I find it a bit unfair to force me rely on CI or other machines
> rather than my host machine to check for warnings. I'd have
> rather waited this option support lands first in Clang before
> enabling this flag.

QEMU has never required regular contributors to submit code that
compiles perfectly on every supported platform. Only that they
make a fair effort to have it compile on their platform, and
respond to feedback if a reviewer points out a problem for a
different platform.

Subsystem maintainers though should be ensuring code is warning
free on every platform by running through CI before submitting a
pull request.

This centralization of CI repsonsibilities on maintainers is one
of the downsides of our mailing list workflow, as compared to
gitforges where the regular contributors would immediately trigger
& see CI reports from every merge request they open.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


