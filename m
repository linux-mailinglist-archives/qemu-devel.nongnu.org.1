Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D84479E01F
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 08:39:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgJWF-0006S8-UX; Wed, 13 Sep 2023 02:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgJWE-0006Rt-2h
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 02:38:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgJWB-0003hs-S5
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 02:38:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-401f68602a8so69922525e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 23:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694587109; x=1695191909; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XGQ97aX+bgFA0xWjQ+JfmzR9bqfL+Njc3b/0gGDUUjw=;
 b=LPixqhdMOF+zjkJoIX8jg4t+V70XKhus8uUwBmstEC0HknJ09jQQaJ8xoviI/6TkIQ
 fXOe47VNUMfJUUi2S0nyeLNeGXHJSH+fje56cZ3tZERcwDVJD6skofEtgmsTZklfNNas
 EZRo4pCZs8z0uKlf1oMiuXamW8HVeNuKRRE4fqg1PndNbuqBN20d+j5vuEJr1U30sBqw
 +DcXz2FYPJt/2ygmYr5U0JdBGKv1IAnAp5NiVOKGInyPFhJUH91YC3YKH/vSJ12/6iCZ
 xWBSHe6i83LIpScNe7w3EQRFZn2Kk56Sxvoca5P8XP46FmhrQx3uhTdPD3J/hI6spHq9
 8+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694587109; x=1695191909;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XGQ97aX+bgFA0xWjQ+JfmzR9bqfL+Njc3b/0gGDUUjw=;
 b=PIrBu5h2MLH1nCJGqr9ZMwVdAYKDiWnMeDCFV7F5jUo9g1lmputXm1ynIRQ9lIj1Ch
 kjz03ZbtOcpVdFg/CMOePcQqsWcmDR98AkRgsblI4kW1NO2r+cyRoUe20qdEmUyJOdqP
 KG14Yk4iAcZATN1Qj4zFbWpzxpVFp8b0t91OdJyAeS0hXOON4zChdukhad7e5qiH2jiF
 vDbMD1BCAJ+igxBjLyXNJFxemDoumTl/wBvdXkjMPMuTgf7hINdm1gfl1EmKRCwZBgL/
 NcNWh/qy0UOJT/HQEq2M1HY1BcOrAz+l2CbbRhpYMKxgeHFFygfvVhNyGkTMz+9F12zg
 WaIg==
X-Gm-Message-State: AOJu0Yxe7gy2SKHthJ+JpT5g/vaKLT2zc4OmfMwlxuQh5vO1Lj5AlJxj
 tUwEqL9kq5P2Rrt530BGuRCWrg==
X-Google-Smtp-Source: AGHT+IEkXmSCwcDGB7AySW/0ncrlk/A+2BaAXWod3bBj8V1V+Jya2ckFmUwR3FBxsw32aPdI4MjgPg==
X-Received: by 2002:a05:6000:8e:b0:317:1b08:b317 with SMTP id
 m14-20020a056000008e00b003171b08b317mr1224921wrx.6.1694587109180; 
 Tue, 12 Sep 2023 23:38:29 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 u24-20020adfa198000000b0031f8a59dbeasm11691443wru.62.2023.09.12.23.38.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 23:38:28 -0700 (PDT)
Message-ID: <30d1cae5-9a44-e9d5-2362-1a3b2ff69d10@linaro.org>
Date: Wed, 13 Sep 2023 08:38:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 0/4] hw/cxl: Minor CXL emulation fixes and cleanup
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Dave Jiang <dave.jiang@intel.com>, 
 linuxarm@huawei.com, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Cc'ing qemu-trivial@

On 4/9/23 15:28, Jonathan Cameron wrote:
> A small set gathering patches that have been posted and reviewed on list
> over the last few months. Looking to get these upstream before making
> any significant changes to the CXL emulation for this cycle.
> 
> More wide spread cleanup will follow later this cycle (reference
> updates to available spec and line length improvements).
> 
> Dave Jiang (1):
>    hw/pci-bridge/cxl_upstream: Fix bandwidth entry base unit for SSLBIS
> 
> Fan Ni (1):
>    hw/cxl/cxl_device: Replace magic number in CXLError definition
> 
> Li Zhijian (2):
>    hw/cxl: Fix CFMW config memory leak
>    docs/cxl: Change to lowercase as others
> 
>   docs/system/devices/cxl.rst  |  8 ++++----
>   include/hw/cxl/cxl_device.h  |  2 +-
>   hw/cxl/cxl-host.c            | 12 ++++++------
>   hw/pci-bridge/cxl_upstream.c |  2 +-
>   4 files changed, 12 insertions(+), 12 deletions(-)
> 


