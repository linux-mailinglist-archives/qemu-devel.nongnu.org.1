Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E6D783B0C
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:38:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLxM-0002vy-SY; Tue, 22 Aug 2023 03:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLxL-0002vg-LR
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:37:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLxI-0000JP-QE
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:37:39 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fef4b063a7so11914745e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692689855; x=1693294655;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qjBIfH3w4YRPuWAe3flPlEk95k+tugzb06i2ZiaqZJs=;
 b=QQqOGTJErnCu+41Vwj11HzAnqwBzc5yYRZaBMsfhjTIOWpPswtev+FKBxKbeeS2UC2
 LLtnRpEo9VCrOEhCogaLkqQvVG98xiSunn8Sm541edr08i1YXKS9m5ww4noEJvIvH5f7
 np9kyR1qRWddAamHgvWCtTpbIWiM/lUimyu2UloZhD9Q/ELj2Wdqt+4SAbdsi1kL0Yqz
 TTg90zEr+4msBwKmJsNwwKLjlT/A7gRZI7cEFDXrYSfYwx7OIsGsS8pjMHzGGK+8t1OH
 bLxaFZvswojUbrkDB0OVN4SL89nziZr1lcAO6l2vbTMXU1BmjsP5ups7Uxj5OZh0aYBm
 FGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692689855; x=1693294655;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qjBIfH3w4YRPuWAe3flPlEk95k+tugzb06i2ZiaqZJs=;
 b=FIG7gX1xeAxfuQW448kMvymt29zWW/AerNE9OhtFusp/p7gbDmgmp2ebkYG/CB3mHp
 CHTySMf1/q7iLhFsfmf+iFEL+Ca9XGuRLyZ2iv6rwsFEgleXfx7qGt7R/60k55c0jrn6
 z/uW9EJoeDJeUewpYHWN6E6MVq5uZ+Gv8Hq7yVobGjVs99oBY37Fr4PZ8uxerps+Xtub
 WH1XRa/UrM4/DbRpzohXYt0Lprpaj/J9vFpFXYA9k2D14L7zum3s3bTguP+WB7cPKoA+
 u4S3GaHYJPa5TJVGd14UpeF+qJ0KFJLdTKjoxwphZ5MG7bjA0GrrSI8mOLCs8PqFzyRt
 zFSQ==
X-Gm-Message-State: AOJu0YxL/tGi7IcVwJ50VMiFrzAoMNWgbiDgFiK26S6d56h6NDcRFhkC
 AN5LSod9C8MmgubgAe0MNXAFGg==
X-Google-Smtp-Source: AGHT+IHFbva73u3yNMELXs5MfjZ6O5mj+B7TlHbrYyYI/6q7A/DMckUL0qVE4YzOG49DhER6ItxGjA==
X-Received: by 2002:a7b:cd06:0:b0:3fe:4548:188d with SMTP id
 f6-20020a7bcd06000000b003fe4548188dmr6352315wmj.7.1692689854747; 
 Tue, 22 Aug 2023 00:37:34 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 w3-20020a05600c014300b003fe0a0e03fcsm18435165wmm.12.2023.08.22.00.37.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 00:37:34 -0700 (PDT)
Message-ID: <7999d76e-d30a-d364-336b-4d4bd8a5ec4f@linaro.org>
Date: Tue, 22 Aug 2023 09:37:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v10 6/9] gfxstream + rutabaga: add initial support for
 gfxstream
Content-Language: en-US
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, akihiko.odaki@gmail.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org
References: <20230822000025.501-1-gurchetansingh@chromium.org>
 <20230822000025.501-6-gurchetansingh@chromium.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230822000025.501-6-gurchetansingh@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.374,
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

Hi,

On 22/8/23 02:00, Gurchetan Singh wrote:
> This adds initial support for gfxstream and cross-domain.  Both
> features rely on virtio-gpu blob resources and context types, which
> are also implemented in this patch.
[...]

>   hw/display/virtio-gpu-pci-rutabaga.c |   48 ++
>   hw/display/virtio-gpu-rutabaga.c     | 1119 ++++++++++++++++++++++++++
>   hw/display/virtio-vga-rutabaga.c     |   51 ++
>   3 files changed, 1218 insertions(+)
>   create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
>   create mode 100644 hw/display/virtio-gpu-rutabaga.c
>   create mode 100644 hw/display/virtio-vga-rutabaga.c
> 
> diff --git a/hw/display/virtio-gpu-pci-rutabaga.c b/hw/display/virtio-gpu-pci-rutabaga.c
> new file mode 100644
> index 0000000000..c71173d8ca
> --- /dev/null
> +++ b/hw/display/virtio-gpu-pci-rutabaga.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0

QEMU expects contributions to be GPL-2.0-or-later, see ./LICENSE:

    As of July 2013, contributions under version 2 of the GNU General
    Public License (and no later version) are only accepted for the
    following files or directories: bsd-user/, linux-user/, hw/vfio/,
    hw/xen/xen_pt*.

Also, per 
https://qemu-project.gitlab.io/qemu/devel/style.html#comment-style:

   We use traditional C-style /* */ comments and avoid // comments.

(You can use ./scripts/checkpatch.pl to check your patches style).

> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
> new file mode 100644
> index 0000000000..bcb3885f1f
> --- /dev/null
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -0,0 +1,1119 @@
> +// SPDX-License-Identifier: GPL-2.0


> diff --git a/hw/display/virtio-vga-rutabaga.c b/hw/display/virtio-vga-rutabaga.c
> new file mode 100644
> index 0000000000..2b2ffed8a6
> --- /dev/null
> +++ b/hw/display/virtio-vga-rutabaga.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0



