Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6E470DD32
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:08:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RkB-00085p-MK; Tue, 23 May 2023 09:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Rk9-00084G-Ku
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:08:01 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Rk6-0001AB-Ta
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:08:01 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-52867360efcso5185852a12.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684847277; x=1687439277;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u+2BQVDycy6R5QgstKKXciGmTZaWmdiDAfqwx8hVWTQ=;
 b=m0DzMeHAjrIOzNn/z2Ylx2FcIV0xH6bM+nxPLBE6cH/H8cjiS7pPgckc4dzyKhtHvO
 Cdxga2990j3VP5JtUY4vWNN0Ov5nKBilheYq5ewEiI8FdpoVo0mYVGk1Y4kvVnuYaqSx
 MqqBRMuQ7LUu7MOXVGyZwOuhWXnq69dOxqO3H7NGb0AvBkwPaE0jLM3mUG/pJ040oNxe
 FqExv/qx9PSOZHR9YtaMH6spHcyMjkPiURnWu9UXC8gm2Dd0N2JV3mfP+4i8uMvmTpld
 YarX8X/9GdxNlk7Gw6O25cZ+M4wkWXVcO6pC0zBopH/+RW/hbKaNcesVXOj1NauMz7tX
 QJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684847277; x=1687439277;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u+2BQVDycy6R5QgstKKXciGmTZaWmdiDAfqwx8hVWTQ=;
 b=d5Q5ON4olPCRLwh6eiiODjjRwZKyTtqhuP4PABF/EPEPP5D6i896BtYEdyAJTpQQaN
 Mik6/Y6RMjJZA6MH446gXW3b4ObdIZ1UO+1AD8AFKISwByzjLJKb9/1BeWSq9ripjT9k
 +SDF+Ag2MncBy8kCALciaRA5I0yeyUiG2G+f1SokA1H7iZsOTSf5PVqxIHNtsAmvw5Lk
 LnpQm8KQ49mlAVncqJnZAQKJ1QmDx50bVOY3vcVECWGnaCPaUOI1PNbnBjefV7OelEk4
 iBdWXbSZHeqLmRsA6gLzGDIffueIjMrGEdRWLzklbB2hPkQW3QfZKNqnExWk9UYjV7Vp
 8/iA==
X-Gm-Message-State: AC+VfDxREwEvmAdIn8FWbBciyp3FRHCoEnfLeZ3us9Sdxb7c8BgbWPNO
 B1HV0d07brHWqbzBN++V+gWWcw==
X-Google-Smtp-Source: ACHHUZ7uPhmG7y6NGqKG3r2k/cpPEF4gn/R+Hv1i77OvJsMAgOWdvFLwsW4K2arLmMz7XW763ZP9PA==
X-Received: by 2002:a17:90a:e387:b0:255:b5ac:dd8a with SMTP id
 b7-20020a17090ae38700b00255b5acdd8amr1295988pjz.42.1684847276847; 
 Tue, 23 May 2023 06:07:56 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 q65-20020a17090a754700b00253298287ccsm6298343pjk.14.2023.05.23.06.07.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 06:07:56 -0700 (PDT)
Message-ID: <b30f4f2e-5784-5c7b-8f13-aa12c61bae23@linaro.org>
Date: Tue, 23 May 2023 06:07:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Add CI configuration for Kubernetes
To: Camilla Conte <cconte@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, thuth@redhat.com
References: <20230522174153.46801-1-cconte@redhat.com>
 <d08d55dd-f38b-063c-d64e-9a0f79dbebf9@linaro.org>
 <CACPOWh0w=YEeGgG8rc1C-fOmfvRwVo4NVTqjARRwZNWEPjZehQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CACPOWh0w=YEeGgG8rc1C-fOmfvRwVo4NVTqjARRwZNWEPjZehQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 01:24, Camilla Conte wrote:
> On Mon, May 22, 2023 at 11:52 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> This does not work:
>>
>> https://gitlab.com/qemu-project/qemu/-/pipelines/875254290
> 
> My bad, sorry. I didn't update the runner with the new values.yaml.
> The Docker environment variables were missing so it's looking for the
> Docker server at the wrong place.
> 
> Now I updated the runner. You have to add the "k8s" tag to the runner
> again in the settings:
> https://gitlab.com/qemu-project/qemu/-/settings/ci_cd#Runners.
> As soon as the "k8s" tag is there the pipeline should be able to run.
> 

The k8s tag has been there on the runner all along.  Did you mean something else?


r~

