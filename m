Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C68783B1F
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:47:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYM5U-000605-0F; Tue, 22 Aug 2023 03:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYM5P-0005xp-Ed
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:45:59 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYM5N-0002Uu-7R
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:45:59 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3197808bb08so3881108f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692690355; x=1693295155;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8fTtoMijkfQ2y3NnW9ovldBgQ1WStZ+VByhh5UVnrtg=;
 b=O7+LDml3aijGTRaAdvvWe1nbGcbnHlmvxo5b944f55gnk9CiOtp1+Sa4JvgfCW1p4X
 Yu+UfZx2u/tnUWYYGF6zjpxew5t44yHirX9+Xx/ClzABnVqJQORjhfWWT5UX3wrCcUJ3
 fvfy/YYTnsDFT2xE9HiAz+SQMmiOo9tHfwK4HBqbnU+qhlHBdcqUZ3BTD/6KfjT2PUv1
 2deqBvnTBGg8LG7zbwlTr+yd2qeYrXo0sh0lZ8NygDzsza0u3yt7ukc113SKbLhBdcMZ
 t6Je2z2yTqpqJl/1loQtHuuz4Eht4RR+6dPpGl5HuBAhru7JW6ArQEd3fqyNj9800YyY
 C4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692690355; x=1693295155;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8fTtoMijkfQ2y3NnW9ovldBgQ1WStZ+VByhh5UVnrtg=;
 b=ZSXFsqTPEM47UV02STHUFp3UccMypOyAtYQ6riSbj1ZLB+VNrpWp8rAP+6Fo8sfrRf
 DMGIQRtgLbGyY5kRcdhOCsv4h3UXcLk8SXFDWUOnMivQDWdUokBHYqa6KLrgVM0BV5J5
 bTLW9vxS3QBiUcCTocjZsU3XlbqYbPuhxhtebbtUWOvjJt1v+LrZuFzWLv43bU60po7l
 sA/DDMnsG3CWLT6NwXIxQteT3GoYCaCov9hWFkUOoSK5gCABwt79DU4WizFuCBNvTLm8
 9DepBreQO7LMFrD928mTJ6BjDipNy0/XJrt6h3eVZfKHVtXjjBuyIRspwYIMujl1Btg/
 xQcQ==
X-Gm-Message-State: AOJu0YziY8TtUxZcoIzKeZRvyf7ncODdMwhdNS+InbQl0R6XB9Ukns7G
 U+YTvEZaFF8iLYmFLhWi8HXW9g==
X-Google-Smtp-Source: AGHT+IFlbuO/fT1h46QlWINDrwTxanc+d3XBBGYhKaxYOAGaKwm+dFxrWpdibSVgdHGb6aAJDLz67Q==
X-Received: by 2002:a5d:42ca:0:b0:31a:d8c0:cb8b with SMTP id
 t10-20020a5d42ca000000b0031ad8c0cb8bmr7641518wrr.25.1692690355362; 
 Tue, 22 Aug 2023 00:45:55 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 h11-20020a5d548b000000b00317e77106dbsm15071899wrv.48.2023.08.22.00.45.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 00:45:55 -0700 (PDT)
Message-ID: <2d228d92-9cb8-4ff6-49fc-4ecf0d494e1a@linaro.org>
Date: Tue, 22 Aug 2023 09:45:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v10 9/9] docs/system: add basic virtio-gpu documentation
Content-Language: en-US
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, akihiko.odaki@gmail.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org
References: <20230822000025.501-1-gurchetansingh@chromium.org>
 <20230822000025.501-9-gurchetansingh@chromium.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230822000025.501-9-gurchetansingh@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 22/8/23 02:00, Gurchetan Singh wrote:
> This adds basic documentation for virtio-gpu.
> 
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Tested-by: Alyssa Ross <hi@alyssa.is>
> Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---

>   docs/system/device-emulation.rst   |   1 +
>   docs/system/devices/virtio-gpu.rst | 112 +++++++++++++++++++++++++++++
>   2 files changed, 113 insertions(+)
>   create mode 100644 docs/system/devices/virtio-gpu.rst


> diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
> new file mode 100644
> index 0000000000..2b3eb536f9
> --- /dev/null
> +++ b/docs/system/devices/virtio-gpu.rst
> @@ -0,0 +1,112 @@
> +..
> +   SPDX-License-Identifier: GPL-2.0

Can this be GPL-2.0-or-later?

> +virtio-gpu
> +==========
> +
> +This document explains the setup and usage of the virtio-gpu device.
> +The virtio-gpu device paravirtualizes the GPU and display controller.


