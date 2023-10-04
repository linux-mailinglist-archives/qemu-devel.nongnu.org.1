Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E71217B77E0
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 08:36:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnvTe-0004q8-Pu; Wed, 04 Oct 2023 02:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnvTZ-0004pw-9h
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:35:17 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnvTX-0002vv-Qu
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:35:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40572aeb673so18048415e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 23:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696401313; x=1697006113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8nfzIdxwnx2mpqK9Jh6V0w7KycQd5nGiUBvrooGyduE=;
 b=yCKpHXe6P0U5LP4bQKdKCtSnkoJlqt66sWVtLh5V6BAkPkTLA3kwOxMcZNIkZ3RswU
 xFh+5nFiVWuW7kmoN5phk9EYEgZBDui97fLZWgwMcUMZNJDhsdBT6F/2+259bfh7bWo/
 aji0TT0wCqYO2pfMsU22J+4d4fCzeXoF4YF3WzXsN1Tmz6h77cRHOfth48Gd2dK4Vf+P
 ZE8TgM67yhfCmGNRbIIHpptA2qqB0ntLr1MveYMajes8QY9BUhTorsKt2shUtgRy3W5l
 awuNvd3tXhsskMQieWkjGJzhn2dpiq/ljPMnk9ZIRAEVywfcpGZMr1C6ABzazbdrSHeB
 ks2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696401313; x=1697006113;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8nfzIdxwnx2mpqK9Jh6V0w7KycQd5nGiUBvrooGyduE=;
 b=EBvKVfOgnlYJx58kOhYwqCfNZ8iJq+mNvqpny3j0RwGzmxShtSZIufX2BO9JSl1Dmz
 qwVq5rjiftJeibdN2T//qEKOVnYwAL7O0UUSmcNU4eKjJ6Sf7iL/99pq8u5rPVpi5Aok
 PDziD8Q2v4rfpwZJxMMXfqjGdokYuWiDg7iCw7C7FbnSZDlp28+qRH0bI5VpAV0ZLSb1
 uzU1uuBeLpPHOg6hJh1k2w1ae8otqglLaZyLaOcpJnCm/d6lUd6C4wYq/rY3KV1pFytK
 9zIUCpgl4FPovqXyCmMhz3n7ydpUL4360QlBa0ijKWfFd50pjIQnwHO9LOZvJx6kJVZv
 QDoQ==
X-Gm-Message-State: AOJu0YzZv6Kl5KD4QPmsc2JrxytVZ3TYU5OvoqPGBMV/AzDWLyMYbURy
 2pTRcQbR2jdPptiSZDGKaetkW4auPyGIu1Pa5KI=
X-Google-Smtp-Source: AGHT+IF3+GVWCemPEV7mHbsJ/M5hV2RYrY1sdrWeuBUDG5gsLJdQhC7bGVu4GrN6rYvmSXvCIW61Ww==
X-Received: by 2002:a05:600c:11cf:b0:405:7400:1e42 with SMTP id
 b15-20020a05600c11cf00b0040574001e42mr1341810wmi.41.1696401313282; 
 Tue, 03 Oct 2023 23:35:13 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 p16-20020a05600c469000b0040523bef620sm1188262wmo.0.2023.10.03.23.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 23:35:12 -0700 (PDT)
Message-ID: <01ca7ce5-0b22-14c9-3ece-ec09ef1db7a4@linaro.org>
Date: Wed, 4 Oct 2023 08:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 07/10] tcg/mips: Use tcg_use_softmmu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231003174356.1602279-1-richard.henderson@linaro.org>
 <20231003174356.1602279-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003174356.1602279-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 3/10/23 19:43, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/mips/tcg-target.c.inc | 231 +++++++++++++++++++-------------------
>   1 file changed, 113 insertions(+), 118 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


