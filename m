Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3588F75F40F
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 13:00:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNtHf-0001Aa-9B; Mon, 24 Jul 2023 06:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qNtHd-0001A3-Dj
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:59:21 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qNtHb-0003Fz-LZ
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:59:21 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so3790099f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 03:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690196358; x=1690801158;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8zq9R1TA+uMCYJe5xE9v0nOeAYFibusYATX+Yy2GpHs=;
 b=W/qBu19lyP4s+dMLWLk681xnmAKx8Nmf8dg4O8e7yVJDE1AXj9WOYjs09UvD1XZe8Y
 T1dPFVD1rP4iVpVW2uLdYGWqREiV631GsJ4cAtNM2fcWthQGJxFLBfhRVgl3pLSbUSG4
 UiIMsvLYzl7Qc1uXKi4JeFiVqMkQ52jFHuqwrtWYFFVQHF0hsnenc6bAlBAkNLDR/grq
 zMzC2cJvJinCPzzTry2g1XHP8TaFGEoIsjmkHkA0ointvaKJshWa/v4cKefcj+GW0Bbw
 FQkFh6Kami3+d/tLJCQf3MD2muZFrjGFjvHnu6ctLQmd2mjTCCKcoDszTB96ojdC/Sjv
 60Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690196358; x=1690801158;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8zq9R1TA+uMCYJe5xE9v0nOeAYFibusYATX+Yy2GpHs=;
 b=RKbfXN0CA12h9IACeccpP4En8YkQdkaEIKMTTUnQDVOpzCYvGOlxsymnd6db4ZQbI1
 Ki/ioSvkEzaahK73QwxAHAWgeky5VJfDnocFl6htT900M1V0fEiWascfJjLZwemc4dLh
 iCd83fIw1pmLuEVB9FJy3OH3yGtObstSXDFpxcyZOOELQ1SdcoL7bYESTYLPjQxPmCAv
 0K+ZuL7LbZQR9vtxLUBnzir8Bw6As88m3jZfRQc6Awurto5dpRUQPmk0szGmRY9Oq5FI
 eIeSNiQ77arU2SCHF1HOMaR4PiEUHJiVARXFaWmRr8LMzWDWPci2wYQNX6GsobiNDwgw
 wUrQ==
X-Gm-Message-State: ABy/qLZ/wsn/+16vrbTMkGHN0EyPPmzeg9PvHmtu/QYPJc/v3juBXEDt
 8gBIWd1ZAGnEnVO4l3zuVZaJNQ==
X-Google-Smtp-Source: APBJJlEi1BfHZd3NKkUtCePeCkc/x3htggNXwy+02L8Yp6yz5kzbgA2shV6ZX+OkQrx2+xm/BihNPA==
X-Received: by 2002:adf:ded0:0:b0:311:1b8a:b70e with SMTP id
 i16-20020adfded0000000b003111b8ab70emr7417920wrn.66.1690196358080; 
 Mon, 24 Jul 2023 03:59:18 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.210.255])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a5d4e0f000000b003142c85fbcdsm12516419wrt.11.2023.07.24.03.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jul 2023 03:59:17 -0700 (PDT)
Message-ID: <e147ad3f-5b5f-8e41-d692-5e2ce66d5f21@linaro.org>
Date: Mon, 24 Jul 2023 12:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] tests/avocado/machine_s390_ccw_virtio: Skip the flaky
 virtio-gpu test by default
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clegoate@redhat.com>
References: <20230724084851.24251-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230724084851.24251-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 24/7/23 10:48, Thomas Huth wrote:
> The virtio-gpu test is known to be flaky - that's why we also did
> not enable the test_s390x_fedora in the gitlab CI. However, a flaky
> test can also be annoying when testing locally, so let's rather skip
> this subtest by default and start running the test_s390x_fedora test
> in the gitlab CI again (since the other things that are tested here
> are quite valuable).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/machine_s390_ccw_virtio.py | 51 +++++++++++++-----------
>   1 file changed, 27 insertions(+), 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


