Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F267D0F22
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 13:51:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qto1o-0002Cm-Qp; Fri, 20 Oct 2023 07:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qto1S-00024u-3f
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 07:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qto1O-0006zd-Rh
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 07:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697802629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CYgcAkSAR957BdA+0448FHo6zd07oCrkdPxOxAN5IrU=;
 b=BdHIfkCfAKpk0WqiDn6MrH822HxcBt07pBi5lfgGD+JwetbEYTcmhM7KwS+RFIQ+t3GI7J
 EPHFVXyhR1KJUKZkAMkvnDbwD5BphyHlqDCt2+TtHSgrRrG26Bp2Dk/zkvOG0VEJK1IzbA
 2U721885hYEfmbTiwY3dcDoOPHvQBQk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-Yh8B0O6BNDaY5vxkcJK1Gg-1; Fri, 20 Oct 2023 07:50:27 -0400
X-MC-Unique: Yh8B0O6BNDaY5vxkcJK1Gg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9FE0889064;
 Fri, 20 Oct 2023 11:50:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF0AF40C6F7E;
 Fri, 20 Oct 2023 11:50:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB47721E6A1F; Fri, 20 Oct 2023 13:50:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,  qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,  Juan Quintela <quintela@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 14/22] qapi: Inline and remove QERR_IO_ERROR definition
References: <20231005045041.52649-1-philmd@linaro.org>
 <20231005045041.52649-15-philmd@linaro.org>
Date: Fri, 20 Oct 2023 13:50:25 +0200
In-Reply-To: <20231005045041.52649-15-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 5 Oct 2023 06:50:31
 +0200")
Message-ID: <875y314iny.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Address the comment added in commit 4629ed1e98
> ("qerror: Finally unused, clean up"), from 2015:
>
>   /*
>    * These macros will go away, please don't use
>    * in new code, and do not add new ones!
>    */
>
> Mechanical transformation using:
>
>   $ sed -i -e 's/QERR_IO_ERROR/"An IO error has occurred"/' \
>     $(git grep -wl QERR_IO_ERROR)
>
> then manually removing the definition in include/qapi/qmp/qerror.h.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/qapi/qmp/qerror.h | 3 ---
>  block/vmdk.c              | 8 ++++----
>  blockdev.c                | 2 +-
>  dump/win_dump.c           | 4 ++--
>  migration/savevm.c        | 4 ++--
>  softmmu/cpus.c            | 4 ++--
>  6 files changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
> index ac727d1c2d..d95c4b84b9 100644
> --- a/include/qapi/qmp/qerror.h
> +++ b/include/qapi/qmp/qerror.h
> @@ -17,9 +17,6 @@
>   * add new ones!
>   */
>=20=20
> -#define QERR_IO_ERROR \
> -    "An IO error has occurred"
> -
>  #define QERR_MIGRATION_ACTIVE \
>      "There's a migration process in progress"
>=20=20
> diff --git a/block/vmdk.c b/block/vmdk.c
> index e90649c8bf..6779a181f0 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -2246,12 +2246,12 @@ vmdk_init_extent(BlockBackend *blk, int64_t files=
ize, bool flat, bool compress,
>      /* write all the data */
>      ret =3D blk_co_pwrite(blk, 0, sizeof(magic), &magic, 0);
>      if (ret < 0) {
> -        error_setg(errp, QERR_IO_ERROR);

As far as I can tell, blk_co_pwrite() returns a negative errno code.
Which we throw away, and claim "IO error".  I expect that to be
misleading at least sometimes.

I suspect the other uses of QERR_IO_ERROR are similarly problematic more
often than not.

Not your patch's problem, of course.

> +        error_setg(errp, "An IO error has occurred");

We should spell it "I/O", unless we're reporting trouble with Jupiter's
moon.

>          goto exit;
>      }
>      ret =3D blk_co_pwrite(blk, sizeof(magic), sizeof(header), &header, 0=
);
>      if (ret < 0) {
> -        error_setg(errp, QERR_IO_ERROR);
> +        error_setg(errp, "An IO error has occurred");
>          goto exit;
>      }
>=20=20

[...]


