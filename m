Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DD07E720F
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:14:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1ATS-00037L-Nw; Thu, 09 Nov 2023 14:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1ATQ-00036O-Oz
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:13:52 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1ATO-00029r-2T
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:13:52 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53e751aeb3cso1944564a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 11:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699557227; x=1700162027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BMfYZC6dvZ9lMQwsxZ3VBi0Dyl5AXzFYb9Mpe+rjRdo=;
 b=LM1QiGB8sPLIzHmr81YF9bgcnZ96yuzjRcm/O0Yb0dSs70oDIVTgnH7b+aVJBEd7nH
 MjoOF+aWHkaXinTDV980l0cpCESaPOI3z/lW6mPeMzxyBr8NkAsB6rj/5BoQ4Ge05EW6
 bISnR+jE+p4Q2lnEUqKN+Bzusyq5kIJmrWS3FSxh6oOBZlYm+/z2r5RcR4AU5Zto7Wpn
 lVTd74w0YNokgnNyA3nXEoZr1p8CL0HshthKoPCu+wcXYqCcqnwdJQ5ruysyU/ng9g43
 nYx7YTzw0yslVGHYX8yHgMW6cKult/O6U7KUX4/islkX3k4pKvSU8WvpaDZI0QV2Dzkm
 9vmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699557227; x=1700162027;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BMfYZC6dvZ9lMQwsxZ3VBi0Dyl5AXzFYb9Mpe+rjRdo=;
 b=kwLlECAmmGSBD3ogHg2ZeTzkL8U82R4jllSERCR7BPHDhcEgML09ymRLadOp6HdEmG
 80fJnBkViT+V3luBMULByFGjjQN/qMWqjAdXBKHRgLYfDStIOAZraET7fWZKfnU0LFMi
 EOhxsWGsXW3GTSUNzFqE428gIZXqGk03v715ZD8b7dEPTdCHU1ANlSgz7CK8q1oNDE58
 VfeaF81xkDMVhOtKbwATZObl18r5/JaI418pid9Tw0yGYOMW9uqgM6ASNqGFD+cTZJ6m
 KENfM0/hmMPArnuDHOjWu0Nn/8AHVhBVwnN1MwlqH8USfPhfTD+X4fbG935E4Z4q3Grs
 OmkQ==
X-Gm-Message-State: AOJu0YyabR35Ak/kEKeMx/gSqni83JV41NDsfxwCSRNBtvEXwiSiPwHb
 UJpUWeyPjmu+WzJJQAZ8eFI5MA==
X-Google-Smtp-Source: AGHT+IHlwwRMeP5Y9bdSJ9IbG92pwP6QygwjYtMCa7JRQhTd8tCnesrk0vMiaTfjTk7BRoYe+bhboA==
X-Received: by 2002:a05:6402:358c:b0:545:5601:414e with SMTP id
 y12-20020a056402358c00b005455601414emr2769829edc.5.1699557227093; 
 Thu, 09 Nov 2023 11:13:47 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a056402516400b0052febc781bfsm166756ede.36.2023.11.09.11.13.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 11:13:46 -0800 (PST)
Message-ID: <0b711283-d06c-4146-9920-62f1896aea89@linaro.org>
Date: Thu, 9 Nov 2023 20:13:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] qdev: Make netdev properties work as list
 elements
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com
References: <20231109174240.72376-1-kwolf@redhat.com>
 <20231109174240.72376-11-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231109174240.72376-11-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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
> The 'name' parameter of QOM setters is primarily used to specify the name
> of the currently parsed input element in the visitor interface. For
> top-level qdev properties, this is always set and matches 'prop->name'.
> 
> However, for list elements it is NULL, because each element of a list
> doesn't have a separate name. Passing a non-NULL value runs into
> assertion failures in the visitor code.
> 
> Therefore, using 'name' in error messages is not right for property
> types that are used in lists, because "(null)" (or even a segfault)
> isn't very helpful to identify what QEMU is complaining about.
> 
> Change netdev properties to use 'prop->name' instead, which will contain
> the name of the array property after switching array properties to lists
> in the external interface. (This is still not perfect, as it doesn't
> identify which element in the list caused the error, but strictly better
> than before.)
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   hw/core/qdev-properties-system.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


