Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 777527921EA
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 12:41:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdTTM-0003JG-LL; Tue, 05 Sep 2023 06:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdTTJ-0003Iy-MZ
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 06:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdTT6-0003ao-Ct
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 06:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693910373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UCqScJPUoSfvK96/l7GDHf+Z71kxxBU03FNDdLftw7M=;
 b=S3gE6Fp5nKisxyZD7NukJo2AE+Jqdbfts5R7VG+/CNw68wdAXFGT6ZOvNEx9TLVwb9sjaZ
 W13gbYOKuqT92KiV+gYnXPbsOalbf9rjXP44wlYRpgAp7bDyx+qwH+s92x+wlT+QrsUBkP
 KKD/icxz7LAal9/Yyr0xy9/XmY3sqWk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-pDKPoj66OaeYV-SixQlCqA-1; Tue, 05 Sep 2023 06:39:31 -0400
X-MC-Unique: pDKPoj66OaeYV-SixQlCqA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31c5adb698aso1185366f8f.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 03:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693910370; x=1694515170;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UCqScJPUoSfvK96/l7GDHf+Z71kxxBU03FNDdLftw7M=;
 b=L6ljIkgQy8MBz4snR0fCXljj2b7KjHrmTl1h5gKi9V9yW88eiWGUOXi1/KGja4Z0Lp
 0yRYAU7ZdplVrgOKLua29nEHUUdCFo65nph16Z0aNpn3V0ilQ5jNDGHjEqE2aeBjUzI2
 nnF+GSQDwyV51oDIl03sDXXY14cUz1NF9Ffx+RdjHCnDVI8kOa2NLr8ah+9qb68KREJ1
 Zzbo+i+9vxhbNGp7jkx730LrlCdk2WyV66Iw7bBxi0BBr3MuaFP86UaXA3g+br4lDflr
 K4ZwI0Et+ZRQY9Yh7Z3O+SzZANFiDjSSUmcvtv4XWKrOEU5cIgU0vHKroiz7NBqIecOG
 H4vA==
X-Gm-Message-State: AOJu0YxEzdO53UqBLRkYul9jUH5/HtRJj4kQj/nZuwcapMqqIEqOoRN6
 tIBZ/lv1vVsvtdxQKj6GG4gj2hF8jKBAgnLBBsY3xPLOhMud0FTGg2HiLfqGB2cij+2IbGaZhlD
 CFKYQC97py1aN6fw=
X-Received: by 2002:a5d:674c:0:b0:316:fc63:dfed with SMTP id
 l12-20020a5d674c000000b00316fc63dfedmr10357677wrw.39.1693910370412; 
 Tue, 05 Sep 2023 03:39:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHANjPVof20khC2Ajmmi6FTZ417//TxWJAjEdUU4OHoDTbkeXqVSlVJh2kh9CkVqzfBvKmpvA==
X-Received: by 2002:a5d:674c:0:b0:316:fc63:dfed with SMTP id
 l12-20020a5d674c000000b00316fc63dfedmr10357661wrw.39.1693910370054; 
 Tue, 05 Sep 2023 03:39:30 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-5.web.vodafone.de. [109.43.176.5])
 by smtp.gmail.com with ESMTPSA id
 f4-20020adfdb44000000b0031984b370f2sm17077333wrj.47.2023.09.05.03.39.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 03:39:29 -0700 (PDT)
Message-ID: <12deb1fe-5a9d-ba44-8867-62f674ecfdf4@redhat.com>
Date: Tue, 5 Sep 2023 12:39:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] audio: remove QEMU_AUDIO_* and -audio-help support
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230905101944.307701-1-pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230905101944.307701-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-1.473, SPF_HELO_NONE=0.001,
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

