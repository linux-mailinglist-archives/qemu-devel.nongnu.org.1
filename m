Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5E5793747
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 10:41:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdo4x-0001vk-2o; Wed, 06 Sep 2023 04:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1qdo4r-0001uz-Bf
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 04:39:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1qdo4o-0006Yt-UH
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 04:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693989593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lF+i+Hod8hVRM3j7PT7ddV3WNbXPtfnxY6uLnZbqiVU=;
 b=dPRX47wFRsYblPuTGI4KCG/ExAKd1vEzbfZZGh95UZ9mMfqbwr4JNkl4ltrFKp9KoIbBv+
 uogUkxA6cG5+Pvp7M98uxFVHyB1G7MSSuRDigwmJF+ne1fnX+gGZP7GdJ3mx/fpzYaC5hO
 fQ5gzljSqkJQ1clLYD5Qnk2ENZe9PqE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-3Rmx3UAQMcmkvwQj5Z2nCQ-1; Wed, 06 Sep 2023 04:39:52 -0400
X-MC-Unique: 3Rmx3UAQMcmkvwQj5Z2nCQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-64aaa3c2bc2so37446606d6.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 01:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693989591; x=1694594391;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lF+i+Hod8hVRM3j7PT7ddV3WNbXPtfnxY6uLnZbqiVU=;
 b=FVfwtfUZljQVCHVAGoH81NTinlvspqBUBTB07aiqqZsF1WHEu1L7ap8rxQTLY5v+EC
 dz8lNTKcmxZq+kS8IHM9pVAPYgDMLo0uCcibLNjnLBjZZZLVkASx9gcV/M6wAYDflnE1
 oyeolKBIiAYDPqoGm85IswryFn4V9f0HcdrylB7YFYBHuEv6InGFfpvTa2csN5twKOyc
 EFTdqYfPFKR++hOBQtlJuVRPFrjK4q3H4qJEQbNjgg1fYllVrgVfsv3uJr2MXZXLjcmn
 iC65UD3lOOkv2M9JPNv6xf4tnTe7Np4g7GQIUCAemEnCI8n7zuu62vfDr3n7oz8BZOO9
 z+IA==
X-Gm-Message-State: AOJu0YzXIykj41qB2Facm0elSyybhqwkBbEr0eCGdzOFfCwR0jn1N6k2
 Wk5Rq0NPja6DrwrORFzW1KCMCCLZEam5ciPSwL7di2XRsBoRztWhCLcPxINsmiEfx8S2+pwp596
 5PGQiDwuGThJPoAw=
X-Received: by 2002:a0c:da0d:0:b0:651:7fa7:b85c with SMTP id
 x13-20020a0cda0d000000b006517fa7b85cmr17450635qvj.42.1693989591636; 
 Wed, 06 Sep 2023 01:39:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6Kr3B7F623uBHDNew5XZQl8pGQ/nqh5uitZMV3mjsryXudnWVhBGUaficJMLCej+R23Llbw==
X-Received: by 2002:a0c:da0d:0:b0:651:7fa7:b85c with SMTP id
 x13-20020a0cda0d000000b006517fa7b85cmr17450618qvj.42.1693989591409; 
 Wed, 06 Sep 2023 01:39:51 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a0ce509000000b0064f5174bc84sm5281283qvm.20.2023.09.06.01.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 01:39:51 -0700 (PDT)
Date: Wed, 6 Sep 2023 10:39:46 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Volker =?iso-8859-1?Q?R=FCmelin?= <vr_qemu@t-online.de>,
 =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v8 00/12] Add VIRTIO sound card
Message-ID: <ZPg60lzXWxHPQJEa@fedora>
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mvaralar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Aug 28, 2023 at 10:54:57PM +0300, Emmanouil Pitsidianakis wrote:
> This patch series adds an audio device implementing the recent virtio 
> sound spec (1.2) and a corresponding PCI wrapper device.
> 
> v8 can be found online at:
> 
> https://gitlab.com/epilys/qemu/-/tree/virtio-snd-v8
> 
Hello Manos, 

I have been testing these patches in a 6.4.6 Linux guest by using the
command:

`aplay /usr/share/sounds/alsa/Front_Left.wav`

There is some audio that is reproduced twice, such as "Front ... Front
Left". I have also observed this in the virtio-sound vhost-user-device.
I'm still trying to figure out why this is happening.

Thanks, Matias.


