Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F86F71602E
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:42:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ygH-0001BH-Gc; Tue, 30 May 2023 08:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yfu-000198-NQ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:42:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yfo-00048G-1H
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:42:01 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f6d01d390bso45975515e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685450485; x=1688042485;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GYFU6ORS/66ZOM4wukv8AbY4unt6VvfNf4xuy0gO/I0=;
 b=h06n0z8/vL0gDwJUoktgY94+E5dUVaG44xfdBlX4DcLYCDaGjiPbYHCFr1iFmYaW71
 asgOP4nGv/WAcAhPC3Qw8xobdxzM0mQ0Y1CnDAleSVZIZskT5xJEFTPr8MgN29/LvhPR
 FwNJbBkZ+Yq04064Ch8/mju2cPsbJx443G6/C0y6EooCNI82wywdlnimI1vJ1OpIw1U3
 2iEOPJp/Eb5UPW9TpYxkq0PhZIDjJWdmLdIDq1mbOBFYLNd/6WyXhFKhYEfqx8OrKNF0
 50es7z87T/ou027aLknry2bhyxk25NHr1TiGYj4iyMdXGFR/KxEeRnlOwUtBn1BwA9vE
 kH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685450485; x=1688042485;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GYFU6ORS/66ZOM4wukv8AbY4unt6VvfNf4xuy0gO/I0=;
 b=L8n6eYkXBawi62YnBp2mdWXaT15TivxTnSrV2DB4rD0oOK4R+0IuTRZCsagv6ROFQT
 i6AYzVwwL7KyaMwHSygj4dwdbQTyZqaKQmSRlsLKlRXGA2WX0lmum0s857B/0noUOc67
 /4HJf0vs4mD+g5Wx+o1mvEZ6DtrakIx7w8K05OW3bn2NOvIgpeo24SvSA9uHIva6R/Di
 kJkQ8F8tgEi2Ff1vmHh9+ZDZCcNto2ROEzMaVBBcrI8h4k2xppaoUIS3VNe5uK3gOGIM
 Xfo6Ylf0KaLhRgnV8EAYDHDVL8Jn8pBlqUZPk/kWybogNy8aeS+gwkjT0gci9iq8a1lc
 r+5A==
X-Gm-Message-State: AC+VfDyDlJpl0IYk6XV8+7Ejn9jOsFA8zoR8N6EcAbQAUVI7xgaxfXPh
 D0vcZrNTw60e95GIiQXK8PDZcw==
X-Google-Smtp-Source: ACHHUZ4/F6HG/AWS1WjD4Bt5xlgkqFW7ZhWLS5EwkvlfDt79pHaR1BPJELQAdUWIS88xOPkmPbj5oA==
X-Received: by 2002:a1c:7412:0:b0:3f6:455:de09 with SMTP id
 p18-20020a1c7412000000b003f60455de09mr2025641wmc.39.1685450485469; 
 Tue, 30 May 2023 05:41:25 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 y4-20020a056000108400b0030abe7c36b1sm3133090wrw.93.2023.05.30.05.41.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:41:25 -0700 (PDT)
Message-ID: <2794cbc6-476d-658a-493f-0d52a8eb0954@linaro.org>
Date: Tue, 30 May 2023 14:41:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 16/16] qemu-file: Make qemu_fflush() return errors
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20230530122813.2674-1-quintela@redhat.com>
 <20230530122813.2674-17-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530122813.2674-17-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
> This let us simplify code of this shape.
> 
>     qemu_fflush(f);
>     int ret = qemu_file_get_error(f);
>     if (ret) {
>        return ret;
>     }
> 
> into:
> 
>     int ret = qemu_fflush(f);
>     if (ret) {
>        return ret;
>     }
> 
> I updated all callers where there is any error check.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   migration/qemu-file.h |  2 +-
>   migration/colo.c      | 11 +++--------
>   migration/migration.c |  7 +------
>   migration/qemu-file.c |  7 ++++---
>   migration/ram.c       | 22 +++++++---------------
>   migration/rdma.c      |  4 +---
>   migration/savevm.c    |  3 +--
>   7 files changed, 18 insertions(+), 38 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


