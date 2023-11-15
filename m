Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F13897EC1DE
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 13:11:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Ej0-0003pt-4p; Wed, 15 Nov 2023 07:10:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Eiv-0003pX-BM
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 07:10:26 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Eis-0003yt-MP
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 07:10:24 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40859c464daso54024235e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 04:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700050218; x=1700655018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oQ+Xmibms/O38n/vfTA3sp0+VKdaZQDLQPH1egAPsjI=;
 b=m1HpmqpQ5h4/eP2Hzy4C3yJgFxHHdpvnqTveKAircoyYufCaf+YSH9QkiBPVjaZVip
 AcK7TsF7ayc7ps1vDp9Q/+5hcpKM2Jj20BmVaNSys5imF7hup/gG993kegvdRdp6Wg5+
 Csu+s5UN8JWylJjcwo3ACQp6DHoWAGG2uzEptn9BGGoYTMKj+jG0EmVw8O5ZmNrTiCW8
 ukrnEbfxb3RKCcxIPog7xtnZd/xnfB3taR3xtRuR4ghBsGYXXxtagkDTR/SW5uFDIq/k
 KtWK/1eDB7sqRzOU+3n3n1L4ltQUUeKslBEEADzJbD0aU0LYxLmlkcpBqiOp5d8HCeBY
 xyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700050218; x=1700655018;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oQ+Xmibms/O38n/vfTA3sp0+VKdaZQDLQPH1egAPsjI=;
 b=TGdE7AyoULMVHmLrOwFpJe0DSP4wtREFDsdPwtPx6zooI3oP5+TqHiUG79j9bLif7q
 MCUUbYcom8DyZy/mFmMUXxtz8Zbz1671kvdv+puhX4CgsMXQgafW+PbqnWKHcwY3Oooa
 MKyzLpTKHnLNtxcdajFCNowypJPCBd4v0aet7b26vasd/zBIxvXsrfU/67BeX6lClTCw
 t2xIN5M4uP9gYukF/LeF648lsUgZFeAp0lZvWOBJe0uESdWy1u9x0U0XxGK2FwgjqHdD
 rMtwGWkKkGOc+7OcX6WX/3Ov2EOO20Xik2q6aLf6sxk24DQrY+Pmi/xoW+15OVYC1lVo
 l0xQ==
X-Gm-Message-State: AOJu0Yy9bhbQZHIrpq2dJPLzGNGFkAdzvaCLgZM3ckUpbo1yFtKFCbKf
 KNSmhNwmK7q+1/7mQZ7zxtZJ8g==
X-Google-Smtp-Source: AGHT+IE1dTwgZ9ZXQE1y5nhBaHyF1XqEPUU3+5wZqH+duADpsEP1RNpKinzFlwhw72AAtRY3hQpxZw==
X-Received: by 2002:a05:600c:4703:b0:408:febf:831f with SMTP id
 v3-20020a05600c470300b00408febf831fmr9044007wmo.28.1700050218187; 
 Wed, 15 Nov 2023 04:10:18 -0800 (PST)
Received: from [192.168.69.100] ([176.176.130.62])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a05600c198900b00407752bd834sm14902243wmq.1.2023.11.15.04.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 04:10:17 -0800 (PST)
Message-ID: <a9d8ac20-4b1f-4bbd-a34a-50e39a0d964c@linaro.org>
Date: Wed, 15 Nov 2023 13:10:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] VFIO device init cleanup
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231115083218.1973627-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231115083218.1973627-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 15/11/23 09:32, Zhenzhong Duan wrote:

> Zhenzhong Duan (4):
>    vfio/pci: Move VFIODevice initializations in vfio_instance_init
>    vfio/platform: Move VFIODevice initializations in
>      vfio_platform_instance_init
>    vfio/ap: Move VFIODevice initializations in vfio_ap_instance_init
>    vfio/ccw: Move VFIODevice initializations in vfio_ccw_instance_init

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



