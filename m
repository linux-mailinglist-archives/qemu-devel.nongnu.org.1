Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6116B791B8C
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:26:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCPH-0000EV-55; Mon, 04 Sep 2023 12:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCPE-0000CR-JW
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:26:28 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCPC-0001x4-91
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:26:28 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2bb9a063f26so24513161fa.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844784; x=1694449584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OjhTv8vbMu73CcpPM02r72GfZrrGI1QEZM2R3d07g/Y=;
 b=xM1qvK29Pa3ryXBNX9CjWc5Mg/RWh6qR/tuYO6oRzfbPi1sAY0WCFHzq8qufeh80ze
 e51+IR7iZ6IIo6XQPHleTGuRNTSEQrfrDfLJMdRvRfeOOq1BbJbZr22QlTprBSeddZ0I
 S49O12uyOY2eyehPorWAAFFWYA0FzwTH+cq/WBAYVZtzo+UB1gXJBrcMQRy2VkqDN+u0
 5gxYfJqDgv8IU20uwbglLdWKzXYo7FhzMds5aZ12dyky0Vpsw7yU5eGr5zRsgosD+u4G
 2MOqaDwKwU5foQp+5wo/o+emiKXcyRtFWThBbNZ+G11aqS78gswBlabNEd3Job1114fl
 8g7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844784; x=1694449584;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OjhTv8vbMu73CcpPM02r72GfZrrGI1QEZM2R3d07g/Y=;
 b=NR8bwLcu5VTnpvwCg42fm34rmz9vTnZAJ9kE2l+ZPjBjCI7MUXk2j4jQlwC3tpiUmx
 /93c+7XdG9KNUm5mabIhf3kZ2oV5/sCH0Ykj17yvpJJT5ubenlFX1Yni9le6hrYDMtwk
 +ZSWf2kfBIJ3O/g1EJ5DLBYeDk5qf0aIJoW4viVZ/axv6aB11bdUMibFINpWaB+fg+KY
 bNK2WLPZxQcaiaR8fwiFcOrxE/jqe8ruWwQoJ5iJES54OMJSQ8KFJtdnh3wm5mwfax+E
 SR3wxrnZMJas/1eumSqM4kNkWoURTvo13frmIcSwh2Jk68wlSHAwlQVtUcPko/a1ookS
 JrGg==
X-Gm-Message-State: AOJu0YxDtHZUqJYqCk2A5XGSQml+6gqUfloOkdmconLjTBVZpHywGo5A
 7+8UzxPkvuE/OmCujD3MStDm0UflqE9wAfNT6dE=
X-Google-Smtp-Source: AGHT+IFSNfP2GQN4MBoQKW5RAfiA4YpPnSWnOXEkg7zNqLuta/ckMQyJRLlFoTJPKez0+vfIw4kQhA==
X-Received: by 2002:a05:6512:210c:b0:4fe:5a4b:911d with SMTP id
 q12-20020a056512210c00b004fe5a4b911dmr6333069lfr.64.1693844784145; 
 Mon, 04 Sep 2023 09:26:24 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 n25-20020ac24919000000b005007cf8968esm1800299lfi.264.2023.09.04.09.26.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 09:26:23 -0700 (PDT)
Message-ID: <c73cfe51-c207-1279-4a99-428567edd6e8@linaro.org>
Date: Mon, 4 Sep 2023 18:26:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] docs/devel/loads-stores: Fix git grep regexes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230904161703.3996734-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904161703.3996734-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/9/23 18:17, Peter Maydell wrote:
> The loads-and-stores documentation includes git grep regexes to find
> occurrences of the various functions.  Some of these regexes have
> errors, typically failing to escape the '?', '(' and ')' when they
> should be metacharacters (since these are POSIX basic REs). We also
> weren't consistent about whether to have a ':' on the end of the
> line introducing the list of regexes in each section.
> 
> Fix the errors.
> 
> The following shell rune will complain about any REs in the
> file which don't have any matches in the codebase:
>   for re in $(sed -ne 's/ - ``\(\\<.*\)``/\1/p' docs/devel/loads-stores.rst); do git grep -q "$re" || echo "no matches for re $re"; done
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/devel/loads-stores.rst | 40 ++++++++++++++++++-------------------
>   1 file changed, 20 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


