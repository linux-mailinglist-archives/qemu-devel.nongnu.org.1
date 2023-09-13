Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB5079DFF1
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 08:21:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgJFG-0006kl-Mn; Wed, 13 Sep 2023 02:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgJFD-0006il-NK
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 02:21:00 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgJF9-0003po-0w
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 02:20:59 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so5947924f8f.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 23:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694586052; x=1695190852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jACZrebzlRMu+VcTNCBWL6fONnEnF8xCCnriazAVUW8=;
 b=To21gnDmpujNsTq7BmVZMmaaRI5WD9n6sr/iZieXc5/hz/IVYFisvn55Cn6gDKkc2h
 Z2SkCcDtvZjDBOgFV9y+ySg7m2qZqIhu2o2O8AR2tNbJev1+uUWogFFcAPPlMWdka4R3
 N4M8pZUNig1j/pKP+KJlgmHyM8XeBYxoU2IjvFK5vTqbmIw2Sg31I1rbeY53CWaj/O/n
 O7Zl43/CyYcss1KqiTw4cbQGoW6Hc3Xkzot5ETj/uVbiZ/EDNUPHO7/6PjrLWaNCE7TZ
 6GkjgUwodafWdsXPb/b2+hCg36q9R2N3nXYvwXwpwn4pvu6EcSqJfldfCRED4wxygwbk
 ayig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694586052; x=1695190852;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jACZrebzlRMu+VcTNCBWL6fONnEnF8xCCnriazAVUW8=;
 b=SCChy3veOLSthUyut5d9PmgTBMya0BJY9Q8KKe9fpJr4WUDEGuqJtpA51sUa9M0+Nj
 RGwzuTWE9Ezse15DsbcY6f9stYuQNq8/UQ48xkHylARUTqq5Zq3K9YfhtgFJjaXIjbEn
 iYRBHjCbtsD3KWq9QusRyCfVR4R+eUu/GWxwFuSnDEaiyhfM4RqDlGsllqAh5X8mrgih
 l2fV86JwaT3ZKQFTmYh8TpcV2G30n6+AOZBR4twkK3jgLcer40gP+6f9zhPFING9hXs4
 uOKUCToZ4fnu5ZPCzNOd3u75sVKYfXKKhApGWhEpuSzFV0dlvLCSglRdcCy8UZeetm8h
 5wyw==
X-Gm-Message-State: AOJu0Yw0XDzdkCim9pauSu33h+Zt5VefzDWZwLoDd5D/3szdpVEJPjic
 ufh0YYb4rVwcwwtPJHjKYc8RgA==
X-Google-Smtp-Source: AGHT+IEj8+EjlBL6nLoMVuH7EpdiAit6Fc34Q+KMuWXtClbqNZCb2U9FWP2hpraE3OUdAZcrT7jXDg==
X-Received: by 2002:a5d:65c6:0:b0:31f:b0ba:f2ce with SMTP id
 e6-20020a5d65c6000000b0031fb0baf2cemr1427220wrw.9.1694586052725; 
 Tue, 12 Sep 2023 23:20:52 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 b14-20020a5d550e000000b0031f34a395e7sm14588304wrv.45.2023.09.12.23.20.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 23:20:52 -0700 (PDT)
Message-ID: <3e41f9bf-9f54-43d9-ab18-f18034a4fc2d@linaro.org>
Date: Wed, 13 Sep 2023 08:20:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] ppc/xive: Fix uint32_t overflow
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20230913055639.174032-1-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230913055639.174032-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 13/9/23 07:56, Cédric Le Goater wrote:
> As reported by Coverity, "idx << xive->pc_shift" is evaluated using
> 32-bit arithmetic, and then used in a context expecting a "uint64_t".
> Add a uint64_t cast.
> 
> Fixes: Coverity CID 1519049
> Fixes: b68147b7a5bf ("ppc/xive: Add support for the PC MMIOs")
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/intc/pnv_xive.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


