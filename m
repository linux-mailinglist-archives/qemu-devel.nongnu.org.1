Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F2076ECEA
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 16:43:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRZX8-0000AS-AY; Thu, 03 Aug 2023 10:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRZX0-00009V-AL
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:42:26 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRZWy-00060a-Ro
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:42:26 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-686f94328a4so741250b3a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 07:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691073743; x=1691678543;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PyBTREPnb9v79YmmSsZjS8fc4YuiIoSGwE9easkBt2g=;
 b=bXVHXkwODt+41kklBPa79YU2CI6quXdoQefu5onRZFfv40qdjViFiCo5NbzAHgMFgv
 NadXO9M1nxATN7N2vnTAlfgqDlfDh55md5dPZrQ6mrDUDfczZLY2728O+HT3Wol6Kwyo
 ALiTXGRYGInfrRy7pYUGuTTA3pz3DPHjdzvBiSX3PYMxsw+c7FYQupZG0LxRepQtJiDb
 BFJWs1rADg2jPVDoUTvFCIyUpprJmsEVwWkRBjBBqyvj9u7RxJLVyaYDX/FnLXSpzNua
 p/nYk6OgLYuUKN8PrYGhh+g/nikYxFRyqZSrrlejJRfEPH5So1+wmBSEhuJ9Utfr44Dl
 Hopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691073743; x=1691678543;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PyBTREPnb9v79YmmSsZjS8fc4YuiIoSGwE9easkBt2g=;
 b=cqj8iVdln+807DLOx/qZZzoB4q2HTJ0vl153nXIl0Y4ZMO7EPkROgQ7M+fmWaH+YZ5
 BW+0+qZ9z4GunekrbqvKqse5JjEgBgKrjoPGyP5SilUxAIgYhzPfgXGApwhmhcYcQE9u
 aaY8qBycFZ+D20rFhQZHMa9WGbi3I3syomjxTLaZsvM88lM7e28yS/lz/OQxuxUMUpuQ
 M9y4fMFSaUclBLFvbOnXuh9/ecYBQTLlXJkqRAXXTd+Hd533lrl1pR+8+Fy0WLzLxJNr
 snKZOddR4gBASHLEJOlNSLw8btn39mWhJU0uzWSTS5fbH7RPcOdaRlIqVTom7wm0H7u6
 S3Kw==
X-Gm-Message-State: ABy/qLYrSeg+ZV7xAF6ZZJHV6Nl3jLGDCRYtv+EBA9Pzc1TJnidq3b3h
 ZCevdFByHIv5wuQcxnEEDDU3Uw==
X-Google-Smtp-Source: APBJJlHwLHyVU+n2N14JAB0jvOdCS0vsSlQWR0NaCljlr9gvkGSgaz6qT9OMLBftiZr9RD36KPAbpQ==
X-Received: by 2002:a05:6a20:748b:b0:13e:2080:ab91 with SMTP id
 p11-20020a056a20748b00b0013e2080ab91mr12497166pzd.28.1691073742717; 
 Thu, 03 Aug 2023 07:42:22 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.144.105])
 by smtp.gmail.com with ESMTPSA id
 n24-20020a62e518000000b00682868714fdsm4788403pff.95.2023.08.03.07.42.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 07:42:22 -0700 (PDT)
Message-ID: <97884811-7b78-286e-fcec-248430a877b1@linaro.org>
Date: Thu, 3 Aug 2023 07:42:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/arm: Do not use gen_mte_checkN in trans_STGP
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20230727162621.445400-1-richard.henderson@linaro.org>
 <CAFEAcA_wYBSiBRy6HQaRh7k=UFrnQ=EwSQQ2e=7PJUzfyVp-ng@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_wYBSiBRy6HQaRh7k=UFrnQ=EwSQQ2e=7PJUzfyVp-ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 8/3/23 06:10, Peter Maydell wrote:
> On Thu, 27 Jul 2023 at 17:33, Richard Henderson
>> -    mop = MO_128;
>> -    if (s->align_mem) {
>> -        mop |= MO_ALIGN_8;
>> -    }
>> -    mop = finalize_memop_pair(s, mop);
>> +    mop = MO_128 | MO_ALIGN | MO_ATOM_IFALIGN_PAIR;
> 
> So here we're implicitly assuming TAG_GRANULE is 16 and
> then relying on the codegen for a MO_128 | MO_ALIGN
> operation to give us the alignment fault if the guest
> address isn't aligned to the tag granule, right ?

Yes.

> 
> Previously we also put s->be_data into the MemOp
> (via finalize_memop_pair() calling finalize_memop_atom()).
> Don't we still need to do that ?

Whoops, yes.


r~

