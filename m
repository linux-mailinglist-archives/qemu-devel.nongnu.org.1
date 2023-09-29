Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C82947B2B0E
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 07:08:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm5iZ-000803-4m; Fri, 29 Sep 2023 01:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm5iX-0007zb-5l
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 01:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm5iV-0004PX-8q
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 01:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695964026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIVrIuBqJ5quxLmtqC1YuwmBKJZnM9NMa0HAMZlUUDI=;
 b=VTWthlC85PnhGhEGih7fMjIOsRBiThylRhgWJz/rgpeZETPhkdxGAatdBH+KVoKfTWlSu0
 y+uYFv1isI32fZTMwhSANP4Q7vQUSG9GLdt8qYnwD8p/HbFqi4S7ACmUmrrfS58kG/l+1D
 SmhV/sh/oarFTss+q55xHBo+UeRZfRQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-IswbEQptM82DMKBQgH3tVQ-1; Fri, 29 Sep 2023 01:07:02 -0400
X-MC-Unique: IswbEQptM82DMKBQgH3tVQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3ECF5185A790;
 Fri, 29 Sep 2023 05:07:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B0BF2026D4B;
 Fri, 29 Sep 2023 05:07:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0C29521E6904; Fri, 29 Sep 2023 07:07:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  qemu-arm@nongnu.org,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 11/22] hw/ide/ahci: Clean up local variable shadowing
References: <20230904161235.84651-1-philmd@linaro.org>
 <20230904161235.84651-12-philmd@linaro.org>
Date: Fri, 29 Sep 2023 07:07:01 +0200
In-Reply-To: <20230904161235.84651-12-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 4 Sep 2023 18:12:23
 +0200")
Message-ID: <87jzs9lg96.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

>   hw/ide/ahci.c:1577:23: error: declaration shadows a local variable [-We=
rror,-Wshadow]
>             IDEState *s =3D &ad->port.ifs[j];
>                       ^
>   hw/ide/ahci.c:1569:29: note: previous declaration is here
>     void ahci_uninit(AHCIState *s)
>                                 ^
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/ide/ahci.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 48d550f633..8c9a7c2117 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1573,10 +1573,8 @@ void ahci_uninit(AHCIState *s)
>      for (i =3D 0; i < s->ports; i++) {
>          AHCIDevice *ad =3D &s->dev[i];
>=20=20
> -        for (j =3D 0; j < 2; j++) {
> -            IDEState *s =3D &ad->port.ifs[j];
> -
> -            ide_exit(s);
> +        for (j =3D 0; j < ARRAY_SIZE(ad->port.ifs); j++) {

This line's change is unrelated.

When we're dealing with at a huge changeset like the tree-wide
-Wshadow=3Dlocal cleanup, I prefer to keep changes minimal to ease review
as much as possible.  But it's sunk cost now.

ad->port.ifs is IDEBus member IDEState ifs[2].  .ifs[0] corresponds to
.master, and .ifs[1] corresponds to .slave.  Size 2 is fundamental, and
will not ever change.  Whether we count to 2 or to ARRAY_SIZE(.ifs) is a
matter of taste.  Taste is up to the maintainer, not me.  John?

> +            ide_exit(&ad->port.ifs[j]);
>          }
>          object_unparent(OBJECT(&ad->port));
>      }


