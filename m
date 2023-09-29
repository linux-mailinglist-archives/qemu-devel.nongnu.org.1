Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1D77B2B08
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 07:00:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm5ae-0006Dm-9K; Fri, 29 Sep 2023 00:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm5ac-0006DB-7B
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 00:58:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm5aa-0002M3-Uf
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 00:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695963536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dItL0TvXfbuTtKqxkuHNARbrBHBLRVsgwGWFCicycY8=;
 b=iqAqwDw5ptyXi65oHSAjlh+J4iUaKAgGCDdXYewVkZWZJsNfDewzsSiZwwn9+705vlQ8p2
 muvW3k3CVCsYwnmsCqVIrZOvVxj37Vnv9Rf/9wiSDLVCZJmbb0S0w/uEYcK3N8OqOSfRFv
 8quH+NPbnvHkLkEpNy0+1Eup7tmmGtY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670--jMXBCxKNAu6iXwX-Pedjg-1; Fri, 29 Sep 2023 00:58:52 -0400
X-MC-Unique: -jMXBCxKNAu6iXwX-Pedjg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6431F3C01BB8;
 Fri, 29 Sep 2023 04:58:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 368AA2026D4B;
 Fri, 29 Sep 2023 04:58:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AF7F521E6904; Fri, 29 Sep 2023 06:58:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,  David Gibson
 <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 20/22] sysemu/device_tree: Clean up local variable
 shadowing
References: <20230904161235.84651-1-philmd@linaro.org>
 <20230904161235.84651-21-philmd@linaro.org>
Date: Fri, 29 Sep 2023 06:58:50 +0200
In-Reply-To: <20230904161235.84651-21-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 4 Sep 2023 18:12:32
 +0200")
Message-ID: <87o7hllgmt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Fix:
>
>   hw/mips/boston.c:472:5: error: declaration shadows a local variable [-W=
error,-Wshadow]
>     qemu_fdt_setprop_cells(fdt, name, "reg", reg_base, reg_size);
>     ^
>   include/sysemu/device_tree.h:129:13: note: expanded from macro 'qemu_fd=
t_setprop_cells'
>         int i;
>             ^
>   hw/mips/boston.c:461:9: note: previous declaration is here
>     int i;
>         ^
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/sysemu/device_tree.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/include/sysemu/device_tree.h b/include/sysemu/device_tree.h
> index ca5339beae..8eab395934 100644
> --- a/include/sysemu/device_tree.h
> +++ b/include/sysemu/device_tree.h
> @@ -126,10 +126,8 @@ int qemu_fdt_add_path(void *fdt, const char *path);
>  #define qemu_fdt_setprop_cells(fdt, node_path, property, ...)           =
      \
>      do {                                                                =
      \
>          uint32_t qdt_tmp[] =3D { __VA_ARGS__ };                         =
        \
> -        int i;                                                          =
      \
> -                                                                        =
      \
> -        for (i =3D 0; i < ARRAY_SIZE(qdt_tmp); i++) {                   =
        \
> -            qdt_tmp[i] =3D cpu_to_be32(qdt_tmp[i]);                     =
        \
> +        for (unsigned i_ =3D 0; i_ < ARRAY_SIZE(qdt_tmp); i_++) {       =
        \
> +            qdt_tmp[i_] =3D cpu_to_be32(qdt_tmp[i_]);                   =
        \
>          }                                                               =
      \
>          qemu_fdt_setprop(fdt, node_path, property, qdt_tmp,             =
      \
>                           sizeof(qdt_tmp));                              =
      \

You don't just rename the variable, but also adjust its type.  When
we're dealing with at a huge changeset like the tree-wide -Wshadow=3Dlocal
cleanup, I prefer to keep changes minimal to ease review as much as
possible.  But it's sunk cost now, so

Reviewed-by: Markus Armbruster <armbru@redhat.com>


