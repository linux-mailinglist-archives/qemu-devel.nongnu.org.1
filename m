Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DAE7A00F3
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 11:55:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgj3K-0001Ef-Oq; Thu, 14 Sep 2023 05:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qgj3I-0001ER-VJ
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 05:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qgj3H-0003OE-FZ
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 05:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694685262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MBcL7WvNWAVesN8rWsylmtVjOeZfHHAq9kWdbGkjLX0=;
 b=V5V4e7eWYxJWPPrTqz8bo9AhMcsfb5AoaaScuhZUgEkfL5GQBHK0JHtTvIhRk4VFn1NFru
 qb4t+ZQrXAcb2XsgCJguko4pPTwoEU/s7tZif3z1aGnfEOc8mR6+dItsCQ/rk6COUK/rs6
 KVsFD8ZRnE0XiliuNi2eb9OFiB5CVE8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-Nm4Z1-mfPMeBrNGJE1Offg-1; Thu, 14 Sep 2023 05:54:20 -0400
X-MC-Unique: Nm4Z1-mfPMeBrNGJE1Offg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31c5c762f97so544412f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 02:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694685260; x=1695290060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBcL7WvNWAVesN8rWsylmtVjOeZfHHAq9kWdbGkjLX0=;
 b=KPa+x6BMUGYLWfMGNzN2UuZJIGH2NT590hvMahp4DmtdjAUk0mt2EmiRVcxjP6vAV6
 /kwxAW+wlGYsF4ARHeO5DvQEZh3sQMtyLAPnNMu2IxAUthJd/J92kNhuP4W8mX3tvvHj
 +p6yPVJ9YJ1a4fi0/JtLETtcm7eynXGtwyKMhBV39CyjgexMxqfHNg/92xp95pkWDu5o
 KC+iNMI2fWoejv1glOThON6CP39eJC99rztTDpVX/GHAqgCeFA1WXJJNBsCufkvfR9nc
 J3a6ZM+6D3jjfNbr2XkEx+oJ+qVYQxCPuT1y3sdjCmt6ZETTnqph8ZZybL/lKHCsrhQC
 MNQg==
X-Gm-Message-State: AOJu0Yzm0f1O7BmzN0f0OOcNfM+M17VtPZyrRBVT++aPRaFOi+D08HUk
 vDoCDukVA/dIa2jRXNixZ4OYBkBpUzGtENzhluNwK1O3ZV7iPtAEudcQ0w+QodHNzmIj/866ThG
 a4I2xa78MDR9LTMA=
X-Received: by 2002:a5d:444c:0:b0:318:7bc:122e with SMTP id
 x12-20020a5d444c000000b0031807bc122emr3973260wrr.23.1694685259807; 
 Thu, 14 Sep 2023 02:54:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZLJdG0Kw6jZS6jjTYwAkBEPC6SRESO4D72bXonCOl13BW7zKs2h4wIKfEbg6tV9ntVltbsg==
X-Received: by 2002:a5d:444c:0:b0:318:7bc:122e with SMTP id
 x12-20020a5d444c000000b0031807bc122emr3973236wrr.23.1694685259432; 
 Thu, 14 Sep 2023 02:54:19 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.205.248])
 by smtp.gmail.com with ESMTPSA id
 z8-20020a056000110800b0031f9bdb79dasm1297986wrw.61.2023.09.14.02.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 02:54:18 -0700 (PDT)
Date: Thu, 14 Sep 2023 11:54:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>, 
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v9 00/12] Add VIRTIO sound card
Message-ID: <2gm4wkfnjopd7l5zvzepzknl4hfomkxvtgvw72daazne2n34wy@fgqmh3mi3r5l>
References: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Wed, Sep 13, 2023 at 10:33:07AM +0300, Emmanouil Pitsidianakis wrote:
>This patch series adds an audio device implementing the recent virtio
>sound spec (1.2) and a corresponding PCI wrapper device.
>
>v9 can be found online at:
>
>https://gitlab.com/epilys/qemu/-/tree/virtio-snd-v9
>
>Ref 06e6b17186
>
>Main differences with v8 patch series [^v8]
><cover.1693252037.git.manos.pitsidianakis@linaro.org>:
>
>- Addressed [^v8] review comments.
>- Add cpu_to_le32(_) and le32_to_cpu(_) conversions for messages from/to
>  the guest according to the virtio spec.
>- Inlined some functions and types to reduce review complexity.
>- Corrected the replies to IO messages; now both Playback and Capture
>  work correctly for me. (If you hear cracks in pulseaudio+guest, try
>  pipewire+guest).

We are seeing something strange with the virtio-sound Linux driver.
It seems that the driver modifies the buffers after exposing them to
the device via the avail ring.

It seems we have this strange behaviour with this built-in QEMU device,
but also with the vhost-device-sound, so it could be some spec
violation in the Linux driver.

Matias also reported on the v8 of this series:
https://lore.kernel.org/qemu-devel/ZPg60lzXWxHPQJEa@fedora/

Can you check if you have the same behaviour?

Nothing that blocks this series of course, but just to confirm that
there may be something to fix in the Linux driver.

Thanks,
Stefano


