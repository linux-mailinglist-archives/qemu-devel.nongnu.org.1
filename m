Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B70F78B4C8
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:51:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaeVY-00076R-TN; Mon, 28 Aug 2023 11:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qaeVX-00075T-33
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:50:27 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qaeVU-0004a6-Sv
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:50:26 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31c79850df5so2902595f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 08:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693237823; x=1693842623;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fB13dQzoy/cyjXqKhkaGiJLy4e+dgduX7PEnLozQMuY=;
 b=toongC+agvNjLmLASDpACR1qbwdIUrGpziAya32zA2TcYtwmH6zax4i2p5LzNwpLcB
 Eq3a9FS4s3tSkc46k4opb1B5uvQSpRQMfiuOJztOa7WNr9FbT8s32lqOHJppZ3Z2jMIF
 rk72vSFg4IXf1x2zGMA2cDC1utKGFLVaT2+57Xsj2QqTLfTNMscEUQovOyI42mDLUBRR
 PfDkTqPWnGxnoaSCbo0cSF/8DFralV+U1VzY4dBc0COkcbZo1QVSLTdu76H6/mXtTsqR
 DhRBhFTpAPlu0MgyGdnuIxAmkNva5tKaxK1AUHOWhxv3OHwqtaGWeBxXsMmhklzWoZgA
 nKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693237823; x=1693842623;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fB13dQzoy/cyjXqKhkaGiJLy4e+dgduX7PEnLozQMuY=;
 b=PGBQz9NK5lTmaaIdSxJ2Q0gXX820fdqT5bv+CVL1aK2ZvpC42MQcdMeKGl73nvpycM
 7a3Cauze/9sxr1Lvkv6nuXdGfCjk0oIakXCa8j+TMNctiOB2cm+VDGTSAwUMa+aNopft
 YRX0xjseCnq/UBicNdRF/jsF1nGSFBrfstcLVJlrc6mucelcyRmWGkAUaBlEjfjv/o9X
 5nm2QJC7dURRXb+99d/OM8o+EIdjEV/OBmso4J0PGPIhqMlq3iILHlt4eQ1vSXjNjjNf
 Wkbqs2VBOhvmuT5+cPxxwd35DZVg5AEvh+t7gF7iDkSfyasTx22eG2i29zcFcn/O5Ks8
 1EiQ==
X-Gm-Message-State: AOJu0YxCeugh8wZCzmKo4/rMDvovmvKTP4vrUczqit7m0O0sTeW3gRu7
 IoxUPf1YpRV6uAE7Bb69+tUkNg==
X-Google-Smtp-Source: AGHT+IG/KFDDJbRJ0VbWC/a+8qye5c3VfHyanJkP3sZUUCRJWvnotdtbOvDD+HW0kz9tKti5bBqu+g==
X-Received: by 2002:adf:f08b:0:b0:315:a32d:311f with SMTP id
 n11-20020adff08b000000b00315a32d311fmr20256934wro.14.1693237823243; 
 Mon, 28 Aug 2023 08:50:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 w4-20020a5d6804000000b0031c77c010e1sm10813899wru.96.2023.08.28.08.50.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 08:50:22 -0700 (PDT)
Message-ID: <eda0f3ba-d000-e3e0-0edb-cba9761a89bf@linaro.org>
Date: Mon, 28 Aug 2023 17:50:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] tests/avocado/machine_aspeed.py: Update SDK images
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Hang Yu <francis_yuu@stu.pku.edu.cn>
References: <20230828090101.74357-1-clg@kaod.org>
 <CACPK8XfMn5PJaM9dBkck=jxhLuusJmGnAv_RE3Dp-kdezYM+-A@mail.gmail.com>
 <7930d670-8d1d-04a2-d8c8-83fa48b19681@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <7930d670-8d1d-04a2-d8c8-83fa48b19681@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 28/8/23 16:33, Cédric Le Goater wrote:
> On 8/28/23 15:54, Joel Stanley wrote:
>> On Mon, 28 Aug 2023 at 09:01, Cédric Le Goater <clg@kaod.org> wrote:
>>>
>>> Switch to the latest v8.06 release which introduces interesting
>>> changes for the AST2600 I2C and I3C models. Also take the AST2600 A2
>>> images instead of the default since QEMU tries to model The AST2600 A3
>>> SoC.
>>
>> Is there any value in testing both the old and the new images?
> 
> For QEMU default tests, I think using the latest version of a test image
> is just fine, or we will end up with a very long avocado test run. That
> said we could make an exception when a HW feature is only activated in a
> specific version.
> 
> I run pre-PR tests with more images (buildroot, mainline, sdk, openbmc,
> provided by other vendors) but only the SDK v08.X images have decent
> results. v07.02 and v04.05 have issues. It could be a software issue.

I'd rather keep all tests committed in the repository, only having the
latest one picked up by default. That way other developer can reproduce
maintainers pre-PR suites.

My 2 cents.

