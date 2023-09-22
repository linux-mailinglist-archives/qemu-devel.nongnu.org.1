Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3147AB8FE
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 20:19:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjkk5-0001sr-5j; Fri, 22 Sep 2023 14:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjkjy-0001sd-NK
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:18:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjkjx-0000Fg-8y
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:18:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4054496bde3so6451085e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 11:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695406735; x=1696011535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ODcpRojcFSQZybYDFJK/kN/z5j6IhI6MZPjfKtld4GA=;
 b=Ym5o3hrxf0hVup2M42o1/K8slUUMZZX0Xq3tysxEWJu2BRQepFGYYcJVg6WP7MyS+E
 EHEapd2HVhRdioyf5wbMrCXSoN9UigpNvN5Wtt1m1XlYMjPEc8wbsA6KNmwaVlEltN1d
 knNxz0tfPshe8VTRr5Beog0Yr31jQn0Li3O5nDBMutg2tCwx4RVpm1BSOM1dcP7CarVx
 08JheEd6TTbIeEbAEjqHzkz54dDkFBgEPYsPh36GjR85mW0TKCGhyBXzbrYktnkIbQCn
 oRmoCqUItMN1sHJ+cI8O7i7QoGHk+QjbfNeVosbz6vtV5OY/fg+Nhb66MATHPZqF9MfZ
 Xytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695406735; x=1696011535;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ODcpRojcFSQZybYDFJK/kN/z5j6IhI6MZPjfKtld4GA=;
 b=pUggWmcu72aYjopx3+LRuFG8jLQ6sEXmtJ7hp6LCsEqplIQs4z7KNXwxD8mTPJWTfo
 Yt6dEQ7/nfGIdhRQx53ek/8p0rz6vWG8kvrka3EH61Yp8qPq+AN0WAqPAbAaltThuTop
 1LA6g0Lpbtbh+m1uVcJ3JfINHAEQ8XxpuL7ClnZhiH3rPSc/hUfsu9sgXoUvL7hkoe3v
 7JLaUEJYHdN5HRfElrdmui36k2NrnC3MJjFavbRPVXbh+Wnw0bkzkYnwtStIFDcj4V05
 /8H2ZUf5kaQ/aLH5gNt8FpGuFfYALBwwciFFROWBLInrKXlMJhLj06R+gcHs1uDozf9P
 f3yg==
X-Gm-Message-State: AOJu0YxToLHdrevd6BCRq3ZbjmZeGzRDUTDqrg3/a1cAUPMfoylX7kSO
 NvP9fX1tCJkNosII9o9pMUV4Iw==
X-Google-Smtp-Source: AGHT+IG92eESexkOrgXdx0q8KLr2S7amEiOnxGnXqn7Us5QE6GoLUY6wlUuSQ/JJyK1CCMuIOSw4MQ==
X-Received: by 2002:a05:600c:2294:b0:405:3803:558a with SMTP id
 20-20020a05600c229400b004053803558amr123261wmf.12.1695406735604; 
 Fri, 22 Sep 2023 11:18:55 -0700 (PDT)
Received: from [192.168.192.175] (181.red-88-28-23.dynamicip.rima-tde.net.
 [88.28.23.181]) by smtp.gmail.com with ESMTPSA id
 5-20020a05600c26c500b004030e8ff964sm4314050wmv.34.2023.09.22.11.18.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 11:18:55 -0700 (PDT)
Message-ID: <e52b8758-e81b-f453-6e92-6c29f57f3cf3@linaro.org>
Date: Fri, 22 Sep 2023 20:15:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] crypto: remove shadowed 'ret' variable
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
References: <20230922160644.438631-1-berrange@redhat.com>
 <20230922160644.438631-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230922160644.438631-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

On 22/9/23 18:06, Daniel P. Berrangé wrote:
> Both instances of 'ret' are used to store a gnutls API return code.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/tls-cipher-suites.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


