Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D962C798870
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:19:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecKO-0007cI-Gj; Fri, 08 Sep 2023 10:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qecKM-0007bj-1v
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:19:18 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qecKJ-0000j0-2y
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:19:17 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2bccda76fb1so37313401fa.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 07:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694182753; x=1694787553; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JGzmzqlyHI87vneM6Qha0RxFp3f3R+b/M4nOF88y5nQ=;
 b=zFVLVv1EPN8uCSCQhFIxkviaWAEucKvYVAbzYztu+GobkCccFNJ9OkWw39Ds2bqfEO
 J7jT/zz1NXcRZ3Z8AsolHS8dmBI44jzhCXlsoTK/qGyXYrRRcnGJVP1NMXRkv2+tB7g8
 PeHnYxjGt7JDLvUI8Ma7wz128s6J8EyjnPcUPTY2kQGKWbn4AOeqGxQtnbmVPuZzp8qr
 XiovsJBTV+0JcEnJKrsGQnLx4IgehFCMkhO2/ipBoqgaffTaE1KmNRk8EZRKfpWz+iAp
 2bsH3WbtBrGrsLrgB8vMFBIuEgAFwt/fAutJIVqTkejpCj0G+k905hmbQUpEMZxIIgzA
 nGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694182753; x=1694787553;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JGzmzqlyHI87vneM6Qha0RxFp3f3R+b/M4nOF88y5nQ=;
 b=X9cAs22+6YBhKcavNM+ny4GgmQhkujnJX8qRzWsEQYMhO139F/4cdyT5WnLtC+p3QU
 sD3jYJBC4PCiFq78fUO8ro2JUouWe5+pO5AKu7d9BdMbMniafTAZ0tsX1JOWxS5sfO6x
 uC/sdnwa5DbMMYTo6eeC/O2rz8ntdh3aqnsUwfVZwVTNxbw168OMfhjDe5eWcbTWdgOg
 Z4GTkVP86HmEfuvqEvfp8R7lShmU7Z+33lwNIBrpUA5hJap3FfTbBIrD6z89+DU/zja5
 y0XZePFm1HF4YvNtXV57qsYdRKqMUCuYmP2zSUlbdOP8jV6L29GpzyKa32XdMn/gr7Sf
 JUcQ==
X-Gm-Message-State: AOJu0Yx8oOruMM/aYCNlL4u6SlfUcs/D2xqt+jfMWJHDOUco1Khd6kip
 XDHLuIEG3Rj0MANrw1rH6p9Ne2mXa9zsINe+7Hg=
X-Google-Smtp-Source: AGHT+IHX7P7hPGjiLpc2iQbwyTdRy5ywS2KWwSmYgaXE+HNc5x/+dlx0PRJBnK4y9kc99PzGxMes+A==
X-Received: by 2002:a2e:9bc1:0:b0:2b9:b4eb:c39c with SMTP id
 w1-20020a2e9bc1000000b002b9b4ebc39cmr1743733ljj.8.1694182752901; 
 Fri, 08 Sep 2023 07:19:12 -0700 (PDT)
Received: from [192.168.69.115]
 (lfb24-h01-176-173-167-175.dsl.sta.abo.bbox.fr. [176.173.167.175])
 by smtp.gmail.com with ESMTPSA id
 e22-20020a1709062c1600b009934855d8f1sm1106928ejh.34.2023.09.08.07.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 07:19:12 -0700 (PDT)
Message-ID: <3e1fd06b-ec03-0ccb-77e0-c52f5587a470@linaro.org>
Date: Fri, 8 Sep 2023 16:19:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 05/14] target/arm: Pass unpriv bool to
 get_a64_user_mem_index()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230907160340.260094-1-peter.maydell@linaro.org>
 <20230907160340.260094-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907160340.260094-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 7/9/23 18:03, Peter Maydell wrote:
> In every place that we call the get_a64_user_mem_index() function
> we do it like this:
>   memidx = a->unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
> Refactor so the caller passes in the bool that says whether they
> want the 'unpriv' or 'normal' mem_index rather than having to
> do the ?: themselves.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I'm about to add another use of this function which would
> otherwise also end up doing this same ?: expression...
> ---
>   target/arm/tcg/translate-a64.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


