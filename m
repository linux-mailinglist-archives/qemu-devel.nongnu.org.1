Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B562F78855C
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 13:07:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZUdA-0005gN-BR; Fri, 25 Aug 2023 07:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZUd5-0005fz-RY
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 07:05:28 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZUd2-0005Rm-UN
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 07:05:27 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99bc9e3cbf1so180724866b.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692961523; x=1693566323;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mKzhajgUmzWCmbN4zmWsKdyU8U5tbak1I2rpnGxvJOE=;
 b=Zj0V6jearfoEFYzgVC8ROkEIPpbFRnd9UgzMWPwwoW/6ertMGYNCRcc8foiYfEZcp6
 k9QunguxCpAchXMoskR/wzBIJIP32000k15roLB+zH8b+hC9a9WpjH+84L/IO4onVPgB
 ujOwyrvaU/Jg+Qmo/edUnHyXP54+m78ltZZWKlavN4v7Hx6+PRkIt2pBzYBLQptFXXQ4
 muU0vFRPpzle+sfyOeJ1lIV/URMU4A42/wj319RwhRV3/v2ji2BP8V1LrMPkMkx0AiM0
 4usWtRnU+S0+TKNAqMEHjAZtY8m2BFCEatAxFgFyiuA5zC/E8o+gISKzmu52sWrZggy3
 6D4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692961523; x=1693566323;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mKzhajgUmzWCmbN4zmWsKdyU8U5tbak1I2rpnGxvJOE=;
 b=R1lm6oPAekT0AImUodp3HOGndpHWqu+RP7sIUMYC6DppPw7pmY0d7mk2g+APBnTOvP
 qvh5mFcOFiJvT2iebizmHa+RsiHiNdI1p2QaOQztQXQTfQv6RVCbpzbJFQmURLjo3Xcc
 WIJTF2Cc1GxM/mfTr1SrX69Idt7t9sm5U/AuLXf+N/E9kVeXnKKqs77LBY3Oo0mulsTf
 9RB1aT1ou52VXgEQ5qdzyQbWVaiMGWYJP2up9cPNUUxfw1pD6jygCALEEpZPJVC1RDHo
 6VzPTAAKaHT/wrSEpKcqPtQoVslLbiZGxo4pAnxBZw8Gz+VIufodBC3xzzzzkuOXWEjX
 2CJw==
X-Gm-Message-State: AOJu0YxY9XAT5lSklEtxNaM2m1itXhfGYX4vqHyao/m49lJNM6xtjGr4
 B35oY2SQMO2LkXQ7z087GvfLdg==
X-Google-Smtp-Source: AGHT+IE7JB3KRoEDm/IiHYKXYQtv3cyQU6tc35PCDt3VDE3Zku5zKI8ftv2mJrcrMDcifxRZCm8tIA==
X-Received: by 2002:a17:907:968c:b0:9a5:794f:f3c5 with SMTP id
 hd12-20020a170907968c00b009a5794ff3c5mr1317068ejc.6.1692961523116; 
 Fri, 25 Aug 2023 04:05:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.69.26])
 by smtp.gmail.com with ESMTPSA id
 j26-20020a50ed1a000000b005257f90c976sm880582eds.3.2023.08.25.04.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 04:05:22 -0700 (PDT)
Message-ID: <904eeaed-9caa-e8e5-73f3-927e134dbd54@linaro.org>
Date: Fri, 25 Aug 2023 13:05:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: Failing avocado tests in CI (was: Re: [PULL 00/24] tcg +
 linux-user queue for 8.1-rc3)
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
 <772eb951-8a43-902b-3737-e52b44f7dcdb@redhat.com>
 <59a970fb-ad7b-d30b-1290-7b167bec0226@linaro.org> <87sf88fobd.fsf@linaro.org>
 <8eb65239-f29e-df5c-f0c0-abd97574254d@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <8eb65239-f29e-df5c-f0c0-abd97574254d@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.57,
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

On 24/8/23 18:23, Michael Tokarev wrote:
> 24.08.2023 18:31, Alex Bennée wrote:
> ..
>> which bisects to:
>>
>>    commit f7eaf9d702efdd02481d5f1c25f7d8e0ffb64c6e (HEAD, 
>> refs/bisect/bad)
>>    Author: Richard Henderson <richard.henderson@linaro.org>
>>    Date:   Tue Aug 1 10:46:03 2023 -0700
>>
>>        accel/tcg: Do not issue misaligned i/o
> 
> It's not the first time something bisects to this commit.
> But I can't find other relevant cases right now..

This seems to be our "we don't model the ISA bus" friend again.

TCG i/o DTRT for me.

