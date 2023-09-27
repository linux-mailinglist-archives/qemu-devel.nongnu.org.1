Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC1A7B0412
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 14:27:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlTdR-0000uK-Uk; Wed, 27 Sep 2023 08:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qlTdK-0000u2-7M
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 08:27:17 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qlTdE-0003tz-TU
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 08:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ihls4mezZXRnHIgaGRplJ2p+c02bdVrjtebQyaQzjCg=; b=cv0qs0DmJRQJsWYhx8C63xrh9n
 fDaNFxgO0d63FzSpcj+SnLNZVsSLDM3FYjlm7xNSDPPtfFR4mXnfC57Em3R6v1N2q6DZYnjJDqUOg
 j7c/oOMFxWNvmelXgAyjT9afcc99qszQ5RfTutBwhecfV7cqq5dnR39tJLbSj1bGIHAOQc/m0LY0X
 Vs3DIlf4KhHj17Zrk8nkeqXZd8/YGmFUnZqDEQHq7LynEkSg6PfxrseyG7rGCPWpaMXkZZvzPTkTn
 lTX4keWMS7/6L6JAKhjDlGX8TIgVAcm3G2cQmez32IPxPswzS+xM5LFDeV7AUSWpif5veboQhF+um
 P0LKbKsDUdSPOZQ4G1sf/7nSC4TFdsgJ8H0aNQW9CTEIJkvtEuKQyKrmMIZTUUAylVOfZqHDvRi/E
 alNwEjPA3j4RKC17qOJbk/00ir5rOarkTDhhIyvnXeDEHz1XwONRumQ36Zl3mFFuRQYoFSClt2sf2
 dM0y9cf/7+APn1JjL9N5Nj33drDmZO7AJffojkiHrNuugDTFhsOThOJs1UWCnkFWzCVAA0YHnIc4p
 6J0XzelDEASl/MYzm3eM4nj5Wl2T+9ZGukJ1YPXH/TFt+lCEisDmkIEUBdKFT7p6FgUQL3zZQ8BxK
 WpejFrOta8eB5AXGAwN0uIz/1PaBqBLoznp1Zuyt8=;
Received: from host86-159-123-68.range86-159.btcentralplus.com
 ([86.159.123.68] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qlTcx-00078P-Eh; Wed, 27 Sep 2023 13:26:55 +0100
Message-ID: <03c181d8-61dd-8c95-3524-82e40cd14da4@ilande.co.uk>
Date: Wed, 27 Sep 2023 13:26:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Thomas Huth <thuth@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is, ernunes@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org
References: <20230829003629.410-1-gurchetansingh@chromium.org>
 <20230829003629.410-7-gurchetansingh@chromium.org>
 <921df90e-418b-5442-e84b-7ead3e75501a@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <921df90e-418b-5442-e84b-7ead3e75501a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.159.123.68
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v13 6/9] gfxstream + rutabaga: add initial support for
 gfxstream
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 27/09/2023 12:45, Thomas Huth wrote:

