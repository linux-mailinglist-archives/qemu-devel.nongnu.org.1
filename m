Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C357B77ED
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 08:37:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnvVU-00069k-68; Wed, 04 Oct 2023 02:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnvVS-000682-I9
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:37:14 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnvVR-0003O9-1D
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:37:14 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3248ac76acbso1633269f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 23:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696401431; x=1697006231; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Myw/br0NFZQoxEoTVWWgoHqq4kz1AZh0wXYOunhPEY=;
 b=AsrndhEZjYhaVK+L05U5lH8B4wdzjOdpPHl8EBOkCkB2iFYs0dqsFjECdh3OaFn1YK
 itluEUX1dyRaQWQ22CMvYvqIZEmbJVRB4fNay/iJUevdAuTC/sNszQ7kqs3Sc71/stpJ
 deCTLorGEaD5L/T4kGRTMwYcxSUqXyg4cbtDCDSqrq9joeF77U/g7i+lRN6LRxlR7/w4
 qQ9N3J6eiXSXYRh/IhwZAjWfBPCYDQsjNuMEjJmH3+KtHeXkpJCnzeDWu0nv2fvpiKq2
 6OTRL9CMfICb7Mu7t7jWc1qdT0lMbTMa3LGyxRw/wQNGHyvFPrf7xtMUBViU5vj1022I
 dnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696401431; x=1697006231;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Myw/br0NFZQoxEoTVWWgoHqq4kz1AZh0wXYOunhPEY=;
 b=KSSIRaOV+DNbbMNCf9aX44Dyl1SwgFhfN9eOh4KvZe7jqBCcBbi4YJTpdHbn1YdvXt
 1STHwAVRIFvsfP7LJCQww0GwZAojNDPFaPN18qtCK9KpNywCoaE+88mGtZHM7nSxrjKS
 woANF7uQQU4zY6iWkMI4uaOIfyjhRTuy21LazQeZ5GgFJY3+5Wi3VHlw3yrmnOSe0ZCM
 ETTNejssyYBp3MIfBPmRlkMf2MXKVSsBvcKWr2x1YcVCjB/naNl+iCRuARrwejinZ3K7
 US5OxTJq5ZWRFWWv7IP2l37QFijSGZHON1YBotBV0CGGF4cz99FZvDnsxUzVpxXSmNXF
 WgWA==
X-Gm-Message-State: AOJu0YwhmE8YD6FIzx/zBI+ucVo+5Cg0jQE/fl0omg0ZPpLY9gyOmwFb
 kw1UtTVZ5XXD4GUNGaRddOAy7kvBVPtD2tTP6SA=
X-Google-Smtp-Source: AGHT+IHE0Jni6gkVYT9CdZRupRuEyvVEAQ0Ze5E9WPhuTn6zTlxfUmOyeCaFewhqvP/ZBpXq+cCphQ==
X-Received: by 2002:adf:f78e:0:b0:31f:fa1d:898 with SMTP id
 q14-20020adff78e000000b0031ffa1d0898mr1102376wrp.47.1696401431563; 
 Tue, 03 Oct 2023 23:37:11 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 c15-20020a5d63cf000000b003143c9beeaesm3177215wrw.44.2023.10.03.23.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 23:37:11 -0700 (PDT)
Message-ID: <9ec7b1ed-d98d-0255-424e-e65f8e93a1f6@linaro.org>
Date: Wed, 4 Oct 2023 08:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 06/10] tcg/loongarch64: Use tcg_use_softmmu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231003174356.1602279-1-richard.henderson@linaro.org>
 <20231003174356.1602279-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003174356.1602279-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
>   tcg/loongarch64/tcg-target.c.inc | 126 +++++++++++++++----------------
>   1 file changed, 61 insertions(+), 65 deletions(-)

Trivial when reviewing with git-diff --ignore-all-space.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


