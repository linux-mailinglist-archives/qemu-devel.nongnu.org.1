Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8E77CC37F
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:45:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjRd-0007i6-BB; Tue, 17 Oct 2023 08:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjRa-0007d9-84
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:45:06 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjRY-0008EN-Kz
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:45:05 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53db1fbee70so9543698a12.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697546702; x=1698151502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wKulzNlfgfrpkUT+QrxCc7IozboSTp13pn0UnsMQw2k=;
 b=aO+daUZWHa97/8byhTsJYsuWxEdkTmBvnaVYxuh1TKE5jXF1bWxeNXvw4OswjEWMj3
 r9fXK/cJ/MSir8syYyhmX/zew5rTMNbdc9Q4Z+mnuj/JaUxUnKfoyZq3m6VNup+ixH9n
 XumxItzjlJsdHY2K3cwxX7Hc+TMaswPhGPtn35tRVMPGIrfA4W+u7FT/oKmzowgKIm/m
 xwQ7OW2ul+oWTUqPBj/97uzOSY4PTojGcYGmO2KCfeZ9GMDhvxALPrw94EshAcuZeglZ
 SyBHhyxUXWCTaQSpo/QYuoit+2u+XPH0swP9KjsSUOkZD0kRhhR5rN7fDYJywXQ8dfky
 PoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697546702; x=1698151502;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wKulzNlfgfrpkUT+QrxCc7IozboSTp13pn0UnsMQw2k=;
 b=ijdPTFsm3ajTk0KvIamf3bkN0/knGZzHVauUN0dWbE1eNsAourWy0Yg/Rvdzkvpw3s
 XiHjgkFvUh2dPXtzu7sFUcwlYxujHQkfo7mAlQ2q4F+SEBiFtQ3A6nk+k5jTyL/t049I
 VUCcsALysMpP92hnBrAablvxfxbamIiLk3bF8bJWUV5+nCVNpzUMvm3QB+vLH22rDFZU
 nmt8iXdWJVp9xRndrmiIeL6a4MRYGlIZYlMzOO9CNGv0dWf2nwD97X8cO0Gl9ffcGtaS
 Ta0PB/gTouqfJBjc8B+fC7n6X3YD+S5BcoShrmWosJGymaDZhmRvxZlzkoxAG/qDHPW7
 wjuw==
X-Gm-Message-State: AOJu0Yxm47gxestqZHyk6Oy21Hyer4uwsmocMP2Ow6TwxrMmNrbHedQM
 06+/9dn0ppG8+eHLvkz8oKEGQA==
X-Google-Smtp-Source: AGHT+IFihxdGtIX0x8Wmu7Uun3EkJ+Oz+UYhZOeEMdxpNBY6C1jGJobwbWDWPbPpzTYsn1xOYep9OQ==
X-Received: by 2002:a50:d658:0:b0:53e:47e9:9614 with SMTP id
 c24-20020a50d658000000b0053e47e99614mr1699519edj.7.1697546701998; 
 Tue, 17 Oct 2023 05:45:01 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a056402038700b005333922efb0sm1147916edv.78.2023.10.17.05.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 05:45:01 -0700 (PDT)
Message-ID: <4a335345-782f-1166-5cb7-cd491fcccf94@linaro.org>
Date: Tue, 17 Oct 2023 14:44:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/6] hw/input/stellaris_gamepad: Rename structs to our
 usual convention
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231017122302.1692902-1-peter.maydell@linaro.org>
 <20231017122302.1692902-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231017122302.1692902-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 17/10/23 14:22, Peter Maydell wrote:
> Rename the structs in stellaris_gamepad.c to our now-standard
> CamelCase convention.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/input/stellaris_gamepad.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


