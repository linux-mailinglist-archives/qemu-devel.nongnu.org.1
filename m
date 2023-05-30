Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 575D7716004
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:38:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ybx-00063e-1Y; Tue, 30 May 2023 08:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3ybu-0005l8-0U
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:37:58 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3ybs-0002xU-Gc
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:37:57 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-30aea656e36so1488483f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685450275; x=1688042275;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BfdLN+uMC0lo4a8gDrkcG97ZDgB+dkL5YLYi70ETYXs=;
 b=lHWL1b/A3YwJZgkJ/+gaXwXDkKnKlejyZ9KEiEcAqHHTPRhPSKHQp12LXh4AOgKXi4
 Op/5pXI6E8VE/vyRMIHl4ooEjMG6U0CdTfstNTYsvT4cX/J5AmLVKMwTfzRXIyeUXTo1
 7H6ReLT5w810Ud3MCj6rqBtPFv+gBC/A9KPavO7TRLuy/fp28Fme5L/d/c8uq3qsQv8x
 glkzrRSj9VrkEWzTwF+yW6IxLIuEHjCd0gYUCOeAZCmJ1H9eDdZKBdC/sx3rLtgHb4M5
 EwCg4snPkyrochxPbcH1302nXvWKWpb13IkT9n7aJQL2lxEMsSmurdPSPm8UHg0X3KDI
 w1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685450275; x=1688042275;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BfdLN+uMC0lo4a8gDrkcG97ZDgB+dkL5YLYi70ETYXs=;
 b=dDNyIeTAXtevBfc14SDh6JfcFrRO0q/BcRhSuDa2ie6XIB1+N4seAiNmlUfojsSyYU
 HxoY+eW/9IDEKgdQA3wywMlu6uWxU0VWqMYtXI4th8D55VtKiivcwyKlWnPr9v8he32H
 21lK1DTVGnDVtci0A8Ly2adiPJCq3gkbFocpx6611OKMH2DwKrPgP8osI10BSLo2QBHN
 8x+4IWdV2+7G4U40/FU0x6+z5nj1LRvHzwR6OCK+zbQWPF3QyGgyW61oetGoeztvuQ2P
 UY1BQ6odnbTOHHFSzPqTQhHmlHdLNhNsHlfZtdwghh8FEom7y/8GlUqzYyAMPrFPKAHv
 jnzA==
X-Gm-Message-State: AC+VfDyjdopd5yLNelBZeQs1Ex73h/ZXVHlRE0C4PhZCqP2YiR+ShXta
 iUzVTLmZuPEFo5W+YZ43HJ6OVZPs9oyKo+0zZNoc0w==
X-Google-Smtp-Source: ACHHUZ5qo2yJ9ofgLtxoJyT+aXnizTyOrsSmJWmX589/PDn+5e28mYI6YzIaB68g9XIiVPanitvVNQ==
X-Received: by 2002:a05:6000:1374:b0:2f6:987f:a0f5 with SMTP id
 q20-20020a056000137400b002f6987fa0f5mr1567286wrz.5.1685450275033; 
 Tue, 30 May 2023 05:37:55 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a5d490b000000b003063a92bbf5sm3140132wrq.70.2023.05.30.05.37.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:37:54 -0700 (PDT)
Message-ID: <4791b171-3908-193c-2ca3-7869efcd7220@linaro.org>
Date: Tue, 30 May 2023 14:37:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 02/16] migration: Change qemu_file_transferred to noflush
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20230530122813.2674-1-quintela@redhat.com>
 <20230530122813.2674-3-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530122813.2674-3-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 30/5/23 14:27, Juan Quintela wrote:
> We do a qemu_fclose() just after that, that also does a qemu_fflush(),
> so remove one qemu_fflush().
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   migration/savevm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