On 05/09/2023 12.19, Paolo Bonzini wrote:
> These have been deprecated for a long time, and the introduction
> of -audio in 7.1.0 has cemented the new way of specifying an
> audio backend.  Remove all the associated baggage, including the
> concept of default audio backends.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   audio/alsaaudio.c               |   1 -
>   audio/audio.c                   |  44 +--
>   audio/audio.h                   |   1 -
>   audio/audio_int.h               |   2 -
>   audio/audio_legacy.c            | 591 --------------------------------
>   audio/coreaudio.m               |   1 -
>   audio/dbusaudio.c               |   1 -
>   audio/dsoundaudio.c             |   1 -
>   audio/jackaudio.c               |   1 -
>   audio/meson.build               |   1 -
>   audio/noaudio.c                 |   1 -
>   audio/ossaudio.c                |   1 -
>   audio/paaudio.c                 |   1 -
>   audio/pwaudio.c                 |   1 -
>   audio/sdlaudio.c                |   1 -
>   audio/sndioaudio.c              |   1 -
>   audio/wavaudio.c                |   1 -
>   docs/about/deprecated.rst       |   8 -
>   docs/about/removed-features.rst |   6 +
>   qemu-options.hx                 |  10 -
>   softmmu/vl.c                    |   4 -
>   21 files changed, 10 insertions(+), 669 deletions(-)
>   delete mode 100644 audio/audio_legacy.c
> 
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index 057571dd1e0..5ffb39c4182 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -960,7 +960,6 @@ static struct audio_driver alsa_audio_driver = {
>       .init           = alsa_audio_init,
>       .fini           = alsa_audio_fini,
>       .pcm_ops        = &alsa_pcm_ops,
> -    .can_be_default = 1,
>       .max_voices_out = INT_MAX,
>       .max_voices_in  = INT_MAX,
>       .voice_size_out = sizeof (ALSAVoiceOut),
> diff --git a/audio/audio.c b/audio/audio.c
> index 90c7c49d116..13f519611f6 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -111,8 +111,6 @@ const struct mixeng_volume nominal_volume = {
>   #endif
>   };
>   
> -static bool legacy_config = true;
> -
>   int audio_bug (const char *funcname, int cond)
>   {
>       if (cond) {
> @@ -1712,46 +1710,14 @@ static AudioState *audio_init(Audiodev *dev, const char *name)
>       /* silence gcc warning about uninitialized variable */
>       AudiodevListHead head = QSIMPLEQ_HEAD_INITIALIZER(head);
>   
> -    if (using_spice) {
> -        /*
> -         * When using spice allow the spice audio driver being picked
> -         * as default.
> -         *
> -         * Temporary hack.  Using audio devices without explicit
> -         * audiodev= property is already deprecated.  Same goes for
> -         * the -soundhw switch.  Once this support gets finally
> -         * removed we can also drop the concept of a default audio
> -         * backend and this can go away.
> -         */
> -        driver = audio_driver_lookup("spice");
> -        if (driver) {
> -            driver->can_be_default = 1;
> -        }
> -    }
> -
>       if (dev) {
>           /* -audiodev option */
> -        legacy_config = false;
>           drvname = AudiodevDriver_str(dev->driver);
>       } else if (!QTAILQ_EMPTY(&audio_states)) {
> -        if (!legacy_config) {
> -            dolog("Device %s: audiodev default parameter is deprecated, please "
> -                  "specify audiodev=%s\n", name,
> -                  QTAILQ_FIRST(&audio_states)->dev->id);
> -        }
> +        dolog("Device %s: audiodev default parameter is deprecated, please "
> +              "specify audiodev=%s\n", name,
> +              QTAILQ_FIRST(&audio_states)->dev->id);

You said that you removed the default handling ... so this log message looks 
suspicious ... is this code block still required?

>           return QTAILQ_FIRST(&audio_states);
> -    } else {
> -        /* legacy implicit initialization */
> -        head = audio_handle_legacy_opts();
> -        /*
> -         * In case of legacy initialization, all Audiodevs in the list will have
> -         * the same configuration (except the driver), so it doesn't matter which
> -         * one we chose.  We need an Audiodev to set up AudioState before we can
> -         * init a driver.  Also note that dev at this point is still in the
> -         * list.
> -         */
> -        dev = QSIMPLEQ_FIRST(&head)->dev;
> -        audio_validate_opts(dev, &error_abort);
>       }

  Thomas


