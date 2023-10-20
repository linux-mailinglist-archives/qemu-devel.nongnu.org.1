Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 126807D2090
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 03:04:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quMs9-0000Xt-3w; Sat, 21 Oct 2023 21:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quMs7-0000T9-P0
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 21:03:15 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quMs6-0006lD-6T
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 21:03:15 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5b837dc2855so1443022a12.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 18:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697936593; x=1698541393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y1WWu6RI/8kIYK8I70BRGyaj9oj5p14/0uTAY1l74vA=;
 b=O/kqINYZnIZDmZGuNfgMPkxK8tAXT5SfSYEgFgmU6rECS71WhrFBtTZ2aGAVGa5Zqa
 +JctumXFucpueLbWEZvpL6N5voj1TMJ3gaPiAXzgsW3HkJD/ntaR6muo1JNyEwH9KncK
 QVgGrli+Q9g2kxni99zxe2GdPtLY9krHfm2nVaFgx1A2NEunk0cgOBAT8lBRqYuqt3xi
 ud31E1eo6HtBudckVkoPw83VgNlLHmYO/S+rTvgl7F0/+Ffwj6aXedjriFikrWgRO6I3
 XtWFHA3VXoqFjBPts1POwGwYrGs5OH1rh7J8bc3vcuS/NmUXxrMwg3+5YAv7e+Vb7i4P
 +xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697936593; x=1698541393;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y1WWu6RI/8kIYK8I70BRGyaj9oj5p14/0uTAY1l74vA=;
 b=ednp8poxHgN2crzGBMtvrc4Tfu6AHNGUtb50tAJyWyVZ12kUZzrGwQNDlkPGueRzXw
 Ht3l+uQAWD/qA2I+sP8sXdnT00z0BQbpjN4y/LKgRGbO4+eI3yRIpMQO7sJ4KB9qqNAf
 mez0f54c4UvcgcUnVUg7nagoO9w3Oe8ngqD/EXN6x8/g8QtV42DM/eXZvZIvCsEOYSuF
 pviG9IwawI3qtr0IFTJInSyycm4n/zUmozXKgmcrnOY+t5mGPC5ykKxfxwC1eUwZzBCU
 LM4pneQx/NsZrinMS9LwgtDwmcOGQfI7o086YQlKi3HoTlblWuY3lp1rw7yKiOjUb9HQ
 fIew==
X-Gm-Message-State: AOJu0Yw8xUcwNEUNCvOMLUPpLSPNR4O2ypAs+iTc2SUi1/55TJXItGrY
 yDYJD/bJtA2Kek2+R1VlRLJ3pQ==
X-Google-Smtp-Source: AGHT+IEdiTLOI0BkKpAmct5Rj2NRTX59hT9x2Dhz2fWGTOccYZxHr5gm0g2nHWieEocROiHiN1he1Q==
X-Received: by 2002:a17:902:e5cf:b0:1c9:dff1:6de7 with SMTP id
 u15-20020a170902e5cf00b001c9dff16de7mr8383461plf.7.1697936592833; 
 Sat, 21 Oct 2023 18:03:12 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 jb14-20020a170903258e00b001bc21222e34sm3704336plb.285.2023.10.21.18.03.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Oct 2023 18:03:12 -0700 (PDT)
Message-ID: <af5539ab-ecb1-483f-b96e-1604239a4e6e@linaro.org>
Date: Fri, 20 Oct 2023 14:31:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] hw/arm/pxa2xx: SysBus/QDev fixes
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 qemu-arm@nongnu.org
References: <20231020130331.50048-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231020130331.50048-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/20/23 06:03, Philippe Mathieu-Daudé wrote:
> Missing review: 6-9
> 
> Hi,
> 
> Extracted from a bigger series which enforce QDev state machine
> (qdev instance must be realized before external API is used on
> it).
> 
> While here, pxa2xx i2c/intc devices received some qdev fondness.
> 
> Since v3:
> - Added Thomas R-b tags
> 
> Since v2:
> - Fixed i2c_init_bus() call in pxa2xx_i2c_init() (new patch)
> 
> Philippe Mathieu-Daudé (9):
>    hw/sd/pxa2xx: Realize sysbus device before accessing it
>    hw/sd/pxa2xx: Do not open-code sysbus_create_simple()
>    hw/pcmcia/pxa2xx: Realize sysbus device before accessing it
>    hw/pcmcia/pxa2xx: Do not open-code sysbus_create_simple()
>    hw/pcmcia/pxa2xx: Inline pxa2xx_pcmcia_init()
>    hw/intc/pxa2xx: Convert to Resettable interface
>    hw/intc/pxa2xx: Pass CPU reference using QOM link property
>    hw/intc/pxa2xx: Factor pxa2xx_pic_realize() out of pxa2xx_pic_init()
>    hw/arm/pxa2xx: Realize PXA2XX_I2C device before accessing it

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

