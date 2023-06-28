Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAF8740D13
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 11:38:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qERcm-0000If-2b; Wed, 28 Jun 2023 05:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qERck-0000I0-OZ
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 05:38:06 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qERcj-0000EX-4j
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 05:38:06 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4fb5bcb9a28so5236836e87.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 02:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687945083; x=1690537083;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+6z8E1SMBrZzbp+SZ6I854q5fc7Ogya2NUiGqFWqPoQ=;
 b=ll6r4lSELacvK+hoDvRarKWSJInsNaif886KZm7y3TBzH9+m2z7dRGFkxnvTNmkvz9
 5ydXNUhuiuNMyaCAg/I5hBoKUpvBlMNTG/9dkw5Lxoj9aUculArGruOlLeqhRvvYK+TF
 B3HnIGq37w4IL3bb+QGApAnGV0pLMOT78MzCoq+m6YGXKMMD0ufrEC0N6oOg9+T7bhqc
 InCoT6bg/2u3QmoCEMH605c8BZMFLy6AlC+y9but2Vs75J2EsCSEnvfPGNxoBUCon1eQ
 UjyT3OTWpiYrFIO2CeRddtaVtRi4F73+jstZ1Hw3qErYe1bysTSlIksDd26Vxp654Y02
 CQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687945083; x=1690537083;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+6z8E1SMBrZzbp+SZ6I854q5fc7Ogya2NUiGqFWqPoQ=;
 b=VM1ApwDAPlpQqkcxOZyOwHI+wBvI6/YPAulcS7YRoq/tXnZBV/QZIyvl96v2KqVHed
 1ZfvYJaDD+AqtMBGIFQyqrEtOhWxuh8jrxHhAj1XI2/YxBc6AhSHFhivVnq0ceij2uI3
 JgYj9CEpuqRgXDdCA29Hil34g4ivgQdxLKXU5ZvOaMruKyJxiWeY7k/kUk0wj7kgSQNM
 +gqOOWyABgG71ZERavJKjkOI9+aGUH3OPJifPvuxQlhfirbWKdxxeT92CDrya2xoSFUR
 /KqO+BIXMKZXicSBQo4aIoGH7MZN/XGf4cTpsM7/1BWRjNT1Ltsvbp5nHfEQ8XOaqmSV
 a6MA==
X-Gm-Message-State: AC+VfDweJXERKWOVX1J7U8MG03qJZn2mvFnJPDXpzG/mJj+MJ1q0Srld
 ORSY/E6MqLQ2a1WFcjEXF1huOA==
X-Google-Smtp-Source: ACHHUZ6pNLD9Dn4YypUJ6l8eo4T8GkKrfDpi7wgwXWDybtdb2Ri+LDkyUdLtW1Kzx6z03PUiTNjdVg==
X-Received: by 2002:a19:4f54:0:b0:4f8:5d94:2e46 with SMTP id
 a20-20020a194f54000000b004f85d942e46mr11510809lfk.48.1687945083211; 
 Wed, 28 Jun 2023 02:38:03 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 er8-20020a05600c84c800b003f7f475c3bcsm5373913wmb.1.2023.06.28.02.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 02:38:02 -0700 (PDT)
Message-ID: <32a75db0-381d-9a55-05ec-047bf40f3300@linaro.org>
Date: Wed, 28 Jun 2023 11:38:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/4] target/ppc: Implement attn instruction on BookS
 64-bit processors
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230627134644.260663-1-npiggin@gmail.com>
 <20230627134644.260663-5-npiggin@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230627134644.260663-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 6/27/23 15:46, Nicholas Piggin wrote:
> +DEF_HELPER_1(attn, void, env)

s/void/noreturn/


r~