> On 29/08/2023 02.36, Gurchetan Singh wrote:
>> This adds initial support for gfxstream and cross-domain.  Both
>> features rely on virtio-gpu blob resources and context types, which
>> are also implemented in this patch.
>>
>> gfxstream has a long and illustrious history in Android graphics
>> paravirtualization.  It has been powering graphics in the Android
>> Studio Emulator for more than a decade, which is the main developer
>> platform.
>>
>> Originally conceived by Jesse Hall, it was first known as "EmuGL" [a].
>> The key design characteristic was a 1:1 threading model and
>> auto-generation, which fit nicely with the OpenGLES spec.  It also
>> allowed easy layering with ANGLE on the host, which provides the GLES
>> implementations on Windows or MacOS enviroments.
>>
>> gfxstream has traditionally been maintained by a single engineer, and
>> between 2015 to 2021, the goldfish throne passed to Frank Yang.
>> Historians often remark this glorious reign ("pax gfxstreama" is the
>> academic term) was comparable to that of Augustus and both Queen
>> Elizabeths.  Just to name a few accomplishments in a resplendent
>> panoply: higher versions of GLES, address space graphics, snapshot
>> support and CTS compliant Vulkan [b].
>>
>> One major drawback was the use of out-of-tree goldfish drivers.
>> Android engineers didn't know much about DRM/KMS and especially TTM so
>> a simple guest to host pipe was conceived.
>>
>> Luckily, virtio-gpu 3D started to emerge in 2016 due to the work of
>> the Mesa/virglrenderer communities.  In 2018, the initial virtio-gpu
>> port of gfxstream was done by Cuttlefish enthusiast Alistair Delva.
>> It was a symbol compatible replacement of virglrenderer [c] and named
>> "AVDVirglrenderer".  This implementation forms the basis of the
>> current gfxstream host implementation still in use today.
>>
>> cross-domain support follows a similar arc.  Originally conceived by
>> Wayland aficionado David Reveman and crosvm enjoyer Zach Reizner in
>> 2018, it initially relied on the downstream "virtio-wl" device.
>>
>> In 2020 and 2021, virtio-gpu was extended to include blob resources
>> and multiple timelines by yours truly, features gfxstream/cross-domain
>> both require to function correctly.
>>
>> Right now, we stand at the precipice of a truly fantastic possibility:
>> the Android Emulator powered by upstream QEMU and upstream Linux
>> kernel.  gfxstream will then be packaged properfully, and app
>> developers can even fix gfxstream bugs on their own if they encounter
>> them.
>>
>> It's been quite the ride, my friends.  Where will gfxstream head next,
>> nobody really knows.  I wouldn't be surprised if it's around for
>> another decade, maintained by a new generation of Android graphics
>> enthusiasts.
>>
>> Technical details:
>>    - Very simple initial display integration: just used Pixman
>>    - Largely, 1:1 mapping of virtio-gpu hypercalls to rutabaga function
>>      calls
>>
>> Next steps for Android VMs:
>>    - The next step would be improving display integration and UI interfaces
>>      with the goal of the QEMU upstream graphics being in an emulator
>>      release [d].
>>
>> Next steps for Linux VMs for display virtualization:
>>    - For widespread distribution, someone needs to package Sommelier or the
>>      wayland-proxy-virtwl [e] ideally into Debian main. In addition, newer
>>      versions of the Linux kernel come with DRM_VIRTIO_GPU_KMS option,
>>      which allows disabling KMS hypercalls.  If anyone cares enough, it'll
>>      probably be possible to build a custom VM variant that uses this display
>>      virtualization strategy.
>>
>> [a] https://android-review.googlesource.com/c/platform/development/+/34470
>> [b] https://android-review.googlesource.com/q/topic:%22vulkan-hostconnection-start%22
>> [c] https://android-review.googlesource.com/c/device/generic/goldfish-opengl/+/761927
>> [d] https://developer.android.com/studio/releases/emulator
>> [e] https://github.com/talex5/wayland-proxy-virtwl
>>
>> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
>> Tested-by: Alyssa Ross <hi@alyssa.is>
>> Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
> ...
>> +static Property virtio_gpu_rutabaga_properties[] = {
>> +    DEFINE_PROP_STRING("capset_names", VirtIOGPURutabaga, capset_names),
>> +    DEFINE_PROP_STRING("wayland_socket_path", VirtIOGPURutabaga,
>> +                       wayland_socket_path),
> 
> FWIW, it seems to be more common to use "-" instead of "_" to separate words in 
> properties ... so I'd like to suggest to replace the underscores in the strings here.

It is actually part of the QOM documentation that object properties should use 
hyphens instead of underscores (see 
https://gitlab.com/qemu-project/qemu/-/blob/master/include/qom/object.h?ref_type=heads#L1013) 
but I agree it's buried so deep in the header file, it's almost impossible to find :( 
  Certainly it should be placed somewhere more prominent in the QOM and/or style 
documentation.


ATB,

Mark.


