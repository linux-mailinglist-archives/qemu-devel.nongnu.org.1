Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBC379E05C
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 09:02:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgJtD-0005MU-2Q; Wed, 13 Sep 2023 03:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgJtA-0005Lu-7p
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:02:16 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgJt7-0004mh-F3
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:02:15 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9a65f9147ccso822002566b.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 00:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694588531; x=1695193331; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=85CbbVJd8TONyyOoRyZNIHQeEqb4MnQuML0d14mjkUs=;
 b=ZckpKRb8k0mXRH/py4Epw35DX8BTwxGmktMD7IW29p5u93QTO6iAkKkXGzB1/oqJXb
 d8RA5C+7tbBj9SnVFGJeQu5MftktmdEJptM3hCbnWyv1AkQqeze0bLhNPzOukX+6z7MS
 fVx3h18pc+MXpl8JxdiNR4CJwworhaZh5efMNrs4tkqK5DAkisjbSguwor4qEyCBeRbK
 66TSNa7frJQHct5VR8fmAL52Q+iz7tKT4VwJpCkvCMGlyaOwz4GY8Hkw0azokJ/uRvEL
 Fcyqp0a0UIF+ESybA/ta1RoB+S/AH29J19zJPJCCGNQ67RkAeDdA6P4vq3HM75NWzoAu
 mLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694588531; x=1695193331;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=85CbbVJd8TONyyOoRyZNIHQeEqb4MnQuML0d14mjkUs=;
 b=qiMHw0NUT3/hXFBZ4kxyBOae0rggeRXoiMgbJlMEUp4iQFwBhOnBmTtaGGlHcW43AZ
 k1x7L1+As4HNHlfubDcz+fM7AtHmYMKI7DoLWnppOo1L67eOLp0xz9ettGA3k9xlK9jN
 zqIeDRxZReBfKP8BRu25nNhzQFqhMC+Tkhb5dXIulrF3HfOJ9ZklNL3TXOTIHENOp5MU
 +3J5x00dWhlTW3hetzkk/DLF310GlGxml9+69OHNbT5AGcQjupHK269K3Zj3nmVDNPRj
 ENoPW7JcXLQL4rcKGMKn4ITcjTe4KnuDIKa/75udwxhLcDINGEGuHUktvrHeYOfki+LA
 5WhA==
X-Gm-Message-State: AOJu0YwRDVSYF18Qzhb+1hls1dnQPbmk8fNwCvYqRoH7cxa+9119YmWn
 DXJzjuk4jYcAG1sQUbOkOeWvnw==
X-Google-Smtp-Source: AGHT+IHzgVDU+TFpUQRD5n2CptSkhQo8r25290rpY8FT21DA1Di+VZK6A6H6IqC6+pkwRrFNwi7WZg==
X-Received: by 2002:a17:907:1de5:b0:9ad:7d5b:dc11 with SMTP id
 og37-20020a1709071de500b009ad7d5bdc11mr1127931ejc.33.1694588531606; 
 Wed, 13 Sep 2023 00:02:11 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 kj13-20020a170907764d00b009a1b857e3a5sm7866469ejc.54.2023.09.13.00.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 00:02:11 -0700 (PDT)
Message-ID: <067801c9-2e46-af82-88f4-d3114e71fe54@linaro.org>
Date: Wed, 13 Sep 2023 09:02:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: CI container image interference between staging and staging-7.2
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>
References: <CAJSP0QXukZuLRF0x1Yt06n2rbeOMAAG0SRsx4Z_QTTro9vMFTw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAJSP0QXukZuLRF0x1Yt06n2rbeOMAAG0SRsx4Z_QTTro9vMFTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 13/9/23 01:07, Stefan Hajnoczi wrote:
> Hi,
> TL;DR Michael: Please check that the staging-7.2 branch has Dan's
> commit e28112d00703abd136e2411d23931f4f891c9244 ("gitlab: stable
> staging branches publish containers in a separate tag").
> 
> I couldn't explain a check-cfi-x86_64 failure
> (https://gitlab.com/qemu-project/qemu/-/jobs/5072006964), so I reran
> build-cfi-x86_64 to see if it has an effect on its dependencies.
> 
> To my surprise the rerun of build-cfi-x86_64 failed:
> https://gitlab.com/qemu-project/qemu/-/jobs/5072087783
> 
> The first run was successful:
> https://gitlab.com/qemu-project/qemu/-/jobs/5071532799
> 
> Diffing the output shows that the software versions are different. The
> successful run has Python 3.11.5 and meson 1.0.1 while the failed run
> has Python 3.10.8 and meson 0.63.3.
> 
> I think staging and staging-7.2 pipelines are interfering with each
> other. My understanding is that build-cfi-x86_64 uses
> registry.gitlab.com/qemu-project/qemu/qemu/fedora:latest and that
> should be built from fedora:38. Python 3.10.8 is what Fedora 35 uses.
> The staging-7.2 branch's fedora.docker file uses fedora:35.

Isn't it clarified by this commit?

commit d4c7a56539d0bdb6fccf60af94d528613cbc7c4b
Author: Daniel P. Berrangé <berrange@redhat.com>
Date:   Thu Jun 8 17:40:14 2023 +0100

     gitlab: centralize the container tag name

     We use a fixed container tag of 'latest' so that contributors' forks
     don't end up with an ever growing number of containers as they work
     on throwaway feature branches.

     This fixed tag causes problems running CI upstream in stable staging
     branches, however, because the stable staging branch will publish
     old container content that clashes with that needed by primary
     staging branch. This makes it impossible to reliably run CI
     pipelines in parallel in upstream for different staging branches.

     This introduces $QEMU_CI_CONTAINER_TAG global variable as a way to
     change which tag container publishing uses. Initially it can be set
     by contributors as a git push option if they want to override the
     default use of 'latest' eg

       git push gitlab <branch> -o ci.variable=QEMU_CONTAINER_TAG=fish

     this is useful if contributors need to run pipelines for different
     branches concurrently in their forks.

     Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
     Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
     Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
     Message-Id: <20230608164018.2520330-2-berrange@redhat.com>
     Signed-off-by: Thomas Huth <thuth@redhat.com>

Michael, did you forgot to set QEMU_CONTAINER_TAG? Maybe we can add
a tiny scripts/make-stable-release to not forget?

