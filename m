Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BCF735CBD
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 19:06:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBIJh-0000B0-EX; Mon, 19 Jun 2023 13:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBIJe-0000AQ-2I
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:05:22 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBIJb-0007rK-37
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:05:21 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso2827799f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687194317; x=1689786317;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1u6o2RpQlEOTykl4PqKBgYSo2H3f03jBLzkO28SE53c=;
 b=ZJ8uDy0vnwbwSPDFp2pdJNG4EKYdBo/NKnTyMW2tI9lCjHIn3oWSBc8NexNy0DG3jE
 GpZWL5HLdujAG5Rd1fWPlf7Gb1gmp354d0DgPy27lcq6bq8gyLchH5fVz9DJePb7ACGe
 upgXGiEpXAjQ+4UhUAnuJmghPj6jMmI6CQh66YU5nWymqD3pjbj95NCTD0lqLyqjPtNx
 bsFTZuC2MW2gkw/mdv0gZ591ztugeyUp3LJnpIP6O7CpUvGigyrAPT8Z9YR6FJRp1jkv
 gE7sDEZ88c3k/Y5gOIB9geqKkGEeWVt4me9v+W2xlmwmlcjRTGziihoi44ALWL38ai+R
 jwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687194317; x=1689786317;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1u6o2RpQlEOTykl4PqKBgYSo2H3f03jBLzkO28SE53c=;
 b=MR4Ewe0H03wN9zcyaqe7R26tm+b14KEEFYbC4b0SUN7pf9e/RK5keQabskIWptPpYE
 l1D+oopyw+VMXOvVXNIEp/8uthpw91KQUIUsj6h//967EtJDkZvSiLOQ+jltYVJB8t5P
 el5QOe8WMmaZmRv+XGNLUcmsNIvwH1np9/oB1KyQtxYErhFn7a4qRvR73AE3X17aoGF7
 Efw0Bxl6rv7RCsiJGN4MuuAl8Pt0LWM2SqU5Vx+CvUjk25C0V4PrdElhKryS+6GY8JHk
 notxz9pThE7BYpoPGLSUSFD+YV+A/VbSX2v/dWu7SsI5sv7yWJleT7MxHN9MoqXg1B2q
 TI9Q==
X-Gm-Message-State: AC+VfDwbhDs/DkwaiFJ9dkUmpFji8Djx6iZ7VsKn6DDLxi21l9sHkLO9
 dMVjyOucHGL/ViD+ZNMbsMMRzg==
X-Google-Smtp-Source: ACHHUZ4IBQ26a4YF6A3neAkumOdI40TAgKDVA9i4Uy7D/PWQZwuOdAEbpfcKEbzyiV5xoPYpi7QmIg==
X-Received: by 2002:a5d:5707:0:b0:30f:bafb:2468 with SMTP id
 a7-20020a5d5707000000b0030fbafb2468mr6157794wrv.40.1687194316849; 
 Mon, 19 Jun 2023 10:05:16 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 m16-20020adff390000000b0031276f8be22sm1171433wro.97.2023.06.19.10.05.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 10:05:16 -0700 (PDT)
Message-ID: <700062c7-0d08-9b81-33fc-b3414c823dd2@linaro.org>
Date: Mon, 19 Jun 2023 19:05:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 06/38] crypto: Add aesenc_SB_SR_AK
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, ardb@kernel.org, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
References: <20230609022401.684157-1-richard.henderson@linaro.org>
 <20230609022401.684157-7-richard.henderson@linaro.org>
 <ZJCIqmERcjqY+UMu@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZJCIqmERcjqY+UMu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 18:56, Daniel P. Berrangé wrote:
> On Thu, Jun 08, 2023 at 07:23:29PM -0700, Richard Henderson wrote:
>> Start adding infrastructure for accelerating guest AES.
>> Begin with a SubBytes + ShiftRows + AddRoundKey primitive.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   host/include/generic/host/aes-round.h | 16 ++++++++++
>>   include/crypto/aes-round.h            | 44 +++++++++++++++++++++++++++
>>   crypto/aes.c                          | 44 +++++++++++++++++++++++++++
>>   3 files changed, 104 insertions(+)
>>   create mode 100644 host/include/generic/host/aes-round.h
>>   create mode 100644 include/crypto/aes-round.h
>>
>> diff --git a/host/include/generic/host/aes-round.h b/host/include/generic/host/aes-round.h
>> new file mode 100644
>> index 0000000000..19c8505e2b
>> --- /dev/null
>> +++ b/host/include/generic/host/aes-round.h
> 
> Could we put these files under a 'crypto/' subdirectory eg
> 
>    host/include/generic/host/crypto/aes-round.h
> 
> and then add
> 
>    host/include/*/host/crypto
> 
> to MAINTAINERS for 'crypto'.

Certainly.


r~

