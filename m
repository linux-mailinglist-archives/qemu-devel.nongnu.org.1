Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FFF720AF6
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 23:29:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5CHm-0001f9-6x; Fri, 02 Jun 2023 17:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5CHK-0000Gz-86
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:25:49 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5CHI-0007yI-Em
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:25:45 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-30af0aa4812so2554653f8f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 14:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685741142; x=1688333142;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WXOrY8zqfAdgEhctOJxGxr0uS6ANZtk6ta6iF/RPjCc=;
 b=C1y+Ixfb97+biqHcX89JALNrkM08xkzN2INk4gVnYsk4lDAE5cvJf7AhiDYIO7kv8T
 /rUM+E69xmh8IdsOSDFemEpsf28vfwPhSqe4/V0G5/8GFc1e36Gx0Rx/SHQFZdH6l0sW
 fPXmbE418t6xnTX92Cju9Q6gMv0A1v/lzSdisHeOujMAPIu2BP5AT/jpemGKOCy75Hcd
 Mh5ly/Sx630nlHoV/7AxpyakjjQjGcOQnuEqbB833BH/Gb9UaCoX1tCirIYnpVnNh+LS
 eXSbk/Dg61R8RIQOeur6rVTMgR/IAHdcvKh2FUOguVFPXaPLmwN/rtoIzh5nz1EeucVn
 O7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685741142; x=1688333142;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WXOrY8zqfAdgEhctOJxGxr0uS6ANZtk6ta6iF/RPjCc=;
 b=gp9zD6b8AVlsWtUEpu4XeS/jRozTMmHp51iuL/48R1eJoX0v/dv+FfOvWepcBV7SCB
 hQHYD93USgNOJbU7ObTFbOEvuRKzEHmGfAmRZhkubPprLj9xEGqer4e+CJu1ruDBMHX0
 K9GBiMuZ26+qxoiicwaIhtC8I0glftmqO2T5W4Y6ST7uux/0LcibjEZ+moW9KgZleUus
 rWiqkCNpW4SNB+0/C4wXh9xEVT+GKnQJl1mFJexyrPBcpM/JIWb1n0kLUTvN5Ls2a2B8
 sspAM3nKRXjXP3lIdnBontTbjSlWdWF8a0cSWyhYi25oDgfkS2IhVRIcEjRpSQgK9FHw
 osig==
X-Gm-Message-State: AC+VfDxLbipAclvI72WGBV0XVkY5PhJ+IrYcc/5Y7C47fl+dTWhGAyw8
 SaOP0jkmWqJXOPI7m21PWfV25Q==
X-Google-Smtp-Source: ACHHUZ623rYyMCQhimOhDgc5q87zKzfnCB8tBVLCUqfZfcxenZVHXwUQBabOSomZNlkgdmVP+GROsQ==
X-Received: by 2002:a05:6000:136f:b0:30a:e8f3:39ea with SMTP id
 q15-20020a056000136f00b0030ae8f339eamr721644wrz.61.1685741142564; 
 Fri, 02 Jun 2023 14:25:42 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a5d5649000000b0030b5d203e7esm2585271wrw.97.2023.06.02.14.25.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 14:25:42 -0700 (PDT)
Message-ID: <afdebaa1-6c7c-af7b-2e53-297576f10964@linaro.org>
Date: Fri, 2 Jun 2023 23:25:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 00/48] tcg: Build once for system, once for user
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 31/5/23 06:02, Richard Henderson wrote:

>   133 files changed, 3022 insertions(+), 2728 deletions(-)

>   create mode 100644 include/exec/helper-gen-common.h
>   create mode 100644 include/exec/helper-proto-common.h

>   create mode 100644 include/exec/helper-gen.h.inc
>   create mode 100644 include/exec/helper-proto.h.inc
>   create mode 100644 include/exec/helper-info.c.inc

These new files miss a license.


