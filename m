Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF54769271
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 11:55:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQPbY-0000JK-2K; Mon, 31 Jul 2023 05:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQPbV-0000Io-BP
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:54:17 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQPbT-00018v-Tx
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:54:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc63c2e84so48139195e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 02:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690797254; x=1691402054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Qz4OAbAFNOND2APMQsSmCuoR0Fp27cB+2i1X/oa0YQ=;
 b=P0lSNHE/8wZgFJ2wXDHcGNJHLSugfpfnzJeedD7P1EIso4yhddM6O4coEQWkUuqr+P
 yQv2tKC91c8Ltu1YWBC6/lOqm2L/HrsVPcBSoLLPNH8hVpeLKDBqwuXapyGXOSVJV1Yh
 gQQ9Fi/OuAlkM2VLx/n5Lzfm1Gsw+eaiD+FqNaTNtZIPkrctzYLvQ4+Z6tHW+ubqsEUQ
 D//7WI5NMcTzsoI1kSnbhGlYb7lbeXg+nKe31dVkIH66AsX5zkmqxdu+riWQzmsy42n5
 hSlBjV0LPn/lcfYvigFuG/tcaUaPo7H6f0PVuegc/PDp5haWDF+z2DHe0JKWypgZvpUQ
 4SuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690797254; x=1691402054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Qz4OAbAFNOND2APMQsSmCuoR0Fp27cB+2i1X/oa0YQ=;
 b=MFCdEkg4Q480plGCRhYsonxYyx2TF3OrCxYdTeu4a1YKYNAp7WmLa3W1DzZvBCYYFP
 Vy3B64TEHeobDiQwFAWoaSVXJv0MHz2qZYPDtWHurOx9VzUbszgWLx1F/BnNxZ7OTogz
 QcGuQ8f60FpO3b1Rm3osVFz5LSRFoY3/Lu1DihzEBBkLnLTXMX5lBYATSBFj4ExyoxGm
 Dl4ffqfkzL5iTF4aDrLVQBgzHD5hl37VMfRe5CTsOqazYraJ/ELgv2elJpnlySuqEQ+X
 /EV7NZCsWc1QY63o9u+XpbKxioey6T47oB69bFRfaOmZm1cubWFvYYBJagsi473ZzMEW
 1QeA==
X-Gm-Message-State: ABy/qLYiCR1iNjd4sVP6wlr4uH4uKEAzLztdU0ElWS2O9aEDdpwylgFI
 mSxEdNTqvgDJ4k8aYsnzi8SgkA==
X-Google-Smtp-Source: APBJJlGfpvIh7WjZ3VSv0MN7yOlpYFJCGQcGV0Aws8MbaoayVLB4NvyhtwehrQfKasNCcL/Km09QMg==
X-Received: by 2002:adf:f74f:0:b0:317:6a8b:73f1 with SMTP id
 z15-20020adff74f000000b003176a8b73f1mr8460643wrp.32.1690797254516; 
 Mon, 31 Jul 2023 02:54:14 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.143.207])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a5d6a86000000b003143add4396sm12543248wru.22.2023.07.31.02.54.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 02:54:14 -0700 (PDT)
Message-ID: <1f4209cd-41c8-8ece-7656-4eb28603fc3e@linaro.org>
Date: Mon, 31 Jul 2023 11:54:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/3] qapi: Moved architecture agnostic data types to
 `machine`
Content-Language: en-US
To: Dinah Baum <dinahbaum123@gmail.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20230730064057.357598-1-dinahbaum123@gmail.com>
 <20230730064057.357598-2-dinahbaum123@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230730064057.357598-2-dinahbaum123@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 30/7/23 08:40, Dinah Baum wrote:
> Signed-off-by: Dinah Baum <dinahbaum123@gmail.com>
> ---
>   qapi/machine-target.json | 78 +---------------------------------------
>   qapi/machine.json        | 77 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 78 insertions(+), 77 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


