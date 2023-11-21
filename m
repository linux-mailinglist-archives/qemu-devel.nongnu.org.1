Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 249987F26E2
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:01:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Lgm-0006p6-LI; Tue, 21 Nov 2023 03:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5Lgj-0006oY-Ps
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:00:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5Lgi-0007HA-4s
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700553650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXKbN3Kzbum0EKd/z60KDsbtT3gYfSg70b0lW4NKB4M=;
 b=E121Ayj9qy12r6Ir5+XPU8Ce3E9fvcz6cPy8i3IN+68NWYfZTjs3ToWcTSU3oPjy4WLhTM
 aQs/bBqImHJCdz56CANahuh1k64nuANY4Rn5Qf9I169BfbA3ooVK3t4Hh+uxQ3fq4vPjc/
 zEIoJvgA+/CNm9BYqgh6hw3NjAuYEt8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-IExuojJuOjS0Q7v4I4_tlw-1; Tue, 21 Nov 2023 03:00:49 -0500
X-MC-Unique: IExuojJuOjS0Q7v4I4_tlw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D81B6811E7D;
 Tue, 21 Nov 2023 08:00:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B11A11121306;
 Tue, 21 Nov 2023 08:00:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B4D4F21E6A1F; Tue, 21 Nov 2023 09:00:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Eric DeVolder <eric.devolder@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,  qemu-stable@nongnu.org
Subject: Re: [PATCH-for-8.2?] hw/acpi/erst: Do not ignore Error* in realize
 handler
References: <20231120130017.81286-1-philmd@linaro.org>
Date: Tue, 21 Nov 2023 09:00:47 +0100
In-Reply-To: <20231120130017.81286-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 20 Nov 2023 14:00:17
 +0100")
Message-ID: <87il5vlemo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> erst_realizefn() calls functions which could update the 'errp'
> argument, but then ignores it.

To be precise: it ignores failure.  Suggest to clarify the commit
message like this:

  erst_realizefn() passes @errp to functions without checking for
  failure.  If it runs into another failure, it trips error_setv()'s
  assertion.

>                                Use the ERRP_GUARD() macro and
> check *errp, as suggested in commit ae7c80a7bd ("error: New macro
> ERRP_GUARD()").
>
> Cc: qemu-stable@nongnu.org
> Fixes: f7e26ffa59 ("ACPI ERST: support for ACPI ERST feature")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/acpi/erst.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/hw/acpi/erst.c b/hw/acpi/erst.c
> index 35007d8017..ba751dc60e 100644
> --- a/hw/acpi/erst.c
> +++ b/hw/acpi/erst.c
> @@ -947,6 +947,7 @@ static const VMStateDescription erst_vmstate  =3D {
>=20=20
>  static void erst_realizefn(PCIDevice *pci_dev, Error **errp)
>  {
> +    ERRP_GUARD();
>      ERSTDeviceState *s =3D ACPIERST(pci_dev);
>=20=20
>      trace_acpi_erst_realizefn_in();
> @@ -964,9 +965,15 @@ static void erst_realizefn(PCIDevice *pci_dev, Error=
 **errp)
>=20=20
>      /* HostMemoryBackend size will be multiple of PAGE_SIZE */
>      s->storage_size =3D object_property_get_int(OBJECT(s->hostmem), "siz=
e", errp);
> +    if (*errp) {
> +        return;
> +    }
>=20=20
>      /* Initialize backend storage and record_count */
>      check_erst_backend_storage(s, errp);
> +    if (*errp) {
> +        return;
> +    }

If you change check_erst_backend_storage() to return bool, you can use

       if (!check_erst_backend_storage(s, errp) {
           return;
       }

Not a demand.

>=20=20
>      /* BAR 0: Programming registers */
>      memory_region_init_io(&s->iomem_mr, OBJECT(pci_dev), &erst_reg_ops, =
s,
> @@ -977,6 +984,9 @@ static void erst_realizefn(PCIDevice *pci_dev, Error =
**errp)
>      memory_region_init_ram(&s->exchange_mr, OBJECT(pci_dev),
>                              "erst.exchange",
>                              le32_to_cpu(s->header->record_size), errp);
> +    if (*errp) {
> +        return;
> +    }

Likewise, with more callers to simplify.  Again, not a demand.

>      pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY,
>                          &s->exchange_mr);

With the commit message clarified:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


