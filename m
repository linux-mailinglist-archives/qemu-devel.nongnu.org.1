Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EFA7201FB
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 14:23:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53nk-0007iJ-KG; Fri, 02 Jun 2023 08:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q53ng-0007hh-6C
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q53ne-0002Ib-MW
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685708553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WFTw4ekzA6pvETIfRcepQkJBwl/T9F3EBZgLmyeYzrU=;
 b=ArHnKjcGyeAaS0qPfTRghUr0uX9UJI3cMFl8+a2UFf8rlDP6/EG+7l14U6PxlO8luljoax
 uMp6eO5FQ5VgmRQFT8OM9bo688ouKWl2aqs+EgsdZaldZqInqg9wwZitqyMv87bptoJ21N
 7jy1pfr0XiGS0f8L0/n/5otG4fGC+LU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-sBhElLDCOmC14Nn9wla7dA-1; Fri, 02 Jun 2023 08:22:30 -0400
X-MC-Unique: sBhElLDCOmC14Nn9wla7dA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AF153C0F192;
 Fri,  2 Jun 2023 12:22:30 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C0CC2166B25;
 Fri,  2 Jun 2023 12:22:29 +0000 (UTC)
Date: Fri, 2 Jun 2023 07:22:27 -0500
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>,
 Michael Roth <michael.roth@amd.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "open list:GLUSTER" <qemu-block@nongnu.org>, 
 "open list:GLUSTER" <integration@gluster.org>
Subject: Re: [PULL 09/21] cutils: Adjust signature of parse_uint[_full]
Message-ID: <l32irl7qbhs2omzbxakm3n27vpjpmbvuscb4azzhgv7jx26nnz@dfjpfem52hz2>
References: <20230601220305.2130121-1-eblake@redhat.com>
 <20230601220305.2130121-10-eblake@redhat.com>
 <874jnqz8vt.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jnqz8vt.fsf@pond.sub.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Jun 02, 2023 at 08:16:38AM +0200, Markus Armbruster wrote:
> Sorry for being late to the party...
> 
> Eric Blake <eblake@redhat.com> writes:
> 
> > It's already confusing that we have two very similar functions for
> > wrapping the parse of a 64-bit unsigned value, differing mainly on
> > whether they permit leading '-'.  Adjust the signature of parse_uint()
> > and parse_uint_full() to be like all of qemu_strto*(): put the result
> > parameter last, use the same types (uint64_t and unsigned long long
> > have the same width, but are not always the same type), and mark
> > endptr const (this latter change only affects the rare caller of
> > parse_uint).  Adjust all callers in the tree.
> >
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
> > Message-Id: <20230522190441.64278-8-eblake@redhat.com>
> 
> [...]
> 
> > diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
> > index 587f31baf6b..8812d23677a 100644
> > --- a/qapi/opts-visitor.c
> > +++ b/qapi/opts-visitor.c
> > @@ -454,8 +454,8 @@ opts_type_uint64(Visitor *v, const char *name, uint64_t *obj, Error **errp)
> >      OptsVisitor *ov = to_ov(v);
> >      const QemuOpt *opt;
> >      const char *str;
> > -    unsigned long long val;
> > -    char *endptr;
> > +    uint64_t val;
> 
> val changes from unsigned long long, which is at least 64 bits, to
> uint64_t, which is exactly 64 bits.

Except that we have:

util/cutils.c:    QEMU_BUILD_BUG_ON(sizeof(uint64_t) != sizeof(unsigned long long));

proving that all of our target platforms have unsigned long long at
the same size (but not necessarily same rank) as uint64_t...

> 
> > +    const char *endptr;
> >
> >      if (ov->list_mode == LM_UNSIGNED_INTERVAL) {
> >          *obj = ov->range_next.u;
> > @@ -471,17 +471,17 @@ opts_type_uint64(Visitor *v, const char *name, uint64_t *obj, Error **errp)
> >      /* we've gotten past lookup_scalar() */
> >      assert(ov->list_mode == LM_NONE || ov->list_mode == LM_IN_PROGRESS);
> >
> > -    if (parse_uint(str, &val, &endptr, 0) == 0 && val <= UINT64_MAX) {
> > +    if (parse_uint(str, &endptr, 0, &val) == 0 && val <= UINT64_MAX) {
> 
> val <= UINT64_MAX is now useless, isn't it?

...so we would have failed to build if the condition could have ever
been true before this patch.  The dead condition is thus pre-existing,
but I will touch it up, since I have to respin to work around a mingw
bug anyways.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


