Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D45F17E1583
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 18:34:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzgzp-00038u-S4; Sun, 05 Nov 2023 12:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzgzn-000383-DU
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 12:33:11 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzgzl-0008CK-MJ
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 12:33:11 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5b9a456798eso2074129a12.3
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 09:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699205587; x=1699810387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tjcPK7crjbFfz+oBjOIhHD92WdOZAp2svei46Bl3UuU=;
 b=pCpGVaxEpbSfUunNdeBaAfIUOB9pjl/zNiTCB6MZSxYr3vx/Nm/SNZVKFGOjOHnsbf
 CJa3QhGfiIXCS2MkFE62c9qPp4md/RpT8CvA8wEySsjWB8I+6i37Ph6vh+7YOkAC3kw/
 ye8VGxdJhpJn0iEWEU9PYsBMZMhNrzwsoQGJGmKI8vz75meYB0Qf5NeYOtYbVQZbEbto
 HF1v0xyvQsmzUGYVoImoY4CsnXb+PNp3NQMWC0tN3u81XZu4VChgkzc+1WIzqy6DtXVP
 esjjNG0z/xnqPb1Utt2K1bw8xfYWZmsCubrGWLUwdTvxc6AqSlDL1zC6MAlNOsoeerQD
 cQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699205587; x=1699810387;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tjcPK7crjbFfz+oBjOIhHD92WdOZAp2svei46Bl3UuU=;
 b=XLFrcyLJ/ZYNonz0nI+dHQZTQ9EoqHmEjzlHaQzDP6q/WvVceYQVuqL+bNcFQNg6Qf
 aPUyu+UIKqkK+4wpa/vTjRIFOAbCqs5OFzdIl8HhaYajG7Ft5DIWqVrNq0B2UjlV49VV
 8KTT1W3JktG+TIvONGTps5ofErZ4KnduMDPt+SC3FYVMuGUt5KzHlhypBzVGCg/stNID
 5gfbxL9u+Fxp68lE4Lj3wtnzvwaPuUH/NstiU1JxgSFvpJGs8MuRbnRcQQfeShPcDHSb
 QVrYpE5JrHS4XoC4905vqotMccgmmRWY+edKcWqIoLcXhuhe0pdxJZJFXIMsTSGuqaG4
 4b7Q==
X-Gm-Message-State: AOJu0YxzvlOKzRmbchA/hGQPqAYLugrFA6S2at0AXKobNNQZZk67Okwv
 DPADKvl7IY7eMKNG8JW2N3Z7zA==
X-Google-Smtp-Source: AGHT+IGmZlxi+ZLafj5ryj5k5P37qEEW8aRVtfqE8ZcRn1MGpnG86AKU5k0dZFbRgnJFXrgvt7ZL3g==
X-Received: by 2002:a05:6a21:3298:b0:16b:74bb:e57e with SMTP id
 yt24-20020a056a21329800b0016b74bbe57emr25337822pzb.12.1699205587153; 
 Sun, 05 Nov 2023 09:33:07 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a170902ce8c00b001cc25cfec58sm4428316plg.226.2023.11.05.09.33.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 09:33:06 -0800 (PST)
Message-ID: <f2079bc8-84c7-48b4-9842-87d239806515@linaro.org>
Date: Sun, 5 Nov 2023 09:33:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/vexpress-a9: Remove useless mapping of RAM at
 address 0
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231103185602.875849-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231103185602.875849-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 11/3/23 11:56, Peter Maydell wrote:
> On the vexpress-a9 board we try to map both RAM and flash to address 0,
> as seen in "info mtree":
> 
> address-space: memory
>    0000000000000000-ffffffffffffffff (prio 0, i/o): system
>      0000000000000000-0000000003ffffff (prio 0, romd): alias vexpress.flashalias @vexpress.flash0 0000000000000000-0000000003ffffff
>      0000000000000000-0000000003ffffff (prio 0, ram): alias vexpress.lowmem @vexpress.highmem 0000000000000000-0000000003ffffff
>      0000000010000000-0000000010000fff (prio 0, i/o): arm-sysctl
>      0000000010004000-0000000010004fff (prio 0, i/o): pl041
> (etc)
> 
> The flash "wins" and the RAM mapping is useless (but also harmless).
> 
> This happened as a result of commit 6ec1588e in 2014, which changed
> "we always map the RAM to the low addresses for vexpress-a9" to "we
> always map flash in the low addresses", but forgot to stop mapping
> the RAM.
> 
> In real hardware, this low part of memory is remappable, both at
> runtime by the guest writing to a control register, and configurably
> as to what you get out of reset -- you can have the first flash
> device, or the second, or the DDR2 RAM, or the external AXI bus
> (which for QEMU means "nothing there").  In an ideal world we would
> support that remapping both at runtime and via a machine property to
> select the out-of-reset behaviour.
> 
> Pending anybody caring enough to implement the full remapping
> behaviour:
>   * remove the useless mapped-but-inaccessible lowram MR
>   * document that QEMU doesn't support remapping of low memory
> 
> Fixes: 6ec1588e ("hw/arm/vexpress: Alias NOR flash at 0 for vexpress-a9")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1761
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

