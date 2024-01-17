Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BDE830063
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 08:13:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ07H-0000gA-2l; Wed, 17 Jan 2024 02:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ07E-0000cw-Pb
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:13:36 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ07C-0003cA-Vj
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:13:36 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-559d38951f2so645472a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 23:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705475613; x=1706080413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gVFzcLJfzV01y6vPNrbUH5ZJZowKBkPUeC1SDW9GfUg=;
 b=gMK4MGi8syyCcxGJyV8aO0dIWBXXWxoKzTOkLPxy9aKvOJGQHKwMv8sCXMXBcj9OLc
 2DetH6scyfYS75nMAHRlkSLZjtsDaNCQud40xWu9IxjnH5eN0D1UlaEuaR9C3k+rUCx+
 PFdocL13i7eSoIZ9gIfUg6Pz4R2g0lbjQT+3mxDYjeAMLRtpmpKcEaucyEEOL5/kYYcS
 YKRhTmOwJ6V2teuBxC2SHeDBI7m3gV8AhLJc2XdkjG0JBdbwCtJPpB9S2GRpOdA/T58L
 uD5vC5Wec9AP95HqM7ZCs33q18I0WGNBl4tj+i8YUcJwPHr4PWEgIi+TcMN8fppRJlS9
 j4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705475613; x=1706080413;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gVFzcLJfzV01y6vPNrbUH5ZJZowKBkPUeC1SDW9GfUg=;
 b=WJ/zTJVwM7JKCJJOHV8uDmGOlwYxYl+Rak1pzHewiPCW4/EOA6Uax5uu0Qd4/e01Uc
 TktGOU2k00dSriNnY2WvDW/beQfGDaJ5jSc06jcq00hZjhwlmbzjmiM09pmeTCAPayrg
 aS3FMrMZohiqOIVBn7FMSPDK8LD0i29flYDNfQOzkfsx/Ntc+5T+3G/+ZIAEBlhH10rb
 OFBJKEDYoIXhlmMwGb/OuRo903Z18570WgWsYGTEFC+DtJoWdNlGefmy5HW1fIfyF4aD
 OoTel6/g9LieYNVxoJMShrCudMVNzL1cLFQdrccZtFghoRdqA+Ba0xMVa/FovRJt/Uic
 SvAg==
X-Gm-Message-State: AOJu0YxcVpjGOjETRADszGbCLTcLXqkVzuftwoyxhKFIVjfAd/WNF3vP
 gFn4wJ/8C91RutERrjOy9n7nL8ddc2I1zUzqMBso8dyAAEJKG/2lDc2zMM0kVFc=
X-Google-Smtp-Source: AGHT+IEmvd8UUuep1vsupxd8wEIyaN/pRw7LYREEEyfRvFR2VHLynlvMgpg8u9E+3BrEzDGpUCRqsA==
X-Received: by 2002:a05:6402:3099:b0:559:3b49:4a14 with SMTP id
 de25-20020a056402309900b005593b494a14mr452929edb.9.1705475613105; 
 Tue, 16 Jan 2024 23:13:33 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 q9-20020aa7cc09000000b00558a3e892b3sm7550911edt.41.2024.01.16.23.13.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 23:13:32 -0800 (PST)
Message-ID: <893c8cd4-cb1e-4fb6-879c-38c6c61e3451@linaro.org>
Date: Wed, 17 Jan 2024 08:13:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Error messages in the "avocado-system-opensuse" QEMU CI job
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
References: <f4c2990a-e47e-434f-b45c-20a41b9354d1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f4c2990a-e47e-434f-b45c-20a41b9354d1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 16/1/24 16:31, Thomas Huth wrote:
> 
>   Hi!
> 
> I noticed that there are some error messages about a missing python 
> module in the "avocado-system-opensuse" QEMU CI job:
> 
>   https://gitlab.com/qemu-project/qemu/-/jobs/5911721890#L191
> 
> Anybody interested in fixing those?

Fabiano is looking at it:
https://lore.kernel.org/qemu-devel/20240116230924.23053-1-farosas@suse.de/


