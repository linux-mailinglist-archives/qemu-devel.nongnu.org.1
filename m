Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB5B73F3D9
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 07:10:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE0wn-0000UV-3R; Tue, 27 Jun 2023 01:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qE0wk-0000U0-R3
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 01:08:58 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qE0wi-0008Qu-38
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 01:08:58 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1b7ffab7ff1so11099925ad.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 22:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1687842529; x=1690434529;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q3An3x9ao6JufZBLh7jFTgrkDm+dcUB/1q0yje+8I+I=;
 b=LhLuy27hwaXBPsizMkdQAjQISXhOYwHQP50EZVTyXLo/mLFus3p4iVOaBog6tZnG4D
 mLkdWg1Pa7Kx5zpTwa6Un4p0Hd9kS94jpMbxbI+URJ0mbvWoTVBF5aoSEZyxV3HfRsZ/
 7HD3x6AIMmkOyIDdzt0obYUREml74zikBvdKg1S4C4PaYiXvC5MoL3vvpy8EwJLvo2Fw
 t6vD5mzfY4XySx1qvlzcP7CqCJiPaDE/+c1ivfQRkFazudPyPLxk2ngxPkJI6zwQP/fS
 j+OZ72ToEyR8PVamNDFR0xkCwtQjl2sHFJx+D+WaDvOwQ/+wjJ07Xm8MhkPmrPvpKQ1i
 bq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687842529; x=1690434529;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q3An3x9ao6JufZBLh7jFTgrkDm+dcUB/1q0yje+8I+I=;
 b=eCeZbHlUkg/1aVV3MtUQSIyNx+F6e2ADRP2d+JtV5Na916XzX3erYzt0FWHSee1iCU
 NSI5cOTFGbaET87lbbiLpyL8QIuGCk3XNGcekY7lvX6zqqBqpt2tR27WKZQsIuPc/db6
 au+bxu8QPnrAcIWU2G/DG24sijXBTLO8NOdhqZclCDy6Xv3JovrsSlsrP9r+UqKbJPcW
 IjPM3CI2P0RfylTShDCEDxYSoUmx+/0tpBVJXRZEd6CqVElUaiRnc/uhXXdqjk+kl+6a
 41vyeIiYH1H1eg7CbNcN6o0B4ScahUrtb7NDphLEZmGBaR39xtjm3M/2CCNifsg5d6Vs
 fFsw==
X-Gm-Message-State: AC+VfDy+qI9FxSumxRUxhj6xvGipIi6R+6zSF5DP1DwVieOmJaFU3UE/
 qEehM7FK1AlXy69bJd1zFakTjXaFeaDAKy+mv0w=
X-Google-Smtp-Source: ACHHUZ7mLsMZMlXfzCkU3UOqtAzbLWd8yXtAYCyNRvsAzzLIHLY1OWdNRrBSsZ0aV/NsWwaEd+3yjA==
X-Received: by 2002:a17:902:d2ca:b0:1a6:45e5:a26a with SMTP id
 n10-20020a170902d2ca00b001a645e5a26amr6397344plc.27.1687842528938; 
 Mon, 26 Jun 2023 22:08:48 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.14])
 by smtp.gmail.com with ESMTPSA id
 h8-20020a170902b94800b001b02df0ddbbsm4956813pls.275.2023.06.26.22.08.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 22:08:48 -0700 (PDT)
Message-ID: <3afd638e-e16a-5f75-7d38-9b5cbeba1efc@bytedance.com>
Date: Tue, 27 Jun 2023 13:06:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: [PATCH 1/5] throttle: introduce enum ThrottleTimerType
Content-Language: en-US
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20230625085631.372238-1-pizhenwei@bytedance.com>
 <20230625085631.372238-2-pizhenwei@bytedance.com>
 <w51y1k55333.fsf@igalia.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <w51y1k55333.fsf@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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



On 6/27/23 05:24, Alberto Garcia wrote:
> On Sun 25 Jun 2023 04:56:27 PM +08, zhenwei pi wrote:
>> Use enum ThrottleTimerType instead of number index.
> 
>> +typedef enum {
>> +    THROTTLE_TIMER_READ = 0,
>> +    THROTTLE_TIMER_WRITE,
>> +    THROTTLE_TIMER_MAX
>> +} ThrottleTimerType;
> 
> If you're doing this I suppose you could also change 'bool is_write'
> with something like 'ThrottleTimerType timer', i.e
> 
> static bool throttle_compute_timer(ThrottleState *ts,
>                                     ThrottleTimerType timer,
>                                     int64_t now,
>                                     int64_t *next_timestamp)
> 
> Berto

Hi,

Right, it's in my plan. But I prefer to do this in a followup patch 
after this series applies. Because this API leads changes from other 
subsystems.

By the way, I prepare to rename 'THROTTLE_TIMER_READ' to 'THROTTLE_READ' 
in next version.

Do you have any suggestion?

-- 
zhenwei pi

