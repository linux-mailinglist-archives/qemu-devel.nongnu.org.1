Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5062376B5DC
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 15:30:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQpS1-0003qZ-9F; Tue, 01 Aug 2023 09:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQpS0-0003qR-7t
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:30:12 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQpRy-0000cs-KN
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:30:12 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8deso62579425e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 06:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690896609; x=1691501409;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JC2u60wzi9vj+wnSHCqPdEyN62BIn6iea1uGAVjZXYI=;
 b=OSSxDoD+XNBJiT1lVE7id3E3BZ+FH3MCFF1vQxB4kiez5rCLyzKzfGuKz2NfkvcRYO
 7E5OmHSv//e/NQtPGCK0AAzU4jY7+3Ksfxho67QLWxUBFNYbLIxgQyUfE5KAYx7U6U0F
 1XlnKPaCSsCoHQYDz9ITenIbLEZDa9LyxpJH4sz5//XmGPPTDSZPVupc+EjzPaZv7PUL
 GQLYbhHkBi0JbI6v2EK4kaFPhYM6hFi4ENWXFUNZGT0yN4Zk+cjxC2ThJD6LYkg7dARz
 WgISU01k8bwdhMiIkJlxv81x6jkWWV4tKPDSd2YOOs33gVY92PdcmPaTq11RXRBmOC3m
 0YqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690896609; x=1691501409;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JC2u60wzi9vj+wnSHCqPdEyN62BIn6iea1uGAVjZXYI=;
 b=Jf+coytbW1hF09gYPCo4+E5qJSzKxJVkkhI+yRHYE3fomIuf3WpY/b/Jxi2qMdEN2+
 7UWF/uAAss3eDLbF8CnsIwO+/YfMZ+Lb/eWwKkcajLP1pQ4Pu6Femszw0WlG5WsR96IG
 AxCiiXEKoDE/Rc8EeHSbBOXadx+BQDyPBIEkhsPKGjd7AYtM0oiv74CkiVCbSZiUoK9n
 L5OUss1fmRIGLpW7kyYy5y0+D5fauWCl9kaWSIdsw0YxRxij73bdgE8sLIkdcF13ni2k
 Bdf/kv8Ap5IVYGkL8rrzxV4L73JBXjRK8YsXRrmwzLlu8T25JDNxOkOXFzXWJJvC3m4A
 hQVw==
X-Gm-Message-State: ABy/qLaCbyFKZCTb1Cb2jJTnBBCItAB40PBHxaP7Mv0BhVYv936v/46x
 dOuC/m9ChYqTrw9t0MesksK2rA==
X-Google-Smtp-Source: APBJJlHcxy6y5WRVfpELJrFbkdOfrCpPXZfJBv7Cv1Bp6Ls0CtAhlimtbdWihMg9X/b79A+9Ibl2qQ==
X-Received: by 2002:a05:600c:2048:b0:3fe:2bb1:11ba with SMTP id
 p8-20020a05600c204800b003fe2bb111bamr994449wmg.27.1690896608742; 
 Tue, 01 Aug 2023 06:30:08 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a7bc8c9000000b003fa96fe2bd9sm16817367wml.22.2023.08.01.06.30.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 06:30:08 -0700 (PDT)
Message-ID: <10295d2b-cace-07c6-0b2b-f8122d8efe98@linaro.org>
Date: Tue, 1 Aug 2023 15:30:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 6/6] gitlab-ci.d/windows: Use Clang for compiling in
 the 64-bit MSYS2 job
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-7-thuth@redhat.com>
 <62b923c2-5c22-44c5-99cd-95351fd200db@linaro.org>
 <a45f5f3a-2139-da7b-0323-a32fa69f1788@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <a45f5f3a-2139-da7b-0323-a32fa69f1788@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 31/7/23 16:43, Thomas Huth wrote:
> On 31/07/2023 16.23, Philippe Mathieu-Daudé wrote:
>> On 28/7/23 16:27, Thomas Huth wrote:
>>> We are struggeling with timeouts in the 64-bit MSYS2 job. Clang seems
>>> to be a little bit faster, so let's use this compiler now instead.
>>>
>>> There is a problem with compiling the spice headers with Clang, though,
>>> so we can only test this in the 32-bit builds with GCC now. And we have
>>> to disable dbus-display - otherwise the compilation aborts in the CI.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   .gitlab-ci.d/windows.yml | 14 ++++++++------
>>>   1 file changed, 8 insertions(+), 6 deletions(-)


>>> @@ -77,13 +76,15 @@
>>>   msys2-64bit:
>>>     extends: .shared_msys2_builder
>>>     variables:
>>> -    MINGW_TARGET: mingw-w64-x86_64
>>> -    MSYSTEM: MINGW64
>>> +    MINGW_TARGET: mingw-w64-clang-x86_64
>>> +    MSYSTEM: CLANG64
>>
>> OK to use Clang, but I'm tempted to keep the GCC job in manual mode...
> 
> Why? We still have the 32-bit job with GCC, and the MinGW cross-compiler 
> job with GCC, so that's already quite a bit of coverage, isn't it?

OK we are good then :)

Thanks,

Phil.


