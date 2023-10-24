Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD557D4C1B
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 11:27:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvDg9-0003zq-NP; Tue, 24 Oct 2023 05:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvDg7-0003yt-6a
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 05:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvDg5-00060C-CK
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 05:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698139580;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CsfWMtFUNJpiSG5UaqW8/bbG+uFyes2QjmDYMvbfmDs=;
 b=Ag3PoYHmFIFN22ZShYMqjdVYp1duEtzhSdciUkg1wEhn4J6BYYktFbkuRlWUMdkgVFB+1P
 Nis3XGU3WDQiK5+kONlqrAj9hQvVwlIgbykBZRp4wTyeOEJOEev4MlOBNSBRojFbEfiV0B
 iFbu4T1xng7H8BDo+p84XGOrJqLqvgA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-E33pbKhMNKaDQtWWExNX9A-1; Tue, 24 Oct 2023 05:26:12 -0400
X-MC-Unique: E33pbKhMNKaDQtWWExNX9A-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c50255b905so38338461fa.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 02:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698139570; x=1698744370;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CsfWMtFUNJpiSG5UaqW8/bbG+uFyes2QjmDYMvbfmDs=;
 b=pnwgOJvQSb+llPPF0+4lZdSWI1LKZFV433FFBj+KWpGPRkN1Fzx8S9Bd/Jxmg3Q9J4
 giIWHwV+Sx03j4IeYMrMSBWHUVSDYx04thb5ut1LYrHsELybbkl9L+5KrRkNOLS55B/y
 am1sYAO6vuN45iciPDvwtgpv54Ib3Eg7AshCHmPV5qLXK0G0vtf0x2vAx21//IUmPX5+
 u5YL9VNWNTCCu0rSOh66oKxcaFWCavPyNpb8HXtT/5rzMKqOy1+zDiM1qTSPLqpU5B6M
 jt5oXoEikGyuJrQZsnpJtoU/JWmxdbRRR9o23ITTroiYXrMMayRn0Iy/0sUfA1814MnG
 vxSw==
X-Gm-Message-State: AOJu0YxOHI6Yr2pWsjfkKSwjCCUyQJgiZ2bh2f4gsSn4b114SVpQoeZk
 itD6O9YiZ4LPGsuptu/j9R8jutQam9y6vsNs1QJ2OKQuCC1O3NNP1DrM5vxTN8KRXBb4Xk4TnHZ
 KFMa1f4BZ/D47xbQ=
X-Received: by 2002:a05:651c:2117:b0:2bd:19c5:3950 with SMTP id
 a23-20020a05651c211700b002bd19c53950mr9729611ljq.33.1698139570627; 
 Tue, 24 Oct 2023 02:26:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7iA3ayPNixW61qkcTnw8xjSZnkzg1ieuFODpOQuXD0U0vCQuUVGnquqdlIOsqrcyzK1KPZQ==
X-Received: by 2002:a05:651c:2117:b0:2bd:19c5:3950 with SMTP id
 a23-20020a05651c211700b002bd19c53950mr9729586ljq.33.1698139570251; 
 Tue, 24 Oct 2023 02:26:10 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 o27-20020a05600c511b00b004067e905f44sm11724794wms.9.2023.10.24.02.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 02:26:09 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  John Snow
 <jsnow@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Samuel Thibault <samuel.thibault@ens-lyon.org>,
 qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,  Jason Wang
 <jasowang@redhat.com>
Subject: Re: [PATCH v2 3/9] net/slirp: use different IDs for each instance
In-Reply-To: <20231024084043.2926316-4-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Tue, 24 Oct 2023 12:40:37 +0400")
References: <20231024084043.2926316-1-marcandre.lureau@redhat.com>
 <20231024084043.2926316-4-marcandre.lureau@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 24 Oct 2023 11:26:08 +0200
Message-ID: <87r0lk1idr.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Using always 0, QEMU will end up loading the same instance, even if
> multiple have been saved.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Similar (but different) fix on next Migration PULL request.

Later, Juan.

> ---
>  net/slirp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/slirp.c b/net/slirp.c
> index c33b3e02e7..af1451b60f 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -47,6 +47,7 @@
>  #include "util.h"
>  #include "migration/register.h"
>  #include "migration/qemu-file-types.h"
> +#include "migration/vmstate.h"
>=20=20
>  static int get_str_sep(char *buf, int buf_size, const char **pp, int sep)
>  {
> @@ -659,7 +660,7 @@ static int net_slirp_init(NetClientState *peer, const=
 char *model,
>       * specific version?
>       */
>      g_assert(slirp_state_version() =3D=3D 4);
> -    register_savevm_live("slirp", 0, slirp_state_version(),
> +    register_savevm_live("slirp", VMSTATE_INSTANCE_ID_ANY, slirp_state_v=
ersion(),
>                           &savevm_slirp_state, s->slirp);
>=20=20
>      s->poll_notifier.notify =3D net_slirp_poll_notify;


