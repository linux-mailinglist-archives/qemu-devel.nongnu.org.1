Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C6F786C95
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 12:12:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ7Il-0004Wr-Af; Thu, 24 Aug 2023 06:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZ7Ij-0004Wj-Fo
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 06:10:53 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZ7Ih-0004d1-BJ
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 06:10:53 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so2906999f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 03:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692871847; x=1693476647;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VppE3bZGjxA/0X+Upw12nzSJJFXRbX6wy3yfzVFRLZ4=;
 b=POnQZmEZMZwr5+wAZFfaI2pcPFWrhRqRUfP46qsQK8f67NJ8KBi1JzfZ4VRfBb5PpJ
 3GdGgcRbNcbq9sb527KS53ugcbtVrxB7oYKol6bPpTKqxHAtMCqeazzsIm6GxTHOGzBK
 mnYANWyqfocOIiy62f948g2uIl0qp4PJORHwlfh317SOO9g0Giaw+SAelMmGuf8jO6IP
 866hf0er8nBOqduEHJ+rdTZTtPO3IHO3Dq7yPynAcZSbzXdqlqsScGrKK10QNR3qiXqj
 TlfKQ19kHSGMCpH3LYV/bB+PSeb6EqAMm+CQRA5hRNJj5OWe9aRr+KYPTsMwpF1ajUg6
 UflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692871847; x=1693476647;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VppE3bZGjxA/0X+Upw12nzSJJFXRbX6wy3yfzVFRLZ4=;
 b=dfNromNykQmZ3tIAB2RvNOa+ai10O/4iG1jgNDtpfmGKwK7uZHy5wj3Wzi5GMOGZci
 qTPQZiu445p4qdH1OLIGahsPDf710OR2P7Amy6zPmu8zk5O757cr2Hkk46er2IzLrs3G
 QrbG1+wXY8ygk3pAG5QM0pcQhC++qKUOSLIH77pPAQjMI9ZBUGd/IZbZ4ZTR1Ofe6iuv
 UildYzZOyYy7QioW9Fop/CN6llEjUWdZ8vIrBmHUgqDfJ0BMR5i/dVVaCYuIQ1BG6shN
 b3HJt6j983ZVgRCTE9rvDXJ6nEczuSAi6rlN+e2Jk7/sVQ/STXba/OKptu/0ovpzq+lP
 U6Ew==
X-Gm-Message-State: AOJu0YzwFJ6ENSuw6itiR0RyxGk4CKoJk26qdQNRNRHaG3ubJO6vnFIe
 8NYH7LRi4yN8UXW2TSro/gE5F5K0g06uAIqp/4s=
X-Google-Smtp-Source: AGHT+IGkIMuB89A4ycsqlda2uK1lHywz5acCCdjCeNb/ExH8gkYUQBRrz2QcQBNR5ox+HWI0ODX64Q==
X-Received: by 2002:a5d:6308:0:b0:313:e953:65d0 with SMTP id
 i8-20020a5d6308000000b00313e95365d0mr11888795wru.28.1692871847430; 
 Thu, 24 Aug 2023 03:10:47 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.238.90])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a5d6247000000b00317f29ad113sm21813017wrv.32.2023.08.24.03.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 03:10:46 -0700 (PDT)
Message-ID: <cab9c9f9-04ad-4a5f-3db0-807b481d4c55@linaro.org>
Date: Thu, 24 Aug 2023 12:10:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 04/24] util: spelling fixes
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
 <20230823065335.1919380-3-mjt@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230823065335.1919380-3-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 23/8/23 08:53, Michael Tokarev wrote:
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   util/cpuinfo-aarch64.c | 4 ++--
>   util/cpuinfo-i386.c    | 4 ++--
>   util/cpuinfo-ppc.c     | 2 +-
>   util/main-loop.c       | 2 +-
>   util/oslib-posix.c     | 2 +-
>   util/qdist.c           | 2 +-
>   util/qemu-sockets.c    | 2 +-
>   util/rcu.c             | 2 +-
>   8 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


