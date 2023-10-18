Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A307CDA10
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 13:13:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt4UG-0004pa-I7; Wed, 18 Oct 2023 07:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qt4UE-0004pI-2w
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qt4UC-0002oq-4o
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697627590;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=5YbuqKzu7970bAzikb4FrX8095bouJ8f1smOrmsjK3Y=;
 b=c9kLvAu3yV9vX61bXSFprP42TqVGfASNlEs1m/uOQleiy+6FkmW1PXMvtoLHNwaQR+J6iA
 vzH4vvDf7ec3y42nB+kDElMogwxvUcH+m6udhcpICLL3yqPbqhacAgubJMG/Vyjst9Oxgn
 1MZsanI4com09/aUIBuAZSVPKQNMYWU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-njJMwGBpNtmIqQfDsbmfRg-1; Wed, 18 Oct 2023 07:13:04 -0400
X-MC-Unique: njJMwGBpNtmIqQfDsbmfRg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38E3F10201F1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 11:13:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A6C7C15BB8;
 Wed, 18 Oct 2023 11:13:03 +0000 (UTC)
Date: Wed, 18 Oct 2023 12:13:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Victor Toso <victortoso@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v2 02/11] scripts: qapi: black format main.py
Message-ID: <ZS+9vVemiYMYStvH@redhat.com>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-3-victortoso@redhat.com>
 <87pm1crya0.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pm1crya0.fsf@pond.sub.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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

On Wed, Oct 18, 2023 at 01:00:07PM +0200, Markus Armbruster wrote:
> Victor Toso <victortoso@redhat.com> writes:
> 
> > flake8 complained:
> >     ./main.py:60:1: E302 expected 2 blank lines, found 1
> >
> > Which is simple enough. My vim has black [0] enabled by default, so it
> > did some extra formatting. I'm proposing to follow it.
> >
> > [0] https://black.readthedocs.io/en/stable/
> >
> > Signed-off-by: Victor Toso <victortoso@redhat.com>
> > ---
> >  scripts/qapi/main.py | 76 ++++++++++++++++++++++++++++----------------
> >  1 file changed, 48 insertions(+), 28 deletions(-)
> 
> Is this all black hates about scripts/qapi/?
> 
> Did you configure it in any way, and if yes, how?

The point of the 'black' tool is that it be highly opinionated and
bring (force) all projects in the python code into following the
same style. As such it intentionally has near zero configuration
options.

You can control the line length it uses (88 by default) and something
related to string quoting style normalization, but that's basically it.

Generally though developers should just run 'black' and accept all the
changes it makes without questioning.

Personally I'd encourage the use of black for any project with python
code, precisely to remove any need to spend time debating code style.


If a project is also using flake8 there's a config needed for flake8
to stop it conflicting with black though

eg in $gitroot/.flake8 you'd need at least:

  [flake8]
  max-line-length = 88
  extend-ignore = E203


If QEMU intends to adopt black, at the very least we need to have
it validated by CI and probably by 'make check' too, to avoid
regressions.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


