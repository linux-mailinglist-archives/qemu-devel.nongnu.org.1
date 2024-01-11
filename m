Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F0782B029
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:03:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNveA-0000X4-5G; Thu, 11 Jan 2024 09:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNvdx-0000UG-LA
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:02:50 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNvdv-00079U-A8
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:02:49 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a28b2e1a13fso570121866b.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 06:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704981765; x=1705586565; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9riYXyXkp5khOZhAcYOCAaJh1uKMHqAS/Ilk5ZNPZCU=;
 b=BDTwXqCBFeQ93/zZYhnrG4+DUmre0jidLT6+qlSg1wTrrTVKIRSkTq9PXCCMDSAio5
 z17bZEV2zZs+1ayA56PR0sx2EN4w+kRPJ/Grtnp6P/pCPAA61scQvdVnb8boUv1DyJHP
 vHGdH2yJWNX4ibyyUG0R++mThj2MR1KpyZHenWrdf7Rjw3JyBwCUmq3AMSYiZrfXRF8o
 KYAhXl23+Tw3MzXeOC9WpYhA7rnE0GN91MVymBM9bRa53SUNv/XfL4SpsZzylBE6sK4M
 bId2g0OodbUcEx34ZLx9bHuZpLxfo5z13PBlFbmbulIGXDWlbXvRN0mXnemspW5KCCeb
 i5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704981765; x=1705586565;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9riYXyXkp5khOZhAcYOCAaJh1uKMHqAS/Ilk5ZNPZCU=;
 b=b/LYATte73qLOsgRQhqhxBcR+Bbp+cBNIdOf9IkOCMmV4fUG9hw4PKlMjO+gXNLxdD
 bmd2UuGyFwGvijLCbxY+n3wtZeCiaDskcx0/S0uzPgW25W0gDX8wAfzxzgHjSX1gwq19
 piuyyTvCFf1W96WNrPuQv3l/LCU5+hPC1AdzX3BhoElqQ0w4YbfuuPDGChU7lnnbpAh6
 bvLxCVjAIEzneCSzIpBt+reuPqB5nEATx14432IOmDYmhcmLQhiMXiFtlc16GVVus97B
 sNg1f7cZUlnba5CeMlHS0lbtE6RtRSa1lN8Ji7kNu1NRQWnqdg7KMgMyv52WnxfQJfxu
 f7SA==
X-Gm-Message-State: AOJu0Yx79FAF1Rbwp3Cc2bqt9HWwrwz8exm5hl6FAYqVQkQoWjhq4uWL
 vOMFIgMJf7fgQQJB9ZdD4LVv/1il/hwgzd/OBiQXqC24F5jb/w==
X-Google-Smtp-Source: AGHT+IGkNd3wjUxfleDip5ZfhpVOe3qnLWVuDnwM6NCyLqUXvrI02BWnD84LdjHIyHO6WNeTA9FkJw==
X-Received: by 2002:a17:906:b2c3:b0:a2a:159a:5ebf with SMTP id
 cf3-20020a170906b2c300b00a2a159a5ebfmr625899ejb.154.1704981765518; 
 Thu, 11 Jan 2024 06:02:45 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 x17-20020a170906711100b00a2c5ec21e0esm575137ejj.85.2024.01.11.06.02.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 06:02:44 -0800 (PST)
Message-ID: <db81fdc0-856d-4ae4-9346-2df5d5ed133c@linaro.org>
Date: Thu, 11 Jan 2024 15:02:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .gitlab-ci.d/buildtest.yml: Work around htags bug when
 environment is large
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20240111125543.1573473-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240111125543.1573473-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 11/1/24 13:55, Peter Maydell wrote:
> Sometimes the CI "pages" job fails with a message like this from
> htags:
> 
> $ htags -anT --tree-view=filetree -m qemu_init -t "Welcome to the QEMU sourcecode"
> htags: Negative exec line limit = -371
> 
> This is due to a bug in hflags where if the environment is too large it
> falls over:
> https://lists.gnu.org/archive/html/bug-global/2024-01/msg00000.html
> 
> This happens to us because GitLab CI puts the commit message of the
> commit under test into the CI_COMMIT_MESSAGE and/or CI_COMMIT_TAG_MESSAGE
> environment variables, so the job will fail if the commit happens to
> have a verbose commit message.
> 
> Work around the htags bug by unsetting these variables while running
> htags.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2080
> ---
> Cc'ing stable purely because it's probably useful to avoid flaky
> CI jobs when testing stable branches too.
> 
>   .gitlab-ci.d/buildtest.yml | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


