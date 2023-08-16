Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6992D77E1C3
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 14:39:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWFnP-0004cI-Pe; Wed, 16 Aug 2023 08:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWFnN-0004bA-Tr
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 08:38:41 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWFnJ-0001hG-Tg
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 08:38:41 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so8733440a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 05:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692189516; x=1692794316;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q9poNHcu5AbZCpcG/Pkquwrs4rfLZEIzGIW9t9Ndfbo=;
 b=aPuBDgVbuy7Lo3xQemFV1AgJUQzABZMqnqoJwhfXG2PeJrNoyU5pAIMFjKHDb/kKMC
 UOYLNSNXzxbwrYSISzEg9qWRk7uVTsS34AYRMdw2xE7k8wM21d3Gid1scdDdKpWFJA49
 IUUlJpXKnitQdjixJGJ9+Cl/pr+26oOli6e2D0eNFUZrFPhUMHjVID0cR3H6Uuptiwkr
 vhnkAVyN/TF2/OoWKby6Ol9YuaOmQnLuE3/nvTunhGMxl9cs3oW4Jr4fpVfBJ04S/uFr
 dUJs00mF1sqJv7RaYxhu+rHqsAtosYJLPpZptprAQa7UTZassKtAgSZMvJU9jycS0UnA
 jDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692189516; x=1692794316;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q9poNHcu5AbZCpcG/Pkquwrs4rfLZEIzGIW9t9Ndfbo=;
 b=WDTxj8ceniOFEwolYi2yrqA5zJ69Ctc2ix4BfdjdKe4nyQ/CfpDV29RjzC0v/mZ2pc
 QPhUraUWnk+ciM4ySF1XY9fUPTQONX6pc0DDFHlZWERmOiAD7dXz8YSrbCU+Bpr6suy/
 BsboDm4L0KxRYnJDxGRJEQu8LHd2vpCNLkJvSFYNqRl++t79M0MTO1pUeDCtUKqmkggJ
 9YwW28tnBfdMroIkT7TXRLuLi/1FI0NZuBXyeelvC7AvvkdxcBiSu54Dnoq43YVOXlQF
 51mP7jMf/wwFrryv7hjLkz7KJacbIoRdCZRJjBPuAuRNUlaCU8rzq9bEI427rars6oZE
 qp5w==
X-Gm-Message-State: AOJu0YwvnK8dax5x8to3KeH7q8rTxP1rE2NLVnM0vhUSLFsxWcN89jLj
 cMTXq4c+67nB2AWsOCKyTJ//JQ==
X-Google-Smtp-Source: AGHT+IEKYGUWbNFMUdDtpCE4kEGjhjbrp0+aYjHUMqkHDXK8PWv2elMYee+jR8OMn2n+9q6hOFMlQw==
X-Received: by 2002:a05:6402:1655:b0:523:1901:d19c with SMTP id
 s21-20020a056402165500b005231901d19cmr1679551edx.24.1692189516162; 
 Wed, 16 Aug 2023 05:38:36 -0700 (PDT)
Received: from [192.168.1.102] (mna75-h02-176-184-40-35.dsl.sta.abo.bbox.fr.
 [176.184.40.35]) by smtp.gmail.com with ESMTPSA id
 k19-20020aa7d8d3000000b0051df67eaf62sm8352815eds.42.2023.08.16.05.38.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 05:38:35 -0700 (PDT)
Message-ID: <dfc59eb5-ed1d-c86d-9e09-1626e943f84c@linaro.org>
Date: Wed, 16 Aug 2023 14:38:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 2/9] tests/docker: cleanup non-verbose output
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 qemu-arm@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20230815145126.3444183-1-alex.bennee@linaro.org>
 <20230815145126.3444183-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230815145126.3444183-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/8/23 16:51, Alex Bennée wrote:
> Even with --quiet docker will spam the sha256 to the console. Avoid
> this by redirecting stdout. While we are at it fix the name we echo
> which was broken during 0b1a649047 (tests/docker: use direct RUNC call
> to build containers).
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/docker/Makefile.include | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



