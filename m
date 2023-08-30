Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7C978D4BD
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:43:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHgV-00036E-VX; Wed, 30 Aug 2023 05:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbHgT-0002pe-AD
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:21 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbHgQ-0001Gt-Gz
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:20 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-401d24f1f27so20567345e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 02:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693388416; x=1693993216; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dFwNI7W8Ys2y553puiN3nULpTJRYrJScb+OAIdwiVhU=;
 b=WXVLhqNrETa19OvDOe3OpOe7DZPgd23noFAc4M6HRBWfPVD36yzcOXoJF/jGy+010n
 nXk27yOHVrA8dcjmaz1b7yWyUm6+lqS1S3vcfB+UosVXvKjPJtxqhzXMB8ZvZvwp3+u+
 LG9TewJkQb3lTIiT+dpjddSj9aoHPuqy8kdRs3YII69wICu4kArEstu/P1A5o5Nm9ngX
 zR2JA4gfqgbsE/4sgFwL9OwO2Ux7kt4kbthrca+7gfNvFcP7QJB/HLPevtSatNm7orGr
 qz4GF1eIJmZ+4l+NEXijGy6I0j70a/sHLUio4dvjiiUHoB0Fmp1Fi5oDoK2UGMs+wiBU
 Ag/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693388416; x=1693993216;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dFwNI7W8Ys2y553puiN3nULpTJRYrJScb+OAIdwiVhU=;
 b=WvWohOxFXNXjgzH3ZKX2+TEKmAjTQM/ZcRN9ix3UVquklxW3VGJcCYFewT/wreCmL2
 F5NG5BF0dYQeLCqwcmzX3Ln/ViYdfL36yei9muYCmGoxx8VROey5tWf4pkbdlBF74ctw
 jD4NiW4AyZvYPQhbxxP4c8ciNqFbDV16Av4AWTxdpWhwUgr6bZeh7DzXtMDhRpcpF2rn
 RubFuOWgG/UWnVyLx+pfYTrEVC8YDpD5zw71Z5MiQDKyrmH1OqR+Gg8x38GJ0Eyp72ut
 1D9LtUTsVCVlRbfoAkmr6gtuNAsaxWbeblkXU2FFodcsZq6PV8AIaWDMA2xIRB193aPU
 N+6w==
X-Gm-Message-State: AOJu0YxTVYjQXNzUo70ibZ+55jdIGhA4I2kgb+D595nB8FfPhjxtLy+U
 ZhlUzJaCuaW3LPfWdJUqjhpqrA==
X-Google-Smtp-Source: AGHT+IGA/AEZCOeW+khTRDl6eryveOC5gm6uBLtwlwvBrEZD31j0B+ZNecl5AuQ8YwZ+NWSsVGXFjg==
X-Received: by 2002:a1c:f712:0:b0:401:c52c:5ed9 with SMTP id
 v18-20020a1cf712000000b00401c52c5ed9mr1404879wmh.32.1693388415682; 
 Wed, 30 Aug 2023 02:40:15 -0700 (PDT)
Received: from [192.168.18.115] ([91.219.21.246])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a05600c379200b003fee65091fdsm1695710wmr.40.2023.08.30.02.40.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 02:40:15 -0700 (PDT)
Message-ID: <1bcb98bd-8e77-f071-9b7e-b41edeba78fd@linaro.org>
Date: Wed, 30 Aug 2023 11:40:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/4] nbd: drop unused nbd_receive_negotiate()
 aio_context argument
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, eblake@redhat.com,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 farosas@suse.de, kwolf@redhat.com, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>
References: <20230829160623.277411-1-stefanha@redhat.com>
 <20230829160623.277411-2-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230829160623.277411-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 29/8/23 18:06, Stefan Hajnoczi wrote:
> aio_context is always NULL, so drop it.
> 
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   include/block/nbd.h     | 3 +--
>   nbd/client-connection.c | 3 +--
>   nbd/client.c            | 5 ++---
>   qemu-nbd.c              | 4 ++--
>   4 files changed, 6 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


