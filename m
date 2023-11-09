Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A78517E7205
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:13:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1ASh-0002Fn-UT; Thu, 09 Nov 2023 14:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1ASR-0002FH-BV
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:12:51 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1ASP-0001zm-B1
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:12:50 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5441ba3e53cso1925897a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 11:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699557163; x=1700161963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t7WVJD1atpFygEZwKguFYjamFbjicRRFOHMul8AYcws=;
 b=YIYlEDwUsi1MZMQKJV7d34dIQf3F24Eblpyg3KUalUPWkEV1WOPVm/Wabm6sxq9I4c
 LwafbZvjSMXYB0QFLWovUuWD6/kPgAG9cJMb6eav+il3mzYSpEbvgOA9wddTAwU7qwli
 F+TfiEvXt1rwsR9E5XSQqyHKfxIOh7JAP1fxJ1bleouTTumgP5mNKB5R6iZFC76zAiv2
 IwDcFWrsVaZOmDn3DxYwzKghWTrCX0AVu/V0Aweuyg7JWtjgNtsCrdof0RJIduJ8kzvh
 o8WQBg6etEPDVJ7/k51tJYN6ocmbRb6fkm6KN3gx1Phon6mVrvrBexo7/d15OdiKlr8O
 yFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699557163; x=1700161963;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t7WVJD1atpFygEZwKguFYjamFbjicRRFOHMul8AYcws=;
 b=EnumnbWSmPizRtvbZsyaIP/i2hqKPSgF2nnnR0QOLeUxMVO8FX9aq+hURkm3zZyfSt
 /BHbB/3YUWN+Gir1DeOyl+jQKV0+DcUDbOe4CapQr4PpfpGFRxNGDGNsFbVBBWCgZH0S
 sgyrZJkN+jZpNn7650NQMjMBKSNPySrPK4TF+y6wXMNYeTEdQ7GHhWy5guo4HGr4zYVK
 cNjRk6HeOnjXOOsigtx3qV30Q1vs0gylzVPLquKKlUPexvKU5iVM6+FL5bi6mt+YVYZ8
 cq0eW4raaC9pro9VMTZ8uD0fYvdJr9QBTKDOXV6aUwBwdZNpgRs+nXbjvF9PUrjMEySN
 NYDw==
X-Gm-Message-State: AOJu0YyLTyUjZKbXLH9hA92PaZLPEQFQIZQe75fG13SWBdX3+AuicvwQ
 aEGriviO2mg+3Etjh0lowWS99Q==
X-Google-Smtp-Source: AGHT+IEeqaeib5txYiGamgPELtKgBIHVr40Ndf+hpn+843VI29QO3WPYhvRHM8sEI8tmSS9ZzS1oGg==
X-Received: by 2002:a50:c252:0:b0:543:6e4f:37b with SMTP id
 t18-20020a50c252000000b005436e4f037bmr5197618edf.36.1699557163687; 
 Thu, 09 Nov 2023 11:12:43 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a056402516400b0052febc781bfsm166756ede.36.2023.11.09.11.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 11:12:43 -0800 (PST)
Message-ID: <d1729225-d8de-44af-ad64-0cee039ed24a@linaro.org>
Date: Thu, 9 Nov 2023 20:12:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/11] qom: Add object_property_set_default_list()
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com
References: <20231109174240.72376-1-kwolf@redhat.com>
 <20231109174240.72376-10-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231109174240.72376-10-kwolf@redhat.com>
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

On 9/11/23 18:42, Kevin Wolf wrote:
> This function provides a default for properties that are accessed using
> the list visitor interface. The default is always an empty list.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/qom/object.h | 8 ++++++++
>   qom/object.c         | 6 ++++++
>   2 files changed, 14 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


