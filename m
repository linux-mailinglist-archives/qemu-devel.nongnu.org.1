Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFB3830778
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:03:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6Vw-0004QO-79; Wed, 17 Jan 2024 09:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ6Vu-0004Or-K0
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:03:30 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ6Vs-0001A4-4R
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:03:30 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a2cad931c50so574438566b.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 06:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705500206; x=1706105006; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Hb8HSZTIlaKM3OWz/hK0LGxM+o9h67iPpCzS074NIg=;
 b=UCR8FZ5+qK3u8vKQXk8lmS82fT0hlLSeddZANgqS4hzNePqIjYtXYnY6uLmvVVJPvo
 H3cVGby2HbpYMI2CyFicfacF0KObTqqCgiZTzzK/IUnnTCyiMIl/0Wu5SRBI2hlJrPjU
 MyBz99gxpkMYK3/esB6TpNhNlJ7AYcDy4ivNtPXYWvqT4RfL5G6qcMfqH+rTHUxQQ1LP
 N+xR17QG6UgZ0d/B97uen1ZW3dBTu9hK3mL50PmJ5vphrsmYpc60/C7cYFJARcYmyJm4
 55gVI2p3ov56ySruHl2Py3nVn7WtWDLxEHdiWm/qVS5Q29Xd86iS24BDE9aK0FlZ5dHa
 R1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705500206; x=1706105006;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Hb8HSZTIlaKM3OWz/hK0LGxM+o9h67iPpCzS074NIg=;
 b=Abppa5AFbWxAL7eguzl7eSx0hl2gRodHEnnsnCQibeR66CaSRFh7tkDaSnuYI6d46J
 FIT3nOwAY1RSlWSXuAP5Ex1OmlmwUQZ3O8U1hAlqmApVzRyBvUZMSgoJ8ybxwSOgZ3Oj
 RgMSBSlGdHqnPjbyp359Dqznbq9+msevM8XxjENPm7mp3pgjlO95+vVLpB3IftUnykAo
 o6cOwxi4lnvD9u/iF12kwyqMPXzQOU0Ic+zr9KCZAqkIkMpXhEMTiVlz0Yf9zgO9JXIK
 sGgjQZU996mr3bXpBJfn279wlfHrYTwNK44AhoM8EUnNkIzG7AHQL+/Q17THedFmN7XN
 CbrQ==
X-Gm-Message-State: AOJu0Yxg19taj6/+cTF+E54zwl+8GAuC+2SbTc8vLzDhF7drZ4oeJFlv
 SMW9B1FbVNYz0AdSBYMNWCZ6g0lUFprk6w==
X-Google-Smtp-Source: AGHT+IEg5Z7hC2UF30gCmvbAMcmXS4eimeCwagFXkmr04ZeqtdKrCWB70oEwkJQetfkAtFYxMhqNjw==
X-Received: by 2002:a17:907:3ad1:b0:a2a:9e31:7ea5 with SMTP id
 fi17-20020a1709073ad100b00a2a9e317ea5mr3053320ejc.132.1705500206113; 
 Wed, 17 Jan 2024 06:03:26 -0800 (PST)
Received: from [192.168.69.100] ([176.187.212.26])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a170906128600b00a2b0b0fc80esm7772901ejb.193.2024.01.17.06.03.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 06:03:25 -0800 (PST)
Message-ID: <8ae6c891-522d-435a-be63-2e5a5c9d6394@linaro.org>
Date: Wed, 17 Jan 2024 15:03:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/vm/netbsd: Remove missing py311-expat package
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
References: <20240117112407.22462-1-philmd@linaro.org>
 <5ae6d41e-e291-4fa1-94a1-6ec22cd809be@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5ae6d41e-e291-4fa1-94a1-6ec22cd809be@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 17/1/24 13:10, Thomas Huth wrote:
> On 17/01/2024 12.24, Philippe Mathieu-Daudé wrote:
>> Per commits a9dbde71da ("mkvenv: add better error message for
>> broken or missing ensurepip") and 1dee66c693 ("tests/vm: add
>> py310-expat to NetBSD"), we need py-expat to use ensurepip.
>>
>> However the py311-expat package isn't available anymore:
>>
>>    ### Installing packages ...
>>    processing remote summary 
>> (http://cdn.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/9.3/All)...
>>    database for 
>> http://cdn.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/9.3/All is 
>> up-to-date
>>    py311-expat is not available in the repository
>>    ...
>>    calculating dependencies.../py311-expat is not available in the 
>> repository
>>    pkg_install error log can be found in 
>> /var/db/pkgin/pkg_install-err.log
>>
>> Dropping it from the default packages list allows creating the
>> NetBSD VM and build / test QEMU, without error from ensurepip.
>>
>> This reverts commit 1dee66c693 ("tests/vm: add py310-expat to NetBSD").
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2109
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> RFC because ensurepip seems important due to cited commits
>>      but I'm not sure where it is used, and this fixes my CI build.
> 
> Thanks for tackling it, I also ran into this problem already and just 
> did not have enough spare time yet to investigate.
> 
> I searched a little bit, and found this text here:
> https://mail-index.netbsd.org/netbsd-announce/2024/01/01/msg000360.html
> 
> "
> - Several packages have been folded into base packages.  While the
>     result is simpler, those updating may need to force-remove the
>     secondary packages, depending on the update method.  When doing
>     make replace, one has to pkg_delete -f the secondary packages.
>     pkgin handles at least the python packages correctly, removing the
>     split package when updating python.  Specific packages and the
>     former packages now included:
> 
>       * cairo: cairo-gobject
>       * python: py-cElementTree py-curses py-cursespanel py-expat
>         py-readline py-sqlite3
> "

Thanks for digging, I'll update the description.

> So it seems like the py-expat package has simply been merged into a base 
> package now. Thus I think your patch is fine. It also fixes the problem 
> for me, so:
> 
> Tested-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 


