Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 985D078AFF5
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 14:20:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qabDN-0007gL-37; Mon, 28 Aug 2023 08:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qabDD-0007eN-EU
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:19:20 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qabDB-0005o0-0F
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:19:19 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31aeef88a55so2557397f8f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693225155; x=1693829955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1PS1sYWwJPisfkTKDmMlElL2VjDLJH1VesRll00RQx0=;
 b=hUImD3qUf+715S+3tkl7molYRbj77iUCPvUqy/MkrK5Sn4dVAKjBeeGTVeaS65GOdJ
 lnThrowZrVrL6g1ezI2o+LDOXpqLYbPDfJlmYa66rLebnFVBQG+gJcsvoe/0nEL73Wat
 RMXI2KY0PRZBFS4ccYVNixAefw42YgArlJkzrxV2XVMXZ6OUQk00IRkx7G7Kp+PSmOwg
 JS0zEc14MsGhKX7sn5kH/ORAYKaMILwcykOLzAYGBhOYD0Yr7ykXJflKYK5yrexytaPC
 OUZL1l0j2fqrn2P3ANSgzrSr5jEAZsYFoLDBxGXbak8GW55ZRM8kQyaeqW0bEyyOHyhE
 ejQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693225155; x=1693829955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1PS1sYWwJPisfkTKDmMlElL2VjDLJH1VesRll00RQx0=;
 b=OdSQpukeN2py/tGu3tbEDPk5QbYQ+NluBxp9eB3mTOyvWrTlhW1e5gsmlpqqWC9RSL
 jzYnk5eH5wS2eO47Cgdkr40BNpUmUmeYjmpD1/yC9Xt/5dm3uJrCdCTs2R8pOzcysT0C
 sQRdHr47VYlkEpHxC7uZedh5rRITUsfe9LX0z0/gUQXLvxLnf3OcihNpH+NHf36wicca
 +FuN342WDxfw4UZj1hRlYw4i31MrReaxgZkkDEI3TGB21CoU9CsFeCLX//g83l4rXCmz
 LrUoHH/+S0vqzDPLbr6w2+jN/h5tnLfgI9k6YvgL1fxDei0LibNhMlkaLtXgzoH4THRX
 Tl4A==
X-Gm-Message-State: AOJu0YyMmfLO3/95oQ/H4WyIP99m5WLrmuwZhiQetHz0FbcrMag62Jzx
 CXeVNDhMg+22Of06xHRsb+JtXkIG7/VY8Jxjb+I=
X-Google-Smtp-Source: AGHT+IFqiOGgYYsZXsUdKNhKByvhEPjc+6orQ5CDD5iefriDJXBZaz9qO/1W50tNZML0TBIfiC/D+Q==
X-Received: by 2002:a5d:568f:0:b0:317:e5ec:8767 with SMTP id
 f15-20020a5d568f000000b00317e5ec8767mr18156714wrv.21.1693225154822; 
 Mon, 28 Aug 2023 05:19:14 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 y6-20020adfd086000000b003179b3fd837sm10439618wrh.33.2023.08.28.05.19.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 05:19:14 -0700 (PDT)
Message-ID: <94cb7c35-39f7-0108-d623-78435a5e7fee@linaro.org>
Date: Mon, 28 Aug 2023 14:19:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] hw/mips/jazz: Remove the big_endian variable
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-trivial@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230825175123.624114-1-thuth@redhat.com>
 <20230825175123.624114-2-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230825175123.624114-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

Hi Thomas,

On 25/8/23 19:51, Thomas Huth wrote:
> There is an easier way to get a value that can be used to decide
> whether the target is big endian or not: Simply use the
> target_words_bigendian() function instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/mips/jazz.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)


> @@ -157,12 +157,6 @@ static void mips_jazz_init(MachineState *machine,
>           [JAZZ_PICA61] = {33333333, 4},
>       };
>   
> -#if TARGET_BIG_ENDIAN
> -    big_endian = 1;
> -#else
> -    big_endian = 0;
> -#endif
> -
>       if (machine->ram_size > 256 * MiB) {
>           error_report("RAM size more than 256Mb is not supported");
>           exit(EXIT_FAILURE);
> @@ -301,7 +295,7 @@ static void mips_jazz_init(MachineState *machine,
>               dev = qdev_new("dp8393x");
>               qdev_set_nic_properties(dev, nd);
>               qdev_prop_set_uint8(dev, "it_shift", 2);
> -            qdev_prop_set_bit(dev, "big_endian", big_endian > 0);
> +            qdev_prop_set_bit(dev, "big_endian", target_words_bigendian());

IIRC last time I tried that Peter pointed me at the documentation:

/**
  * target_words_bigendian:
  * Returns true if the (default) endianness of the target is big endian,
  * false otherwise. Note that in target-specific code, you can use
  * TARGET_BIG_ENDIAN directly instead. On the other hand, common
  * code should normally never need to know about the endianness of the
  * target, so please do *not* use this function unless you know very
  * well what you are doing!
  */

(Commit c95ac10340 "cpu: Provide a proper prototype for
  target_words_bigendian() in a header")

Should we update the comment?

