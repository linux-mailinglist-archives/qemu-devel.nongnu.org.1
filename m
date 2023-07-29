Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F84767C97
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 08:43:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPdBh-00057n-Rs; Sat, 29 Jul 2023 02:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qPdBf-00055H-8s
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 02:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qPdBd-0006uq-FJ
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 02:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690611140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VqwEkgm0+AuPoKehsQi4ZJGs07wiUgtgUyFrHKgnyRk=;
 b=AYlZlSGxFQWQMfc6JckHMc47k6AY551qD7mGTEeZYvGEij7hdEHoAdRbwAqbupugoE5Imz
 pdpHZEuHq3xHqi+wXJCmT1f71+vUdVivCydP4gku2rZPTHgPV2ONaq9oB8SXbJwprIIdC7
 KhAhLp0G3T9geUOaPsrJZZLrEbcYLB8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-kS47WyqAOVixcXsnfulICw-1; Sat, 29 Jul 2023 02:12:16 -0400
X-MC-Unique: kS47WyqAOVixcXsnfulICw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A3E7101A54E;
 Sat, 29 Jul 2023 06:12:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A26B0F783E;
 Sat, 29 Jul 2023 06:12:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7BCEB21E6690; Sat, 29 Jul 2023 08:12:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel@nongnu.org,  ~hyman <yong.huang@smartx.com>,  Juan Quintela
 <quintela@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH QEMU 3/3] MAINTAINERS: Add Hyman Huang as maintainer
References: <169056029099.1291.9838508091499564970-3@git.sr.ht>
Date: Sat, 29 Jul 2023 08:12:14 +0200
In-Reply-To: <169056029099.1291.9838508091499564970-3@git.sr.ht>
 (hyman@git.sr.ht's message of "Thu, 27 Jul 2023 02:10:09 +0800")
Message-ID: <873517gsap.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Recommend to tweak the subject to

    MAINTAINERS: Add section "TITLE"

where TITLE is whatever you use in MAINTAINERS, provided it's short
enough to fit.

~hyman <hyman@git.sr.ht> writes:

> From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>
> I've built interests in dirty-limit and dirty page rate

Recommend to drop the dash.

> features and also have been working on projects related
> to this subsystem.
>
> Self-recommand myself as a maintainer for this subsystem

"Add myself as ..."

> so that I can help to improve the dirty-limit algorithm
> and review the patches about dirty page rate.
>
> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12e59b6b27..d4b1c91096 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3437,6 +3437,15 @@ F: hw/core/clock-vmstate.c
>  F: hw/core/qdev-clock.c
>  F: docs/devel/clocks.rst
>=20=20
> +Dirty-limit and dirty page rate feature

Suggest

   Migration dirty limit and dirty page rate

> +M: Hyman Huang <yong.huang@smartx.com>
> +S: Maintained
> +F: softmmu/dirtylimit.c
> +F: include/sysemu/dirtylimit.h
> +F: migration/dirtyrate.c
> +F: migration/dirtyrate.h
> +F: include/sysemu/dirtyrate.h
> +

Should this go right after section "Migration"?  Or are there other
applications?

>  Usermode Emulation
>  ------------------
>  Overall usermode emulation


