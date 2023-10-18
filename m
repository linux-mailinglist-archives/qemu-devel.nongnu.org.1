Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 674097CDF63
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:20:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7OQ-0003uN-Gt; Wed, 18 Oct 2023 10:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qt7OO-0003jU-3V
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qt7OK-0005mi-O1
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697638758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQ8jGO1rc65kBw83jhVOtnen8vp/+MHQoFPfactGFh8=;
 b=R77PJHyj0J2Y5FNMv6sz5cabo9/0uwgXRpO5aYezb8xJYt5D/HGXyJQSQRNlSHqThd3cHH
 2hAtYbUmUEwtRiXQbQVCBtkjD1meuE7aSAsWalJBEKPCfx0UoirbjgrMivnocEYs1/qly4
 /f5+vYoW61PAP0ElYJIs9jJlA1X/Gt8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-3ySLh3XyMemz_5AOy9cNQQ-1; Wed, 18 Oct 2023 10:19:11 -0400
X-MC-Unique: 3ySLh3XyMemz_5AOy9cNQQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-53df95eaebfso5176492a12.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 07:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697638749; x=1698243549;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lQ8jGO1rc65kBw83jhVOtnen8vp/+MHQoFPfactGFh8=;
 b=QDY7Y0d19w+53zY1TsyXPnuuifjF+XHSTOhEkWPcetEjGPqZbwP+z4/bIDw1FdLPUy
 N4e8eAYfZ1yA6a7DOgBLNe5nJUKH0rhKHCkuquhlX3YQnIsbsFwirlodl49ylxYEYgIa
 5PBISD2QJ56aH7XxIsVdfdPNc3fht+GZ42HnqZaUenb1TRjuhoc7lCvcSGpwunDQj6qL
 0sU4jCUP2sVo4a3CyUoDAf1j3RhEqwcGfQtydJVpIsxY+g4VQ38MO/+aBIBUgrq2lA8S
 enEd/C96fohrftBFhiXKOo2BmXIgdogsxYJgz0SV795RXMTKg5cGFduL6OlDynEtX75H
 m9wQ==
X-Gm-Message-State: AOJu0Yz8Onfr+PKVhKrZXruQJmf5JBOHEt3KlCZNFC/5uE/XXrRQ3ofr
 8v0zo8ueVZ6kblf/rMUyT3fCwsrcV0KuOMHtqbnFeiKK89wBYhsphqVbn9YayVSIkLzPtgPT5G6
 od0aMp5fGa3i2w/y0il4fOQrlQ2QJuTN1yY76cPV7ug==
X-Received: by 2002:a05:6402:2711:b0:53e:7b7e:b713 with SMTP id
 y17-20020a056402271100b0053e7b7eb713mr4576610edd.22.1697638749513; 
 Wed, 18 Oct 2023 07:19:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOHd49EGcZjrvGC1LBJo/YvBK2YxLprcznA3BgrRtBk/QM5TuQhfOe8PCr11eHvjGkGm1FDOzbxD4Epe8WRLc=
X-Received: by 2002:a05:6402:2711:b0:53e:7b7e:b713 with SMTP id
 y17-20020a056402271100b0053e7b7eb713mr4576584edd.22.1697638749196; Wed, 18
 Oct 2023 07:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231018133820.1556962-1-marcandre.lureau@redhat.com>
 <20231018133820.1556962-5-marcandre.lureau@redhat.com>
In-Reply-To: <20231018133820.1556962-5-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Oct 2023 18:18:57 +0400
Message-ID: <CAMxuvaxjs8J9ZNJ+LFT06CXJUGAoHxHGdmGhKdVvSOY2+DrdXw@mail.gmail.com>
Subject: Re: [PATCH v4 04/19] vl: move display early init before default
 devices
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-arm@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-ppc@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi

On Wed, Oct 18, 2023 at 5:38=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The next commit needs to have the display registered itself before
> creating the default VCs.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

nack,

this needs further early display initialization from
qemu_create_default_devices(), will fix in v5

> ---
>  system/vl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/system/vl.c b/system/vl.c
> index 3100ac01ed..73e4ed2bef 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1933,7 +1933,6 @@ static void qemu_create_early_backends(void)
>                       "ignoring option");
>      }
>
> -    qemu_display_early_init(&dpy);
>      qemu_console_early_init();
>
>      if (dpy.has_gl && dpy.gl !=3D DISPLAYGL_MODE_OFF && display_opengl =
=3D=3D 0) {
> @@ -3664,6 +3663,7 @@ void qemu_init(int argc, char **argv)
>      suspend_mux_open();
>
>      qemu_disable_default_devices();
> +    qemu_display_early_init(&dpy);
>      qemu_create_default_devices();
>      qemu_create_early_backends();
>
> --
> 2.41.0
>


