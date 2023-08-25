Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFFD7880BB
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 09:16:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZR2T-00074S-D3; Fri, 25 Aug 2023 03:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZR2R-00073w-9q
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:15:23 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZR2P-0002HZ-49
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:15:23 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31977ace1c8so462586f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 00:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692947719; x=1693552519;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QIntS/pJMxAoTl14tAADVzHJX0FPqG3x0EMIW3png6o=;
 b=zVqXw4vln63u2nVWI1zs1mOMEBR3tvXkjs6Lgr+e2IflhP5OXkLvJrsE07NFrr2tUM
 YVY6SL5vOgiZUl1RwTITCvygrJb4f0DeReroscUUrajHz793+D1Chhcnay3VOkAvAE0m
 H08h+yCgdytQoXRiCRW7jbc9dQvSmVRgV7Or0WEaHnDEHjL8LPbOXomPGDUaUfgAUjiG
 dEIuXgmHdS4e3Je9ezrPc2Havx9GCGaynWDVXkqbNC0zHR4wIvHKWRsH8z4bxcBmkLrL
 rhTYGWxnlSBLwODmSOb0KGp+IGRR0UpvYqLvLipZpFWP1+Ju1Nmn524v+jkc4HB3XEeT
 iJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692947719; x=1693552519;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QIntS/pJMxAoTl14tAADVzHJX0FPqG3x0EMIW3png6o=;
 b=Pj7gUOq9yITTHvhgM3Zu1S3Fx21AXdgHJimfFPfdyuONkz0ShDX6bTLiK3F1WPKkcQ
 +B53QE6CA9OQGNHdWkYmcKPsdfQrsr1P4kObMdAgPFH4BpHGZA1p+z0hldhr3Bj81SMH
 oVD6zEhs9bruycBCjQb/jIxKwHkQDE7X+Y7LHjvh3RGA0d+80Ubcqf7opo8oPwNtRFv2
 Cyi7x/0Nq/2akfFhk2gcR8WwoyMNJdU6vTira0jeosMXzVqsOEgo4ml0D16FL3zax2VK
 AxCpKS8VI+ynf7La1EUwBkCMsVxRPkGE9kGY9l49OqiQVQGh0sgV69DBpIhsbyYkFjax
 oiiw==
X-Gm-Message-State: AOJu0Yz2Civ612Yv+8Lv9e/khWEiWyjNTq4Ery2D/CJtodK31XghQCyo
 0Zra5Apd5SjnfLH1iEBEzSE2RsEbVkkL4D9qGTQ=
X-Google-Smtp-Source: AGHT+IFzn7PxIFZD0Fd4hb3wimJ9z1y+NGu5dzSPnniZIoZQZvTtiUGgq0IdmBPP/eD0fDPpve2dBQ==
X-Received: by 2002:a5d:4041:0:b0:317:3f70:9dc4 with SMTP id
 w1-20020a5d4041000000b003173f709dc4mr13857883wrp.31.1692947719307; 
 Fri, 25 Aug 2023 00:15:19 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.69.26])
 by smtp.gmail.com with ESMTPSA id
 h8-20020adffd48000000b00318147fd2d3sm1342637wrs.41.2023.08.25.00.15.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 00:15:18 -0700 (PDT)
Message-ID: <e35c0ddb-0f8c-e2ba-a8bc-573f3c9015e6@linaro.org>
Date: Fri, 25 Aug 2023 09:15:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 4/5] target/hppa: Use privilege helper in
 hppa_get_physical_address()
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20230824210434.151971-1-deller@kernel.org>
 <20230824210434.151971-5-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824210434.151971-5-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

On 24/8/23 23:04, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Convert hppa_get_physical_address() to use the privilege helper macro.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   target/hppa/mem_helper.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


