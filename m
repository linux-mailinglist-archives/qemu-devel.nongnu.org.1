Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2C57E2063
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:52:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzy6q-0008HV-Mu; Mon, 06 Nov 2023 06:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy6p-0008FO-AG
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:49:35 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy6n-0005cn-Pf
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:49:35 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40906fc54fdso33776225e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699271372; x=1699876172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BTeDHNEKhiuOcQpVzudlt8L4kEpJlvCJCd6qMEJnrdg=;
 b=x/6tMEZRhMx2Ma1eLhhWVeqDwZ2VrAC9ZoCYVZZ58KQK8aef2kC7hPmDXwHNGzUkjt
 EAxDYy7TKYu7nLFpwkQkg0hnL84VUHAHITXDFMkqZmKowomDqwGaCXUd6qu1/x3LwiF2
 RVFHeGHpnLn/BRpoYvZAWXvbgLZB7GLglB1OMYnSafkWPxkQ92aTgUQwaFZqpvRB0F15
 5Ve2KQx1VwYOcTmSPIWgyYH07GByhnqDuwLZD6CL0iankXbUvATw9oDDG9mzCE7e0ADb
 U6u33bX+Ml87IvJ6EyE/JwjUGNwOB1Wq+6vfXI58sdD0FFE0mrz+i+u9RRI3nRuuTk39
 tnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271372; x=1699876172;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BTeDHNEKhiuOcQpVzudlt8L4kEpJlvCJCd6qMEJnrdg=;
 b=ao7hWvjhI5yn+tISfI27bmk8m58XCCcymZiRW3Dkm/RAyn0nq4rXmM+tLVyHE1a3uP
 mNiF+jJfcLQWZdMgz8VK/3+NeKbhox1bE7+89vEcoNWKUUPDUGoypBSII9NRws+7CUMj
 wI2kdYHb/yJKTyzPv0gr1k/dA82mNvoxZjUcrjQCs5yJ51wBFeZYtPdCSv+zuWEwMH7s
 ROlu+UQQlCVDrn8VYvwxuuOVhe4wtkLc8ZTTogo3cG/juiaH4ROGGbuqlHuOEhdUF0Yv
 8tNGsGd+NhKjctnhUFWRgvoIYQAmU9B7PfcCmfy8n20xCyOQ1X7//eYXbfDyIAFl4FtL
 aBqA==
X-Gm-Message-State: AOJu0YxeRpcispSAcG0NBdtao4jY7Mp/s7inf9urA8SVXmD0XmxzPB3D
 2gyUL9Ut1UAbKeukuRoR/DE+Ew==
X-Google-Smtp-Source: AGHT+IH0Rf3hUb9QVi4kq3+eiBD0qhWzPqSoIiC6XLUWTW0cS0Gk8VE4JkwY6AvIA2gMjuRntzgHig==
X-Received: by 2002:adf:d1c9:0:b0:32d:8094:f4c8 with SMTP id
 b9-20020adfd1c9000000b0032d8094f4c8mr24116444wrd.19.1699271372107; 
 Mon, 06 Nov 2023 03:49:32 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 y15-20020adff6cf000000b0032f7f4089b7sm9180814wrp.43.2023.11.06.03.49.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 03:49:31 -0800 (PST)
Message-ID: <ca707851-ab6e-170c-4a94-8f628771b914@linaro.org>
Date: Mon, 6 Nov 2023 12:49:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 12/71] target/mips: Constify VMState in machine.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231106065827.543129-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 6/11/23 07:57, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/sysemu/machine.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


