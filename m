Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC75F7C9E52
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 06:45:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsFTU-0000x3-Lf; Mon, 16 Oct 2023 00:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsFTS-0000wt-Ue
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 00:45:02 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsFTR-0005iA-73
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 00:45:02 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40572aeb6d0so40560545e9.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 21:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697431499; x=1698036299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gBA0FXkPWoA/o0/92Z2MIwKuajHLWeP1x9KgD9/Foac=;
 b=RZWRVsdkSWRa46WnegVyGqGig1i8jva6cGDSijhQEy3dXy/bA4vEsp3gFJZ+0bRkF2
 ehf7B3UjCKnbBg/MtQF7dEAd8hXdqjrTTVsHCxP1c0IQTxjILdiEy0/k5/S6F0gCPQDm
 H7FJjFguWx6hZNv9oeyFKsa6EvEv0GMX0RZloQ3aQvsuVvngUP8wDxRpNQPbS94lG1SZ
 8mYb+qK/zDNFJHLK/qUNKqdncKyz7DMxVoE20IB6v2I8nUrudzCKFw7h2Y5IO5hMV3kM
 /MzBOQrxMX9YH+rlkshKUqzov2d6k60OF+EXsHNSxj3dBCvNkaLIR6d8Kwx1TYjlwd9o
 gBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697431499; x=1698036299;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gBA0FXkPWoA/o0/92Z2MIwKuajHLWeP1x9KgD9/Foac=;
 b=Lw0jeA/K27Ne4iNJ4ka2Fn8/3UVFDHcI8Hlbcv1VTSxblrv/7m+w+leoQ3pziqQEhz
 jtgJ/zd4UrLvbyYAirvF2YIL0vQOCyoJbE6t+OwB3TtKf27AK79jRaxSNVQZmNGYagbr
 xToCs1T59fC6YdH808Y9hykO80IIVImxoKNVxB4kZwj+G4JO26LPFdI52dujc3XYH62O
 yjF6Si7Lo4/6ElySJMJxIVXp4fwphxHNXOgOQWK54RrsVQr0DBsGbAhjzwdGY2MEqN+M
 ovBI9weqRTdRC6n8mMVJOMEXiI8ySrNa0iCXXuSi3pDpGX/VpdfCUZBlDYMk2JD8pkCm
 9pfQ==
X-Gm-Message-State: AOJu0YyjHaE0OExrUzdT0vh3iwGTQdOKWvjJlhs/3S+2ND9L4D0O3d/Q
 Q0V/GcJefx0lVSROsie8vcDiLaHJrxzjgZXR4cg=
X-Google-Smtp-Source: AGHT+IFikcaLkXjKU4YmqBWVUURaAZDiCnKAdPvpud4lBw8so7OV8K05Xaif0eCSQQXaakRbqy+QWg==
X-Received: by 2002:a5d:4536:0:b0:32d:b759:cf0e with SMTP id
 j22-20020a5d4536000000b0032db759cf0emr792913wra.20.1697431499491; 
 Sun, 15 Oct 2023 21:44:59 -0700 (PDT)
Received: from [192.168.69.115]
 (mdq11-h01-176-173-171-135.dsl.sta.abo.bbox.fr. [176.173.171.135])
 by smtp.gmail.com with ESMTPSA id
 k7-20020adfb347000000b0032d8913f3dasm12152762wrd.97.2023.10.15.21.44.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 21:44:59 -0700 (PDT)
Message-ID: <ccb4392f-2f0c-d836-8684-f50c4a27a719@linaro.org>
Date: Mon, 16 Oct 2023 06:44:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] tests/vm: netbsd: install dtc
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231013153027.800327-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231013153027.800327-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 13/10/23 17:30, Paolo Bonzini wrote:
> Install dtc as it is now a mandatory external dependency in order to build QEMU.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/vm/netbsd | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


