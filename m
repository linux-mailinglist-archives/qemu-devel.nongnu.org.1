Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A379774B7E9
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:35:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHs9r-0001TA-I8; Fri, 07 Jul 2023 16:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHs9n-0001SU-W3
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:34:24 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHs9l-0003Zu-MM
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:34:23 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-98e39784a85so662584666b.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762060; x=1691354060;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A5h7AH8oqpzXuSee3k/wK6DkuJ4jydhcu2xiWPa1XAY=;
 b=nZC1GUvOlYfLTg0wfSMjiWwwDC0KNPigCoiJNrc6tReuqQMobAOzz30JJDpbCDDWNs
 6WmmU5hPtnReXN96ixBnldV3xJLHRKDFu9cSmOaHwbFH2C48A6UnfGqoIPXk1wX9K2L8
 53nuTNrG8QVEpgbJ0MdX7CDKICL2sh0REe0nOC3WKm7qd6AWS0NUuITMfJ717DfdKu+I
 xG2pwgtea1MxHAc1yZgaxRhk+kkB5M9m6yqEOzDc+rljjtqwaFODjpmWZrfHMdB7J6qA
 t2aqhNRy8Dx8S3v+0QQUhb5qMH4q4ppYab4sDNWXliSZfSNv0RtBJKTjJhkjH2PP5jwo
 3b1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762060; x=1691354060;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A5h7AH8oqpzXuSee3k/wK6DkuJ4jydhcu2xiWPa1XAY=;
 b=fG3muRYFwm4l4FHI8RUWj0hvLjfcRbj7qXXm0ZBGpJkUOYDD90NX0Bk+iPbLgBqhRB
 ZOn++GE6wmJAnLLmcMCNZGrreg/1us+KZ33b5SZ0XahRanoIrwIlV0QvyEGxrfH+RQlD
 XVhGx8Zva7u5GZnRkeTlsBfmgLkLv/RLiVUqnrplEdlXXq4K1d7EOM76eIZ2iBN32tEF
 1ms4E3EMtAyh/tqYT5B0nng/A4hbt7gViKHOhYqHyJ12U//MfvPV87J6oFosv6eb6cTQ
 vz61xpXK7k7kcx5IULZZLyxg71XBGxzb6TY6A4h8C+FwwszjvKVudG7HlREPtOOM6GNV
 QIHQ==
X-Gm-Message-State: ABy/qLaRmTown/b88K5VRyfE3W4bW7gwrLsAvKWSTPOSVj94LNUAxRGO
 MevmkxjO7EJ6m7JrJMv6Gtj6xg==
X-Google-Smtp-Source: APBJJlGErNkZhf+8Hz9HKls+nHTZzQ0noPtbUbiX00FsRbc8MKfkujoUtMUNHZajY3Gcfa/fwt7ASg==
X-Received: by 2002:a17:907:3d9e:b0:985:259f:6f50 with SMTP id
 he30-20020a1709073d9e00b00985259f6f50mr9653323ejc.34.1688762059736; 
 Fri, 07 Jul 2023 13:34:19 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.184.32])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a170906148900b009786c8249d6sm2608467ejc.175.2023.07.07.13.34.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 13:34:19 -0700 (PDT)
Message-ID: <ca0fc5a7-9dfd-210f-05b8-c4b0b1e6edad@linaro.org>
Date: Fri, 7 Jul 2023 22:34:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v4 23/37] target/i386: Use aesdec_ISB_ISR_IMC_AK
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com
References: <20230703100520.68224-1-richard.henderson@linaro.org>
 <20230703100520.68224-24-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230703100520.68224-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/7/23 12:05, Richard Henderson wrote:
> This implements the AESDEC instruction.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/ops_sse.h | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


