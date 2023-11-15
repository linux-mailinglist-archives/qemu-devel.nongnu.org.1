Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 980987EBAA1
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 01:37:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r33uG-0004Fl-4B; Tue, 14 Nov 2023 19:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r33uF-0004FA-0O
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:37:23 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r33uB-00079M-Ej
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:37:21 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc53d0030fso2963545ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 16:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700008638; x=1700613438; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xvb7cLF5DhgD4quTUfsHEObWFbjC/DcTYzmTikQKrk8=;
 b=lk1NDHwvmjWfOuYpJxVy4/tfJ5cVKltGNnnJSrAjHkKnwWSG2u7ZB0IY6/8D4tKWWc
 FBOBNu4bY8pXw5k6pUGmWxcTujgE6Jf29QRkqvQdraAQKDLvb40NPfJ13pZ3RNUF3/0h
 q5kmneC0Yjg4wa3rDiMuSFgKa/uAN+nZATGx+nPY8JbOWZiVBaJJwJ/5Wd2xyF3Vhq2h
 5XRnIDeIFtno1S6RYWKwpUehv9VdN8uGAns+Lf1nzzs/6jnQzyn+11+lCbF3r2YXgv/v
 HYEDOrxKvjV4o+uxntc1kGXoQrD5Tr3PqfLvYz8fntfAxHqb40k1I1ylg+qn6AzZOQ6e
 xfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700008638; x=1700613438;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xvb7cLF5DhgD4quTUfsHEObWFbjC/DcTYzmTikQKrk8=;
 b=fq1RTlK5Zm+35m67M5Bo3f/m8r65+JRFJfnPae5lviCn4DQjVSQk52wkalIR74fmUa
 bBx5guGoCd4zvsC0m6yeVISqFgqGzrAVKdFG1pmX7YvVNwLfjk6eJBHAJRg1gJTX89Na
 L5U1XhKYSVIJfocZ4Qx/R7bZLEb0Q/C6lHQThg1ZZr5lxet9DCoP0PYEicMLf9dGXeP1
 V+4Vw5D4S2BCWYVB4WODFSSawXOzaC4uZfcJksSdmNJRmeDS2qA6iS1dMS354d14x4sV
 AWS4CEtUAsBx7eBilxwbpNdV98g21sSiI3MBJ+AmCnrfaezrOKrz4zva0oIlc/sqUmWl
 DzNg==
X-Gm-Message-State: AOJu0YwwdtcWbf8PzdTkA3uJUiXdFfRKi1M/upEhrxb3Qsk++yPkAnts
 8M3NZudlTAJbREFSH91EJXg+eQ==
X-Google-Smtp-Source: AGHT+IER84M03FyMT+zXo//815ZnHmz2bcVMRhlv387qgVxBQpDMzG2aUO/pmspPeTgNiXBuraSVDg==
X-Received: by 2002:a17:902:c403:b0:1cc:419e:cb4b with SMTP id
 k3-20020a170902c40300b001cc419ecb4bmr6257626plk.19.1700008638048; 
 Tue, 14 Nov 2023 16:37:18 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a17090332c400b001bbfa86ca3bsm6275251plr.78.2023.11.14.16.37.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 16:37:17 -0800 (PST)
Message-ID: <9ab709cb-9a55-447a-b81d-418483c9075b@linaro.org>
Date: Tue, 14 Nov 2023 16:37:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/31] cpu: Add generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-7-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-7-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 11/14/23 15:56, Gavin Shan wrote:
> Add generic cpu_list() to replace the individual target's implementation
> in the subsequent commits. Currently, there are 3 targets with no cpu_list()
> implementation: microblaze and nios2. With this applied, those two targets
> switch to the generic cpu_list().
> 
> [gshan@gshan q]$ ./build/qemu-system-microblaze -cpu ?
> Available CPUs:
>    microblaze-cpu
> 
> [gshan@gshan q]$ ./build/qemu-system-nios2 -cpu ?
> Available CPUs:
>    nios2-cpu
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   bsd-user/main.c |  5 +----
>   cpu-target.c    | 29 ++++++++++++++++++++++++++---
>   2 files changed, 27 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

