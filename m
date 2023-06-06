Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEBF724411
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 15:14:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6WVL-0002FS-3P; Tue, 06 Jun 2023 09:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6WVF-0002EP-91
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:13:37 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6WV8-00017U-TF
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:13:33 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f6d7abe9a4so53146465e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 06:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686057209; x=1688649209;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mKWhSrRCMQhVoMMnQJ7rvIRbYbcRujESbqCptnmoUF0=;
 b=n64v3h9oCbDMxz59DEeJMEtv1Fx/XtxzcQ6NT3UNC3RDmPYzDTugkgL2qmbqrShvqn
 AMKgPCg0rDw+IKFR5ZAVZpwoya67KLZhMX++gjSP220Ca+mmbJSppGkbOfzLpidsqS0s
 Gx8j8w8FB9kE/tYSF1HpskqKXzNMde6m6VCgdAXvB9H9szaCGc4Vg9myqyHvGi9/eR1p
 cz3dWF8YTldPFFDZEOBNSTuX0N+NmzXU50zocg4TJAZm0FHSu52qolSdLOeP2eY6qqoH
 dSOQ+vP2pKlZ7yqThw9svr2uO1HoJlBksO8/DmOV2oGwby3sbbjYoJOu84B3dOPKO3VB
 5B9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686057209; x=1688649209;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mKWhSrRCMQhVoMMnQJ7rvIRbYbcRujESbqCptnmoUF0=;
 b=HvNzitySUL/iGM+i7Mo0faznR3NG7X6j1JPOy7vTM8J4l+QHLIqltC7DTaxbD05jaB
 IWNrpC9yKntSfUtlK3WKTkzkcJhjSulfMz/iUf9TLEk+VtwbHhL7ps7IWd2GfVrnJO98
 utgRk9aE8N0Q4hV42Tf0nhQLepFwYK/56TfugQJpIw1KT/NFKMSrn6HTkz9d17RKrMK1
 RrLunDY0UFlcmrgb0xRx/ryeJettyWq00fOP4d+tKF9UROqkaiHZXniYzEww1caixFHZ
 C3uBbZaCC+QtBYIc5KOKDfr5/ikK2gnE4+YotNvypNYrEMcg8qvthiDoYX5pnqp/+sIl
 Ovfw==
X-Gm-Message-State: AC+VfDxyALqd1QOC9ZfMYAT+SW8mW8UJ2brUmtXzsvO0uzf36N07DgRz
 gvADPHGDag6RetEcVs7S+Fr6hw==
X-Google-Smtp-Source: ACHHUZ52hr9OYaj5qu6J8HalFECPiwSExSgV+Wo/rF9a+MS/OddThhi/FAB04BiZTbVfY69gOekh/w==
X-Received: by 2002:a05:600c:2058:b0:3f4:2365:e5ac with SMTP id
 p24-20020a05600c205800b003f42365e5acmr2029596wmg.13.1686057208924; 
 Tue, 06 Jun 2023 06:13:28 -0700 (PDT)
Received: from [192.168.69.115] (vbo91-h01-176-184-50-104.dsl.sta.abo.bbox.fr.
 [176.184.50.104]) by smtp.gmail.com with ESMTPSA id
 t14-20020a7bc3ce000000b003f60e143d38sm13951330wmj.11.2023.06.06.06.13.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 06:13:28 -0700 (PDT)
Message-ID: <d2d9d803-5cdd-6b31-6127-ac93ace39439@linaro.org>
Date: Tue, 6 Jun 2023 15:13:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] hw/sd/allwinner-sdhost: Don't send non-boolean IRQ
 line levels
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20230606104609.3692557-1-peter.maydell@linaro.org>
 <20230606104609.3692557-3-peter.maydell@linaro.org>
 <635fdcd8-23fe-c0db-c912-3aa0517dd4b7@linaro.org>
 <CAFEAcA9cObnb11cSS_StbSHdP0aB6sDeqSHfjb3-qRBfy7K9Kw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9cObnb11cSS_StbSHdP0aB6sDeqSHfjb3-qRBfy7K9Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/6/23 14:55, Peter Maydell wrote:
> On Tue, 6 Jun 2023 at 13:39, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Peter,
>>
>> On 6/6/23 12:46, Peter Maydell wrote:
>>> QEMU allows qemu_irq lines to transfer arbitrary integers.  However
>>> the convention is that for a simple IRQ line the values transferred
>>> are always 0 and 1.  The A10 SD controller device instead assumes a
>>> 0-vs-non-0 convention, which happens to work with the interrupt
>>> controller it is wired up to.
>>>
>>> Coerce the value to boolean to follow our usual convention.
>>
>> I remember once wanting to convert qemu_set_irq() to take a boolean
>> argument but someone said using integer was more useful because ...?
>> I searched a bit but can't find that in my mail archives, maybe this
>> was on IRC. Any clue? (I find simpler to use a boolean rather than
>> having a convention of using integers restricted to [0, 1] range).
> 
> We have a lot of use cases where we just want to transfer a boolean
> value between two devices. We have a few use cases where we want to
> transfer an arbitrary integer across the channel between two devices.
> (For instance hw/intc/etraxfs_pic.c:pic_update() sends a vector
> number to the CPU via a qemu_irq -- see commit f4f643882d9dc467.)

Thanks for this reference!

> At the moment we use qemu_irq() for both. In theory we could
> construct a parallel set of machinery for wiring up and setting
> values for the "want an integer" case and restrict qemu_irq() to
> bool only, but the lazy path is to use the same function for both.
> (If we had machinery that made it easy to construct arbitrary
> strongly-typed signal connections, that might perhaps be ideal.
> But it's probably not very easy especially in C.)

I see, thanks.


