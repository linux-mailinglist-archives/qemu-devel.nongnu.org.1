Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F35FF7AD60D
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 12:32:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkisw-0007sg-Oh; Mon, 25 Sep 2023 06:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkisZ-0007ZS-28
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 06:31:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkisX-0002YJ-H4
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 06:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695637908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c1cwFSdRlu0Wnlm1jrM9IfNJHssewWckutA3WOkrFVA=;
 b=fCUYq8NIig5B3d4eNNCtXpOTxZONoDTKyR7PNYzVa5te5NGDAJh1yCeGM6chiIaqIGB/ZQ
 vf9U3IX53LdRKwMjVphvIPiv6XlecoC6Bttm6qBjdjlqi3Lw8wq5YBSb+xogUyhuawFsR9
 JW4cXW2BuGZPMAozm5hNEnhRmryjMdI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-nkcvOYVKNwqG9o6IF5p6kg-1; Mon, 25 Sep 2023 06:31:45 -0400
X-MC-Unique: nkcvOYVKNwqG9o6IF5p6kg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06EB785A5BE;
 Mon, 25 Sep 2023 10:31:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7D9F2026D4B;
 Mon, 25 Sep 2023 10:31:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DB02D21E6900; Mon, 25 Sep 2023 12:31:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 04/15] hw/pci/pcie_sriov: Do not open-code
 qdev_unrealize_and_unref()
References: <20230203145536.17585-1-philmd@linaro.org>
 <20230203145536.17585-5-philmd@linaro.org>
Date: Mon, 25 Sep 2023 12:31:43 +0200
In-Reply-To: <20230203145536.17585-5-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 3 Feb 2023 15:55:25
 +0100")
Message-ID: <87lecua6i8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> (See commits dc3edf8d8a "Convert to qdev_unrealize() manually"
>  and 981c3dcd94 "Convert to qdev_unrealize() with Coccinelle").
>
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/pci/pcie_sriov.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index 93b0624599..0b6101302b 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -204,11 +204,10 @@ static void unregister_vfs(PCIDevice *dev)
>      for (i =3D 0; i < num_vfs; i++) {
>          Error *errp =3D NULL;
>          PCIDevice *vf =3D dev->exp.sriov_pf.vf[i];
> -        object_property_set_bool(OBJECT(vf), "realized", false, &errp);
> -        if (errp) {
> +
> +        if (!qdev_unrealize_and_unref(DEVICE(vf), &errp)) {
>              warn_reportf_err(errp, "Failed to unplug: ");
>          }
> -        object_unparent(OBJECT(vf));
>      }
>      g_free(dev->exp.sriov_pf.vf);
>      dev->exp.sriov_pf.vf =3D NULL;

This replaces object_unref() by object_unparent().  Why is that okay?


