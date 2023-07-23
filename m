Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4E875E3DC
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 18:31:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNbyV-0004Hq-C8; Sun, 23 Jul 2023 12:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNbyP-0004HR-6f
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 12:30:22 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNbyL-00025A-AW
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 12:30:19 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-316eabffaa6so2448601f8f.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 09:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690129815; x=1690734615;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l8YjtkArDdH15tZsTImBTdb7zzzhluJQo97pvzZEK3g=;
 b=mvzJ18et/EaBTFEjcbL8jPZ1u2tNBflDh2K3y48UqtWiUvGd7pevBv/Nhn7hxVtkU2
 AmDI7rWSi50/iZxy/nIOOy3PU7phT8WceCqAB3Wot2yVY0GRwmMJF2kiZX4CXVd2KAU8
 tIcabiHH0Fd8qdj6gl2aCkRJxULl0aFFOEvUD6zT1LoFZcfCPtdfAUjyaH7vfebiPaeQ
 f9Yc8Tptv1tFsIpRDdN+jLlkD08jGHfso2jMkWgaDmR5fk1BU5uyIleI3ED6sy2vjGzR
 0UAsPhHkctw/t5aaXlOvvOssA7Si2Kw9UP02kbryjXD1Azsq0jmHRzncU6JH9BIXB3mo
 AQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690129815; x=1690734615;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l8YjtkArDdH15tZsTImBTdb7zzzhluJQo97pvzZEK3g=;
 b=hT6ezvuFF1Pahq8VU4Rx+wf/4G3UOGVRaQtUQB7W8YQIFOUR09nceVpj5T8KG3azd/
 25bEfOcLLxIkB6DzefvNKBH9CMmnHY65ECGjyk88tir+XhglR2V0asL07q7O72r9R17E
 bBKxV8e879wqQ76sznyi3aVd8ryFiHMjzJBHC97ERq9wRp6UQpv/96eiIKlf2kwHuaAS
 bM/x5Yh8kqRUHxVPJKqtrB4UVelANUjFSFUCbAKx7gDEx2OBpRSpE1R5US9nvE+IcMOK
 0tz8Uf8PsJr8pHklGNKeKycanf4G648B56truf6bmkfXBQbyy0fUyFM4YcY1M/pGQV0l
 +KUQ==
X-Gm-Message-State: ABy/qLZnLXalZcS0bHF8mnnn1pu1lgc9u0HBQCy4bjbsrqKiJjO55SqP
 IeUQIb6hrBCnNrwPi09Mxx5s+g==
X-Google-Smtp-Source: APBJJlGX947LVQXNRU1Dhou2UF4JLRGNjlzQt2q73IaRPmAZ1O+zX2ACtPlAP1hkK2b3Hc1yDRg3Fg==
X-Received: by 2002:adf:e68d:0:b0:313:f8de:1ff6 with SMTP id
 r13-20020adfe68d000000b00313f8de1ff6mr4985833wrm.51.1690129814688; 
 Sun, 23 Jul 2023 09:30:14 -0700 (PDT)
Received: from [172.20.2.0] (179.181-106-213.static.virginmediabusiness.co.uk.
 [213.106.181.179]) by smtp.gmail.com with ESMTPSA id
 o5-20020a5d6845000000b0031435731dfasm10116410wrw.35.2023.07.23.09.30.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 09:30:14 -0700 (PDT)
Message-ID: <e1816d89-80f8-020a-65b3-4dc804c1818c@linaro.org>
Date: Sun, 23 Jul 2023 17:30:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 04/14] target/s390x: Fix ICM with M3=0
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230719221310.1968845-1-iii@linux.ibm.com>
 <20230719221310.1968845-5-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230719221310.1968845-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 7/19/23 23:11, Ilya Leoshkevich wrote:
> When the mask is zero, access exceptions should still be recognized for
> 1 byte at the second-operand address. CC should be set to 0.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: e023e832d0ac ("s390x: translate engine for s390x CPU")
> Reviewed-by: David Hildenbrand<david@redhat.com>
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   target/s390x/tcg/translate.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

