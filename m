Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC8F785859
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 14:56:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYnOR-0000kl-2w; Wed, 23 Aug 2023 08:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYnOG-0000k2-Ng
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 08:55:16 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYnOF-0000E4-18
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 08:55:16 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99c93638322so1143150366b.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 05:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692795313; x=1693400113;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fPEudrUDNDVWc/nbVFMiBb6C0EIXkhJooyR0VD6sUQ8=;
 b=BMJqXD9g45Ofe1pRSISAq21cZ5DpkAo/OcX/r2QNTLpY/aGV/Flt6MypVuWO8Z6SGk
 GyTqZFHLMMiqzY+Gi3ANoH1xAm5qV5yPcU86tH1JX0MLWabje5n9/r1S4vz4os46BQYY
 N/CiVBWW81iak9Sb3cJn61XoM/9R1d9OzSiC0t+iSmMU5zyuzR/s6PKEsD+gVCSuldIz
 rgTTv09qrIji/gUGcEtQX/VejgwIr61MQlqVsHGFpNU2Gm96D2aHC7ZdEoVEtHJxcNzu
 7tG/NJbdEgBgzM0fGnWcskWj0L87aSz59OWzr4/fJv8s8MlCGQaUREAtkWW63zoDnJ4l
 ZKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692795313; x=1693400113;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fPEudrUDNDVWc/nbVFMiBb6C0EIXkhJooyR0VD6sUQ8=;
 b=HW2TLcHtFau96KwIew1znwBr56PqLW5rnAXzfJcvsyK2QILqTdHBJ8wxoJMI2mtW0V
 gLrS0gbyrUCO5vee0qfDr0xuDZ0bvegjQAB77ZAvNsXVo7ysGLHZDLAe+f2+WjEmBaxR
 971iDpOstrCGYS7Ap62BteVNuK9A86OZ4o7BsOQY450w/xzVaEUzArCPrzgpjCgmx01q
 hWS+9yvOEQ0I+cRSZuL+h9M+Y4BDjDFKqYWqqwa4VaYloKW6QI/9lKhbeLHxQojcmUCX
 rMRk3JO6/5hW2N3UWuoJryY2n6vHx0YHfwCbefx0mMStC32nFODCV7L+DU0cYcsYUITe
 RZkg==
X-Gm-Message-State: AOJu0YzoORYaK8kAiTzX9iXOqkX6kYw/z7B1LzSzh2wk/VXFUnDl+qIW
 x4ztMRBWvOe/tAtmIPTKJHsJEw==
X-Google-Smtp-Source: AGHT+IHSuODUhd3bDUHiIbUSTSVz4QSPPqdLQb292MBKb6iK/aF079vCF73FCR/bc9gHrZ3hyidubw==
X-Received: by 2002:a17:906:9b94:b0:98d:abd4:4000 with SMTP id
 dd20-20020a1709069b9400b0098dabd44000mr12560564ejc.35.1692795313579; 
 Wed, 23 Aug 2023 05:55:13 -0700 (PDT)
Received: from [192.168.69.115] (gsv95-h03-176-172-10-165.dsl.sta.abo.bbox.fr.
 [176.172.10.165]) by smtp.gmail.com with ESMTPSA id
 k26-20020a1709062a5a00b00997cce73cc7sm9820044eje.29.2023.08.23.05.55.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 05:55:12 -0700 (PDT)
Message-ID: <d6194868-a3f3-fd2a-3bc4-85db19749312@linaro.org>
Date: Wed, 23 Aug 2023 14:55:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 01/10] linux-user: Split out die_with_signal
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
 <20230823051615.1297706-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230823051615.1297706-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.684,
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

On 23/8/23 07:16, Richard Henderson wrote:
> Because we trap so many signals for use by the guest,
> we have to take extra steps to exit properly.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/signal.c | 52 ++++++++++++++++++++++++---------------------
>   1 file changed, 28 insertions(+), 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


