Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 563AA76BF82
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:49:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQxEU-00017o-Qs; Tue, 01 Aug 2023 17:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxET-00016z-BW
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:48:45 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxEQ-0003oP-OR
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:48:45 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31751d7d96eso5219338f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690926520; x=1691531320;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fG70qcc+1kQrlSnAh1H0yZsx4R6wJoKoDd2s3u55gh8=;
 b=nR7NhdNNx1gSO8um4jMbC2UsVzyIb5poMeBomiTtg4rlmLFM0pOJxK+061YwankVqf
 rAHGXTq96w6P/kAGU8ib4cJgi5kxW/YztqdzXg6FgFEI634C1c9iaT2tSCCiRExh1Byr
 oLNbpgkqacuJ9INz8tNV051Gq0Ric9WfcF4eyd6pPAKhtKBFVdW44OWcoab7dqZStSy5
 +CpGqydPT//tdUqJrd4xljkKfBM0X1rG6ZiesZw680rDW/dvaEw0TlG4N+WerlZ1+uho
 972Xj8vSRcQVYq0P4mRjUJN8EE1eArI4zKaB+PCm+jvNsDUT0DMhGTA7pKHtL1rcRT5d
 l1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690926520; x=1691531320;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fG70qcc+1kQrlSnAh1H0yZsx4R6wJoKoDd2s3u55gh8=;
 b=WZhIwuVLBCAfIsZ7zFw1geMkl0+yslmJn8IQTAN6O66UegyuNAqTyzJ3qJjhrWPKiw
 5qcH9qPnPuX5/Y1JSgM9lSg1+4RapXHsCdRwLmXnREXIjvn8HBb6gLl3rIE/XoboEjhQ
 LJsbQE1gUvWuftuFk/iKQWNlHhinm/dnD+PbJWzevHW3KUKs2cVNG9kz6nOib81q5T4+
 dVglNEoykXkQfKCjihLQuhvCb/V+YALe8pYldNRIOweyHTZnZsDq0A2eCAxj9ivbQEfw
 KASvAWhAmI3xo61o3RESZOtrgNmfOyRdH2JoekhKgTnTTvo+sVNPT0VPg4yBr2zCUSAE
 FJTg==
X-Gm-Message-State: ABy/qLag3tqBCEg7zNuhZp9iE+8fkJ2rK8cTi7pmKmSZSS/GAl0MxdDX
 HDHaTZzDwJTOlZsGf2vfVfRw1w==
X-Google-Smtp-Source: APBJJlFu8gdGUAMkRUzJtP/df5wjNFKGKw4gkJLIkysqendRTIRCaoBxx4Jq6NJ8bH1mIAbxAeYvzQ==
X-Received: by 2002:adf:e9cf:0:b0:313:f61c:42b2 with SMTP id
 l15-20020adfe9cf000000b00313f61c42b2mr3061083wrn.69.1690926520487; 
 Tue, 01 Aug 2023 14:48:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 d14-20020adff2ce000000b003176053506fsm13386334wrp.99.2023.08.01.14.48.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 14:48:40 -0700 (PDT)
Message-ID: <9de18290-27c5-c269-31c8-5c371a7858aa@linaro.org>
Date: Tue, 1 Aug 2023 23:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] tests/migration: Add -fno-stack-protector
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org
References: <20230731065904.5869-1-akihiko.odaki@daynix.com>
 <20230731065904.5869-3-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230731065904.5869-3-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 31/7/23 08:58, Akihiko Odaki wrote:
> A build of GCC 13.2 will have stack protector enabled by default if it
> was configured with --enable-default-ssp option. For such a compiler,
> it is necessary to explicitly disable stack protector when linking
> without standard libraries.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   tests/migration/s390x/Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Queuing this single patch via misc-fixes.

