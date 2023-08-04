Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6205076F9E9
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 08:14:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRo4Z-0001Xv-D2; Fri, 04 Aug 2023 02:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qRo4P-0001W2-6q
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 02:13:53 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qRo4N-0002Xy-9r
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 02:13:52 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bba48b0bd2so12100115ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 23:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1691129626; x=1691734426;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oFmXZbZTZUEYtNj4lW3YOAejUUXmyJVwf6NM+4lEtCg=;
 b=G6kY7odl+szvQH2UyJNIR7gT1+GkkMde1fDecrrZr5NuOelo8cdkKFn/BbKEDZN8XO
 4rrzVslqp+tskdP6qNc0tQTkCkVGzKZ9/HXpsi8CCHAGKPwCvXzaIHV5ZMuGYIpJo5ob
 hX41CIYPTQap2pIn93KWUjNuONuw8oCAU037r2erM3lLutIb9SeUBVHdh338TnQCzkNg
 V3UIRNDzkBv/G4Zr2CxDvDxNgio9o02hnNOboZi8YwKDJKcKx7nfERrR2xHhxGhOAT/8
 df1mgZDTPySDAO3Dqy1UUyhwhBB9d4SmdSu0N9bTNXROFOef89C13Wvcvdq0oS23Xv8S
 DDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691129626; x=1691734426;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oFmXZbZTZUEYtNj4lW3YOAejUUXmyJVwf6NM+4lEtCg=;
 b=bAkR00QRS782od+HKkFJVWymQXOky2OIip2EUCXnKhsyFDpVrSw6e4uvlS2MXcM1d1
 3LBa3NaNmRqhKnD8hGFADkbAQYbhhjeDQpxw/QBXJ7ysTJ17vLRae3CTs5BoGZSBJv1n
 AFoZVuaHxa73a27cWxGFIZZ2wXfY+mQbEY31VOA27wq3H3q1q7kfyO58kTyOepXPk3Jz
 YOb80SwMdy8Ai4HwJJf8HLoMdPLfkHTyAgd3kdFjQ3DEPwMD9AWvYh0u0v1uRtcVfD2n
 DT28cbwETs03LVgPbfW6wGSJaMhOZSDtAtEOj5qVVL+uVEO1xp7CDkHSc7cdsvVa26py
 c/GA==
X-Gm-Message-State: AOJu0YyvhAi3Gt3bVZ2HrN27FXB0HCvRBbMCBV9QlS1eztJ+AdpTJuVB
 OgVVnl+1pPsQ3FozImMa4bDzTg==
X-Google-Smtp-Source: AGHT+IHyYECQpM55XX1k/ZiWxPYIiWzWkpebsA2zSv/MF1qqQAqJZGSrFaUU/U8acgT6xp6BaxQqfQ==
X-Received: by 2002:a17:903:1205:b0:1bc:e6a:205f with SMTP id
 l5-20020a170903120500b001bc0e6a205fmr794556plh.20.1691129626637; 
 Thu, 03 Aug 2023 23:13:46 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.8]) by smtp.gmail.com with ESMTPSA id
 c8-20020a170903234800b001a6a6169d45sm867007plh.168.2023.08.03.23.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 23:13:46 -0700 (PDT)
Message-ID: <3d594b74-e7cf-0974-0940-28ddbe379b8b@bytedance.com>
Date: Fri, 4 Aug 2023 14:10:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Re: [PULL 22/22] cryptodev: Handle unexpected request to avoid
 crash
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Xiao Lei
 <nop.leixiao@gmail.com>, Yongkang Jia <kangel@zju.edu.cn>,
 Yiming Tao <taoym@zju.edu.cn>
References: <cover.1691101215.git.mst@redhat.com>
 <15b11a1da6a4b7c6b8bb37883f52b544dee2b8fd.1691101215.git.mst@redhat.com>
 <7406c7df-4c4a-2566-6abc-9fa2eb0dccd2@tls.msk.ru>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <7406c7df-4c4a-2566-6abc-9fa2eb0dccd2@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x62f.google.com
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

On 8/4/23 12:35, Michael Tokarev wrote:
> 04.08.2023 01:21, Michael S. Tsirkin wrote:
>> From: zhenwei pi <pizhenwei@bytedance.com>
>>
>> Generally guest side should discover which services the device is
>> able to offer, then do requests on device.
>>
>> However it's also possible to break this rule in a guest. Handle
>> unexpected request here to avoid NULL pointer dereference.
>>
>> Fixes: e7a775fd ('cryptodev: Account statistics')
>> Cc: Gonglei <arei.gonglei@huawei.com>
>> Cc: Mauro Matteo Cascella <mcascell@redhat.com>
>> Cc: Xiao Lei <nop.leixiao@gmail.com>
>> Cc: Yongkang Jia <kangel@zju.edu.cn>
>> Reported-by: Yiming Tao <taoym@zju.edu.cn>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> Message-Id: <20230803024314.29962-3-pizhenwei@bytedance.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> This smells like a stable-8.0 material. Please let me know if it is not.
> 
> Thanks,
> 
> /mjt

Hi,

Both this one [1] and the previous one [2] should be table-8.0 material, 
I think.

[1][PULL 22/22] cryptodev: Handle unexpected request to avoid crash
[2][PULL 21/22] virtio-crypto: verify src&dst buffer length for sym request

-- 
zhenwei pi

