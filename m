Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CEC7B3BE5
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 23:23:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmKwg-0003Ka-LT; Fri, 29 Sep 2023 17:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKwf-0003Jc-0z
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:22:45 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKwb-0005hQ-G7
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:22:44 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso107317825ad.2
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696022560; x=1696627360; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iJkMbm2iAvFWIK/8bBSEPw3AkZJWb3ffPRBy0flGuvc=;
 b=MAQKebLjRi5Hyn+2NDuURSsURGUDHgAaSABZC7PNu3o3Jjx3ZpyXoCNTL9QVSTnFaJ
 d7n9EitTsS66IOCctmCtfTKws6m18ZsPsEYZEVtjdgmAa+1/RFTOUyJnM3gL2g/VhB+D
 LJA6V78mRp2L80wY8VYMqhapB1ng08Ni5KZfzXRybBFDuW4EAaCqch92lwm1PtUx+KKy
 iA8PQjkseqYAK6IiOlqDl9fAqyRS/QXmBLbip3cM/y2x8pyqWUWhuzIq4BrH+3j7YM66
 B81VuuOQ5bfFj+9whN9I4tIcFh+EQrhAeMMamhjoMJ2n3CCnMNkOHvgccIFv3rb6vOk2
 72Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696022560; x=1696627360;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iJkMbm2iAvFWIK/8bBSEPw3AkZJWb3ffPRBy0flGuvc=;
 b=vnHq6xGEqpXfmBEOOSlCNoYZ7SACESMuQ/MYOQsf97mpPqIob1PNibRnoTxkWFLf8G
 qznI7f09DvIR8H1ppQh5ZG301EOHcyJwmPIAqer+c9ZkBKf4wvp61q9rFX0EgenuY0Rc
 qhexEW0GQMqzemM/xvd7FUWd6GLdA15ifff8fSfUN8Wq5iw0WfcN7DKKyH4tBuV2JesO
 PIlkea1RsQVMs1uSoDq/A+InJx2VkgoLZPl98nhI2bENijIk2ItTdJsDXo659TYaOHmf
 OCaE/cv77xDeRQo8cBUXn983MvXt24k3ApWHDbLCcIWprxbjAru3rpL7mh/AuufjAdbe
 tgNQ==
X-Gm-Message-State: AOJu0Yy6eBS0gbXmMiiKZakKnHoMnnottqfbYLLwR+touNVwg4Vqe0YX
 xXrIX8ztBVUq2PPcJmjn25EG9El1VKVlZX2MPAg=
X-Google-Smtp-Source: AGHT+IHS3mr9flQSuhYJsIHT/MbeC2rK6YF/24NrCDD1Na59R7D4Vv0sLBPuF3oQJPme2n101xOoNQ==
X-Received: by 2002:a17:902:e74a:b0:1c3:9f2b:4d08 with SMTP id
 p10-20020a170902e74a00b001c39f2b4d08mr6452327plf.20.1696022560000; 
 Fri, 29 Sep 2023 14:22:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a170902f68600b001c41e1e9ca7sm17295143plg.215.2023.09.29.14.22.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 14:22:39 -0700 (PDT)
Message-ID: <9bf78202-8d87-ce7b-ebac-00038cf8005a@linaro.org>
Date: Fri, 29 Sep 2023 14:22:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 15/22] exec/cpu: Introduce
 CPUClass::verify_accel_features()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-16-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918160257.30127-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.295,
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

On 9/18/23 09:02, Philippe Mathieu-Daudé wrote:
> Some CPUs need to check the requested features are compatible
> with the requested accelerator. This has to be done*before*
> the accelerator realizes a vCPU.
> Introduce the verify_accel_features() handler and call it
> just before accel_cpu_realizefn().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/core/cpu.h | 4 ++++
>   cpu.c                 | 5 +++++
>   2 files changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

