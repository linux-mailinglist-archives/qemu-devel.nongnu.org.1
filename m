Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB43B2C417
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Aug 2025 14:49:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoLkZ-0003tx-JA; Tue, 19 Aug 2025 08:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoLkV-0003ta-2G
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 08:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoLkR-0003Bi-Oy
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 08:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755607649;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vlSg2RdoyhHGxerVEYG1yVWAj+pcnrE5SGfkoR8JV9g=;
 b=Tj0s+wtvJyKtSq039R4Ytq4UT2WvMTOERcWSb0cJsTyhztnOC33FlQnfmCaLuajXGpGquo
 G/bfWbNRnebP23YK59Km+j4RRruOvrECMGDlS+302esZiA7W+oJWlRMgnDfFOBgSCufbtU
 ZG9kfHlAyv8gPEhcm6qvi5bShmNS+io=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-rotnO66tN6W6q-Gc0MPbMw-1; Tue,
 19 Aug 2025 08:47:26 -0400
X-MC-Unique: rotnO66tN6W6q-Gc0MPbMw-1
X-Mimecast-MFC-AGG-ID: rotnO66tN6W6q-Gc0MPbMw_1755607645
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6336F1882813; Tue, 19 Aug 2025 12:47:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.237])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70DF119560AB; Tue, 19 Aug 2025 12:47:23 +0000 (UTC)
Date: Tue, 19 Aug 2025 13:47:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH] scripts/kernel-doc: Avoid new Perl precedence warning
Message-ID: <aKRyV8z8jjr3zMpg@redhat.com>
References: <20250819115648.2125709-1-peter.maydell@linaro.org>
 <aKRp22i5RhqZKGkt@redhat.com>
 <CAFEAcA_qj1dSgMTy4n6eAGrubMNSuModFS0_jBRGqVz7yJ28eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_qj1dSgMTy4n6eAGrubMNSuModFS0_jBRGqVz7yJ28eA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 19, 2025 at 01:16:25PM +0100, Peter Maydell wrote:
> On Tue, 19 Aug 2025 at 13:11, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Tue, Aug 19, 2025 at 12:56:48PM +0100, Peter Maydell wrote:
> > > Newer versions of Perl (5.41.x and up) emit a warning for code in
> > > kernel-doc:
> > >  Possible precedence problem between ! and pattern match (m//) at /scripts/kernel-doc line 1597.
> > >
> > > This is because the code does:
> > >             if (!$param =~ /\w\.\.\.$/) {
> > >
> > > In Perl, the !  operator has higher precedence than the =~
> > > pattern-match binding, so the effect of this condition is to first
> > > logically-negate the string $param into a true-or-false value and
> > > then try to pattern match it against the regex, which in this case
> > > will always fail.  This is almost certainly not what the author
> > > intended.
> > >
> > > In the new Python version of kernel-doc in the Linux kernel,
> > > the equivalent code is written:
> > >
> > >             if KernRe(r'\w\.\.\.$').search(param):
> > >                 # For named variable parameters of the form `x...`,
> > >                 # remove the dots
> > >                 param = param[:-3]
> > >             else:
> > >                 # Handles unnamed variable parameters
> > >                 param = "..."
> > >
> > > which is a more sensible way of writing the behaviour you would
> > > get if you put in brackets to make the regex match first and
> > > then negate the result.
> > >
> > > Take this as the intended behaviour, and update the Perl to match.
> > >
> > > For QEMU, this produces no change in output, presumably because we
> > > never used the "unnamed variable parameters" syntax.
> > >
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > > This obviously will clash with the "import the python script"
> > > patchseries, but I figured it was worth providing the minimal
> > > fix for the benefit of stable backports.
> > >
> > > The kernel's copy of kernel-doc.pl still has this bug.
> > > ---
> > >  scripts/kernel-doc | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> > > index fec83f53eda..117ec8fcd1f 100755
> > > --- a/scripts/kernel-doc
> > > +++ b/scripts/kernel-doc
> > > @@ -1594,13 +1594,12 @@ sub push_parameter($$$$$) {
> > >
> > >       if ($type eq "" && $param =~ /\.\.\.$/)
> > >       {
> > > -         if (!$param =~ /\w\.\.\.$/) {
> >
> > I think it would be possible to change this only line to
> > collapse the ! and =~ into the !~ operator:
> >
> >     if ($param !~ /\w\.\.\.$/) {
> 
> Yes, it would, but then the code would be:
> 
>  if ($param !~ /\w\.\.\.$/) {
>      stuff...
>  } elsif (param =~ /\w\.\.\.$/){
>      other stuff...
>  }
> 
> where we check the condition twice rather than using "else".
> So I favoured:
>  * "if C then {A} else {B}" is faster and more obvious as a way to say
>    "do A or B depending on C" than "if !C {B} elsif C {A}".
>  * match the logic that the Python script uses
> 
> over "smallest possible change to resolve the warning".

Ok, I'm not that fussed so to your patch

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


