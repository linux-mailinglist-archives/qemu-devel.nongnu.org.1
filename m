Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8BF828ECB
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 22:15:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNJQw-00018K-SJ; Tue, 09 Jan 2024 16:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNJQv-00017Z-1b
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:14:49 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNJQt-0004J7-FE
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:14:48 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e4d64a431so13359945e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 13:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704834886; x=1705439686; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ImaxehhcGPJCky0TDQmCWZDF0yf/dhL/nX1CqME4sbE=;
 b=yVuPLAK+vBV2MqgHZ8pO9DSIEbY2sQPjkPZ06IWaTa//YqC0KHLxW7JMyBHxDNjHfI
 tRDeq/f1oIKBYaxQT7L3J8lfsH6MzYsw9HnB9HJ7UTlYovetjmMCSsGqDpTqxhb2n5Q/
 Om5mGrzgTpRlXxR5yahDTteAQvSYQbhYs3tA02zomdv60dyaaOVPePNgUZ1hQ962DPDx
 pn/XVEfePXrda4JGedrDAl8+4yfUH2lzoBY8EQJIxTS32Ngfu3Um92Ah/Np1lit1VVtw
 WQwbf54qlaPwdmZWAqgSdPTKRuavjMc1CrUKPZOrDwVtYyckyRl9oQOul+3c1QshOEHd
 eAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704834886; x=1705439686;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ImaxehhcGPJCky0TDQmCWZDF0yf/dhL/nX1CqME4sbE=;
 b=J55EQo3qUuDPqa1aOk1ohjLuh39AVLIOzUHzcup/c3q2d/ezwBlSWP6R+f6ELEMxbR
 vTXZX2M3fdD0a4FlcSU2eQG0Mlc4IJd3zrtFbA8m5j8xQp2DSzMWyAI3A0M5QLbzS+zr
 otYFKhtZG8TC3NzEdNWricY5/pGSX0cZjxQW4IxHGuqDYZIphJn76Fg1if2ZCeB3LOf0
 GERcuUYX8AZzg0FfzVdEfLdzoyTS7C7RZDXtgTQhkye0sWNS5uBhhLFgnfIkx0052+z8
 ewFNKIjIrlH/e117I8fOs8C4odQSiHYolzCjlzRoQ7wvYR+1aafzmVdta7dSAHVw6f3t
 UjOA==
X-Gm-Message-State: AOJu0Yzulo9Y2/Yt1MbmjFQW6Ha1+SBJMUx61gh71a77GQUik4AOnAWT
 dxI7CGMjhLh1JF8vNujZqvca1nRmzzQsoA==
X-Google-Smtp-Source: AGHT+IH9eiPUDkI5zUr3mZ168OeE+FdZwHpS+UcKFbSNJBxvYkrB9H4ZyKfSjQMP5WnWQIC61VTYqg==
X-Received: by 2002:a05:600c:314a:b0:40e:427d:4b02 with SMTP id
 h10-20020a05600c314a00b0040e427d4b02mr3201745wmo.67.1704834885852; 
 Tue, 09 Jan 2024 13:14:45 -0800 (PST)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 e30-20020a5d595e000000b0033776a50472sm2318129wri.10.2024.01.09.13.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 13:14:45 -0800 (PST)
Message-ID: <6b7963ef-ce40-42a9-bfcf-26fadba562cb@linaro.org>
Date: Tue, 9 Jan 2024 22:14:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] hw/virtio: rename virtio dmabuf API
Content-Language: en-US
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>,
 marcandre.lureau@gmail.com, kraxel@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20240109125614.220293-1-aesteve@redhat.com>
 <20240109125614.220293-4-aesteve@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240109125614.220293-4-aesteve@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 9/1/24 13:56, Albert Esteve wrote:
> Functions in the virtio-dmabuf module
> start with 'virtio_*', which is too
> generic and may not correctly identify
> them as part of the virtio dmabuf API.
> 
> Rename all functions to 'virtio_dmabuf_*'
> instead to avoid confusion.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   hw/display/virtio-dmabuf.c        | 14 ++++----
>   hw/virtio/vhost-user.c            | 14 ++++----
>   include/hw/virtio/virtio-dmabuf.h | 33 +++++++++---------
>   tests/unit/test-virtio-dmabuf.c   | 58 +++++++++++++++----------------
>   4 files changed, 60 insertions(+), 59 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

