Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8EA7B034C
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 13:46:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlSzM-0001D9-SM; Wed, 27 Sep 2023 07:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlSzK-0001Ar-Pe
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlSzI-0001Gp-Ol
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695815151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K30bNB7nTGKicho4tq08gBzq08m8zkdLJhD39wrOTRM=;
 b=STqHibH4VmienWMnb43AnUqq2X0MF/79+CCXVO8GqvsWO8rHwoy2zlUmgru6wQb4sK8h/c
 2BLXdTZ28tlKF9lvtYZinQO75wMbaj+4B+RKET1OOObeQZ11buPhNyA48e/wotXVidr89P
 jTntaG7dnJ1zWel0gKzVntvEKm5sLAc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-1j1cGI0VP7u7qDphsqCyrg-1; Wed, 27 Sep 2023 07:45:50 -0400
X-MC-Unique: 1j1cGI0VP7u7qDphsqCyrg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65aff02d602so136189716d6.1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 04:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695815149; x=1696419949;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K30bNB7nTGKicho4tq08gBzq08m8zkdLJhD39wrOTRM=;
 b=Lax+SkOyjgn3FfTRyxmvI4lmnPUdq4NJBJp/LlR5PkjuWuvfS/2Tls0cdzCbItPZZy
 xC8eaDHekFEer4kQXrhwVkd7R4FtHTHyPe/WBC7b5uzmugdinqnvxk2zI7sjdq2pn7tz
 iq0EEqqUhs+BqwM8NUO3aS/0dE9c8yNfzIjbICvcgqvCdDfHJvj4ewno6K1ffIRiB2wS
 o1zNrqhvMZenLhGA16eVNkpoSyMB/qzYXMdaG2frSfT6KOUsfBEKoc9lA2jHVGLVTDI8
 VaMyW4145xfAsQnKtZll6G314OD1m6ZS1EZJ8mgD4hdlIe7eaxJsRDvxgrCzIsetb0OJ
 DlfQ==
X-Gm-Message-State: AOJu0YzDK5UiQDlWYULKfJBOgt7Y/ZwTmG70vwh2s4CaTac7vuSeM2Js
 xYFpRrpt807XsecaqW3iiC98jZM/ZWexYNjH7DskfN77H2FBSrykxdPo8NmbHbIum18cSxL7bNh
 6DssPOznpwvTF3kM=
X-Received: by 2002:a0c:a998:0:b0:649:384f:ed4 with SMTP id
 a24-20020a0ca998000000b00649384f0ed4mr2068738qvb.19.1695815149446; 
 Wed, 27 Sep 2023 04:45:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWXnh5o9vSBbFugvtoF7EchnFngI86jBbzPXErTRJn7lOmLvaxSAfqgiLsceL6A9QVPDcF0A==
X-Received: by 2002:a0c:a998:0:b0:649:384f:ed4 with SMTP id
 a24-20020a0ca998000000b00649384f0ed4mr2068715qvb.19.1695815149150; 
 Wed, 27 Sep 2023 04:45:49 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-178-22.web.vodafone.de.
 [109.43.178.22]) by smtp.gmail.com with ESMTPSA id
 e14-20020a0ce3ce000000b0065b0771f2edsm2991622qvl.136.2023.09.27.04.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 04:45:48 -0700 (PDT)
Message-ID: <921df90e-418b-5442-e84b-7ead3e75501a@redhat.com>
Date: Wed, 27 Sep 2023 13:45:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is, ernunes@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org,
 mark.cave-ayland@ilande.co.uk
References: <20230829003629.410-1-gurchetansingh@chromium.org>
 <20230829003629.410-7-gurchetansingh@chromium.org>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v13 6/9] gfxstream + rutabaga: add initial support for
 gfxstream
