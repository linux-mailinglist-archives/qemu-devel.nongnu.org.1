Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 116997F2687
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 08:41:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5LNG-0001DS-QJ; Tue, 21 Nov 2023 02:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5LND-0001DH-11
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 02:40:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5LNA-000235-Oy
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 02:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700552439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGsmivuNtzFAdJAXCDZQdR0/DRH01+xj7YDoxFhhnAo=;
 b=Lly5gGzryBFX+VRp/9L88LG5pg9DVNCmf/JE0Xmyuc3NOWJq/reENvB3XdfpCJ2GM+4kqQ
 GGtA/df8MYtyGYrsUOr9B7cqhYKlxXRpvVX9jMYlFk8e6GqWgEJWbFBMZ/j5E2GkAYA8N2
 YEnB91GXXQ7h8VrwaTIFeVo/zWHln90=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-yiuXycmVNFGSIVMWAv2vXQ-1; Tue,
 21 Nov 2023 02:40:37 -0500
X-MC-Unique: yiuXycmVNFGSIVMWAv2vXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 769681C07257;
 Tue, 21 Nov 2023 07:40:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 192A820268CF;
 Tue, 21 Nov 2023 07:40:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 11BF921E6A1F; Tue, 21 Nov 2023 08:40:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Zhenwei Pi <pizhenwei@bytedance.com>,  "Gonglei
 (Arei)" <arei.gonglei@huawei.com>,  Markus Armbruster <armbru@redhat.com>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH-for-8.2 v2] backends/cryptodev: Do not ignore
 throttle/backends Errors
References: <20231120150418.93443-1-philmd@linaro.org>
Date: Tue, 21 Nov 2023 08:40:36 +0100
In-Reply-To: <20231120150418.93443-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 20 Nov 2023 16:04:18
 +0100")
Message-ID: <87cyw3mu4r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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

> Both cryptodev_backend_set_throttle() and CryptoDevBackendClass::init()
> can set their Error** argument. Do not ignore them, return early on
> failure.

Let's mention why we need to: "Without that, running into another
failure trips error_setv()'s assertion."

>          Use the ERRP_GUARD() macro as suggested in commit ae7c80a7bd
> ("error: New macro ERRP_GUARD()").
>
> Cc: qemu-stable@nongnu.org
> Fixes: e7a775fd9f ("cryptodev: Account statistics")
> Fixes: 2580b452ff ("cryptodev: support QoS")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  backends/cryptodev.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/backends/cryptodev.c b/backends/cryptodev.c
> index e5006bd215..fff89fd62a 100644
> --- a/backends/cryptodev.c
> +++ b/backends/cryptodev.c
> @@ -398,6 +398,7 @@ static void cryptodev_backend_set_ops(Object *obj, Vi=
sitor *v,
>  static void
>  cryptodev_backend_complete(UserCreatable *uc, Error **errp)
>  {
> +    ERRP_GUARD();
>      CryptoDevBackend *backend =3D CRYPTODEV_BACKEND(uc);
>      CryptoDevBackendClass *bc =3D CRYPTODEV_BACKEND_GET_CLASS(uc);
>      uint32_t services;
> @@ -406,11 +407,20 @@ cryptodev_backend_complete(UserCreatable *uc, Error=
 **errp)
>      QTAILQ_INIT(&backend->opinfos);
>      value =3D backend->tc.buckets[THROTTLE_OPS_TOTAL].avg;
>      cryptodev_backend_set_throttle(backend, THROTTLE_OPS_TOTAL, value, e=
rrp);
> +    if (*errp) {
> +        return;
> +    }
>      value =3D backend->tc.buckets[THROTTLE_BPS_TOTAL].avg;
>      cryptodev_backend_set_throttle(backend, THROTTLE_BPS_TOTAL, value, e=
rrp);
> +    if (*errp) {
> +        return;
> +    }
>=20=20
>      if (bc->init) {
>          bc->init(backend, errp);
> +        if (*errp) {
> +            return;
> +        }
>      }
>=20=20
>      services =3D backend->conf.crypto_services;

Preferably with the commit message improved:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


