Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8D7787F1B
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 06:54:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZOpL-0007Ny-53; Fri, 25 Aug 2023 00:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qZOpG-0007ND-M6
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 00:53:39 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qZOpE-0001i2-5A
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 00:53:38 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bee82fad0fso4653975ad.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 21:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692939213; x=1693544013;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2y9aVcSi7Zg/pNfsOEuUkvWQh38yqIKJs9mY/qsmDew=;
 b=N/qAYL3mHAn9LFM3b9uYsjgeFu+Abki3IhRzOcsWrSGksKrpb1Jj9BL0Y6vF+HH7CJ
 X9f3L4RkxhjIdsLnG0xkSl1/wdOhhKgls/EMrKdCDXrpuAZDw67NNxiIO0nf0QH1WfGV
 HY8B9mTAtYSHSKfhfi0y0ZGWtx3xCcWGmSAjtpxbMVsiZn7X4HF1IabnIiehfpRuDRmA
 c82gzY2B04K7PwJ5vzFsxLaotK6+Uo6R6BNiAvqqOV6LWTuldrYLsHpHdy8EjUIU0AqQ
 plMHE8ZlG6vMH1Mc5+hSdIo7zd1uW/d1suHVdvqXlbrcVafxWQ2SAUxGRgu357B7vhA6
 s8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692939213; x=1693544013;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2y9aVcSi7Zg/pNfsOEuUkvWQh38yqIKJs9mY/qsmDew=;
 b=kO1ejo7fUOiwOAEfZRaO+wD2BcUK+RiHsHTqC9N540US+Dwz6WwNN/sC8+Od6aS1p1
 3yyW0Q7ayVJCYaibdyUVECWxbC0SOGtVv1uMe9poYyKCxYZYCN8PIrlYvecivFVOsB5+
 6REV5jsTcMEcivwsrcdm634nkBPbtBk9hqVPIuY0BxcY1OFLDdIZHQLI0puk5ztzioCZ
 6UX6BJZ/eAmklELC3vNxd1C3pNb5Ym1KTBDdbJLdNmHvm2JNxuO3TUMF5yOdYwE1MlSc
 1qV3OW8GP2bJh9Mh5sAALDmNHV+UhEQyUksvdeVJLoZsVhW9jVsZqzadBs2OhJg9GQaX
 KDXQ==
X-Gm-Message-State: AOJu0Yw2poTcTV5FhXSB29eEgKAHEYNNKGQDpfV01ljoub2iR4RlZMqQ
 xaEgCuor2jW9a8x3//X0dAI=
X-Google-Smtp-Source: AGHT+IFez6Hd3hVh8ORaDyuwKEqiJJUwTzzYbT/q29JbqDD7Yayyidnnq7LkrIHXvyEly4POTDyE2Q==
X-Received: by 2002:a17:902:e842:b0:1b9:e972:134d with SMTP id
 t2-20020a170902e84200b001b9e972134dmr15753425plg.3.1692939213493; 
 Thu, 24 Aug 2023 21:53:33 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a17090301d200b001b8ad8382a4sm579073plh.216.2023.08.24.21.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 21:53:32 -0700 (PDT)
Message-ID: <50caa93a-c1be-4db5-94ee-eb154623f406@gmail.com>
Date: Fri, 25 Aug 2023 13:53:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/9] rutabaga_gfx + gfxstream
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is, ernunes@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org,
 mark.cave-ayland@ilande.co.uk
References: <20230824234046.499-1-gurchetansingh@chromium.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20230824234046.499-1-gurchetansingh@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 2023/08/25 8:40, Gurchetan Singh wrote:
> From: Gurchetan Singh <gurchetansingh@google.com>
> 
> Prior versions:
> 
> Changes since v11:
> - Incorporated review feedback
> 
> How to build both rutabaga and gfxstream guest/host libs:
> 
> https://crosvm.dev/book/appendix/rutabaga_gfx.html
> 
> Branch containing this patch series (now on QEMU Gitlab):
> 
> https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v12
> 
> Antonio Caggiano (2):
>    virtio-gpu: CONTEXT_INIT feature
>    virtio-gpu: blob prep
> 
> Dr. David Alan Gilbert (1):
>    virtio: Add shared memory capability
> 
> Gerd Hoffmann (1):
>    virtio-gpu: hostmem
> 
> Gurchetan Singh (5):
>    gfxstream + rutabaga prep: added need defintions, fields, and options
>    gfxstream + rutabaga: add initial support for gfxstream
>    gfxstream + rutabaga: meson support
>    gfxstream + rutabaga: enable rutabaga
>    docs/system: add basic virtio-gpu documentation
> 
>   docs/system/device-emulation.rst     |    1 +
>   docs/system/devices/virtio-gpu.rst   |  112 +++
>   hw/display/meson.build               |   22 +
>   hw/display/virtio-gpu-base.c         |    6 +-
>   hw/display/virtio-gpu-pci-rutabaga.c |   47 ++
>   hw/display/virtio-gpu-pci.c          |   14 +
>   hw/display/virtio-gpu-rutabaga.c     | 1119 ++++++++++++++++++++++++++
>   hw/display/virtio-gpu.c              |   16 +-
>   hw/display/virtio-vga-rutabaga.c     |   50 ++
>   hw/display/virtio-vga.c              |   33 +-
>   hw/virtio/virtio-pci.c               |   18 +
>   include/hw/virtio/virtio-gpu-bswap.h |   15 +
>   include/hw/virtio/virtio-gpu.h       |   41 +
>   include/hw/virtio/virtio-pci.h       |    4 +
>   meson.build                          |    7 +
>   meson_options.txt                    |    2 +
>   scripts/meson-buildoptions.sh        |    3 +
>   softmmu/qdev-monitor.c               |    3 +
>   softmmu/vl.c                         |    1 +
>   19 files changed, 1495 insertions(+), 19 deletions(-)
>   create mode 100644 docs/system/devices/virtio-gpu.rst
>   create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
>   create mode 100644 hw/display/virtio-gpu-rutabaga.c
>   create mode 100644 hw/display/virtio-vga-rutabaga.c
> 

Thanks for keeping working on this. For the entire series:
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>

