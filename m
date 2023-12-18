Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3A381737F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 15:25:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFEXv-0001bR-MV; Mon, 18 Dec 2023 09:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rFEXu-0001bH-8i
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:24:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rFEXs-0007tK-JL
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702909474;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G+aEaVIUA2pZzUlTh1rmCDiADbydVy1BB51jFRslGLg=;
 b=cNwoDHeyM/qhj+8b0yZfqUlYpdLCNMSHhAjxdR1coUx9abeogqLf5iFZgtEafzwlI3JbJc
 bSyXjXXfAU3EPtq9IAA/79BdsshnvT8Bci2EQMKuj3G3hhYP91kkEzL1W9pajaeAfKVhTe
 YGHpWEcTjRKbdeA190oXh8xcH3khmz4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-qrfIiqnzNCOi2MkhF7L-lQ-1; Mon, 18 Dec 2023 09:24:32 -0500
X-MC-Unique: qrfIiqnzNCOi2MkhF7L-lQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D5E6869EC0;
 Mon, 18 Dec 2023 14:24:32 +0000 (UTC)
Received: from redhat.com (unknown [10.39.195.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E96B2027042;
 Mon, 18 Dec 2023 14:24:31 +0000 (UTC)
Date: Mon, 18 Dec 2023 14:24:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [v2 3/4] crypto: Support generic LUKS encryption
Message-ID: <ZYBWHdV2QXTYn2nY@redhat.com>
References: <cover.1701879996.git.yong.huang@smartx.com>
 <910801f303da1601051479d3b7e5c2c6b4e01eb7.1701879996.git.yong.huang@smartx.com>
 <ZYAp6kxCXgV749j2@redhat.com>
 <CAK9dgmZ6E4Zv5Y_BBTSQBanXdC7310VKpfkJNLPomfhJZKZwqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9dgmZ6E4Zv5Y_BBTSQBanXdC7310VKpfkJNLPomfhJZKZwqw@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.083,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Dec 18, 2023 at 10:15:34PM +0800, Yong Huang wrote:
> On Mon, Dec 18, 2023 at 7:16 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:

> > > @@ -903,6 +928,17 @@ block_crypto_child_perms(BlockDriverState *bs,
> > BdrvChild *c,
> > >
> > >      BlockCrypto *crypto = bs->opaque;
> > >
> > > +    if (role == (role & BDRV_CHILD_METADATA)) {
> > > +        /* Assign read permission only */
> > > +        perm |= BLK_PERM_CONSISTENT_READ;
> > > +        /* Share all permissions */
> > > +        shared |= BLK_PERM_ALL;
> > > +
> > > +        *nperm = perm;
> > > +        *nshared = shared;
> > > +        return;
> > > +    }
> >
> > What is code doing ?  You've set  BDRV_CHILD_METADATA role on the
> > crypto->header  object, but how does this block_crypto_child_perms
> > method get run against crypto->header ?
> >
> This paragraph originally aims to provide a function that multiple disks
> could share
> the same LUKS header (with read-only permission).
> But I've found that it may not work when updating the detached header after
> reviewing the patch recently :(.
> 
> Should it be a separate commit, Since it kind of has nothing to do with the
> basic
> function?

Yes, that would be better as a separate commit.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


