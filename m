Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1A67196E4
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:27:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ea9-0003eW-J9; Thu, 01 Jun 2023 05:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4ea6-0003eI-Ji
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:26:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4ea5-0005qR-6f
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685611611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CddVgBPwxR4w1FzHVjg48jBFWbJ/cEXwMdtkJb0FM4c=;
 b=POHwpzRH0MKvHwhpDi3oite5W3FrDrmjFYKRavVxmxfF6n1M3l/XlDSZJeersiV3TM6WBg
 KnZjLE72dTOQXw9XM39sc7n+63uFOZdZVcU6Z2iy2VqUr1mjekXHoj2zDChK+f7cFLFXRN
 J17V9CBh3Yt5wjlHlrj602Baz04Y51A=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-dOqpCjTLMuulg2jZst7L1Q-1; Thu, 01 Jun 2023 05:26:50 -0400
X-MC-Unique: dOqpCjTLMuulg2jZst7L1Q-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f4e06b3c6aso445620e87.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685611608; x=1688203608;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CddVgBPwxR4w1FzHVjg48jBFWbJ/cEXwMdtkJb0FM4c=;
 b=Sui8oFnIplBosThYZYPzrtwYT89WGuVejxZbiroVuI7XN0faFL+TtkTSAWl9TU5n+o
 PjBCMQhwDeTg/cXnsiKYbHdjTDi3MiTzenWTfsVXPlLScOZoc5P6QjJTkf1IrB4T+CZK
 Fwv3Xmt7YBwJtuimGa7ZHuyaoCUU0E9oqC8PqjAE7UcUqEdSmvPLqW4ulfYbKC9drcsJ
 +7vwhGYZHmqzWFeC/wTmxI4v9gYm18fhdHLrYPZZirJd1U+BhbcQZt9KVpuMC+fzCgbe
 h4oZAVeSDL2dLapruk1ZggT4Xp7XW+cnUzYBNYNkz97+W3/FO/PD+CbzRNy8fv2bok27
 L9sQ==
X-Gm-Message-State: AC+VfDwXaROwCqrschp5Nmc2BKCE/gdr3ihlmqm+ODnj3ETuORZKHe+W
 pEYEBY67MLEDey8qwyCqDT9Z49sBGAQpQYkUyuaJuGWYUP53tvvhurJ4ndXZfekN2ewWRF7nu2v
 1om8JSFoqKUaJkFA=
X-Received: by 2002:ac2:592f:0:b0:4f3:8823:ebdb with SMTP id
 v15-20020ac2592f000000b004f38823ebdbmr866308lfi.34.1685611608754; 
 Thu, 01 Jun 2023 02:26:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7HgiRQUZQ+lqOqaqszI2hQjt3vvtYeNtCD7LPB0tRBuFJE3+Z/99RLWFP6xMPnkBD7i9F+bA==
X-Received: by 2002:ac2:592f:0:b0:4f3:8823:ebdb with SMTP id
 v15-20020ac2592f000000b004f38823ebdbmr866298lfi.34.1685611608474; 
 Thu, 01 Jun 2023 02:26:48 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-86.web.vodafone.de.
 [109.43.178.86]) by smtp.gmail.com with ESMTPSA id
 d24-20020a1c7318000000b003f6129d2e30sm1691920wmb.1.2023.06.01.02.26.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 02:26:47 -0700 (PDT)
Message-ID: <7e0f528c-ba81-068c-46b6-e0f3142ec1b8@redhat.com>
Date: Thu, 1 Jun 2023 11:26:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/9] tests/qtest: get rid of 'qmp_command' helper in
 migration test
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-4-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230531132400.1129576-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 31/05/2023 15.23, Daniel P. Berrangé wrote:
> This function duplicates logic of qtest_qmp_assert_success_ref
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/migration-helpers.c | 22 ----------------------
>   tests/qtest/migration-helpers.h |  3 ---
>   tests/qtest/migration-test.c    | 29 +++++++++++++++--------------
>   3 files changed, 15 insertions(+), 39 deletions(-)
> 
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index f6f3c6680f..bddf3f8d4d 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -85,28 +85,6 @@ QDict *wait_command(QTestState *who, const char *command, ...)
>       return ret;
>   }
>   
> -/*
> - * Execute the qmp command only
> - */
> -QDict *qmp_command(QTestState *who, const char *command, ...)
> -{
> -    va_list ap;
> -    QDict *resp, *ret;
> -
> -    va_start(ap, command);
> -    resp = qtest_vqmp(who, command, ap);
> -    va_end(ap);
> -
> -    g_assert(!qdict_haskey(resp, "error"));

What about this g_assert(!qdict_haskey(resp, "error")) ? 
qtest_qmp_assert_success_ref() does not have this assert... do we still need 
it somewhere? If not, please add a comment to the patch description why it 
can be ignored now.

  Thomas



