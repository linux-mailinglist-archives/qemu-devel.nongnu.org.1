Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B9F779E43
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 10:47:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUkG0-0002vd-8A; Sat, 12 Aug 2023 04:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qUkFw-0002vM-Rp
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 04:45:56 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qUkFu-00026G-RP
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 04:45:56 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fe61ae020bso4197973e87.2
 for <qemu-devel@nongnu.org>; Sat, 12 Aug 2023 01:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691829951; x=1692434751;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uOj26Cg9xYPNQPkoDTqc21lgCw3pSjFYE9bi+12r7Hc=;
 b=ml1D7IsspZhy4iIBhuuyHt9EMaJuCpPi7AmUTj5NqEJUjVA/j8L2CdxEi3bcgpGqtF
 SBW4scEgOaJZrNFM/Mz2IxcJB+BdAqc4kOENWdvF9vWy6AKDWPc4qiUpauxHXkJfCjmo
 ev86WqA0tei5WSe8tkpTu3p/AoGOmDGzobCn57HSXCURaJMqY9AaFW8qDvHz000sga7H
 VdJktMr34Bv+e78wjmP910uVCyTycFGrWosYKXWyjPPH9+5QlG8u0j4OtKpTReRfN4JW
 X63oViKHdFGtNsJGeSXaBxTThXfqxpnry2GgF30m5Ystk5LgUUYTnwD5It3KX6MwRK2j
 jvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691829951; x=1692434751;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uOj26Cg9xYPNQPkoDTqc21lgCw3pSjFYE9bi+12r7Hc=;
 b=KZu+ZyhTCFXC5ahMKioMCe3n3CzI1y6HY9IN+PHmCILFV6ZhVb7Uhy+VBOT5X/npyF
 i17+0x5XWX6PzVyIAEYJFsVZOmtZ5xMGDLyK52i7lNP+GqlsV/X7WAdd0/v1RLztvJjb
 OL2b7YXjNzXP9wDZ5vZrGqwCC1Pga+DyAVAM0xW5ZGyPTq4dUQXOWMWYnujcLhIp+JZ/
 ui4G6IqwmEIOdsod+a9ovktguYDcRPS5eoEukJ5l9t4CzxJyjI8ujmSZgFM7JaJqH2ev
 zL2Ncx0sd5+SLSPY6zjeXQb7Qmtb6+8cU30wmefJxsPhNttBGia/DtcV8qeLOSV/nJ8a
 WvbQ==
X-Gm-Message-State: AOJu0YydiXqrTE9+bUHCtj7s/468ZOxD/MTi3E6/z5VVRQ28sl9iWhj+
 oroAVvfnskEqT7IfNoM16En/RQ==
X-Google-Smtp-Source: AGHT+IEAx5tulEk0l/dXsk4RIoONtc4AHzvlkUpmgNzVePzMzMSzpt5DCh8veCv+bbHbBD6Bq35qmA==
X-Received: by 2002:a05:6512:1051:b0:4fb:744e:17db with SMTP id
 c17-20020a056512105100b004fb744e17dbmr3545063lfb.1.1691829951509; 
 Sat, 12 Aug 2023 01:45:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.219.164])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a05600c19d000b003fe1b3e0852sm8285954wmq.0.2023.08.12.01.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Aug 2023 01:45:50 -0700 (PDT)
Message-ID: <c97f6139-924c-f38f-9fa1-95efc3a5c5c7@linaro.org>
Date: Sat, 12 Aug 2023 10:45:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] meson: Fix MESONINTROSPECT parsing
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
References: <20230812061540.5398-1-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230812061540.5398-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.972,
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

On 12/8/23 08:15, Akihiko Odaki wrote:
> The arguments in MESONINTROSPECT are quoted with shlex.quote() so it
> must be parsed with shlex.split().
> 
> Fixes: cf60ccc330 ("cutils: Introduce bundle mechanism")
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   scripts/symlink-install-tree.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



