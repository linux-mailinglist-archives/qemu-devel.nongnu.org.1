Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 819BD7E4224
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:54:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0NSv-0005NH-Fx; Tue, 07 Nov 2023 09:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r0NSc-0005De-4t
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:53:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r0NSX-0006nG-BA
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699368819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dVdVpRAJULVgN6n3RP7oKs8iI/jsuwKze1jZRGLr5Nc=;
 b=MzpeZJWoBfYRTpLQNFv8QUMRZkrZYu1lZX2NZ3z5X5jIiyWu3KZhF22gNUfMBhpfRSbEdz
 ZB3IQ6vo6Ycgi7Gx4H45Yi/8CBxurjlZtPfxYZiyd7YiySLyHdv8u/l9DZZWr4PCAlC1KC
 3aJVkwL++LuRXR891M9UdhAE28hk1/Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-YA5leVTRPXe9BRqiV2G9mQ-1; Tue, 07 Nov 2023 09:53:38 -0500
X-MC-Unique: YA5leVTRPXe9BRqiV2G9mQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-53dfe3af1b9so4504696a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699368816; x=1699973616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dVdVpRAJULVgN6n3RP7oKs8iI/jsuwKze1jZRGLr5Nc=;
 b=jTS/ruYyU/px4ZkiF90dbTKPgfBgmfULMxBOZRBcni9nnDchOflFIbx9Bp/TlT19Fs
 V0xepb1jM1YVBTGamDSJ5iMYSmvh/cZ4SzIOm5Q84CsycdfJZtT/y7GdFlsDd46HRje8
 cYFU3aPrWt51X+3ETRxzluabKvv3Bic445v3zqy92od+bNDuLbyXcuUjXbY3rRrLEFL/
 Lr9sSeI5W48PKQYgEsPui8kR59xLU+3BdyYuKziHpp5cDx4xsWq6D5LNr+yI1Xrqwq9o
 n2BciQoM1kQDz7RmpbwyPUrvgYw+NZHROoZcMWClbcCOE2bWjQKs8M71ZBME+TptJjOj
 tN6A==
X-Gm-Message-State: AOJu0YxUfErAQwihYBCiyphiGeYAl59N2P+wCAMFvT4lrdK09UatYyuq
 y7pE3pGtWevcJ+TfcYN48Yl5AK/IlZ3+3J0p3Ptu00humzSEPB6SApsXhe/+VGjhZ+kKml4Eb+8
 ysaJzaMx/p1zJ1vKrAS6Kkvt5l9pIMDfQDHy0beVAiA==
X-Received: by 2002:a50:d7dc:0:b0:543:54da:1a43 with SMTP id
 m28-20020a50d7dc000000b0054354da1a43mr21122219edj.7.1699368815896; 
 Tue, 07 Nov 2023 06:53:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7Dj7czbIkFLJN7q+T7yQJOVloo19CylBvFNeselm6hsKPlPvLzjIX2WQwM4OPi7zR7A6ulEoIIBBrugiG5eI=
X-Received: by 2002:a50:d7dc:0:b0:543:54da:1a43 with SMTP id
 m28-20020a50d7dc000000b0054354da1a43mr21122205edj.7.1699368815611; Tue, 07
 Nov 2023 06:53:35 -0800 (PST)
MIME-Version: 1.0
References: <20230922151858.263447-1-berrange@redhat.com>
In-Reply-To: <20230922151858.263447-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 Nov 2023 18:53:22 +0400
Message-ID: <CAMxuvazGuV-Z1JZD+_ZtPXGtDTbBnQkOY-nhTV2PW2-gASBveA@mail.gmail.com>
Subject: Re: [PATCH] audio: don't abort on f32 audio format in wav backend
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
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

On Fri, Sep 22, 2023 at 7:19=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> Print a debug message as is done for other unsupported audio formats
> to give the user the chance to understand their mistake.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  audio/wavaudio.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/audio/wavaudio.c b/audio/wavaudio.c
> index 6445a2cb90..e70e5ee0c3 100644
> --- a/audio/wavaudio.c
> +++ b/audio/wavaudio.c
> @@ -97,6 +97,10 @@ static int wav_init_out(HWVoiceOut *hw, struct audsett=
ings *as,
>          dolog ("WAVE files can not handle 32bit formats\n");
>          return -1;
>
> +    case AUDIO_FORMAT_F32:
> +        dolog("WAVE files can not handle float formats\n");
> +        return -1;
> +
>      default:
>          abort();
>      }
> --
> 2.41.0
>


