Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB25B7986F5
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:23:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeaVd-0002Hj-9d; Fri, 08 Sep 2023 08:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeaVb-0002H9-0K
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:22:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeaVV-0007E5-Vl
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694175761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aT5vDxiBlFmpdZ1YQlunZyTtTLykQU1JULEawSaiRPs=;
 b=Ti8tPmX4wy87hQUhAX8uQTGUL9/ilX/VUjgnf84o9+hj8V9jLdBuuWXiCa8qo7HCMZPm5g
 bW6BOFsG2tR3frvt6Z45VQwxRnrU0tLQuUEhn48xHuDNa6EJjIQ/ld5RobKlV9ETOLZQ1+
 KXIB4ijnukoezJrraXuC2r+7Knr6wK0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-mdljyajYMtGObREfhhCsVQ-1; Fri, 08 Sep 2023 08:22:38 -0400
X-MC-Unique: mdljyajYMtGObREfhhCsVQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8ADEF1C05B02;
 Fri,  8 Sep 2023 12:22:38 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76DD8493110;
 Fri,  8 Sep 2023 12:22:36 +0000 (UTC)
Date: Fri, 8 Sep 2023 14:22:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, William Tsai <williamtsai1111@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 0/1] qom: fix setting of qdev array properties
Message-ID: <ZPsSC4K6XSJGrdIw@redhat.com>
References: <20230904162544.2388037-1-berrange@redhat.com>
 <ZPbt0io6He9mE2SB@redhat.com> <87edja9vkr.fsf@pond.sub.org>
 <CAFEAcA-OVUqhwUprR2MJW24yxWpvz9zxv7u7iGqnYhtaGNM96w@mail.gmail.com>
 <ZProov27HNpHmz5j@redhat.com>
 <CAFEAcA9sKeUmVvzPoQGCZc_GJa8vUbp58T9VnQ3F+P+Zhht9QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9sKeUmVvzPoQGCZc_GJa8vUbp58T9VnQ3F+P+Zhht9QQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 08.09.2023 um 11:53 hat Peter Maydell geschrieben:
> On Fri, 8 Sept 2023 at 10:26, Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Am 07.09.2023 um 11:35 hat Peter Maydell geschrieben:
> > > On Thu, 7 Sept 2023 at 10:33, Markus Armbruster <armbru@redhat.com> wrote:
> > > >
> > > > Kevin Wolf <kwolf@redhat.com> writes:
> > > >
> > > > > Am 04.09.2023 um 18:25 hat Daniel P. Berrangé geschrieben:
> > > > >> By the time of the 8.2.0 release, it will have been 2 years and 6
> > > > >> releases since we accidentally broke setting of array properties
> > > > >> for user creatable devices:
> > > > >>
> > > > >>   https://gitlab.com/qemu-project/qemu/-/issues/1090
> > > > >
> > > > > Oh, nice!
> > > >
> > > > Nice?  *Awesome*!
> > > >
> > > > > Well, maybe that sounds a bit wrong, but the syntax that was broken was
> > > > > problematic and more of a hack,
> > > >
> > > > A monstrosity, in my opinion.  I tried to strangle it in the crib, but
> > > > its guardians wouldn't let me.  Can dig up references for the morbidly
> > > > curious.
> > >
> > > I don't care about the syntax on the command line much (AFAIK that's
> > > just the rocker device). But the actual feature is used more widely
> > > within QEMU itself for devices created in C code, which is what it
> > > was intended for. If you want to get rid of it you need to provide
> > > an adequate replacement.
> >
> > I have a patch to use QList (i.e. JSON lists) that seems to work for the
> > rocker case. Now I need to find and update all of those internal
> > callers. Should grepping for '"len-' find all instances that need to be
> > changed or are you aware of other ways to access the feature?
> 
> AFAIK the only way to use the feature is to set the len-foo and
> then foo[0], foo[1], ... properties, using any of the usual APIs.
> So git grep '\<len-[^-]' should find them all.
> 
> If you want a cross-check, the devices that use it are easy
> to find (search for DEFINE_PROP_ARRAY), and almost all of them
> picked property names that are easy to grep for.
> 
> But as Daniel says, if you haven't changed the behaviour for
> "code sets the properties in the right order" they may not
> need updating.

I'm replacing the 'len-foo' and 'foo[0]' etc. properties with a single
'foo' property that takes a list, so the callers need to be adjusted.
The devices can stay unchanged, though.

> (I would be happy to see the rather hacky implementation replaced
> with true support for list properties at the qom/qdev level.
> But the hack is there because it was simpler :-))

It's not really that hard, but it would probably have been even easier
if we had just used the list support in the visitor interface from the
beginning instead of adding this hack. (Though obviously that wouldn't
have worked for user creatable devices before we added JSON support to
-device.)

Kevin


