Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07594736902
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:19:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYRL-0004pp-KL; Tue, 20 Jun 2023 06:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBYRJ-0004pY-Du
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:18:21 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBYRH-0007s6-U1
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:18:21 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51a4044b7a1so5581656a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687256298; x=1689848298;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J6/nYXXoE7eYrBASOpaIQ4Nf87zRTYkYMqLvXhKZbZs=;
 b=GQ5A8nOSCeMNRpH9JsLL6CpABUClBxoNtL2Meu7mT4xfvOt6X8llbq0uWaLxuqX1Ro
 qBkGJAjUREB92CVrhC5AT2PujMVSB70qClbS1HlLnHRZ7R+LsHVNlLyjSpfMpAC1TcXr
 KXFBXj9Ky9nvauXLjCc4ROSM21hRmACpPHrtjFOaudEHXw1QfpCjtT3zQ0u945zhyxhm
 UhXbGwoMliWJTQIzLnBBBdQmVXrLW33Qs3Y2M9t6Nfr0DqSXtbbsh26vSw5oEM455CD9
 RQV2n05ZwlPNxriaS5nUV5twPyXbSvODcvoVufQkimcX7snkzqMx0iqZuEc3+BFSyvjc
 VhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687256298; x=1689848298;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J6/nYXXoE7eYrBASOpaIQ4Nf87zRTYkYMqLvXhKZbZs=;
 b=SGMLTpkebwJG3SQ1yxuf+5viaYYdo5Rc3X6n1Kcu6X2Nz6SimhmfnmqKG0iX1V12yg
 c96sBf6zn0FLdM5BLU4NypTVH1p+Jsx/7Pa8d6kZ7zl5SrnwoOgFD4FDlKy7A3AFgYaO
 6p5680c2flWIdbiHsuz8FCndCsx6gXxMSwCZGbSkVMMVNh1lArIMQE3+TzfJi0R5T5pM
 cGJm+pSv9yDxQlcwTBMtvBhmhiy2M3cluTFEMzRVdMivGD0Wp31AtkbcvU9oTouMgbJF
 ddQCGhA9yY24IIlAddOdHMahgF7os8xcmlLmgS8SMrWYGxZX2GF8swwahyS4+temEgfe
 Ff9w==
X-Gm-Message-State: AC+VfDwVYsyxhhga+BRxWZaq/2DIjJSb9NirBB47zZGkPLWNivPJHiTf
 jkZgZcPB+KjBKfrQIeDgFZdQyQ==
X-Google-Smtp-Source: ACHHUZ415hFw/R4tqKYxoljG/fmAYlgZWQ1vZLzlyyvb24NaXxMI8rv7IDcoqz6GPj9lclpUs8txXg==
X-Received: by 2002:a05:6402:498:b0:519:b784:b157 with SMTP id
 k24-20020a056402049800b00519b784b157mr7172290edv.12.1687256297854; 
 Tue, 20 Jun 2023 03:18:17 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 c12-20020aa7d60c000000b0051b4a25fab1sm940760edr.41.2023.06.20.03.18.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:18:17 -0700 (PDT)
Message-ID: <e2ff8707-4190-6258-e54b-f24962b4c32b@linaro.org>
Date: Tue, 20 Jun 2023 12:18:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] x86_64/atomic128-ldst.h: fix arch include guard
Content-Language: en-US
To: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, alex.bennee@linaro.org
References: <20230620083918.9134-1-frederic.petrot@univ-grenoble-alpes.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230620083918.9134-1-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 20/6/23 10:39, Frédéric Pétrot wrote:
> Fix arch name in the define that prevents multiple inclusions.
> 
> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> ---
>   host/include/x86_64/host/atomic128-ldst.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



