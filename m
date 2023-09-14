Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8742B79FB1D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 07:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgf9b-0000nX-MQ; Thu, 14 Sep 2023 01:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgf9S-0000kM-ME
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 01:44:31 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgf9Q-00007l-VK
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 01:44:30 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31ae6bf91a9so497236f8f.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 22:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694670266; x=1695275066; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9j1F9nTA1F6Xae1lUlPhYjKd546Ro2g0wXxk7Qigh5E=;
 b=qej8Uf4RHIczR+o0Y+mxv8MCZOHlO7BNaQTZmT/FIvlLBZgyFNZqT8/ftv44fphvxW
 eYbwLzZMhFlnaauGLUH7/HpcZSaIR77wLQ4291DGoCIA4+2mD83Km6cYBcGB2lICxLIs
 GPL9u9VxhtWkEPeG2+YQ6YVdAN1caodf5DLnIQZWbRuYfCRqdNbg8mnI9YCPAbC9FZs8
 fcpc1b3tXJ+sj00KNpfLoHd/9U2bW0mXjjSQJcVMbkgLJsccAePeKrTXyMAOxCPlz3de
 WhC/hTai5aa3/XQdLptmVfP++Efwdk4pMaE2BqQhUg0L4hVx/eeHeqq6SN9Iu6/mIA4L
 c/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694670266; x=1695275066;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9j1F9nTA1F6Xae1lUlPhYjKd546Ro2g0wXxk7Qigh5E=;
 b=UkVBojH/RE30f/dZ6zaxgYRzHDrXH9+nPFg8/D6px8MAAQMfkLNJeY+U3Yy/zgAuRT
 ztwLHWwzF1Dh/66A/3DY08xTdyVZLLJHbj856NMNqVwEd1/GWTEy5FmrgpBXBtaJU6h/
 rA2vJS43V7AtIk8ib+ZRcAbJS+hUm7AqBMXu/SeSLWiOcZgsW3CFH0xZnA/Qp9ANfI3U
 FBr9F9RxQf7R3tqQE5y9WX7ZgPcvjbQNXQKHKvxB0ADrOkuAwkO3KL4X87Gl7oglxITv
 1FTYD5QCTG3lHu7BSHbRBMwCo2YQedO9k7j19w41TSRl6nw8H3pXc9ZGv23NAVah2Sxw
 YwCg==
X-Gm-Message-State: AOJu0YxupjKIQTk3yNhNZnD+GEu95RyoS8JuU9Y7NYyyXjGwbdH53qQ4
 UaIoqnTMUXe7FW1FFqKcdT4Ikw==
X-Google-Smtp-Source: AGHT+IFUlnhUISbZXRBQrsgaGjC+tX+zoLDcW8B2dKj1yqfyBzsu+TnLhXjuPHdiQ5q+xaZkZwlXdw==
X-Received: by 2002:a5d:490d:0:b0:31d:d977:4e3d with SMTP id
 x13-20020a5d490d000000b0031dd9774e3dmr3485204wrq.19.1694670266609; 
 Wed, 13 Sep 2023 22:44:26 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 r16-20020aa7c150000000b0052fe12a864esm436214edp.57.2023.09.13.22.44.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 22:44:26 -0700 (PDT)
Message-ID: <aa66299f-39bc-55f7-5912-000027ef452e@linaro.org>
Date: Thu, 14 Sep 2023 07:44:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 3/4] hw/cxl: CXLDVSECPortExtensions renamed to
 CXLDVSECPortExt
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>
Cc: linuxarm@huawei.com
References: <20230913150521.30035-1-Jonathan.Cameron@huawei.com>
 <20230913150521.30035-4-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230913150521.30035-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 13/9/23 17:05, Jonathan Cameron wrote:
> Done to reduce line lengths where this is used.
> Ext seems sufficiently obvious that it need not be spelt out
> fully.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   include/hw/cxl/cxl_pci.h       |  6 ++---
>   hw/cxl/cxl-component-utils.c   | 49 ++++++++++++++++++++--------------
>   hw/pci-bridge/cxl_downstream.c |  2 +-
>   hw/pci-bridge/cxl_root_port.c  |  2 +-
>   hw/pci-bridge/cxl_upstream.c   |  2 +-
>   5 files changed, 35 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


