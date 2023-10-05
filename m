Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA55F7B9CAC
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 13:07:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoMCQ-0006Lp-Ea; Thu, 05 Oct 2023 07:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoMC8-0006CC-8c
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 07:07:04 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoMC6-0001Ti-Hg
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 07:07:04 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40572aeb73cso7036725e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 04:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696504019; x=1697108819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JgJuM3vRF/kRL0UgPexGcb8qEvFHqn67U92/Q65427I=;
 b=MR1TqGbC1dpH9JW/nI+2YRhph4XZPvZSWBgrnkW7/IPbw5hPw9SylmcTz5u76SkdNk
 FdPlCsKPbtvPIBzADI1474OyVev30oCT6k9qW/hpeWVYdbtUKUDySomdo5pgIolkpZZj
 DgZ4WI9F1wywFelbYH05h2crQ/PKivCRUt9Y1HdmHMBfSVRFz/TnRHWfNyb1L32wpIte
 rBfhh9gWY9Fg2QW95sgnTkCAfkAMV0HZXPogEaNQThaZfSpqXGhKFDck4Z/4KjW5j5gz
 ZvuQ5Aext/8BHTY89m62iWvgNutwnas4bPulWeMONm5Vh1q4utHnRuILInOPDONHftKr
 Q/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696504019; x=1697108819;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JgJuM3vRF/kRL0UgPexGcb8qEvFHqn67U92/Q65427I=;
 b=muV7Q6nW7MvNmjwj5eC00RkdK/wtfdti3nxDRPyCCOwgIfqks4xdx9I/mSp208K2H0
 ZveXfIvcEzcM1IHvcjtVeQbaEWq6OwSLvmlcUzRYY9jabldLNfNYk+ICCaKUv71RZuj5
 qrSdu5qWiRvluhjcBkw5odExmAyK4+3DNQB3cFUccJnRcqbAxa0Ev6Ge1C71uyHKu+rP
 QRf+EIoxvO8zTnORWotWdpRafQM8yPFI00XAgWjztCxiCTvfgSMl1tGgtHQGUVpO//C8
 jCq5NGY/SSYD7y4/0uXIQFpsCmq3kh3ubPZB3yYEYuPndinTtNsmSkcLbX4dCE908qC4
 xALg==
X-Gm-Message-State: AOJu0YwerLZBUPwNpHVxCjE5zL4+0Fobwx5QumJvuqYTcD8bFI8bVy5N
 UzvG1jOoyy20XNNMYdph+FWr8w==
X-Google-Smtp-Source: AGHT+IGy5fC7WHEGTjZTAVJFlNN28g/GXobqZhfeWfSYg1NRMyjxluSyHljmsNbV9fHZwaQI81o1bQ==
X-Received: by 2002:a7b:cc88:0:b0:401:bdf9:c336 with SMTP id
 p8-20020a7bcc88000000b00401bdf9c336mr4730109wma.27.1696504019340; 
 Thu, 05 Oct 2023 04:06:59 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 4-20020a05600c248400b004060f0a0fd5sm1269710wms.13.2023.10.05.04.06.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 04:06:57 -0700 (PDT)
Message-ID: <79e8666f-49d9-8d0e-4c2b-7e4b1d4d1410@linaro.org>
Date: Thu, 5 Oct 2023 13:06:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] target/hexagon: move GETPC() calls to top level
 helpers
Content-Language: en-US
To: Brian Cain <bcain@quicinc.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, quic_mathbern@quicinc.com, stefanha@redhat.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com
References: <20231004123957.1732915-1-bcain@quicinc.com>
 <20231004123957.1732915-2-bcain@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231004123957.1732915-2-bcain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
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

On 4/10/23 14:39, Brian Cain wrote:
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> 
> As docs/devel/loads-stores.rst states:
> 
>    ``GETPC()`` should be used with great care: calling
>    it in other functions that are *not* the top level
>    ``HELPER(foo)`` will cause unexpected behavior. Instead, the
>    value of ``GETPC()`` should be read from the helper and passed
>    if needed to the functions that the helper calls.
> 
> Let's fix the GETPC() usage in Hexagon, making sure it's always called
> from top level helpers and passed down to the places where it's
> needed. There are a few snippets where that is not currently the case:
> 
> - probe_store(), which is only called from two helpers, so it's easy to
>    move GETPC() up.
> 
> - mem_load*() functions, which are also called directly from helpers,
>    but through the MEM_LOAD*() set of macros. Note that this are only
>    used when compiling with --disable-hexagon-idef-parser.
> 
>    In this case, we also take this opportunity to simplify the code,
>    unifying the mem_load*() functions.
> 
> - HELPER(probe_hvx_stores), when called from another helper, ends up
>    using its own GETPC() expansion instead of the top level caller.
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Message-Id: <2c74c3696946edba7cc5b2942cf296a5af532052.1689070412.git.quic_mathbern@quicinc.com>-ne

Odd '-ne' trailing.

> Reviewed-by: Brian Cain <bcain@quicinc.com>
> ---
>   target/hexagon/macros.h    | 19 +++++-----
>   target/hexagon/op_helper.c | 75 +++++++++++++++-----------------------
>   target/hexagon/op_helper.h |  9 -----
>   3 files changed, 38 insertions(+), 65 deletions(-)


