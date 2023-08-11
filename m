Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF9B77917D
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 16:12:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUSrl-0001AO-Jt; Fri, 11 Aug 2023 10:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qUSri-0001AE-Sl
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:11:47 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qUSrh-0008OM-8L
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:11:46 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e57d2so17792315e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 07:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691763102; x=1692367902;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aje4WPzicPMczHXwcqWSlcA1kbW/rv7Fdx5iuYsOxSo=;
 b=H6hBKbiSKY7fr0kxp3GOdV2gs7HfFePKFv7c+mBAQis1d4v8RdfvW9ss9PGGlqnay4
 rs6bHMr6O5P7T2e8TOpnFhPncrnrSNI4OB5foOMnDDbXICGZCCIXeqHTJzAVkQrRi5cF
 Sf4IXTWSMyHdT18sxcIytvDZmsfE5m+xGxmNJ30PhfGrsq0U2EIrb+S4f3f/hyEfD38k
 XIQgcI65t2YrbDZQL/fGOS9IifYBwapsqQhmIQL3pWOshN/q9sgrwJ+3gWU+Ix7Ck0pP
 C+AooDzeKY7BtvI0n6Dz1gijP3oPpUkpCVzJA15qd801pX8OpOH+udU2d63swqsjKFc+
 zQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691763102; x=1692367902;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aje4WPzicPMczHXwcqWSlcA1kbW/rv7Fdx5iuYsOxSo=;
 b=aOo0foonsbjA9UZr3V21Z4ftLaqJYB9pZdRJAi4dM0IXabxpHHU5vvNKTdrB/othYN
 U6NDKDCVcxgMFhADtZaYE3Uxeys3An4XLe+faI8ng0Uc2I4kfCM3EWIjb36fwWkXBL7U
 oYIhlFJ38XbGGD5OKI9h4+hQrFCt54PB9/wF7v+C//uVxJ45iH8YC3QHKV6WlR6XaEPs
 6otTjq1GzrbIHBgU8mqMu1LhgXChzLEoxp65qcfTWb9wqSXWworlrrehpQ+qJLcHDDhk
 pwxj0FVmRAymmvf9t8uDUO1si3xkyVe3w0MzxqX8iPmiqZJcDSUhckKzq+0WdDEvDo4c
 7rlQ==
X-Gm-Message-State: AOJu0YxsCR/x1bViEaI+XzNoegmnL680s3UkSStOObiz2mp0Pjz5cvrD
 Aoyj/khKlGbw+7Qd6+oLbV0e9g==
X-Google-Smtp-Source: AGHT+IGvTNWMEsIBQudy/6UXnAtdTJrr1+WqeMlwqanc4stNvgoxhusQkQzCMx5E2Xs2E3jDipgwrA==
X-Received: by 2002:a1c:7703:0:b0:3fe:159d:422b with SMTP id
 t3-20020a1c7703000000b003fe159d422bmr1645066wmi.32.1691763102646; 
 Fri, 11 Aug 2023 07:11:42 -0700 (PDT)
Received: from [192.168.69.115] (tre93-h02-176-184-7-255.dsl.sta.abo.bbox.fr.
 [176.184.7.255]) by smtp.gmail.com with ESMTPSA id
 f21-20020a7bcc15000000b003fc01189b0dsm5278047wmh.42.2023.08.11.07.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 07:11:42 -0700 (PDT)
Message-ID: <509307d1-ffa6-59c8-d8bc-068b4923eeb0@linaro.org>
Date: Fri, 11 Aug 2023 16:11:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] linux-user: Fix the build on systems without SOL_ALG
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230810215706.1394220-1-iii@linux.ibm.com>
 <20230810215706.1394220-2-iii@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230810215706.1394220-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.972,
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

On 10/8/23 23:51, Ilya Leoshkevich wrote:
> Building QEMU on CentOS 7 fails, because there SOL_ALG is not defined.
> There already exists #if defined(SOL_ALG) in do_setsockopt(); add it to
> target_to_host_cmsg() as well.

Does including "crypto/afalgpriv.h" help?

> Fixes: 27404b6c15c1 ("linux-user: Implement SOL_ALG encryption support")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   linux-user/syscall.c | 2 ++
>   1 file changed, 2 insertions(+)



