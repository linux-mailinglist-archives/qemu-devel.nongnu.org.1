Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FFA7A5E80
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:46:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXId-0005d0-1e; Tue, 19 Sep 2023 05:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qiXIE-0005R5-J0
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:45:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qiXIC-0007iw-CA
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695116715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V1mP29WFUX97+g1j0GENZgYcEtjWxZ7dHu7PUEU0WXI=;
 b=MzDyViMLTSP0X2QNOMG7wVHScyyO8ZMa7qaDb2YSFRJsYTE4cR0Wp4PiUyj0QXFYzcJFzF
 2gpm2JirvWlfeRUVQSLVREnx8lAUUMlxrLZI+F+ZBdmgYDyrnBFk0JjVBQhlGSUllGSlSQ
 LMF5+vH7iVWMbEOptdK/wvMUVFj8nKc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-1ckR902UOiaT0vEMdhORnA-1; Tue, 19 Sep 2023 05:45:10 -0400
X-MC-Unique: 1ckR902UOiaT0vEMdhORnA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF7523C0C480;
 Tue, 19 Sep 2023 09:45:09 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47482140E950;
 Tue, 19 Sep 2023 09:45:06 +0000 (UTC)
Date: Tue, 19 Sep 2023 11:45:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, idryomov@gmail.com,
 pl@kamp.de, sw@weilnetz.de, sstabellini@kernel.org,
 anthony.perard@citrix.com, paul@xen.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, stefanha@redhat.com, fam@euphon.net,
 quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 kraxel@redhat.com, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH 4/7] block/dirty-bitmap: Clean up local variable shadowing
Message-ID: <ZQltoZWlnIW/wDi3@redhat.com>
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-5-armbru@redhat.com>
 <ZQQNUjN4Laf+k1Nk@redhat.com> <8734za4stm.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734za4stm.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 19.09.2023 um 07:48 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 31.08.2023 um 15:25 hat Markus Armbruster geschrieben:
> >> Local variables shadowing other local variables or parameters make the
> >> code needlessly hard to understand.  Tracked down with -Wshadow=local.
> >> Clean up: delete inner declarations when they are actually redundant,
> >> else rename variables.
> >> 
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>  block/monitor/bitmap-qmp-cmds.c | 2 +-
> >>  block/qcow2-bitmap.c            | 3 +--
> >>  2 files changed, 2 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/block/monitor/bitmap-qmp-cmds.c b/block/monitor/bitmap-qmp-cmds.c
> >> index 55f778f5af..4d018423d8 100644
> >> --- a/block/monitor/bitmap-qmp-cmds.c
> >> +++ b/block/monitor/bitmap-qmp-cmds.c
> >> @@ -276,7 +276,7 @@ BdrvDirtyBitmap *block_dirty_bitmap_merge(const char *node, const char *target,
> >>  
> >>      for (lst = bms; lst; lst = lst->next) {
> >>          switch (lst->value->type) {
> >> -            const char *name, *node;
> >> +            const char *name;
> >>          case QTYPE_QSTRING:
> >>              name = lst->value->u.local;
> >>              src = bdrv_find_dirty_bitmap(bs, name);
> >
> > The names in this function are all over the place... A more ambitious
> > patch could rename the parameters to dst_node/dst_bitmap and these
> > variables to src_node/src_bitmap to get some more consistency (both with
> > each other and with the existing src/dst variables).
> 
> What exactly would you like me to consider?  Perhaps:
> 
> * Rename parameter @node to @dst_node
> 
> * Rename which parameter to @dst_bitmap?

Parameter @target to @dst_bitmap (it's the name of a bitmap in
@node/@dst_node)

> * Rename nested local @node to @src_node
> 
> * Rename which local variable to @src_bitmap?

@name to @src_bitmap (it's the name of a bitmap in the local
@node/@src_node)

> * Move nested locals to function scope

I don't really mind either way, but yes, maybe that would be more
conventional.

That you couldn't tell for two of the variables what they actually are
probably supports the argument that they should be renamed. :-)

Kevin


