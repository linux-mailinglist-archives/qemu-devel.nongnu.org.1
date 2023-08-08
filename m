Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B81774D13
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:30:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTUHP-0001F0-BC; Tue, 08 Aug 2023 17:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUHI-0001AK-TG
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:30:09 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUFs-0001EL-3p
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:28:41 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-686daaa5f1fso4318522b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691530118; x=1692134918;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ahIM7PDCQp0RXXJ6QMkIjepupHtLdwR54UCi38RcleA=;
 b=UyF1K6D859Cnh2GGItD+EX/vVEjJbP21pr1TfGkNfJbayuIpH4V0lu4kC3GMYOFSU6
 HiILBaD4bHc1HBKSQ8kob8BXcmukwrMQ/iOXG9ZhBtMVSsVQJ4eIQpBqS62D0D7Tp+2h
 5PMF68gW0AceWwhlHJpssw4Ln+vExaPMGGwY/bnL3HVyugav4n4fKsSSMx61J4idq1md
 q+lEn5vJ4lKV+/1MxDxBJbA8COKiDGOlk9tQrNfuFZgIUPcAIbpsTHhIBAtLlOLy4wq3
 aVSmVvHCpva6U4X8oII9m1HpQtymXv2Ra3NcfhD4u9F5gvNgyNrAghjrgtpE46rA4TGo
 Eb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691530118; x=1692134918;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ahIM7PDCQp0RXXJ6QMkIjepupHtLdwR54UCi38RcleA=;
 b=ZvZLaLIvxYQshEq/rQzLlHaAlYtCtJXsY4LC5bCG7UUJujSZeTY9wA2UiPmpWmdB3j
 iiQ3pG82DvlGJhjgWJjci4iWEH4HMH+eYdrmX33RLUm5nJcEI/3APfPa63ArvzKKkTFM
 WIyjTGyIalPspZAeg/vNPg+zVXcXiU+VKcQTsAprl2sIvRDbww9dnLWUkXP0js541FX5
 tQA/5RNgg98w+x2O1YhQXMrUJ096N8Lv+FoXGgdMIFQCpOG0gy7Ehfoa+gKfTUJyJiht
 f36tfQPJWoyiTwylFZDQVVyJrLsuQb0E1serTpFchQec6wuOSmadrXu9g4LtDRjSF+qL
 dZ4g==
X-Gm-Message-State: AOJu0YxrJvk/9+mGZp3fj8FE//AwohnAFQvWBM12pfKVMqj54wJibYIl
 2oMs1vnkHOEyHNbYwgXG8GTtMA==
X-Google-Smtp-Source: AGHT+IEe7mjeFZ6Xz86vR8pbXhofDLdezVb03s+SCu3LDSjCaYTMYc1+WCZGz4NcUcsthamq8nqTUQ==
X-Received: by 2002:a05:6a21:3390:b0:137:fa5:8519 with SMTP id
 yy16-20020a056a21339000b001370fa58519mr895581pzb.31.1691530118402; 
 Tue, 08 Aug 2023 14:28:38 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 i11-20020aa787cb000000b006828ee9fa69sm8549019pfo.206.2023.08.08.14.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 14:28:38 -0700 (PDT)
Message-ID: <ad06ff30-d1ba-a401-c31c-6ac642816824@linaro.org>
Date: Tue, 8 Aug 2023 14:28:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/33] Rename target_freebsd_time_t to target_time_t
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-13-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-13-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 23:07, Karim Taha wrote:
> From: Warner Losh<imp@bsdimp.com>
> 
> This is necessary for future code using target_time_t, in
> bsd-user/syscall_defs.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/syscall_defs.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

