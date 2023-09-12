Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D8679D95C
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 21:11:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg8mK-0002Pv-8O; Tue, 12 Sep 2023 15:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qg8mH-0002Pe-Pv
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 15:10:25 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qg8mF-0006AS-CH
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 15:10:25 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68fdd5c1bbbso123963b3a.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 12:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694545821; x=1695150621; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J0F7emHqf7jwZ0AzaPOVzUlYIxLK3bJ8bGEf+7nTrOE=;
 b=fvvInD030aNdLWmmrQWdpbn56AYlAt8Ka86/9sXlKzl0sp3yiEeZAcDhyVdWU7gL2N
 N+HOChTg826KwIjw/e+gBdgSSNVQ1le6gMahqYMjrXWPrz9uVdWkJ+DrI9HlvETk3c+O
 SujTiLdYH1FpADyBBNCUf5SFs9nlMMIbfXbcVATaxiuoJAEo1rSQlaQ39r4uxoow2YCW
 DIwL9+uFlEb/7k8C29j9PCnPb9qQFuALub5sMncvrnnCKOJPvnogJa2ohFhzBZ6X4Hz7
 80xd87VKSmRjtW5pXdzA001blbOnqE2c4qKhQS9fxC0wY0ZDwa9RKvU385hlR+O50es2
 Md4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694545821; x=1695150621;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J0F7emHqf7jwZ0AzaPOVzUlYIxLK3bJ8bGEf+7nTrOE=;
 b=K88KOqjAMBjcFFZsMgu/skJXQt1KO7zqC3Cjo6DHE37z1JOv2b8zKRipr69nRXaoVm
 kCNCHA3zveMJFXxVbbEu2zAZMQO8xXxZiV8C2rcmGTjbNQFv/T+4T9nlI4CeywfKDUYj
 mfpXaPPrF++Iuzp4uTrf2ImvOJfsaofCb1HPBTbgxyvJoxatGU/iexLlhL/vdkfargW5
 j9ao7pBxiQF4TkH/FJj7Cha68x7W/TnwqlXIx2XwjtLyWxo2xk2Q3WjjYDw+1RETvMZh
 Tx4Zh0QxMgsSJELS/20mEC7H8e60WH9beGqetuHCA0HHklsTyVQIoLCatIVNxT+HyEqC
 Uu5w==
X-Gm-Message-State: AOJu0YwE2HJZ6rMwWbeu2FOiKSo2o4n/mEFsN3lE48SAr90GxzGAkyGR
 hvwRgDB/lQjOy7Ux7e6pcWwhtw==
X-Google-Smtp-Source: AGHT+IHuAWe+Grn9yxLGFss6l//zQ/MKZXjCs43cx+dg1u2DAsDHtd0TJ2Ag0SUVu79QLT0uafs3JA==
X-Received: by 2002:a05:6a20:1607:b0:133:38cb:2b93 with SMTP id
 l7-20020a056a20160700b0013338cb2b93mr703439pzj.9.1694545821447; 
 Tue, 12 Sep 2023 12:10:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 g19-20020a62e313000000b0068fe7c4148fsm1710364pfh.57.2023.09.12.12.10.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 12:10:21 -0700 (PDT)
Message-ID: <61724857-2edd-e19b-aa37-23658cd4119b@linaro.org>
Date: Tue, 12 Sep 2023 12:10:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/4] microbit: add missing qtest_quit() call
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230912184130.3056054-1-berrange@redhat.com>
 <20230912184130.3056054-2-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230912184130.3056054-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 9/12/23 11:41, Daniel P. Berrangé wrote:
> Without this call, the QEMU process is being left running which on
> FreeBSD 13.2 at least, makes meson think the test is still running,
> and thus execution of "make check" continues forever.
> 
> This fixes the regression introduced in:
> 
>    commit a9c9bbee855877293683012942d3485d50f286af
>    Author: Chris Laplante<chris@laplante.io>
>    Date:   Tue Aug 22 17:31:02 2023 +0100
> 
>      qtest: microbit-test: add tests for nRF51 DETECT
> 
> Fixes:https://gitlab.com/qemu-project/qemu/-/issues/1882
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   tests/qtest/microbit-test.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

But I think that it's unfortunate that we have to remember this for each test.


r~

