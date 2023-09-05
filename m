Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64773792230
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 13:38:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdUND-0002lr-Cu; Tue, 05 Sep 2023 07:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdUN7-0002lU-Lv
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:37:29 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdUN5-00087q-G7
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:37:29 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fe15bfb1adso3993494e87.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 04:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693913845; x=1694518645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8cA4LaZPYdX2qA/FRnn2B//GAlzcmxN1oP7iyNSnrps=;
 b=N+igbgzWJAmZ+YMyGkdg7756Hy9QeP4Y43j76H8F7RMoEiWDWAuyLnpC2eqQ9Ajulb
 Tl7x0FV5TQGfNo4ArxhCSVDYYCaGQfwFQ/fzCuc3OaR+cKk9vVRu0lZO1RPypK76YmF4
 X5PqnsgVFCk6kil86ZTDKGhcsvU9Ix7WVuqu+awV3+LILGO15zLy+/bqIOiBq7WSB5Wr
 z9kMoSfImpLdNuFchjWaWtjW6VLuQzbtaOmKqmv+ZskyP12Sgi/0E7vne+lw8jctTW4f
 F//qfUFrsglm7JLAH7JXTu0b9bxTODgtd7OHkOWrhvAHlmXyRhFApVke4cxCj8jrxZwp
 Ot+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693913845; x=1694518645;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8cA4LaZPYdX2qA/FRnn2B//GAlzcmxN1oP7iyNSnrps=;
 b=a2Ra5mpl62DkLYvRlPelhQOgsVGbLDqcdSFaw8miFAqxA6oj4ecugwrrY60br2847m
 UziSLII/J6m+kmKzdunPrX4YMe/VCXxCYqFykXSsUjeyBS+VbdxmUEKsJ++ZyAW1ZI9v
 O3KXV/iU8l4HyVzDaQJucarXroUgmePGRkk06nDnyoh4nuw8Bh0IUmpnGDh8R1dVutcq
 XYUGwL1iyK/bXqij2wjFQGrk5oFOMOMvP9qsNq+H43aaRw8PKawxUghk80Ia3zss+Y/v
 wgpC9Ea/VtjXl+HKqTe5g4pyqGEeOeORoy1bal2y5MGwhIQ/2aj7wegXywGAYIKCSIYc
 jbQg==
X-Gm-Message-State: AOJu0Ywd1fI9iheqFZ/NIqp8/GyC8ZNiHHcs2BaI1wdWLaAKwb2w2QNt
 0qgWtL+/NJoYIZUd/azZfUATWg==
X-Google-Smtp-Source: AGHT+IE4f81fVQh64kzpcGjQpVlYzkTfB+xBsaXcFNorM7xNmmTaAbhJ4tQ5bT/72TGZvJPmX3AOGQ==
X-Received: by 2002:a19:711a:0:b0:500:9de4:5966 with SMTP id
 m26-20020a19711a000000b005009de45966mr6724579lfc.62.1693913845412; 
 Tue, 05 Sep 2023 04:37:25 -0700 (PDT)
Received: from [192.168.1.34] ([37.69.27.38]) by smtp.gmail.com with ESMTPSA id
 f7-20020a1c6a07000000b003fe407ca05bsm19842822wmc.37.2023.09.05.04.37.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 04:37:25 -0700 (PDT)
Message-ID: <f301930f-b5c3-0ea8-a584-789bfa978a35@linaro.org>
Date: Tue, 5 Sep 2023 13:37:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v4 11/14] simpletrace: move event processing to Analyzer
 class
Content-Language: en-US
To: Mads Ynddal <mads@ynddal.dk>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-12-mads@ynddal.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230823085429.20519-12-mads@ynddal.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 23/8/23 10:54, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
> 
> Moved event processing to the Analyzer class to separate specific analyzer

"Move"

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> logic (like caching and function signatures) from the _process function.
> This allows for new types of Analyzer-based subclasses without changing
> the core code.
> 
> Note, that the fn_cache is important for performance in cases where the
> analyzer is branching away from the catch-all a lot. The cache has no
> measurable performance penalty.
> 
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> ---
>   scripts/simpletrace.py | 60 +++++++++++++++++++++++++-----------------
>   1 file changed, 36 insertions(+), 24 deletions(-)


