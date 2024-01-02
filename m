Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9267821B33
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 12:51:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKdI0-0008NS-67; Tue, 02 Jan 2024 06:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rKdHy-0008N8-75
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 06:50:30 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rKdHw-000775-Mo
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 06:50:29 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4282e2fd93aso260481cf.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 03:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704196227; x=1704801027; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QwbypJ73LcLsDwIupB/a+pv5MQVKwJbdWWDIfRz9jok=;
 b=HqV0IKlhxJWmiBYxqYXvtYCkIbaW88gmmgMPmOMbuQ6q5Sewsbzm77UN8OP5/KKPMw
 aRzBQTHt0ILvm41vhk6slzmEyOApOr08s7LDWwr13R/oMJvvesbABRragvgcZtXfL91F
 5oscnkI/EHBOu4uQwG4ugnxgm0fxFjX9o/rB2dj0EmZY/KPm9PdwQD9vySrG6ApO1rZu
 L3RXNB5o8httvSCouvg5Q60Pk+4IvhgZ+XoCRSR2q9EKhyWiHxm08uklfKf9sMlm2yrD
 PikmB6saEbSkEC5JQHENCPejf/NpNqrJPrCZMk4mmwRNSMYwYTrFLOEJTq0K9PT2BoFj
 I1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704196227; x=1704801027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QwbypJ73LcLsDwIupB/a+pv5MQVKwJbdWWDIfRz9jok=;
 b=KvwbSiCvc/AxBd4Ee4I3xDXRsT2ifn+ZHmgAQ92Gjs4d2obAk+oil09U70sWkuXWe5
 bVR28Dkt2JLkGewa4sKasVkjKAW4Z9gygaumC2Wx1nuYG8YKYWD2iVi4My8d2yYlC942
 CZfbxBOpdOa0f/MnWhM/+WT+m3Uw1edboelSgMPPtnKaFCLpeVCGrlX2YD6Dp4ZqyAm2
 JG2habRiaJbajynSl/+Y5sbuCe245O/vdXxsVxITVjVk+BTpfaWWWAKntdnEN0qPtiGn
 UoRDjByeXn953IF8+gEy5AZXual5MDLO+ycLu55dSQU6ZPeNiQ4ObXnSUjPAbl9gBEDf
 fDQA==
X-Gm-Message-State: AOJu0YwHdXPvZskT6M25L07DFudc75c9q6y8DSKljMeK3iORhr1mAnmX
 N206UgcLoMHsfAOZ2t23RnVzN+tPxjnuM3bqgi8=
X-Google-Smtp-Source: AGHT+IGotzR+IbHSvLyCTquJ++TDP/oxY3q2zmw1Iu0n3CSYZAH8Gw3eD1Fr7WRXBgiyURwS/8vn0RIOkL1U8tBC/70=
X-Received: by 2002:ac8:5788:0:b0:427:f474:89c3 with SMTP id
 v8-20020ac85788000000b00427f47489c3mr8227656qta.121.1704196227540; Tue, 02
 Jan 2024 03:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-5-ray.huang@amd.com>
In-Reply-To: <20231219075320.165227-5-ray.huang@amd.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jan 2024 15:50:16 +0400
Message-ID: <CAJ+F1C+gu0Jh9KSJK5jgUx0xOq7Da0wkN+U0zOBLffC3wDgVpA@mail.gmail.com>
Subject: Re: [PATCH v6 04/11] virtio-gpu: Don't require udmabuf when blobs and
 virgl are enabled
To: Huang Rui <ray.huang@amd.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>, 
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com, 
 Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Antonio Caggiano <antonio.caggiano@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Dec 19, 2023 at 11:54=E2=80=AFAM Huang Rui <ray.huang@amd.com> wrot=
e:
>
> From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>
> The udmabuf usage is mandatory when virgl is disabled and blobs feature
> enabled in the Qemu machine configuration. If virgl and blobs are enabled=
,
> then udmabuf requirement is optional. Since udmabuf isn't widely supporte=
d
> by a popular Linux distros today, let's relax the udmabuf requirement for
> blobs=3Don,virgl=3Don. Now, a full-featured virtio-gpu acceleration is
> available to Qemu users without a need to have udmabuf available in the
> system.
>
> Reviewed-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>
> No change in v6.
>
>  hw/display/virtio-gpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 8b2f4c6be3..4c3ec9d0ea 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1443,6 +1443,7 @@ void virtio_gpu_device_realize(DeviceState *qdev, E=
rror **errp)
>
>      if (virtio_gpu_blob_enabled(g->parent_obj.conf)) {
>          if (!virtio_gpu_rutabaga_enabled(g->parent_obj.conf) &&
> +            !virtio_gpu_virgl_enabled(g->parent_obj.conf) &&
>              !virtio_gpu_have_udmabuf()) {
>              error_setg(errp, "need rutabaga or udmabuf for blob resource=
s");
>              return;
> --
> 2.25.1
>


--=20
Marc-Andr=C3=A9 Lureau

