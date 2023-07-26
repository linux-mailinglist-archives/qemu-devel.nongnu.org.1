Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A166E762893
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 04:09:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOTwO-0006vS-FP; Tue, 25 Jul 2023 22:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOTwF-0006vA-IT
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 22:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOTwE-00048h-2T
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 22:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690337260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3VkxgKGYM3CDeAHIaoW1kvvQlMST2Ioe/N67Mi+YkIs=;
 b=QQcYnv5kqQTBt9/J9VZGg2xELKMg8cKK1bCfWoZQsLH1nCr3hrbQncaRXfjz7SX8RFrmr9
 XrhZb/EL17iB2EW40rRl43HJjYE1gAcqF+gAHW1ivv4wR9v/BcQ4XMaqau3gJ23McRNsos
 7TTM+/uqjecZkdhxx8d9NQBefcW9R6A=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-kzO2TLYCNO2TWcs78MIDgg-1; Tue, 25 Jul 2023 22:07:39 -0400
X-MC-Unique: kzO2TLYCNO2TWcs78MIDgg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b934194964so54536041fa.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 19:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690337257; x=1690942057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3VkxgKGYM3CDeAHIaoW1kvvQlMST2Ioe/N67Mi+YkIs=;
 b=LaOW5Du7V225F5NFVnhQJZm+M4CNXx4sNhnHeKCj6ght3D6VorPijnsSylEuLnVzyD
 6rXv83EwZT9tHdATVGc8dq/cu49kGoRKMQLzGPzSTUjaRYD3ZGw7zJh86bb3mVMXFRhc
 dkLJslHwUhnnH/Nnj05q3wS6HvtjKJXd8lVhnqpLVqz69otr65Cc56yx7Im2DkHGfcQX
 YHQBu6Q1hWSfGPrucpto0WVCF/koYdjZ5n/Y0P/GvOI4Qfbw06Mu78GqnPPi8Ly4j5dD
 25tYHVe7rUjCUq5Agl0xfUY7g7V+lZuIHXKAMcaFk1OqHfHqB6gM+c54RfXRXN5S2U2Y
 4d8A==
X-Gm-Message-State: ABy/qLaglgSf+EdBEvSJhJBuhldr6xfyQdbOsZa1BHGof2QJvw4l2a92
 o9SrNJ73ccOggh8CkGpbLzHV5R1I0ndLcSqjQ4uXpaBltWB9I5vP9WrQIAsl4gKPGL0MQFQGtxu
 MdEIsskc9b3KvJrs7x8ERO7VyHhaq4tQ=
X-Received: by 2002:a2e:9e56:0:b0:2b6:df6b:84c0 with SMTP id
 g22-20020a2e9e56000000b002b6df6b84c0mr276986ljk.25.1690337257537; 
 Tue, 25 Jul 2023 19:07:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGSIB7ccJOD6QMH5/1K2fioHyoJVwUEGPfL/gBK1M2EJuuCZvpYPmFWxhKEBVIdwSNtBtvDFO8ma1yHrEjy7WM=
X-Received: by 2002:a2e:9e56:0:b0:2b6:df6b:84c0 with SMTP id
 g22-20020a2e9e56000000b002b6df6b84c0mr276977ljk.25.1690337257250; Tue, 25 Jul
 2023 19:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230725182143.1523091-1-eperezma@redhat.com>
In-Reply-To: <20230725182143.1523091-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Jul 2023 10:07:26 +0800
Message-ID: <CACGkMEsqbZNGKdK1kM-qQeZShNeonQKK4_65vtCueQxUsRFTsQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: set old virtio status at cvq isolation probing end
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, si-wei.liu@oracle.com, qemu-stable@nongnu.org, 
 Hawkins Jiawei <yin31149@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Wed, Jul 26, 2023 at 2:21=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> The device already has a virtio status set by vhost_vdpa_init by the
> time vhost_vdpa_probe_cvq_isolation is called. vhost_vdpa_init set
> S_ACKNOWLEDGE and S_DRIVER, so it is invalid to just reset it.
>
> It is invalid to start the device after it, but all devices seems to be
> fine with it.  Fixing qemu so it follows virtio start procedure.
>
> Fixes: 152128d64697 ("vdpa: move CVQ isolation check to net_init_vhost_vd=
pa")
> Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  net/vhost-vdpa.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 9795306742..d7e2b714b4 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1333,6 +1333,8 @@ static int vhost_vdpa_probe_cvq_isolation(int devic=
e_fd, uint64_t features,
>  out:
>      status =3D 0;
>      ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> +    status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER;
> +    ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);

So if we fail after FEATURES_OK, this basically clears that bit. Spec
doesn't say it can or not, I wonder if a reset is better?

Btw, spec requires a read of status after setting FEATURES_OK, this
seems to be missed in the current code.

Thanks

>      return r;
>  }
>
> --
> 2.39.3
>


