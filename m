Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B40F6718324
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:48:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MAn-0001hR-9K; Wed, 31 May 2023 09:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MAk-0001eK-MY
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:47:32 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MAi-00011z-FD
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:47:29 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-30aeee7c8a0so818851f8f.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685540846; x=1688132846;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BuLV135jLD2QR7UPyAIYEYbJFd1fZLVZOEXibbCP8j4=;
 b=IBqzDvXhQPt6KEEbFc0SD/pwyxriUWwHQ4WNuUicT29v+SQHPFn83QOsDvf2CENevJ
 nprw7kQuL5lwaY1+QomkCzf7kDzqgqgfxZ3ykVjTzTGWzrNakTTIaXY9/iOeaTR8aYXw
 13M1OOC//Ayiwr7LnSCEvWK7Qq9T2jzWOKqBLGJjubXO3KXVA5zV04/vQbL3G9UL4D7w
 03Suikc3675RNeBq0ajaDH47evq+TMfkMPWsypGf8zX4bYC7Fth7PVhN1fpyKwhIBYY4
 FbM6QYxbBb1k5bd6zESDBgVg9ouU+izuKtA+YjCAchMUwbFofH3AgJtBprQxUAkyNdes
 6xVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685540846; x=1688132846;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BuLV135jLD2QR7UPyAIYEYbJFd1fZLVZOEXibbCP8j4=;
 b=QWuZKJx3LJmTE4ZYLlixeHCsUw7dXj9GT0vfCLm1YZWPQtk3d/GXbolLmmNTjXjT5m
 ZLf6GWJxay3WZChkl3GiGvasog5ASzcJmLYsJNINRMY3Yg8KIb2Nj1xfg0cOVgEor80U
 KkeSymL8ousjEbuQ4bePJfF+f0UkQpiB6EKcDMrJqIoiMegWo2Hv9nEpFIRTxgdb1HQv
 7khP7QEi2uvaSJ6YYsdZukpjtu5MlNLGYNaq0TzOwN453Mf4l0ti0aD/Uu3ScrbCw9ox
 Q6MQ3RIkftwp1IOTfRANkUY6Ez82S2CV7RB3otPkJUpyeobCaxXpFUPNFuM9M/tvS38A
 CiTg==
X-Gm-Message-State: AC+VfDxTUARzd/F6oMU/4rxm0yrz33s2HvSEy4RzIMa7lb8mKIbvoifD
 LoT0D6vxIXR/qu1bbqVhu5S0fbPnUhKFmnLGtTo=
X-Google-Smtp-Source: ACHHUZ5njFMCuJ+VgVNdj7Ttri6amhzATTv6KZdyPFH3/vcglbOmMDIGP3npFFctSNeHpf67BjTdfw==
X-Received: by 2002:adf:f00c:0:b0:30a:8edc:8567 with SMTP id
 j12-20020adff00c000000b0030a8edc8567mr4648822wro.8.1685540846020; 
 Wed, 31 May 2023 06:47:26 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 l9-20020adfe589000000b00307c8d6b4a0sm6937880wrm.26.2023.05.31.06.47.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:47:25 -0700 (PDT)
Message-ID: <e2ff97cf-6610-1fd3-d4f2-6c352b0b1315@linaro.org>
Date: Wed, 31 May 2023 15:47:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 12/23] q800: move VIA2 device to Q800MachineState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-13-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531125400.288917-13-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 31/5/23 14:53, Mark Cave-Ayland wrote:
> Also change the instantiation of the VIA2 device to use object_initialize_child().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 27 ++++++++++++++++-----------
>   include/hw/m68k/q800.h |  1 +
>   2 files changed, 17 insertions(+), 11 deletions(-)

Thanks for splitting in 2.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


