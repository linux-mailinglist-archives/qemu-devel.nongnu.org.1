Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 512CA7F0BDF
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 07:34:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4xq9-0007SQ-NZ; Mon, 20 Nov 2023 01:33:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r4xq7-0007S7-VD
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 01:32:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r4xq6-0003eh-Bx
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 01:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700461976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7oD6gUbnQRW6v0pn+q/tci9tLbPPW0Z16l5J3s22AKM=;
 b=YLo+icusef7CxY07uFywMdFseh4WGHzlvXeK94dUgM73LwycM3CydJv2qYTaTQyl0vAn7k
 M4rcSNIDx7AMgXVU4g9V4Q3iOzkjiesmXPYjdwGQ3cLwv2ilQk9SiUIl96cqFKSyLps7h9
 0mSrwmnxrGcKYPNiss+EUf/TNIGd9rk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-9PWdCoiGNTa7SCVecPG_Yw-1; Mon, 20 Nov 2023 01:32:54 -0500
X-MC-Unique: 9PWdCoiGNTa7SCVecPG_Yw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-543714a9d86so3066142a12.2
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 22:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700461973; x=1701066773;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7oD6gUbnQRW6v0pn+q/tci9tLbPPW0Z16l5J3s22AKM=;
 b=nVdpy9CKTmxeeevEpYxNxTtNyTclODB/SOHIWIlVQQru+x5799UXsFw0Ni9H5xYINz
 Dzb6/+7MTHwLRVb0VPxHpAJo598YpBZUinrZ3m1G3N+3pSSXkfBVaG0g14slhOPRhUaL
 tI9/HCTsKizXkJAeSyMFmTskhZvBB3n8je0b5wg1ShutWvluYapVqCzuFATPUmevdg0a
 p1+oo5uv32PP1zFfNCANhVSAIy2i+jxMYxuB+aouxnfnio/GXkJwBLccPYk1ONynyOTb
 W9i+ufJD/DpiaJoNWN0DkVa9nlmlba+2Ub5bLkSIMjWRi/34PV5tJa+r6r8APblgn10J
 Cnlg==
X-Gm-Message-State: AOJu0YwcoYdxVPHYB6Xg21VX+MPCgfwkfWRpryW0IrXo9Yo1hNFsyBKN
 EVRp2lk+UNFeMw0hgIOHHnG9VaJfHjTatK66NyJR//ANIPNYJX1VdFFsREnK0mCYjXVdbUIoZMu
 DcEE9UwFhxeaAIb6vdgdOGwPUCyuxABU=
X-Received: by 2002:aa7:c658:0:b0:533:c75a:6f6 with SMTP id
 z24-20020aa7c658000000b00533c75a06f6mr4828679edr.12.1700461973358; 
 Sun, 19 Nov 2023 22:32:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHe2CqE+eSfTCXi8XnVwhiKweL1xjrCIMHKkoqYegGnbqNTDRklZBGBEAZwEWOnHU4xizZ+AyqjSIySU0bKyYc=
X-Received: by 2002:aa7:c658:0:b0:533:c75a:6f6 with SMTP id
 z24-20020aa7c658000000b00533c75a06f6mr4828675edr.12.1700461973074; Sun, 19
 Nov 2023 22:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20231119083940.20558-1-akihiko.odaki@daynix.com>
In-Reply-To: <20231119083940.20558-1-akihiko.odaki@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 20 Nov 2023 10:32:41 +0400
Message-ID: <CAMxuvayt2PHtZmFPWyMsXP5kLXYVT3Bhwowsk__8_Z_jTxvWjw@mail.gmail.com>
Subject: Re: [PATCH] audio: Free consumed default audio devices
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Nov 19, 2023 at 12:40=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> Failed default audio devices were removed from the list but not freed,
> and that made LeakSanitizer sad. Free default audio devices as they are
> consumed.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  audio/audio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/audio/audio.c b/audio/audio.c
> index f91e05b72c..becf6cdf46 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1758,12 +1758,14 @@ static AudioState *audio_init(Audiodev *dev, Erro=
r **errp)
>                  goto out;
>              }
>              s->dev =3D dev =3D e->dev;
> +            QSIMPLEQ_REMOVE_HEAD(&default_audiodevs, next);
> +            g_free(e);
>              drvname =3D AudiodevDriver_str(dev->driver);
>              driver =3D audio_driver_lookup(drvname);
>              if (!audio_driver_init(s, driver, dev, NULL)) {
>                  break;
>              }
> -            QSIMPLEQ_REMOVE_HEAD(&default_audiodevs, next);
> +            qapi_free_Audiodev(dev);

I'd set s->dev to NULL, to avoid potential dangling pointers.

(it looks like like this could already hit a double-free on error path)

>          }
>      }
>
> --
> 2.42.1
>


