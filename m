Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBA47AD99F
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 15:56:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkm3Z-0005OB-Ue; Mon, 25 Sep 2023 09:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkm3Y-0005Ni-1k
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 09:55:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkm3O-0006cZ-RD
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 09:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695650113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+GO3FDGo0gpmW/3m5oH5gjD2slFhzSLVeWiAtW2rptc=;
 b=MEuwmIssNB/2Hb7x2Atr/ftlzenBUKbgv6ddraRPakNMETKXMHdWEOQNS5mP4kWShrTSJ0
 G/IjZ9U5reD6v6b5UBotlITE0AXeYDUbnuWib/BGkk9M5iO7by8GlkLFS1h6ljhiCmY6+A
 3Ku6VXOwaLPukpi67GvFXBmQZGIJ8cY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-zSKz7mR4OyW-A4rYBbo3dA-1; Mon, 25 Sep 2023 09:55:10 -0400
X-MC-Unique: zSKz7mR4OyW-A4rYBbo3dA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0169F811E94;
 Mon, 25 Sep 2023 13:55:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D285A40C2009;
 Mon, 25 Sep 2023 13:55:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C259E21E6900; Mon, 25 Sep 2023 15:55:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Juan
 Quintela <quintela@redhat.com>,  Zhijian Li <lizhijian@fujitsu.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] MAINTAINERS: Add entry for rdma migration
References: <20230925133441.265455-1-peterx@redhat.com>
Date: Mon, 25 Sep 2023 15:55:08 +0200
In-Reply-To: <20230925133441.265455-1-peterx@redhat.com> (Peter Xu's message
 of "Mon, 25 Sep 2023 09:34:41 -0400")
Message-ID: <8734z2s6gz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> It's not obvious to many that RDMA migration is in Odd Fixes stage for a
> long time.  Add an explicit sub entry for it (besides migration, which
> already covers the rdma files) to be clear on that, meanwhile add Zhijian
> as Reviewer, so Zhijian can see the patches and review when he still has
> the bandwidth.
>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 355b1960ce..f6b21da753 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3217,6 +3217,11 @@ F: qapi/migration.json
>  F: tests/migration/
>  F: util/userfaultfd.c
>=20=20
> +RDMA Migration
> +R: Li Zhijian <lizhijian@fujitsu.com>
> +S: Odd Fixes
> +F: migration/rdma*
> +
>  Migration dirty limit and dirty page rate
>  M: Hyman Huang <yong.huang@smartx.com>
>  S: Maintained

Hmm...

    $ scripts/get_maintainer.pl --status -f migration/rdma.cLi Zhijian <liz=
hijian@fujitsu.com> (reviewer:RDMA Migration)
    Juan Quintela <quintela@redhat.com> (maintainer:Migration)
    Peter Xu <peterx@redhat.com> (reviewer:Migration)
    Leonardo Bras <leobras@redhat.com> (reviewer:Migration)
    qemu-devel@nongnu.org (open list:All patches CC here)
    Odd Fixes
    Maintained

Contradictory status.  Do we care?

To avoid, try something like the appended patch.  With that one:

    $ scripts/get_maintainer.pl --status -f migration/rdma.c
    Juan Quintela <quintela@redhat.com> (odd fixer:RDMA Migration)
    Li Zhijian <lizhijian@fujitsu.com> (reviewer:RDMA Migration)
    Peter Xu <peterx@redhat.com> (reviewer:RDMA Migration)
    Leonardo Bras <leobras@redhat.com> (reviewer:RDMA Migration)
    qemu-devel@nongnu.org (open list:All patches CC here)
    Odd Fixes


diff --git a/MAINTAINERS b/MAINTAINERS
index 355b1960ce..3e80857eab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3216,6 +3216,15 @@ F: docs/devel/migration.rst
 F: qapi/migration.json
 F: tests/migration/
 F: util/userfaultfd.c
+X: migration/rdma*
+
+RDMA Migration
+M: Juan Quintela <quintela@redhat.com>
+R: Li Zhijian <lizhijian@fujitsu.com>
+R: Peter Xu <peterx@redhat.com>
+R: Leonardo Bras <leobras@redhat.com>
+S: Odd Fixes
+F: migration/rdma*
=20
 Migration dirty limit and dirty page rate
 M: Hyman Huang <yong.huang@smartx.com>


