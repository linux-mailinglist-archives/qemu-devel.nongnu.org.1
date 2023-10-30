Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE5D7DB864
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 11:40:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxPgI-0007tS-BS; Mon, 30 Oct 2023 06:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxPgG-0007t1-3G
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:39:36 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxPgD-0000tF-Mm
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:39:35 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso2715385f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 03:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698662372; x=1699267172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e+TwgWDLl4AnJbMcoL85lD0Wr2asiN+tI27UKxrQI5c=;
 b=SK6wkuUkqYo9ox6MKXU5j9rEv5UbIZUOTpjAZ2HFOZOTl/r1eW8ODY18b3XBP4KO+d
 Y3VLsZEElerJg6dOIK2twik1+j2nL75L22SW+zFo2QANRqmCm5r7Gg46FpHlYXA1ixhX
 F3yFon5eulGR8N/goOlrdXkplGRkPCACQ0kaXi0bsXAjL8AvR5KQEvRJu4s+u/9C4Pbu
 5L5kM49Mhe0q5y6AqKZ0ok2DgNQEikbCJKgupn5o88GI8nJ5+fyKF/iXnrfpBR+HZKin
 Utvsa39s+yr93thYYBYCsVyxsgsxIrFCGL67IosPRpgFF1yujgIVGvjNitQdM/L5lEdh
 eWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698662372; x=1699267172;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e+TwgWDLl4AnJbMcoL85lD0Wr2asiN+tI27UKxrQI5c=;
 b=npgWMyfEFcmtS88y0BLmR69Ec8YD/jN6qCD0bQjfW3X8p6Ic5cvxYaRTQwW7KiQ35c
 GPHSYEPZ65+BT80bsn5a4CPbQVR8AwMEOuD1KWOonJmaQ8ppXdWWZ3E/tvV2ACuTNrAH
 cx2x6cFQRF3BzxzUy51P3sasjN3gt7RIEwuWPR+1cHOPpIQlYL8rIJ3GHtnIB4Px/Yyk
 18xzHYAWgFRWrLUqfNYGN2jDLTi+nH+yaXERAgVt2RFiIpPB+WRD769jnDy7KCCLdkiz
 LAvjaqWdr1ezEqqXFKVa+1u1wDOyX95XYhGF+u2U0o+je67Y6Xwl+vC22yiiLVxUZaV8
 6I8w==
X-Gm-Message-State: AOJu0Yyp7cw1spVvtOSLzvn27zVr1uJKqreTDwqlVwBwcL0MD/MGZ4NJ
 Wxlu+Ex/TeMTxnPF1tBWvOHvvw==
X-Google-Smtp-Source: AGHT+IEthVCgGR7bFr77PinqbzW0LCmRlm0+kozqq/7pi0Dza1dK8wEPGhe2IzjrLCxNaXdiKze35w==
X-Received: by 2002:a05:6000:1205:b0:313:f463:9d40 with SMTP id
 e5-20020a056000120500b00313f4639d40mr5274739wrx.65.1698662371742; 
 Mon, 30 Oct 2023 03:39:31 -0700 (PDT)
Received: from [192.168.69.115] ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a5d6445000000b0032da4f70756sm7950613wrw.5.2023.10.30.03.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 03:39:31 -0700 (PDT)
Message-ID: <f9bdd29e-208c-3df1-d377-ce2619655d68@linaro.org>
Date: Mon, 30 Oct 2023 11:39:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/6] arm/stellaris: convert gamepad input device to qdev
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231017122302.1692902-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231017122302.1692902-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.972,
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
> (I had this all ready to go before I went off on holiday two
> weeks ago, except I forgot to actually *send* the emails...)
> 
> This patchseries converts the stellaris board's gamepad input device
> to qdev. This isn't a very important bit of conversion (I was just
> looking for a small tail-end-of-the-week task), but it does reduce by
> one the number of users of a couple of legacy APIs: vmstate_register()
> and qemu_add_kbd_event_handler().
> 
> I've included Kevin's qdev_prop_set_array() patch here, because I
> wanted an array property and it doesn't seem sensible to write it the
> old way and have another thing that needs converting. I'm assuming
> that by the time this patchset gets reviewed and committed that
> one will already be upstream.
> 
> thanks
> -- PMM
> 
> Kevin Wolf (1):
>    qdev: Add qdev_prop_set_array()
> 
> Peter Maydell (5):
>    hw/input/stellaris_input: Rename to stellaris_gamepad
>    hw/input/stellaris_gamepad: Rename structs to our usual convention
>    hw/input/stellaris_gamepad: Remove StellarisGamepadButton struct
>    hw/input/stellaris_input: Convert to qdev
>    hw/input/stellaris_gamepad: Convert to qemu_input_handler_register()

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


