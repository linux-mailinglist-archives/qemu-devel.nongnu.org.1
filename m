Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50963AA5434
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Apr 2025 20:52:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACW5-0003Lg-Py; Wed, 30 Apr 2025 14:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACW4-0003LL-5O
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:50:44 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACW1-0008HB-Cl
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:50:43 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso308132b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 11:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746039039; x=1746643839; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kxcQui2TsUuv+ajrRAy8NIbvBPz1PBp9QglH+YxsXIk=;
 b=MTa5qsQvlEohHGF8iS8/EshwacVQSpDQv9YNBB+B+tNjrKq6vIkl3cETHP9JmRoPS4
 R/8ISyqtb+a2VgCryD1Xf+URB/9IfqHnbbHxSMuJ59jisJqXyG6JzgmUwBzNHbNL5qq5
 qVVAzPYEJHUsrTuK04HHaZ2CGa0ryeUSrw08jogwFAli6Cly87kh7ZrYk3CRx2JL0F8m
 gNpBhU7zRO2UeQdTHZqwTLOwuWkpOZjcXQnQny7r71f4rI9EnWjAstpTNRnUEb46eZ7j
 KuO8Mcx/3AbCBQG3awNkU+Kw423NZvlM/8y7P0dAMvRibCjZLYgC05B3wfinUfmAf7kM
 f/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746039039; x=1746643839;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kxcQui2TsUuv+ajrRAy8NIbvBPz1PBp9QglH+YxsXIk=;
 b=irslDmCyBRQIbMfCSdyy7DlV1xvFMJReTmVfv+BEz598ZfZOpf6lsW8h57+xj7jG5n
 TniyN0Ngd+koOndMThm8+QKGqxWg7xazBeTN/T45akAxTQxmJS1EowwMmYtqRTLEIYPM
 +qGbWS1ZhyRMiYdTd+nI9908rRh3C1cVsShDKdOwsI44padOTFcPUG5o7DOmZtSQGdpL
 3ogUNj84R3RrClMqFrIzXzRfy0MitK1az/1wEVoCqCpbuDH9LozFo0hoX841O6VTzTts
 1nIu8UiqWuT9tMIkA2Jh+DaSW0HQBuY5xFAYKbxraoGCjr+qDCiJ6Ys/yqEKOSjgKAhw
 y2rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX32ESDiAYTlkHZuwxjY1dOzsg34mIQEFcxmWGuVtsf2CrFNLVsClxKOXyPN6D9NzrKp3c6vmCVrlEr@nongnu.org
X-Gm-Message-State: AOJu0YysZCXZM/NB30HB+WO1s89OYfAnA8tRzUG9eMpttQp7CRcuj4TT
 bqfVyIKaCnzT6MXuX6x6eHMIRj3ptyr0nZX6JWQezlpeX7E5/09yDcgSZMjHG7o=
X-Gm-Gg: ASbGncsxOVmr4nZ1ca6S2ZrJBTLU5JN3+MSvvIJ7UO7ooLcY8V0CNEJ+ryBDM8WCH4/
 VyHMCMsevsGds1JF++KWjUQTF7zOLZh7CJR9NXxeiezdU8N9xekC5abXd6UVx/QqZIQurNh/8yr
 i07KKQF8R1K6eqn/+Xox17Kzk8kWnGGA4e8uwnLdMtZXrB/z6OJzyYQ99/up6+yIx/WzipwGDan
 sdvb4WA/dTWIMsQYBPv/UqhCm4meqP/2pUhjVTxtgCYdhogdRZVT26wge9dC/vJqe74X/5/hDXt
 6ciFPI+xdgnxEYO+N+RmvVm7bPXwTYog3IgJu4HwADFCxFpnfXwLWM4H4BuN4HEtlu2qGUwbg/L
 kkKxEbZQ=
X-Google-Smtp-Source: AGHT+IHG+YHTZIvzJHIaptMbcm9aiLNqhmOhTm+WK5TjZVos2qoZOf+1YY8G4Z8bsdWit9hM/8svoQ==
X-Received: by 2002:a05:6a00:3a09:b0:736:3e50:bfec with SMTP id
 d2e1a72fcca58-7404777ecd5mr85495b3a.8.1746039039225; 
 Wed, 30 Apr 2025 11:50:39 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039a5bde6sm2012103b3a.127.2025.04.30.11.50.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 11:50:38 -0700 (PDT)
Message-ID: <e77b5c7d-5f6b-46e8-ad68-207ae87a07dc@linaro.org>
Date: Wed, 30 Apr 2025 11:50:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] target/arm/cpu: compile file twice (user,
 system) only
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, anjo@rev.ng
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
 <20250430145838.1790471-12-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250430145838.1790471-12-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 4/30/25 07:58, Pierrick Bouvier wrote:
> +arm_common_system_ss.add(files('cpu.c'), capstone)

I wonder if we should inherit these dependencies from common_ss or system_ss?


r~

