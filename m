Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA64A73E0A4
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:29:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmHc-0008Gw-E9; Mon, 26 Jun 2023 09:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDmHW-0008FN-ID
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:29:26 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDmHS-0000BJ-B5
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:29:24 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fa23c3e618so47419915e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687786157; x=1690378157;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fRrPm3TKAWCdJ/yxz1AcqpmxavE4TEeChV6mFdde5r4=;
 b=Tyr4kn7iLnpQmo0TDQrGVxgP8kmSHSZ1LCf9/Rxze/aLFK+vObX93yvxFma6ipfN5e
 f+0dCs2btLYfADzQArW0JxCmvrE+bc1V3CSGmOh+zm/A+idzwRl13vZ6nN3mbSkT8RBF
 o7StiMyGNiqX2zRYKa6/qmWGYlqZ0WsyrFY2ZqvN9XP5GkcWGhK61/kc4Mq7x60EHBpC
 7Cx7vHqGL6rBG/PyJIKOffflCOLGn2fTeZLoh+wr8G+F8FdHUofSRRNb8cOIlJUzSghV
 aBQ67Tn8vccssajyVFm56VEpjvi9WIoo2JAZRAJJncRD0PIsN/rw1sna5nfhczk3yJMl
 UaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687786157; x=1690378157;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fRrPm3TKAWCdJ/yxz1AcqpmxavE4TEeChV6mFdde5r4=;
 b=RKvz2RYgQUD9zJXyUzFZ7MVTuZ7ISXlbf6ylHcl9WLwAA+y8B7EoCfigDzoLSZTsI2
 jj6SKxrfGfhhuvOiEK2vbZx57VFCaSqhHn+GTIygoTuensyJDy3+w8Lt1YtT9PZIMg8j
 999M7WbSneuwxKE/KZ2CM9NvZ1pvF8nvAP6uhlRjcHK2BBASWhBGjivDKe8ojhuWOnML
 T9iwoW+eWl+Gm81g2KaAima3poFi1Pa034/iBg4x8BYrypKcYiA45J0/+XpO/A2VU92D
 msCbqOeAknamG7cWEw0DdXVvhfhXtMYDnUJbMU40Xn8VKzGR0LXK51hKWm9w9QtL90g3
 OE8Q==
X-Gm-Message-State: AC+VfDzTUsc2WNZlLTnMBqoIVhCbgvYLGtkr1XHmGhFCLS87M4gbuyiF
 5Q+otbiax8gsQDs0YzWhr4Y70A==
X-Google-Smtp-Source: ACHHUZ5w3qbaGUs3bQbclvmyWMflxb7NSVkK6by6zE5YJftdHdGF60InubXcZ58ewhrf0eRFr0thiw==
X-Received: by 2002:a1c:7906:0:b0:3f9:3853:9d6a with SMTP id
 l6-20020a1c7906000000b003f938539d6amr20769888wme.12.1687786157303; 
 Mon, 26 Jun 2023 06:29:17 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 c25-20020a7bc019000000b003f819faff24sm10668454wmb.40.2023.06.26.06.29.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 06:29:17 -0700 (PDT)
Message-ID: <6828f8b7-b923-af04-2eb8-a8222f36baa4@linaro.org>
Date: Mon, 26 Jun 2023 15:29:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/30] Next patches
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Leonardo Bras <leobras@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
References: <20230622165527.2417-1-quintela@redhat.com>
 <1f5c4a38-6ae2-53dd-d739-65accb1d86a8@linaro.org>
 <87leg719rs.fsf@secure.mitica>
 <a614493f-1e3e-1d6b-13df-702be2b1bd8e@linaro.org>
 <874jmue5mi.fsf@secure.mitica>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <874jmue5mi.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/26/23 15:05, Juan Quintela wrote:
>> The "full logs" are
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/4527202764/artifacts/download?file_type=trace
> 
> Not useful.  I was hoping that there is something like when one runs
> ./tests/qtest/migration-test

I thought I saw some patch today that to save more artifacts.

But the bottom line is that we don't emit enough stuff from any of our tests to debug them 
from logs -- we're too used to using other methods.

>    And I don't understand what CFI is (and I don't rule out that
>    posibility) or I can't understand how checking indirect functions call
>    can make migration-test die without a single CFI error message?

CFI (control flow inspection/validation/somesuch) adds checking along call paths, which 
may affect timing.

This is almost certainly some sort of race condition.

> Do we have a way to run on that image:
> 
> ./tests/qtest/migration-test
> 
> in a loop until it fails, and at least see what test is failing?

Not as is, no.  You'd have to create a new CI job, and for that you'll need advice beyond 
myself.


r~


