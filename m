Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A852AAA60B5
	for <lists+qemu-devel@lfdr.de>; Thu,  1 May 2025 17:24:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVlq-0001ZE-0G; Thu, 01 May 2025 11:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVll-0001Ox-Qt
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:24:15 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVlk-0005T2-9p
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:24:13 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so1117505b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746113050; x=1746717850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oTb37Xh3764UHx4GkunEtiY4YocHVNCV/2Hme8te8Ks=;
 b=BSs/W/e0b5hXgx6CYSrr3qyKE4R6wmqi5aByVG4Sb1csh/sP+EmqXTeXDaaltil/U6
 JKDHsWmPM48/kzhL331mYJAjjEEixp5HssuTrE6FxSDTt9zwcVGpzRKgDAMpuPalaXSv
 L1N14HKEa/JG0N90/eER6NO2Dk5NOJtCNyAy0JV9XZubangnxhXcI1lsslgzc/KXfqiv
 D037PZNw4E2xSck0MKtmWvfoxjPA3cM//vtUXtH8mVATpm4tpi4CMiFaKXYn0kG3qPb9
 fQ81ISwhmU3UgRRl2UhCyG3Js3rzDPLcVwjcuG/1+CSZyopDrcWcHu6oj55GmMhKbesU
 qDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746113050; x=1746717850;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oTb37Xh3764UHx4GkunEtiY4YocHVNCV/2Hme8te8Ks=;
 b=Jyinb2eczTv+JLr9VgHn1QoDNP/WVyhiMIEvHL4sEkgHgyV9HfNK9Z7qtLWXxjCkJS
 WKPgRlI6gO2Ast3SVFbz1im51MsGBchEQ+Pd2B0rLJ6qVMsXQ4fjfNIDg7xeY9rbNeXZ
 CoXta5eTmD0eAyfiC9U4q++UJ2hyvaiGrUMJ2nc72H/doYp5kHEN4tOMj8hYUQe3OPXG
 AzQyryvUumXt+d5RX1ovbzGcrWCWtZ2Ks7XA8Leld7tOu4i3xid3pS6vSa74L0WZzI2B
 tz95l/iCKG6Q3EEgcm7ljPgkVI0mJ68UwOZ3Qk9LyPKxhBTIrPlnBv2suHPNJubUH17W
 uj9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWplVF/q6j4LHz4v2HtmXB7/ZSlg7ta9wfRa5qGTpBcJN8shK2Ll5M1w2aBa0q74+BEuw3kq/AE2yNv@nongnu.org
X-Gm-Message-State: AOJu0YyC4KPUQFLT9X9Ont5I68ZDMgBPuvEcdN7pQNsYbFiTss74F2Bv
 cUZVQfdBSMGLnjDCQ8T8owstL+sOFb9KdtiNsBidcuLYk92ZEx36Lv3dEUsjCg7owZ7Chochdp9
 K
X-Gm-Gg: ASbGnctZVjeAdJz6GpX4866H41M4OgwW4J5ote0sr8vWodEcKaNMMVQF8uz2Hcuuk4Z
 3Trwf1mmr+mi/ALTOh3iz9lWBX+ammcNz8Fv7tddDo+emyXwbiol+PPmU7n/XhJ4IrRgY/xQqq6
 l/el9k9PBpjNE0kf8UcuE+VWgRj7rZzFKNpcRzI74jhcS5jeOf6Qb6AjOru1vB6gMNnusEkWhvD
 Gq2mXc57oe7dsdIRncQ9IbskhHo+MbSoHlnhZxo/i2SUbmcWygsuxPefl4a1xzi2wlV54uzfYEw
 equymK8vdrUdnp6qy9Jc78VHQSFep33kw0OTZHCpsBktl0HT3LgKE4RcNBlY/+4FS1ZgmvujuQs
 qAiY34AI=
X-Google-Smtp-Source: AGHT+IFtYPPoKV22gQdXSnGvoCfMB1I5lAUTgyrS/ys3+0aJbnk8DbbtBSmldZ23PrL2j0wpzoqV4Q==
X-Received: by 2002:a05:6a20:258d:b0:203:de5e:798c with SMTP id
 adf61e73a8af0-20bd6b4b359mr4810347637.18.1746113049768; 
 Thu, 01 May 2025 08:24:09 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404eeb293csm965322b3a.10.2025.05.01.08.24.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:24:09 -0700 (PDT)
Message-ID: <e01f8acb-bf41-4ce3-86be-c576a690aad3@linaro.org>
Date: Thu, 1 May 2025 08:24:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/33] target/arm/arm-powerctl: compile file once
 (system)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-28-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-28-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

