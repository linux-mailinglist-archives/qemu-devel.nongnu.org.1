Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1497AD5D9
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 12:27:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkinJ-0004h2-TW; Mon, 25 Sep 2023 06:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkimF-0004TV-QN
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 06:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkily-0000qI-Lv
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 06:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695637501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/2xlzOxoYzOUyfvoqPfqBKT/PN7ylKqsVzVgaqkZs48=;
 b=AQ9X5DbBc/Ke9UQudHB4li5x5sG0zyjkGGYu3n98PJVuZBTLXsD/UF+oNLnM9p98gTEic8
 O3pGc7O0I7GNEL7Z4unKzDJBCbk3zR59fVjLEaQIGqHb2MSXOwo0aIA5oHoWjor56hLKv/
 dkvJFmAvWpvj4xYfoHBPZc8ku2aa6+k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-696-vPtgFpWSM4a6E67ACwto5g-1; Mon, 25 Sep 2023 06:24:56 -0400
X-MC-Unique: vPtgFpWSM4a6E67ACwto5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABE3885A5A8;
 Mon, 25 Sep 2023 10:24:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84E932156701;
 Mon, 25 Sep 2023 10:24:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EB7A921E6900; Mon, 25 Sep 2023 12:24:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 01/15] hw/pci/pcie_sriov: Replace
 fprintf(error_pretty) -> warn_reportf_err()
References: <20230203145536.17585-1-philmd@linaro.org>
 <20230203145536.17585-2-philmd@linaro.org>
Date: Mon, 25 Sep 2023 12:24:53 +0200
In-Reply-To: <20230203145536.17585-2-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 3 Feb 2023 15:55:22
 +0100")
Message-ID: <87y1gua6tm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/pci/pcie_sriov.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index f0bd72e069..93b0624599 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -196,19 +196,17 @@ static void register_vfs(PCIDevice *dev)
>=20=20
>  static void unregister_vfs(PCIDevice *dev)
>  {
> -    Error *local_err =3D NULL;
>      uint16_t num_vfs =3D dev->exp.sriov_pf.num_vfs;
>      uint16_t i;
>=20=20
>      trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
>                                 PCI_FUNC(dev->devfn), num_vfs);
>      for (i =3D 0; i < num_vfs; i++) {
> +        Error *errp =3D NULL;
>          PCIDevice *vf =3D dev->exp.sriov_pf.vf[i];
> -        object_property_set_bool(OBJECT(vf), "realized", false, &local_e=
rr);
> -        if (local_err) {
> -            fprintf(stderr, "Failed to unplug: %s\n",
> -                    error_get_pretty(local_err));
> -            error_free(local_err);
> +        object_property_set_bool(OBJECT(vf), "realized", false, &errp);
> +        if (errp) {
> +            warn_reportf_err(errp, "Failed to unplug: ");
>          }
>          object_unparent(OBJECT(vf));
>      }

We use @errp for Error **, and @err, @local_err and similar for Error *.
Recommend to stick with @local_err here, i.e. just

  -            fprintf(stderr, "Failed to unplug: %s\n",
  -                    error_get_pretty(local_err));
  -            error_free(local_err);
  +            warn_reportf_err(local_err, "Failed to unplug: ");