In-Reply-To: <20230829003629.410-7-gurchetansingh@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 29/08/2023 02.36, Gurchetan Singh wrote:
> This adds initial support for gfxstream and cross-domain.  Both
> features rely on virtio-gpu blob resources and context types, which
> are also implemented in this patch.
> 
> gfxstream has a long and illustrious history in Android graphics
> paravirtualization.  It has been powering graphics in the Android
> Studio Emulator for more than a decade, which is the main developer
> platform.
> 
> Originally conceived by Jesse Hall, it was first known as "EmuGL" [a].
> The key design characteristic was a 1:1 threading model and
> auto-generation, which fit nicely with the OpenGLES spec.  It also
> allowed easy layering with ANGLE on the host, which provides the GLES
> implementations on Windows or MacOS enviroments.
> 
> gfxstream has traditionally been maintained by a single engineer, and
> between 2015 to 2021, the goldfish throne passed to Frank Yang.
> Historians often remark this glorious reign ("pax gfxstreama" is the
> academic term) was comparable to that of Augustus and both Queen
> Elizabeths.  Just to name a few accomplishments in a resplendent
> panoply: higher versions of GLES, address space graphics, snapshot
> support and CTS compliant Vulkan [b].
> 
> One major drawback was the use of out-of-tree goldfish drivers.
> Android engineers didn't know much about DRM/KMS and especially TTM so
> a simple guest to host pipe was conceived.
> 
> Luckily, virtio-gpu 3D started to emerge in 2016 due to the work of
> the Mesa/virglrenderer communities.  In 2018, the initial virtio-gpu
> port of gfxstream was done by Cuttlefish enthusiast Alistair Delva.
> It was a symbol compatible replacement of virglrenderer [c] and named
> "AVDVirglrenderer".  This implementation forms the basis of the
> current gfxstream host implementation still in use today.
> 
> cross-domain support follows a similar arc.  Originally conceived by
> Wayland aficionado David Reveman and crosvm enjoyer Zach Reizner in
> 2018, it initially relied on the downstream "virtio-wl" device.
> 
> In 2020 and 2021, virtio-gpu was extended to include blob resources
> and multiple timelines by yours truly, features gfxstream/cross-domain
> both require to function correctly.
> 
> Right now, we stand at the precipice of a truly fantastic possibility:
> the Android Emulator powered by upstream QEMU and upstream Linux
> kernel.  gfxstream will then be packaged properfully, and app
> developers can even fix gfxstream bugs on their own if they encounter
> them.
> 
> It's been quite the ride, my friends.  Where will gfxstream head next,
> nobody really knows.  I wouldn't be surprised if it's around for
> another decade, maintained by a new generation of Android graphics
> enthusiasts.
> 
> Technical details:
>    - Very simple initial display integration: just used Pixman
>    - Largely, 1:1 mapping of virtio-gpu hypercalls to rutabaga function
>      calls
> 
> Next steps for Android VMs:
>    - The next step would be improving display integration and UI interfaces
>      with the goal of the QEMU upstream graphics being in an emulator
>      release [d].
> 
> Next steps for Linux VMs for display virtualization:
>    - For widespread distribution, someone needs to package Sommelier or the
>      wayland-proxy-virtwl [e] ideally into Debian main. In addition, newer
>      versions of the Linux kernel come with DRM_VIRTIO_GPU_KMS option,
>      which allows disabling KMS hypercalls.  If anyone cares enough, it'll
>      probably be possible to build a custom VM variant that uses this display
>      virtualization strategy.
> 
> [a] https://android-review.googlesource.com/c/platform/development/+/34470
> [b] https://android-review.googlesource.com/q/topic:%22vulkan-hostconnection-start%22
> [c] https://android-review.googlesource.com/c/device/generic/goldfish-opengl/+/761927
> [d] https://developer.android.com/studio/releases/emulator
> [e] https://github.com/talex5/wayland-proxy-virtwl
> 
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Tested-by: Alyssa Ross <hi@alyssa.is>
> Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
...
> +static Property virtio_gpu_rutabaga_properties[] = {
> +    DEFINE_PROP_STRING("capset_names", VirtIOGPURutabaga, capset_names),
> +    DEFINE_PROP_STRING("wayland_socket_path", VirtIOGPURutabaga,
> +                       wayland_socket_path),

FWIW, it seems to be more common to use "-" instead of "_" to separate words 
in properties ... so I'd like to suggest to replace the underscores in the 
strings here.

  Thomas


