Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 880FC791338
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 10:22:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd4q5-0000jp-DO; Mon, 04 Sep 2023 04:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd4q1-0000jQ-43
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:21:37 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd4py-0001Cz-Va
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:21:36 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99de884ad25so180169466b.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 01:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693815693; x=1694420493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dqtoQqNKSlO189pIgYPaMe9BsWnF20NVcp79jGw8ZEA=;
 b=WgVyurW5neYZyOxT2KUx4/zhq+QPtzFz97vFs5y4zQ1/ZsbzYXA1zVFqrXwebMWu9U
 jw9XiOoYHdai06dQqrU3gkc+kfesdRjYMZNd1SNsYKFOvcJCLcxyNa3nIMIoxeTy0Iu+
 Y8LX3tUONwh9XmEJMOPKF7Q3WimccdcBkIQn3oc2sGQCAaLIre2tpgmwwOZ/psxPM5Pg
 xAoVhFt6XOS5P28dUgP/ZgeLlPamrML81dJCjqidwoBbhofkTrcSJ9zeE0imGq3YSfw+
 RAHX13z+fq1JTYDcvg2jokvDjBw+CAdKj9H38/gEQvMuDo3ziZVr1bEoSTtxuu1LQmHu
 GXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693815693; x=1694420493;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dqtoQqNKSlO189pIgYPaMe9BsWnF20NVcp79jGw8ZEA=;
 b=DeIMZ/iaBfEB2YXuy9tcQylgSkY8SRArbUoKab7Q0wRytDJm/D45PQbKhzApOwMv7q
 Cr1G8cEXtVbOpUafxyzfvyBALk37TU2+KbVLV9J7CCU6BHaD3JlGpJjxSHaJRBZkmIXK
 of0jZ/nmZymHoUlz9S6gGQAcRvQ73TqH23f8+FUqqlKO2LNjazsusckJ8bWJeP/gP6md
 F3DRlUVedrIpBm6MW6BMdx2c3wDu+Fz4bVwbJ+3ryCyEBxfEOxIQ1BKsnoTkvkjCqjlu
 LYBsToZXXG8jTn++S4LrC88npqAvi0/3hTIq8EzW5aWJ46wwfTy+T41dw0RfqxhlrxXp
 IKEQ==
X-Gm-Message-State: AOJu0YzZEWWVBcOAwTxIDX10Cr98SgALv5V+b5oVCV1umMg0m+5xWPqF
 BNsV6Df9GOvVyiQiV5O3CPBZlQ==
X-Google-Smtp-Source: AGHT+IEHKYlaIIy+LAf1n4XUbB3kr80yM4FoVESRwHjCUn8fGYA9eRO6NBcbSI4CDSCZE/YO/rYRig==
X-Received: by 2002:a17:906:20d0:b0:9a1:e994:3444 with SMTP id
 c16-20020a17090620d000b009a1e9943444mr2604289ejc.3.1693815693536; 
 Mon, 04 Sep 2023 01:21:33 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a170906241100b0099cf91fe297sm5963457eja.13.2023.09.04.01.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 01:21:33 -0700 (PDT)
Message-ID: <46d64808-6e88-5464-e10f-517a23488f6e@linaro.org>
Date: Mon, 4 Sep 2023 10:21:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 12/13] virtio-iommu: Resize memory region according to the
 max iova info
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.williamson@redhat.com,
 clg@redhat.com, jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com
References: <20230904080451.424731-1-eric.auger@redhat.com>
 <20230904080451.424731-13-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904080451.424731-13-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 4/9/23 10:03, Eric Auger wrote:
> By default the virtio-iommu MR has a 64b span. As we intend to
> remove the VFIO assumption of 64b IOVA, let's make sure the MR
> is resized according to the actual GAW of the physical IOMMU.
> Otherwise we will get a failure on vfio vfio_find_hostwin().
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/virtio/virtio-iommu.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


