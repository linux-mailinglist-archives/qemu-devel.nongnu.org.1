Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BE57BB2DC
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:14:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qofxE-0007zz-3q; Fri, 06 Oct 2023 04:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qofxA-0007zk-TA
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:12:56 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qofx9-0004Hw-1H
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:12:56 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-406650da82bso16475805e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 01:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696579973; x=1697184773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KLN9IZSumui8KeXQErmwczcaiwnpvY9u9u50l7Thhdc=;
 b=bQeVQ+x88VhvS7AkULKcTqHKCpgCGZ8+oH8x7eXxfKZ3pgVxrZWAiERT9u7AvbV3vu
 Ue0J4z6okSXU8ZzCtDFAkE58C/6IwqT8oroWCrI+k2FX4FKB42z5Y5yawsgIwXG967ui
 PY5au19wsQsfsFF1GFNaZRqhuI8beuah+9xFvxW6Bkp+3qYGs19N1xROPhGvqAz8DYS2
 3v5zYuSuxeGn/foz5tuJtDQ6ctPos9klNpynoRTL7R47aWXHsxmYpijVUwUXRi33pZXg
 ShmOp33mHEQYl8J2xzDQS2OG6YtQxqUHKuwF+29cSEfowjJ87sUbukJ+0rt/PQHl+Wr6
 Dx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696579973; x=1697184773;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KLN9IZSumui8KeXQErmwczcaiwnpvY9u9u50l7Thhdc=;
 b=i7y/S8iIilsMrBAVmTFbexuy6WtOGytjhb27Sm8zkkgSkr01UJNlMVF0GBUVZALD5o
 kAXmY4qPyCHmps7HhALQw4oQ+gIiouAz1uXlwj59wlxdQqlVCN24W/Dc1cHSBWSa2smc
 BpWkDrEDTnYuZysJJQvSTXKuUUd9DJQrtdd9qq+qr3ewMo84frldFn7PcZi7ooTl+qWU
 NgQOvA/WdRUcqtUpKEY2OvpQJYK8evRIxozEmejD3vfKSfEwPY4kOHm9FctwDVH6gWQs
 IMn13S0+sjuhrQzLuy8fCmBA5JMXqy/wHO+/2eJJOht8xpso03WAInytC3++4Zc3Odd3
 Rtfw==
X-Gm-Message-State: AOJu0YyINjWIMSlIW1RKAI+Ey606liVZL0LNAW1VnNQbSINKrjamiRL8
 6IBK2ptQpD18TcPMvaiv8CroQw==
X-Google-Smtp-Source: AGHT+IH1bie+SABHMYXDkTGAi75JwBVN4bJBwVmqITE+viOmrcobMOD1Bsk6r1tRdNPNsxSD7SRktQ==
X-Received: by 2002:a5d:484a:0:b0:320:1d1:71c4 with SMTP id
 n10-20020a5d484a000000b0032001d171c4mr6995893wrs.23.1696579972761; 
 Fri, 06 Oct 2023 01:12:52 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.115.173])
 by smtp.gmail.com with ESMTPSA id
 e18-20020adffd12000000b0031980783d78sm1041903wrr.54.2023.10.06.01.12.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 01:12:52 -0700 (PDT)
Message-ID: <e6b1427d-1213-4baa-100d-c2081c53c703@linaro.org>
Date: Fri, 6 Oct 2023 10:12:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH mcdstub] first version of mcdstub
Content-Language: en-US
To: Nicolas Eder <nicolas.eder@lauterbach.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Christian.Boenig@lauterbach.com
References: <20231006074148.17719-1-nicolas.eder@lauterbach.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231006074148.17719-1-nicolas.eder@lauterbach.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
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

Hi Nicolas,

On 6/10/23 09:41, Nicolas Eder wrote:
> SUMMARY
> =======
> 
> This patch-set introduces the first version of the mcdstub.
> The mcdstub is a debug interface, which enables debugging QEMU
> using the MCD (Multi-Core Debug) API.
> The mcdstub uses TCP to communicate with the host debug software. However,
> because MCD is merely an API, the TCP communication is not part of
> the MCD spec but specific to this project.

[...]

Thanks for this contribution!

Unfortunately your patch series isn't correctly formatted,
so it is too hard to review as it.

I recommend the git-publish tool which usually "do the right
thing" and is very easy to use:
https://github.com/stefanha/git-publish#how-to-install

Looking forward to review your v2!

Regards,

Phil.

