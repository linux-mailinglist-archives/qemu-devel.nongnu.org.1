Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9024C7A0B78
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 19:22:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgq1n-0004Mb-QM; Thu, 14 Sep 2023 13:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgq1i-0004La-8j
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:21:14 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgq1g-0002Pr-Ou
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:21:14 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4ff8f2630e3so2161727e87.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694712071; x=1695316871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YaZwKKFNBvaScjwndwG7Qbor/60HG7c3Yvxm6lplfXc=;
 b=FQ/Ay5lWon0h8NPaEMI/Q/gy86HEsWJiXr1YbBhU+dNE9tqnYzqFSrrrSBlDeNtznZ
 0voIIfSeno+Q739IX153zWa1VabNCjqHvaxpAhEV18252qQyHZpQ27TsaFYZ5K+Yty5X
 BCy31KRL5bkAxHM0OwJ54JTWTNKFfpa7k0nDZXWThcLqQHnP7VtTYlD1C2/406RICYNV
 W8DbRjedjpgChx0L3EheN/H/h2lXZOpWsDyaeHn4WvYq2WGMiWk/g0wuTDQydZwBlKet
 Z0OOkPrNGPj4cHnFV9bOLePFIPo/1lObJIe+qVESc2EtBLTtPlJinutPjhORVxGBQrr2
 xkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694712071; x=1695316871;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YaZwKKFNBvaScjwndwG7Qbor/60HG7c3Yvxm6lplfXc=;
 b=fP+4UQ/EQTyedkRD48FY/PIHW+XYgmKU9S3w8q3tYm0QF7WGzy9+TyFphEWxsd9Y1u
 HUfI1oY9bHgQLoabP3ylvfc5djUI8GnwpJHcUCsOkxrIirE8dYe0Gb/xfHprjXGlf5x9
 ZiyHwoMOZdHOvY5cGOu4YjyQ1WT73nGoaIPFy+czTYSCfKbBhsw8r5JuPTB85eB55Lpa
 9UYuwmQR65a7Jc83dvEgYl6j8Pxf/4EFvhbWx1jXmnmiiRA97GD3jZNDI9NjVFY0o46H
 LsEGlYzo9hUvDN8b4FwR832kQP2c38IC+0TuUPDrPhQURHL7eQNGjubSyZBo6xL2jiPv
 0S1w==
X-Gm-Message-State: AOJu0Yyxqe0Q+LX4mHS4sMkrGT8WZeYJwOJWxl3r1XQoLI8A9U/h7gDJ
 LtTDUQYvh6kTzVKti8tYV0Biig==
X-Google-Smtp-Source: AGHT+IEnI5WIX+XU6f1bfZhrN2yN9bOj0UHNTm8jQPZZw+9/j9kwj5pYdeq9vZfnDy73k2Fgp6T4eA==
X-Received: by 2002:a05:6512:3d0e:b0:500:9ab8:b790 with SMTP id
 d14-20020a0565123d0e00b005009ab8b790mr5725765lfv.60.1694712070211; 
 Thu, 14 Sep 2023 10:21:10 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 z15-20020a1709060acf00b0098d2d219649sm1285399ejf.174.2023.09.14.10.21.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 10:21:09 -0700 (PDT)
Message-ID: <b707a129-5881-430d-708f-00687ae724ca@linaro.org>
Date: Thu, 14 Sep 2023 19:21:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 2/9] gitlab: fix typo/spelling in comments
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Joel Stanley <joel@jms.id.au>,
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
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230914155422.426639-1-alex.bennee@linaro.org>
 <20230914155422.426639-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914155422.426639-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

On 14/9/23 17:54, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/base.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


