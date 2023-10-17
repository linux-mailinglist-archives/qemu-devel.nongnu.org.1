Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7515A7CC4DE
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:38:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskGu-0000Va-DT; Tue, 17 Oct 2023 09:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qskGs-0000VJ-J3
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:38:06 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qskGq-00034f-Ua
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:38:06 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6b9af7d41d2so2475949b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 06:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697549883; x=1698154683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=puadJz5t7xW3vd1KmFXuJisSfN54xdZ0hs6Aa+O15jA=;
 b=O7qFsWdKrfbRNpWlfypAqKMFMYoyZdoGKlOca501jV7Keds0t4LBKZ2JPtmgWUyzap
 C/fDh+liEiBJgAnLlou75j/lZMIX1X989SY4idzDj7Lu42EBtaoWscizONHHjUjz/i4K
 7wl8pHxNUQfG77YxcUL9ZRr59hn+aRgBFGbmgXf88tRNmtyS8InWeykL5+X6B2e3pvU2
 PbJPB2Oa/0tBDRtF+hqAXa/lGQvP66cj+Qu6wwwVrnVup/1vb2EBG+WNeHRZ46HW/W/e
 uT/VAT4hYsH1WHnnlicfftkUrk4W3pPtDKasraORrX83Kz7P2ZWkAHTSvbh2kLjL22pV
 CCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697549883; x=1698154683;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=puadJz5t7xW3vd1KmFXuJisSfN54xdZ0hs6Aa+O15jA=;
 b=lmeGbiEycg3Wm0arSQZkRkTvwrmCw/UGSV1tOhdp5Z/+iOroc/5jG3m9Md5fUS3IuO
 l4x1lW3XDeprdsg+gYxR9lwOD8EBXPe0QdJR9FYRfbVWz8nAtKB1pnV9gDgImSUfVvuj
 O9JFUdaoeT14R3fYY2sZoIGt3VfgetZR52Q/tZjTkfpk1X8nrxwWz5H9+v1VgtxNF3G8
 peWDCB3T02OwCYWhfSTcGOilHGCFOWMnSCO26TeWpn3B0HaNqjLv3lcG5yHJFgYC1whe
 d/uiX3PXCiNZuhWUwuEkbWPTnrg87tC085oyiifxC7zGAC7n/ObVnesGSiILPrSq8HZB
 4xpw==
X-Gm-Message-State: AOJu0Yx/BUoiRWNcA+WZenHJcdkJYekX4MQfNXFhBYdu6MOV4598/jaR
 Ybh/VO8ryyzFcVi1amicxO7y4A==
X-Google-Smtp-Source: AGHT+IFHAd2Dq/e4BTB2rKLwN88BRpDnNY1tykXMtJwef6CnzYbgOSJCtg9HaM4sSQkR1o3XkBm12Q==
X-Received: by 2002:a05:6a21:32a4:b0:17a:ee7d:c035 with SMTP id
 yt36-20020a056a2132a400b0017aee7dc035mr2009761pzb.38.1697549883449; 
 Tue, 17 Oct 2023 06:38:03 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 y2-20020a17090322c200b001b9f7bc3e77sm1529043plg.189.2023.10.17.06.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 06:38:03 -0700 (PDT)
Message-ID: <69691ad3-e4cc-43c7-9f81-b00988ebff76@linaro.org>
Date: Tue, 17 Oct 2023 06:38:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] tcg: Streamline vector load/store
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Brian Cain <bcain@quicinc.com>
References: <20231013175109.124308-1-richard.henderson@linaro.org>
 <2ccd41e7-bc4a-9223-7f56-04493e0357d4@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <2ccd41e7-bc4a-9223-7f56-04493e0357d4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/17/23 04:52, Philippe Mathieu-Daudé wrote:
> On 13/10/23 19:51, Richard Henderson wrote:
>> We have tcg_gen_qemu_{ld,st}_i128, which can be used to implement
>> load/store of vectors to guest memory.  But at present we have to
>> split into, or concatenated from, two i64 to reference the guest
>> vector register backing store within env.
>>
>> Provide tcg_gen_{ld,st}_i128, which can avoid the trip through i64.
>>
>> This does require that the target store i128 in host byte ordering,
>> which is true of i386 (and some other backends) but not arm or s390x.
>> There is definitely further cleanup possible.
> 
> Is hexagon gen_vreg_load() candidate?

Yes.


r~

