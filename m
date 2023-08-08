Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E36B774B6C
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 22:47:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTTaW-0000vu-17; Tue, 08 Aug 2023 16:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTaT-0000vg-6n
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 16:45:53 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTaR-00021L-PG
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 16:45:52 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-686efa1804eso4507036b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 13:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691527550; x=1692132350;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Iy/8bd5GSO2nsZGk+Q21/D3FG9FPDoFycMNQnQeQ83Q=;
 b=ymefCVkHxujs2vkenR9Wu3dv9EGFeI7v6g2eZMmzJYrxaJpDiC0NP54tSc3/H9+WkN
 SgMpexXZN1vJfCo0uMPEChATRDrDd9CScUo3WdOKu36PZFgdAFMg+fxgO1X9nlTeEBGj
 2BflQ1jkSmj83G/2kz1VXrCy0HbMJl77rK4Dj7+IhI2mxfsiMobUU1BfNTu4in7cOnF9
 Slmhd4cTO14Zc39xd1OW4JuYUBoT/oAFVCfcUOZPYANjJ9AtdGZ5g5kgVpfSePTI3+3+
 bKWgn9hdwsStuZhq45+iSmJJRh80ua/nzSSwD7VzPf34Sx1G8Z/mvXLhMhg5XsSR40r2
 s/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691527550; x=1692132350;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Iy/8bd5GSO2nsZGk+Q21/D3FG9FPDoFycMNQnQeQ83Q=;
 b=eh51xvKXl5nzHXxEcUKbhkNVjQ7nMwjCNEvCFGN9AcTmBI3FPSxAEJYG+Z2eFC77ee
 18P1WIKeyd6N01JqWwzBIbfE0w2B1k6gk8cWB/GrU6GMO+/R4Qd++agLn7qs4lRQ2W26
 9BpAVEbz1z6lvX1INiquKSEcf6I3Vh9G7ea/tXelOhtqRoZL1ZC2jPvvvEYpBdRd7f0q
 H4SjreF4fUxJDVENHrXGOOaSsd8WLxzl1uGrheLeJskYOXwxAhziPUBr8apd5GLFIQ/d
 tu9o8Hs+v1MoGCqn648w3D4NcSwR1zilTfKposR/FmMWq7A5GrT2IqJ0edZ5LeBVlxrl
 0vYA==
X-Gm-Message-State: AOJu0YzEOkVlnj0ulx8w/asH48vLnzHdlXvxUkuvaaCknq8m9Rqn3ndf
 CCN2fav3bpV5FJ7Sj2H0sD6Iig==
X-Google-Smtp-Source: AGHT+IEP7iwtV2sQFXNqJhpywrFxflXbYd48dETdAGsj5wVQK8cPxgAkYGMLna50/u7g1zibYFcqnw==
X-Received: by 2002:a05:6a20:12d0:b0:13e:2080:aba2 with SMTP id
 v16-20020a056a2012d000b0013e2080aba2mr749951pzg.38.1691527550018; 
 Tue, 08 Aug 2023 13:45:50 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a62b610000000b00687260020b1sm8433062pff.72.2023.08.08.13.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 13:45:49 -0700 (PDT)
Message-ID: <01bb9ec5-f732-8c42-6db5-d8fa4e83a091@linaro.org>
Date: Tue, 8 Aug 2023 13:45:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/33] Move _WANT_FREEBSD macros to include/qemu/osdep.h
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-2-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-2-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 23:07, Karim Taha wrote:
> From: Warner Losh<imp@bsdimp.com>
> 
> move _WANT_FREEBSD macros from bsd-user/freebsd/os-syscall.c to
> include/qemu/osdep.h in order to pull some struct defintions needed
> later in the build.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/os-syscall.c | 11 -----------
>   include/qemu/osdep.h          | 13 +++++++++++++
>   2 files changed, 13 insertions(+), 11 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>



r~

