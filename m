Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5741278C9D2
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:43:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1nH-0004Qm-K7; Tue, 29 Aug 2023 12:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1nA-0004QA-09
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:42:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1n6-0000gB-BT
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:42:11 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-401187f8071so12215e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693327325; x=1693932125;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=83e5koAilgLUolY7xNHwOlJBPOY3n9Ao6QkCqx1M4lY=;
 b=ffLQvOn9pYcbnPJU00VHjEQfWF0K5WJAZWnDGssUrjANQ+D+pjAkp+YEUFcU6bk3BQ
 NkFKOmz1qf3MYE1Zsgl0BRl6XVTs/2CRFIrv2rE+9vT+5O4jI908ajOkL2eAD4d1yWhG
 YxTbTCUj9L4eW5LwF3UZamPhAUqhEwkSjU3gCLTIlFBJWrna7Fk0kokEgjD86hasXEk4
 ffBzVroFDaSJhHfovxFstT2wvyUsfFUIxy26yl0Tj8fc6RPC2al5lanuufV/f1GEe6/1
 OmctkbreIms/+aE4WUaJlOr29xrAZ+9b6w4S69Uq32cJGeCj3pGiI869UbdjHx6EfFum
 MLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693327325; x=1693932125;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=83e5koAilgLUolY7xNHwOlJBPOY3n9Ao6QkCqx1M4lY=;
 b=IGey5UjwlfTa3bvmz3WZqWNhvfbjuEe1gULaFopH+mdkbYtGG9pRfBVT3v/qjkRKvf
 V16070FsvteK/XwwPDpdisasNeHx7lV9FDoUSxhYL32mnS1TbLwE+MQ7ci/PnQ7lZYeq
 To2BC3Qt/WcW56BoucSQRn4B2DanizgeGR1GTBsKt0NuzcUe4aGJQpONMXKozxzNVJqD
 NVnUL7SJvdqXx5upuSRnlY8mx6eEVCrO6JZYeESCAsZQ8QRh5t1DmPlq0tmnclvEAlNa
 LVj9aOdXBBvoz0yYgyyF/lu40UzO7wK30+bwrUal2uZXdGwrY7id3RRA87IIkUBM5Ovf
 UtIQ==
X-Gm-Message-State: AOJu0Yw7o8YwgOx0OxWLZa/XI3sqb13baPOWpwbhE0daeOnAgTnkE98n
 0xQV2IEmclkX1HKvh9C45NUINA==
X-Google-Smtp-Source: AGHT+IFbs5hwh8YmnMC8weJu1kVbl+L0ymFM4wue40PLd77D8kx/Fj33Masiy/uAescFrjuvQ5ZltQ==
X-Received: by 2002:a1c:4c17:0:b0:3fe:da37:d59 with SMTP id
 z23-20020a1c4c17000000b003feda370d59mr2606769wmf.4.1693327324684; 
 Tue, 29 Aug 2023 09:42:04 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 6-20020a05600c020600b003fc04d13242sm17755176wmi.0.2023.08.29.09.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 09:42:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E8C5A1FFBB;
 Tue, 29 Aug 2023 17:42:03 +0100 (BST)
References: <20230829132948.51053-1-thuth@redhat.com>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-block@nongnu.org, Markus Armbruster
 <armbru@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] qemu-options.hx: Rephrase the descriptions of the -hd*
 and -cdrom options
Date: Tue, 29 Aug 2023 17:39:33 +0100
In-reply-to: <20230829132948.51053-1-thuth@redhat.com>
Message-ID: <87jztdu7fo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Thomas Huth <thuth@redhat.com> writes:

> The current description says that these options will create a device
> on the IDE bus, which is only true on x86. So rephrase these sentences
> a little bit to speak of "default bus" instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-options.hx | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 29b98c3d4c..a7ce5f0f7a 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1209,10 +1209,10 @@ SRST
>  ERST
>=20=20
>  DEF("hda", HAS_ARG, QEMU_OPTION_hda,
> -    "-hda/-hdb file  use 'file' as IDE hard disk 0/1 image\n", QEMU_ARCH=
_ALL)
> +    "-hda/-hdb file  use 'file' as hard disk 0/1 image\n", QEMU_ARCH_ALL)
>  DEF("hdb", HAS_ARG, QEMU_OPTION_hdb, "", QEMU_ARCH_ALL)
>  DEF("hdc", HAS_ARG, QEMU_OPTION_hdc,
> -    "-hdc/-hdd file  use 'file' as IDE hard disk 2/3 image\n", QEMU_ARCH=
_ALL)
> +    "-hdc/-hdd file  use 'file' as hard disk 2/3 image\n", QEMU_ARCH_ALL)
>  DEF("hdd", HAS_ARG, QEMU_OPTION_hdd, "", QEMU_ARCH_ALL)
>  SRST
>  ``-hda file``
> @@ -1222,18 +1222,22 @@ SRST
>  ``-hdc file``
>    \=20
>  ``-hdd file``
> -    Use file as hard disk 0, 1, 2 or 3 image (see the :ref:`disk images`
> -    chapter in the System Emulation Users Guide).
> +    Use file as hard disk 0, 1, 2 or 3 image on the default bus of the
> +    emulated machine (this is for example the IDE bus on most x86 machin=
es,
> +    but it can also be SCSI, virtio or something else on other target
> +    architectures). See al the :ref:`disk images` chapter in the
>  System

See also?

> +    Emulation Users Guide.
>  ERST
>=20=20
>  DEF("cdrom", HAS_ARG, QEMU_OPTION_cdrom,
> -    "-cdrom file     use 'file' as IDE cdrom image (cdrom is ide1 master=
)\n",
> +    "-cdrom file     use 'file' as CD-ROM image\n",
>      QEMU_ARCH_ALL)
>  SRST
>  ``-cdrom file``
> -    Use file as CD-ROM image (you cannot use ``-hdc`` and ``-cdrom`` at
> -    the same time). You can use the host CD-ROM by using ``/dev/cdrom``
> -    as filename.
> +    Use file as CD-ROM image on the default bus of the emulated machine
> +    (which is IDE1 master on x86, so you cannot use ``-hdc`` and ``-cdro=
m``
> +    at the same time there). On systems that support it, you can use the
> +    host CD-ROM by using ``/dev/cdrom`` as filename.
>  ERST
>=20=20
>  DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

