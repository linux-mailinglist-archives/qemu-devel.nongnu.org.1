Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 014407A175C
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 09:27:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh3DJ-0001CC-Dj; Fri, 15 Sep 2023 03:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qh3DG-0001By-J8
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qh3DC-00060D-Pu
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694762757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AmuiBrqQCK+Aw3GwGPGQvIsO1A5eSJ7U6n1g9nnaNa0=;
 b=QdfRu2VWK0nOB9AqlkP6tl3YzzfbtNhsgin58bIndXAQmWn2uzWLdJW0n4o5O7ptze8qzr
 Y347agX4kpx5F2gvj0QBTtoA9zK++GQX75o6ih6GFRkXBJ08faLhe06ZPhKYuw95DqWTjH
 eU6mnfAXnNQATIqqcpdNuGNyYdSsNf8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-mlLDi4Q9MYOwrTZ1_IwtwA-1; Fri, 15 Sep 2023 03:25:53 -0400
X-MC-Unique: mlLDi4Q9MYOwrTZ1_IwtwA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB290185A79C;
 Fri, 15 Sep 2023 07:25:52 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB2422026D4B;
 Fri, 15 Sep 2023 07:25:50 +0000 (UTC)
Date: Fri, 15 Sep 2023 09:25:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, hreitz@redhat.com, fam@euphon.net,
 vsementsov@yandex-team.ru, den@virtuozzo.com
Subject: Re: [PATCH v3 2/2] qemu-img: map: report compressed data blocks
Message-ID: <ZQQG/UVwK3Vb6O23@redhat.com>
References: <20230907210226.953821-1-andrey.drobyshev@virtuozzo.com>
 <20230907210226.953821-3-andrey.drobyshev@virtuozzo.com>
 <b6yyul657xkv3usgp7vrczy6r5xssbhmzfgftvrp2srlnct7gt@ja5barlss2kh>
 <e2e0bf60-1a3e-4f48-8c5a-81e16d5245ad@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2e0bf60-1a3e-4f48-8c5a-81e16d5245ad@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

Am 14.09.2023 um 23:40 hat Andrey Drobyshev geschrieben:
> On 9/15/23 00:17, Eric Blake wrote:
> > On Fri, Sep 08, 2023 at 12:02:26AM +0300, Andrey Drobyshev wrote:
> >> Right now "qemu-img map" reports compressed blocks as containing data
> >> but having no host offset.  This is not very informative.  Instead,
> >> let's add another boolean field named "compressed" in case JSON output
> >> mode is specified.  This is achieved by utilizing new allocation status
> >> flag BDRV_BLOCK_COMPRESSED for bdrv_block_status().
> >>
> >> Also update the expected qemu-iotests outputs to contain the new field.
> >>
> >> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >> ---
> > 
> >> +++ b/qapi/block-core.json
> >> @@ -409,6 +409,9 @@
> >>  #
> >>  # @zero: whether the virtual blocks read as zeroes
> >>  #
> >> +# @compressed: true indicates that data is stored compressed.  Only valid
> >> +#     for the formats whith support compression (since 8.2)
> > 
> > s/whith/which/
> > 
> > "compressed":false seems universally valid for all other file formats,
> > and the field is not marked as optional.  Do we really need the
> > disclaimer?  Could we get by with the shorter 'Will be false for
> > formats that do not support compression', or by omitting it
> > altogether?
> > 
> 
> You're right, this remark should've been removed as it only makes sense
> in case of the field being optional.  Feel free to remove it altogether,
> or I can send a follow-up if you prefer.

I'm updating it in my queue to read:

# @compressed: true if the data is stored compressed (since 8.2)

Kevin


