Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EFC7D0421
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:41:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaly-0005mV-VR; Thu, 19 Oct 2023 17:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtalw-0005fx-Q2
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:41:40 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtalu-0000Rz-4Z
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:41:40 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53e70b0a218so132069a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697751696; x=1698356496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g9fHF1Lm2z45kA/ks0p/qc2goX8ifReYHByDbDQUh3c=;
 b=crIaWZws03rSZWplmR4I6dz+OpahGg/HYRPxYpUK2ywx4TwNDSwG1oOy8thQFywDR9
 RPr1MCyOe5V5VdSDDj6jA0RKf/Pi5G2o0xG/OZ+O3WLT1owSD+cPmhKaYtmYCloyZzhg
 PEBx1JrbIx9tfUIW5YSfALxCtDZvdSav43O5Y90UwZXriD39OX5yqH1MAFYtM+PW/mG4
 63ZBsfpxZPAYM8+iro60FOmd1uGH0XUbQAB0gFYPm4I0/4Ru8QHOwmHxpeDLzjRk/xbE
 nTvVKOalGgRXHszbLkS97tHzCNoTh/5f1PWndk6Zoqp/IwVZjFKfgy7Nkyes8hkdeH4W
 h03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697751696; x=1698356496;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g9fHF1Lm2z45kA/ks0p/qc2goX8ifReYHByDbDQUh3c=;
 b=SIWf9dwitDYLaDz4PPCLhPhoyvg9+H0mZW3iy9heWup5RB9p4E2xFcUjSpWnHT7Flo
 h+bCbsVlkKZtzDcDb8TJdfJVJqwewpEUCiuipvvmlQI2ClX2rDTv6N1w08io73SnOYqv
 9xrSDTyaL282w1pOCwGe2RsziY/BLOuTWbLXUCqnijHaCCMx4Bo6ti7D2AQppimoUgUU
 HcyOGMswI43NyteB+MWf1EdfXx7tkwOdt2fWyw/LhUbFW1hCiK9FMxQ1I6RXCIdqlTcN
 YRKsF6bfjVEn2UZB1DSn1k4WgG5/0tK6i1psUK4OEVaae5XV32d7Yc2v4Qph+Jq4HD64
 5K0w==
X-Gm-Message-State: AOJu0Yww8M3eg4UxgU9oIpxlv23Rb+OKfr8q3B2FV3JEOAoEsjmZk/I4
 fGm1jFJhf++85myy1cs82YHsYp+gSebSIaUY0ywsXA==
X-Google-Smtp-Source: AGHT+IGhNYfnBMC8MggQaEl8LZP7PDTBG6LSNJrwV/C+KBZDbLv2jVQ60ul4+5wvmgA7oPXpHYj+vA==
X-Received: by 2002:a17:907:60d4:b0:9ba:1d08:ad43 with SMTP id
 hv20-20020a17090760d400b009ba1d08ad43mr3496384ejc.70.1697751696023; 
 Thu, 19 Oct 2023 14:41:36 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 a7-20020a1709062b0700b009932337747esm224113ejg.86.2023.10.19.14.41.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 14:41:35 -0700 (PDT)
Message-ID: <b2d724ca-5369-76ab-30bb-88cf9bcedcb6@linaro.org>
Date: Thu, 19 Oct 2023 23:41:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/7] hw: Few more QOM/QDev cleanups
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Gerd Hoffmann <kraxel@redhat.com>
References: <20231017140150.44995-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231017140150.44995-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/10/23 16:01, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (7):
>    hw/virtio/virtio-pmem: Replace impossible check by assertion
>    hw/block/vhost-user-blk: Use DEVICE() / VIRTIO_DEVICE() macros
>    hw/display/virtio-gpu: Use VIRTIO_DEVICE() macro
>    hw/scsi/virtio-scsi: Use VIRTIO_SCSI_COMMON() macro
>    hw/dma: Declare link using static DEFINE_PROP_LINK() macro
>    hw/net: Declare link using static DEFINE_PROP_LINK() macro

Patches 1-6 queued to hw-misc.

