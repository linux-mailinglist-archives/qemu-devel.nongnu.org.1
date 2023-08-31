Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB3978F09C
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 17:53:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbjyR-0006rB-M9; Thu, 31 Aug 2023 11:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbjyP-0006pG-5z
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 11:52:45 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbjyN-0006gh-3x
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 11:52:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bf1935f6c2so6324885ad.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 08:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693497160; x=1694101960; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LKD9qFqmFZitD6OLdD4lyfJU5OvuNlWNTHaaowmgB/k=;
 b=kisHzaJOzCh5WqTc1lngN4eqnp7Yj2pIERB60ZYPYhf/Ag9qMnwP6fi+92YJbHV32n
 sR88ahQ8LVTYrY0ExhnlRwtTud0ror2qyCETjWBin5ulPPeVyRDgpYmYir+l+CRqFD4l
 LREE+x1BP40l8tfxAeu7KihJmbQ/U4A8Y9Fusso8w3s/2JPBiZQ3gkhDPKj3BPSpjItN
 Q9AXNl5r/IWZ+9FjETxeHmw2HDGhyz9xkHr2EAu6YtHUCcwC7g0R+oZIlRNITFR1SlKm
 u1gyMxsTm7US/1BLT6szAUbEex3vTt+0aA6S117Pa/fhc39Xr9rVDH+Q1AwLhqxQf3xK
 F5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693497160; x=1694101960;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LKD9qFqmFZitD6OLdD4lyfJU5OvuNlWNTHaaowmgB/k=;
 b=aS1nAaJZv3QwW/GYehHt1z68I4owSKNuwcAA1Wy2Pa7JuO+TFKM+7R5baFFRN/hJvH
 pvcOorAgXoX9QeGxP9nESsmsXs7K41NmSaiLMRSrWkWApJUrVSUK4ThvsxfN5keh2pth
 3y2xSffsaG69JfyTv/9RLjIHBXtWU3iYNKoWcjWJ0E2dOJrj5hzBt2Jt2WXsvw7Qx80N
 tCvvYYgz/KaxrKU0QvZinqn/VCXgVRcnuAGzARcQyjF69sg/9R/u3ejJuIXI0Q+9WXnY
 1twA5kgLLzGNMW00s2bG+3zQOMt0FiwAXjVF9ZAb0j5IIns22JJnK5QZUx4xWpPZXbZy
 x74Q==
X-Gm-Message-State: AOJu0YwYRVAcEkV9KyllCZ+ZsxJ9wQPfORgDVLFxv5z2bP9c8439nW50
 +hQX+EpTDFKjxupMkIJ/kxvb+Q==
X-Google-Smtp-Source: AGHT+IERCFmBzPxmrXgph50c3mHgrBYUSn0DLvtBvq9JrAm6Gygg3BxcyumHn3cIkJw7JhXYSOUQaw==
X-Received: by 2002:a17:902:d4c9:b0:1bc:1e17:6d70 with SMTP id
 o9-20020a170902d4c900b001bc1e176d70mr135168plg.24.1693497160385; 
 Thu, 31 Aug 2023 08:52:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a170902704a00b001b9da8b4eb7sm1413156plt.35.2023.08.31.08.52.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 08:52:38 -0700 (PDT)
Message-ID: <f751ab27-2d6e-19a2-a0bc-ca021a61a8f4@linaro.org>
Date: Thu, 31 Aug 2023 08:52:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 7/7] qobject atomics osdep: Make a few macros more hygienic
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, idryomov@gmail.com, pl@kamp.de,
 sw@weilnetz.de, sstabellini@kernel.org, anthony.perard@citrix.com,
 paul@xen.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, thuth@redhat.com, philmd@linaro.org,
 stefanha@redhat.com, fam@euphon.net, quintela@redhat.com, peterx@redhat.com,
 leobras@redhat.com, kraxel@redhat.com, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-8-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230831132546.3525721-8-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

On 8/31/23 06:25, Markus Armbruster wrote:
> +#define PASTE(a, b) a##b

We already have glue() in qemu/compiler.h.

The rest of it looks quite sensible.


r~

