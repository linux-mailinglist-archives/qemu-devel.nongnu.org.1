Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4E2715FE4
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:35:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yZl-000233-Ar; Tue, 30 May 2023 08:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yYw-0001Qb-Gu
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:35:00 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yYu-0002Fa-8f
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:34:53 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30ae141785bso3438792f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685450091; x=1688042091;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cAwzAXD8WEFZl5n06V6r30ert0zOHmitz8qRc0FhLQo=;
 b=NoCU9cemO8d99JNjinKpLV/zhvkVEImfG1thSl3YOA62OzDUs+6ByCHEcfDG0BnuXu
 Wm3OrY6zoFPifsLQ7P7F8Y/iDzClMSSWdxSE6EAnuosOsPX+wySd83fhD2yb3SDjRqDx
 ffui5MhPmi4JqZQWFP/kMP4IZTFHJCMSLvlfEzJaGgNd8HPmP+Ig2ILfmIBpO3/6ST7P
 OxQLSBNs+PKI9NiQQK3FNBV63hGIVnuNt57+9EmmlMM9EWu1oTM8HjYh8PXJveZZD0mh
 WAaLm3hWzKccyd1agdCHMCPO91v2hsfZAjCIP5ywl4Z/neZhIKsyfe1GnTSKcGs1QN8A
 dPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685450091; x=1688042091;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cAwzAXD8WEFZl5n06V6r30ert0zOHmitz8qRc0FhLQo=;
 b=SbXBIoMVvtCZNdtWqfX3qFHdQTwZmQZuKJ0XH5hNfU4CQ1du5iRHUweVM0UcrF9AoU
 n4srafnn/ZeyXZnOQTvT7cAFnHfKiS4MGIgEI9J4lVfjUIUemyoeYcOCWS9aQDy94Br/
 I0seyEtVEC3n/dhddm25AlYU+vBmwL2koxcrKUxvIDjZOlda/XVpWBERMWbbRuc6SR/U
 3frFj3GR2mAOEJDI3AgJRWVVM9D8N8VTMNB9eiOqUIJIA21L22Sjhr1xK3JWRVZRj4/s
 LJkNRxwQk9aMqvfOHc4FdaLWVBZ1VEwMxTo56Jr5lq//lHGpYgxA1CfrRHZcL3hDyvqY
 Ia3w==
X-Gm-Message-State: AC+VfDxcyK8DbkxOp03CAhbC7i/2uXCzH1ouekkVG4gONcOldo+7Ld55
 Ul57KX6rLsTyW0324T3OcWf3dhXOaiXHYjJ/3eOhqA==
X-Google-Smtp-Source: ACHHUZ6w5u1mZWxUGqXovs0AU8RxtxQwO9Yd014eZrL8GI/S8Bf7EqUsoTzNB2NBDyXeQWT4Z2PQOw==
X-Received: by 2002:adf:e70b:0:b0:306:4162:ebbe with SMTP id
 c11-20020adfe70b000000b003064162ebbemr1541627wrm.49.1685450091025; 
 Tue, 30 May 2023 05:34:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 l19-20020a5d5273000000b0030ae09c5efdsm3205469wrc.42.2023.05.30.05.34.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:34:50 -0700 (PDT)
Message-ID: <dbe09342-a048-0a61-1c36-2a0407cb8230@linaro.org>
Date: Tue, 30 May 2023 14:34:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 12/16] migration: migration_rate_limit_reset() don't need
 the QEMUFile
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20230530122813.2674-1-quintela@redhat.com>
 <20230530122813.2674-13-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530122813.2674-13-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 30/5/23 14:28, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   migration/migration-stats.h | 4 +---
>   migration/migration-stats.c | 2 +-
>   migration/migration.c       | 2 +-
>   3 files changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


