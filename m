Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DEA746023
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 17:53:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLqr-0007MZ-Ke; Mon, 03 Jul 2023 11:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGLqp-0007M0-PL
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:52:31 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGLqo-0002xS-9K
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:52:31 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso30919775e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688399548; x=1690991548;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t428fN787+yvdxeOAMngw5BNu57gGIfq2lu98D6DXVs=;
 b=zqWIzjbEVB4orF8c09/Nk/BpZc9TJtZQP6VRYO9dheVlFx/0LEx74k53bL9jKRK1JZ
 B8zRz+h6xim6AwNguGJ2k4c0wsRL1Lywe4Q4UnXkaBM/Gui/p+j7i/+WIgS2BNNvzCas
 32zR0sqPPP6nH3xNjRZo1kQJ/Z+tr1ygHUiDLXs0LQqFJVlnqcXq7U3j0Wnp6CjBQjOD
 ZVnUK/pez4XR/hnjI0HVPv5FUt8LY+xEhttgoKtQCi9HrUfPVhP1Ahr9Vox1RKkmbMJN
 M0H2unaohBcyn7lUlHmwiCik1baMFIhKKw3nmLv2hrUI/zDYoH7njEpW7XRltg/a6L4j
 BL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688399548; x=1690991548;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t428fN787+yvdxeOAMngw5BNu57gGIfq2lu98D6DXVs=;
 b=ANUnyLxZpdE6VVI8dBDPqk3O749tVZqeIajFoV43tyLhWN8KPDLVnplbQs/b92ZzCv
 8DMNmWJacuwI8ihiqgWzo6DmYwThG/6Q5USK8B0GfUxuCqznGyvmh4IMwbat76kYx0fj
 8WjC+D+j5Awy0QzvAAOg4NAX/5c+ISB0hWlB/oo7pHL2UFBD+ykm+P3Wjcz40n9ViN4w
 g6rS559IfpwjruGmUuElOO0yA7/X6A+foCmTBbrjRncz6U+UHMUNwb1zxTLK6/1JuHxR
 uOkPnAtb5lmDMys74Bl9PD+Jl2kiBbO6SqiXHx8g0ZLVEykgQPV8lQ3S9md8swR2ng4Z
 LGuw==
X-Gm-Message-State: AC+VfDyv/N1IBYv+hbZlx+V8F8KghjSOrZg1ezKHXULQbF6uNeMG1qHL
 CwUkP0jaXK4I3Lju18fqUTvm9A==
X-Google-Smtp-Source: ACHHUZ5AFj1ReoE1RW0fsj4CKxingK0iLj49RjIB1t+51BvOuQUbhunTYKmqH9VC0elTLffslexdtQ==
X-Received: by 2002:a05:600c:291:b0:3f5:39:240c with SMTP id
 17-20020a05600c029100b003f50039240cmr8394540wmk.27.1688399548484; 
 Mon, 03 Jul 2023 08:52:28 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.178.91])
 by smtp.gmail.com with ESMTPSA id
 j15-20020adff00f000000b00314315071bbsm5234433wro.38.2023.07.03.08.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 08:52:28 -0700 (PDT)
Message-ID: <6efc76a5-220a-8cc3-cc5b-9cec07b3c1b0@linaro.org>
Date: Mon, 3 Jul 2023 17:52:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] MAINTAINERS: raise status of 9p to 'Maintained'
Content-Language: en-US
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
References: <E1qGKgV-0003Hj-01@lizzy.crudebyte.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <E1qGKgV-0003Hj-01@lizzy.crudebyte.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 3/7/23 16:34, Christian Schoenebeck wrote:
> Change status of 9p from 'Odd Fixes' to 'Maintained', as this better
> reflects current situation. I already take care of 9p patches for a
> while, which included new features as well.
> 
> Based-on: <E1qDkmw-0007M1-8f@lizzy.crudebyte.com>
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



