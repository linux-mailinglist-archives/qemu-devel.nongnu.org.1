Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4190C70C2F8
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 18:06:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q181z-0003aH-61; Mon, 22 May 2023 12:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q181t-0003Zv-WE
 for qemu-devel@nongnu.org; Mon, 22 May 2023 12:05:02 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q181o-0000jh-VH
 for qemu-devel@nongnu.org; Mon, 22 May 2023 12:05:01 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-75afc10188fso98240385a.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684771494; x=1687363494;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l3o07hAx+xVExjVlNAsthx/Rb+eGLI1xxsnlUA+C52M=;
 b=JejSvr1pVcn51D77s7QewtnMLbJokM5OWs91mRk2z2rYv9rK8RgqlOMAcHYE4sndxF
 A+bPNuP43H3YHvXaW0iz70MQdI/P+pQvzrgf55JtLQuBEuqo5CdHF9Wvav5QeZ8m3x2I
 tbzG0aPdQ3q/f9FFprhOqBwP63yysL3dUZyE1843NdpgfTmCBWeakPOLl2sGVPuqKMPY
 TUMfU9s0HmF3U6A1usm8rbunddtJnQppJSRrsIj073kC4NbQltQWAJs6hAPeM11q7MWT
 eSBq0rGrr2gThJegLR3LC3/N6axPqhNVgcpE/lPFjkfAWhsc+fHpJahEI3rJMD+K8IQw
 WwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684771494; x=1687363494;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l3o07hAx+xVExjVlNAsthx/Rb+eGLI1xxsnlUA+C52M=;
 b=HLPvgUGDhe+xxvzHg1E2dz9AO5ytsunHW+P4+Q8FmZ5Pq9WXxByFmA/lZw0usrwJwu
 fwCYCDc/cB4tcxLXKz75b8Slr0hcbESN4OSjx/7D3K+FhTaPaR/SvgphUWV0ehDG2IJR
 U3tKa40q7lzfq+GLy0M8VomeEy4P587AJUjb17MgjMg8YbJY2YppX14l7MhyJVKz4oBc
 FUVWydgTO2r8h7Xw2bnzjvuB7JNcJJHgepsVRpwSQR0UXRzW36DL4VjGoxuD497/fwhu
 4WMUmNAnUZB7McOfChUpQyk068if1yiFWLpKycfgj45h3Q+qhS7X2qgikogupviz2Dkx
 FFyQ==
X-Gm-Message-State: AC+VfDwj7yJuw0LiUII1APMb+Dlc2q1Lmv0P6zQ4Gja9HX7m27q9Kgf6
 2U10A8MelHFNgRX/3no7qc6VMA==
X-Google-Smtp-Source: ACHHUZ7mPcyFAlP/Qpjs5tj82rndNdkJhaKppBt5kUjOQ8+f6q0jfYzSH8J0xy4x6ajcg06oO4kiLw==
X-Received: by 2002:a05:620a:3e81:b0:75b:23a0:d9e8 with SMTP id
 tv1-20020a05620a3e8100b0075b23a0d9e8mr1084111qkn.62.1684771494694; 
 Mon, 22 May 2023 09:04:54 -0700 (PDT)
Received: from ?IPV6:2607:fb90:8063:704:7944:82ed:f254:5737?
 ([2607:fb90:8063:704:7944:82ed:f254:5737])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a05620a15a600b0074d4cf8f9fcsm947882qkk.107.2023.05.22.09.04.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 09:04:54 -0700 (PDT)
Message-ID: <662b0cdc-29f1-23a6-a42b-8cfa58026bb9@linaro.org>
Date: Mon, 22 May 2023 09:04:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v3 00/21] Block layer patches
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20230519171806.435109-1-kwolf@redhat.com>
 <1513489b-2d86-3722-94fa-1a560ac31aa8@linaro.org>
 <ZGsdjRQIbgIcaAhA@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZGsdjRQIbgIcaAhA@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 5/22/23 00:45, Kevin Wolf wrote:
> Am 19.05.2023 um 21:11 hat Richard Henderson geschrieben:
>> On 5/19/23 10:18, Kevin Wolf wrote:
>>> The following changes since commit d009607d08d22f91ca399b72828c6693855e7325:
>>>
>>>     Revert "arm/kvm: add support for MTE" (2023-05-19 08:01:15 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>     https://repo.or.cz/qemu/kevin.git  tags/for-upstream
>>>
>>> for you to fetch changes up to 95fdd8db61848d31fde1d9b32da7f3f76babfa25:
>>>
>>>     iotests: Test commit with iothreads and ongoing I/O (2023-05-19 19:16:53 +0200)
>>>
>>> ----------------------------------------------------------------
>>> Block layer patches
>>>
>>> - qcow2 spec: Rename "zlib" compression to "deflate"
>>> - Honour graph read lock even in the main thread + prerequisite fixes
>>> - aio-posix: do not nest poll handlers (fixes infinite recursion)
>>> - Refactor QMP blockdev transactions
>>> - graph-lock: Disable locking for now
>>> - iotests/245: Check if 'compress' driver is available
>>
>> Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as
>> appropriate.
> 
> Hm, I just pulled, and it doesn't seem to be actually there in master?

I dunno what happened.  Applied for real this time.


r~


