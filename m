Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAF77A1CD7
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 12:55:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh6SB-0002IQ-JS; Fri, 15 Sep 2023 06:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh6S9-0002HO-7M
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 06:53:37 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh6S7-0000hv-Ct
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 06:53:36 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9adcb89b48bso86024366b.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 03:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694775214; x=1695380014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E4k7cQeZxV8vUXswzcTiTHVdLI1rOf5ExfLEQo9DK5g=;
 b=XVGLdIE5iRD6rEWff43ox607CRmxpmN/ffhDWX9PuJSfTK7fPK1UafhDn3/wld5Ezs
 Xwqc0PHgqwS1KFbck+HlU79JDkn+SCjxklg6iADuIepKQiB9KvwRQkTakJADhpPFeCe2
 /PaziHXIU15zRPcuqmOUcBDEFGmaQ5F7gmXxzaPwsqy6FbHCPkC+dnv/9Tr1S09QPkUl
 pOCJnmW0w2LDI8HbJ/p9JftBAmTFF5J6ruHPL60VmCIo3NLk036+A6MFI2wIE5S+osg0
 RxKRYoxpeeyJBVl7RsDxdxVZwXr0b4ByHoeTt7v3jg9XaP/auPNCp3J1L/8L0w4IUzSA
 cAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694775214; x=1695380014;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E4k7cQeZxV8vUXswzcTiTHVdLI1rOf5ExfLEQo9DK5g=;
 b=pBhuckUWqiiVxW0NMqiFYgJOFa6RziV8I1MvCdi2Vb11p/aENtPP4RcnRhEYL1irwN
 cldG47MjbhJY/ZJlq+JuIKIpSU3XfFHRbgx4y8kw7EowUs53gTVETFOgCp4fosYAzi6V
 wWZiw62Jav2UEEBZm5CEeqQk2+XacLd/c8YFjGIjjPJGXT9C82JjR0xvEetS1h1ozMNd
 KZ9LtBhNpWlutzf7fVHabCtpsHUxxJTV5bENA5gcVd53X8v3lexscqgvba3Nu1nwdWN3
 c1MtwyqsNqntQtQbtv3SW67wXS/yCjKrB5OQnM8TbFCiUOAcyIvpofhz6fOVJv18lqOV
 AKgQ==
X-Gm-Message-State: AOJu0Yyp6XjlQ8k6nUKjlJRRuPanbFjp2znuu5Rm+Nywszbo2PjyZMC7
 zJgR0pGiaTLKyNDanCB/sMWtMg==
X-Google-Smtp-Source: AGHT+IEbiIeZO2ns0sCFVueryz1hVV7LfgjNMta4jLZVD8e43xBC/1JUv9IMwXwZlD5k34IZ1KQV9Q==
X-Received: by 2002:a17:906:cc15:b0:9a9:e73a:3dd4 with SMTP id
 ml21-20020a170906cc1500b009a9e73a3dd4mr967955ejb.64.1694775213841; 
 Fri, 15 Sep 2023 03:53:33 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 w15-20020a17090633cf00b009944e955e19sm2238018eja.30.2023.09.15.03.53.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 03:53:33 -0700 (PDT)
Message-ID: <242dc7bd-f0c4-d58c-fc6a-f3ddc0168bf2@linaro.org>
Date: Fri, 15 Sep 2023 12:53:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/9] tests: update Debian images to Bookworm
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cleber Rosa <crosa@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230914155422.426639-1-alex.bennee@linaro.org>
 <20230914155422.426639-2-alex.bennee@linaro.org>
 <30ac04ad-eb02-90ad-57ff-089538413602@linaro.org>
 <ZQQi6n+3mp+bQIgu@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZQQi6n+3mp+bQIgu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 15/9/23 11:24, Daniel P. Berrangé wrote:
> On Fri, Sep 15, 2023 at 11:14:29AM +0200, Philippe Mathieu-Daudé wrote:
>> On 14/9/23 17:54, Alex Bennée wrote:
>>> Bookworm has been out a while now. Time to update our containers to
>>> the current stable. This requires the latest lcitool repo so update
>>> the sub-module too.
>>>
>>> For some reason the MIPs containers won't build so skip those for now.
>>
>> Debian removed mipsel:
>> https://lists.debian.org/debian-devel-announce/2023/09/msg00000.html
>> https://lists.debian.org/debian-release/2019/08/msg00582.html ...
> 
> Wwith our general aim to support latest release, plus the previous
> release (capped to a maximum of 2 years), we can still consider
> mipsel supportable in QEMU CI by sticking with oldstable (Bullseye)
> for the mipsel containers.
> 
> Once Debian 13 comes out, however, we'll be discarding Bullseye
> from CI and so we'll be unable to do CI for mipsel. At the very
> least this means we'll consider mipsel to be downgraded in terms
> of supportability when that happens. We might then consider
> explicitly dropping it as a buld target entirely, as the writing
> is on the wall for 32-bit OS platforms in general...

I'm fine with dropping system emulation on 32-bit hosts, but a bit
reluctant to drop user emulation there. Anyhow I agree with our
distrib releases support rules, so the mipsel buildsys part is
effectively condemned.

