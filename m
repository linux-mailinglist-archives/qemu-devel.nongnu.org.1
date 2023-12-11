Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA3780D8AD
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 19:47:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rClJU-000779-Fj; Mon, 11 Dec 2023 13:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rClJP-00076o-Dd
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:47:27 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rClJK-0001aA-J6
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:47:23 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ce7632b032so2576768b3a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 10:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702320441; x=1702925241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T4EVXnFmH+Xbs+DTLFROLXN3bytTK3WSKfs9LgFF1vw=;
 b=BmWGxLMCKnU2oww5Bvs1pKVlShxfVOzJWtEulE+CSiGoVG3GzVtB5OqkZnKVNQ/MMj
 PMf5q3qD0V0bhjQ/AfoTHCfP9hAGZP4XyTD20Ee32xgwMxO0vH06S3j8IKs7fd0EG18h
 7ptZ+usImiC20owphpqmb7rgZOe5y0qXmU2v7PSuxOOxlwpGr/PGu41dJWJUbrmf2WEH
 r3SZ/38j3i2s6Wc8JcijZl9kOhayUTIBhtaruvEUMqKMa9YQ18cUVfbHiFbomZrr4s6Q
 MD7+Bba6GaGEu/Ma1xChhj5XpRhwFDTjHWMsNmKXOjdgDuOaSRVbykAn/Ysl+1NrNWdQ
 luXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702320441; x=1702925241;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T4EVXnFmH+Xbs+DTLFROLXN3bytTK3WSKfs9LgFF1vw=;
 b=L0Pn+QjD5vQZ6/VYMmSj3Aq0Q6VlLvMfON9iybr0+UwKpwvJ55wlYFPElJSGs11tht
 VPkmaprzw+afwbEKXx+6UsF5QSmP5jWWDinF/bNKuwpSfYZyvy8x8A2Qas61X8wdMSRx
 QJFNGwjn2ebY5/uqrge2qZbnef/c/jvKKFhimi0VBGTQuDjET5DU0LLSXc7+LWlzMIBt
 A3R1QyvdkuDU2BaHID3gXhY4paNEAlfQzE8yOZkzbUBN8E3FtyNGfM+8iZMHh2k9qNQn
 eCRn5168BJ/4A3CBFJLP4+0bd891J5EHrCTNqf7d+RuuvF0bTp400WF6ZSecrrITRSYU
 6bww==
X-Gm-Message-State: AOJu0YzS4bYvgdL8gEmcq8MfjGwHJ7jFyqye1MnGPrLcvaW1ieKm+Drq
 JIfHhO8vj4ZESBT/Ed+M3lHiJg==
X-Google-Smtp-Source: AGHT+IHBhMfGmKLr4tXwhUbEe3Yo08xwKU+IwPsVR9fRfkO2f+DARzLWwYCS6eCQPUeFgyfeTGQa9g==
X-Received: by 2002:a05:6a20:6a1f:b0:190:fca:72d7 with SMTP id
 p31-20020a056a206a1f00b001900fca72d7mr2390449pzk.90.1702320440972; 
 Mon, 11 Dec 2023 10:47:20 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a056a000b8400b006ce5bb61a60sm6582307pfj.35.2023.12.11.10.47.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 10:47:20 -0800 (PST)
Message-ID: <c7189f3b-7ef6-481c-a0ca-4f14f6e0e1ce@linaro.org>
Date: Mon, 11 Dec 2023 10:47:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] tcg: Make tb_cflags() usable from target-agnostic
 code
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20231208003754.3688038-1-iii@linux.ibm.com>
 <20231208003754.3688038-3-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231208003754.3688038-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/7/23 16:35, Ilya Leoshkevich wrote:
> Currently tb_cflags() is defined in exec-all.h, which is not usable
> from target-agnostic code. Move it to translation-block.h, which is.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   include/exec/exec-all.h          | 6 ------
>   include/exec/translation-block.h | 6 ++++++
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

