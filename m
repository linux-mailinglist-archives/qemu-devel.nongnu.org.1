Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 391AF7F58A6
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 07:54:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r63ai-0002C3-8F; Thu, 23 Nov 2023 01:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r63ae-0002BY-8S
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 01:53:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r63ac-0006ql-8F
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 01:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700722404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhEHX2k7iHQkXFUoOSaVN9gueOnV43nyf17PTtkoRKI=;
 b=Rbjd9ozwWaCH5ubIlX+/Wdz9lTTlhxaAKE2kzxF/F5R3Udq9W8UlndLHuzmuDBRDWKSsaJ
 Eipzjx40FV3GoZH2yFor44tpIswkpp+vs6zAmxWnCb+dy/lTEARSGIGqSd12gHlw/CtkBl
 aYqFwKycHF87eUe6EOxuUqEV1qUb6xo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-vaDBr7EIP_qfp5MMgSWfqQ-1; Thu,
 23 Nov 2023 01:53:20 -0500
X-MC-Unique: vaDBr7EIP_qfp5MMgSWfqQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5ADEF3C027B1;
 Thu, 23 Nov 2023 06:53:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F14B5028;
 Thu, 23 Nov 2023 06:53:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2042221E6A1F; Thu, 23 Nov 2023 07:53:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Jiaxun Yang <jiaxun.yang@flygoat.com>,  Markus
 Armbruster <armbru@redhat.com>
Subject: Re: [PATCH-for-9.0] hw/mips/cps: Simplify access to
 'start-powered-off' property
References: <20231122183633.17676-1-philmd@linaro.org>
Date: Thu, 23 Nov 2023 07:53:19 +0100
In-Reply-To: <20231122183633.17676-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 22 Nov 2023 19:36:33
 +0100")
Message-ID: <87o7fl7yg0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Since commit c1b701587e ("target/arm: Move start-powered-off
> property to generic CPUState"), all target CPUs have the
> 'start-powered-off' property.
>
> This object_property_set_bool() call can not fail. Use &error_abort
> to simplify.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/mips/cps.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index b6612c1762..4f12e23ab5 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -78,10 +78,9 @@ static void mips_cps_realize(DeviceState *dev, Error *=
*errp)
>          CPUMIPSState *env =3D &cpu->env;
>=20=20
>          /* All VPs are halted on reset. Leave powering up to CPC. */
> -        if (!object_property_set_bool(OBJECT(cpu), "start-powered-off", =
true,
> -                                      errp)) {
> -            return;
> -        }
> +        object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
> +                                 &error_abort);
> +
>          /* All cores use the same clock tree */
>          qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->clock);

There are more:

    $ git-grep -A 1 'object_prop.*start-powered-off'
    hw/arm/armsse.c:1025:            if (!object_property_set_bool(cpuobj, =
"start-powered-off", true,
    hw/arm/armsse.c-1026-                                          errp)) {
    --
    hw/arm/armv7m.c:321:    if (object_property_find(OBJECT(s->cpu), "start=
-powered-off")) {
    hw/arm/armv7m.c:322:        if (!object_property_set_bool(OBJECT(s->cpu=
), "start-powered-off",
    hw/arm/armv7m.c-323-                                      s->start_powe=
red_off, errp)) {
    --
    hw/arm/boot.c:1290:                object_property_set_bool(cpuobj, "st=
art-powered-off", true,
    hw/arm/boot.c-1291-                                         &error_abor=
t);
    --
    hw/arm/fsl-imx6.c:131:            object_property_set_bool(OBJECT(&s->c=
pu[i]), "start-powered-off",
    hw/arm/fsl-imx6.c-132-                                     true, &error=
_abort);
    --
    hw/arm/fsl-imx7.c:195:            object_property_set_bool(o, "start-po=
wered-off", true,
    hw/arm/fsl-imx7.c-196-                                     &error_abort=
);
    --
    hw/arm/xlnx-versal.c:51:            object_property_set_bool(obj, "star=
t-powered-off", true,
    hw/arm/xlnx-versal.c-52-                                     &error_abo=
rt);
    --
    hw/arm/xlnx-versal.c:153:        object_property_set_bool(obj, "start-p=
owered-off", true,
    hw/arm/xlnx-versal.c-154-                                 &error_abort);
    --
    hw/mips/cps.c:81:        if (!object_property_set_bool(OBJECT(cpu), "st=
art-powered-off", true,
    hw/mips/cps.c-82-                                      errp)) {
    --
    hw/ppc/e500.c:957:        object_property_set_bool(OBJECT(cs), "start-p=
owered-off", i !=3D 0,
    hw/ppc/e500.c-958-                                 &error_fatal);
    --
    hw/sparc/sun4m.c:806:    object_property_set_bool(OBJECT(cpu), "start-p=
owered-off", id !=3D 0,
    hw/sparc/sun4m.c-807-                             &error_fatal);

We also set the property with qdev_prop_set_bit() in places, which is a
trivial wrapper around object_property_set_bool() that passes
&error_abort.  Either is fine, I think.


