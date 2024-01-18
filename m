Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB42831F16
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 19:28:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQX6q-0005c3-BD; Thu, 18 Jan 2024 13:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQX6e-0005Zh-Sx
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 13:27:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQX6d-0004Se-Cd
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 13:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705602429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8JhtkA98RGBDK/wnHK6LTLS1niCrCl4nDDQDvAUPmw=;
 b=AEGOnm8/UNGcungML6FafdM5UxnfDI76IKpOBpFgEV8me6nRFImnaK/IfLWEGKdA7GBNNs
 HIk89b7KC7GHOHvVCwlgMQKd449xaUdjFb4yY0/XIvweTRW2pSiHL/g3DipWcUDAMMo3GS
 L1HRt1ZkuXiisuQIf3pHungnIftQ4kA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-0o9dAGF9PLSTFBLhAD9gSw-1; Thu,
 18 Jan 2024 13:27:06 -0500
X-MC-Unique: 0o9dAGF9PLSTFBLhAD9gSw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2F5A3815F95;
 Thu, 18 Jan 2024 18:27:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DF8B492BE2;
 Thu, 18 Jan 2024 18:27:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 11CFD21E66CF; Thu, 18 Jan 2024 19:27:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,  Zhenwei Pi
 <pizhenwei@bytedance.com>,  qemu-stable@nongnu.org
Subject: Re: [PATCH v3] backends/cryptodev: Do not ignore throttle/backends
 Errors
In-Reply-To: <20240118181955.19949-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 18 Jan 2024 19:19:55
 +0100")
References: <20240118181955.19949-1-philmd@linaro.org>
Date: Thu, 18 Jan 2024 19:27:04 +0100
Message-ID: <87bk9i8pl3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
> can set their Error** argument. Do not ignore them, return early
> on failure. Without that, running into another failure trips
> error_setv()'s assertion. Use the ERRP_GUARD() macro as suggested
> in commit ae7c80a7bd ("error: New macro ERRP_GUARD()").
>
> Cc: qemu-stable@nongnu.org
> Fixes: e7a775fd9f ("cryptodev: Account statistics")
> Fixes: 2580b452ff ("cryptodev: support QoS")
> Reviewed-by: zhenwei pi <pizhenwei@bytedance.com>
> Reviewed-by: Gonglei <arei.gonglei@huawei.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
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

Reviewed-by: Markus Armbruster <armbru@redhat.com>


