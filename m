Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26255829A00
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 12:59:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNXEg-00010H-OV; Wed, 10 Jan 2024 06:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rNXEX-0000zM-O7
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 06:58:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rNXES-0002QH-S7
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 06:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704887930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtFE1dJsK2MDS7eACPV30aak8Vu9wcFVMJE44VX6vMY=;
 b=d94kAU970FYsuYrGSRKDunSxXIU3YWLs6RE4S3Tx6YRikiWlWylGyiA/0LEc5mOAS7PTJP
 eoQBvgGqioIG2vmWD71kzv4M6h7Hx/riU5ongUi+ne8eKTyESF+/W4VlnKFP242XtINw5B
 JaUHDu6gdYMmAHYMfwrtYbKjuN3M8kw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-6hGFCRJGMVmCYdnXfkIWGA-1; Wed, 10 Jan 2024 06:58:48 -0500
X-MC-Unique: 6hGFCRJGMVmCYdnXfkIWGA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a28d6f071b2so158402066b.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 03:58:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704887928; x=1705492728;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OtFE1dJsK2MDS7eACPV30aak8Vu9wcFVMJE44VX6vMY=;
 b=qF3uvKdCpUn2XmhR34br+zTXd4FOS2RzSax5vLcm6KNB/B/i2tGEOzoEPFI2a4tqrO
 V4iI46oXt2zDrMUWvd3ey+5FnBm6m2pyumZNCMQpx8iWHENbcBzT4pCRdA33g86fUoU4
 CFGOPE8u1MqLuGXB1thHZSRk5UBj357A2ZLeeNRLYLG9u3Bb908dHX8LCOEl4k3KC9CW
 tMSWZZNElgACtpuV6TGRafQtASdpgtNjP/MekoYiljmfzcbH5012MFe1geDeA1H+eTlv
 63KT/pJ+C8Ex0t6f7Dr1F46xaAwCn/CQ/VTBpB5lRlEMXZgC5fdGq4uHIuw2TP73EenH
 PuTQ==
X-Gm-Message-State: AOJu0YymvQaNetcyVEkdgkCIgrQ1aLAitQoFZGkjuMj8F1qNC1pTkXH3
 6au+mRPMCXlBH7p/m1lqpdVqFHqt2Btk/tW+3jrNvrNf+wUstl6k1/NvTClYcQetWqYVaKlWDmT
 YkSTefHGUUxo7lFezUI6ErF+4sODdwk9SwmYklx0=
X-Received: by 2002:aa7:d484:0:b0:557:4797:bcb9 with SMTP id
 b4-20020aa7d484000000b005574797bcb9mr403823edr.77.1704887927952; 
 Wed, 10 Jan 2024 03:58:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8IIgQD//8AxtFh+Fif2mQnq8wR5j1ezQwQ/Cl/WilJj0u+1RXzqR1vO/YPriV0kFSIEOvLfbaCLskEZkbiIY=
X-Received: by 2002:aa7:d484:0:b0:557:4797:bcb9 with SMTP id
 b4-20020aa7d484000000b005574797bcb9mr403817edr.77.1704887927724; Wed, 10 Jan
 2024 03:58:47 -0800 (PST)
MIME-Version: 1.0
References: <20240110111644.28294-1-berrange@redhat.com>
In-Reply-To: <20240110111644.28294-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jan 2024 15:58:36 +0400
Message-ID: <CAMxuvayPK=68vNQ7ZCm3YgR8+PuTDHJJGAVRr-YGPpVDnTQ7pg@mail.gmail.com>
Subject: Re: [PATCH] chardev: close QIOChannel before unref'ing
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 jiangyegen <jiangyegen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
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

Hi

On Wed, Jan 10, 2024 at 3:16=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> The chardev socket backend will unref the QIOChannel object while
> it is still potentially open. When using TLS there could be a
> pending TLS handshake taking place. If the channel is left open
> then when the TLS handshake callback runs, it can end up accessing
> free'd memory in the tcp_chr_tls_handshake method.
>
> Closing the QIOChannel will unregister any pending handshake
> source.

ooh oh, one of those little things..
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

(weak refs could be a solution? but it's also sometime tricky, and we
don't have those..)

>
> Reported-by: jiangyegen <jiangyegen@huawei.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  chardev/char-socket.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 73947da188..7105753815 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -378,6 +378,10 @@ static void tcp_chr_free_connection(Chardev *chr)
>                                   char_socket_yank_iochannel,
>                                   QIO_CHANNEL(s->sioc));
>      }
> +
> +    if (s->ioc) {
> +        qio_channel_close(s->ioc, NULL);
> +    }
>      object_unref(OBJECT(s->sioc));
>      s->sioc =3D NULL;
>      object_unref(OBJECT(s->ioc));
> --
> 2.43.0
>


