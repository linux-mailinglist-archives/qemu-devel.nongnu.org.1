Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B45E5792317
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 15:34:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdWBR-0008NP-OI; Tue, 05 Sep 2023 09:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdWBD-0008MN-3U
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:33:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdWB5-0006OS-OI
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:33:16 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-401b3ea0656so23652675e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693920790; x=1694525590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J8JUwOl3+0rNYArdVYIBl5VgxVjojkYgpvX6gWWMyAo=;
 b=BEatKIn3AmEVnot+37nTu1M8aVIOQVturbUJnMgWHbWp8AdfyyPmZyft4JBbIxJFnX
 is161MMMxcveO2YmmGWzwzoGQH3oIKmfz4TBubNpmmvMsZHT8CYX95d1luKWsYXRCU2v
 l6fJiQP8PCRHxq+GV1ZmoBQhh2blIPGXedPkvbpg2W1FMF25wyxaH3UdmhdkEfIf6h1E
 OWa29kmHhjhsRibS1Xcuj9WDsHjUIOz0D0EBdXYVRiZBni591uPa4i9VoVkPgymQvvGP
 8V2At4qZh4VD0odjvO0CRpQJZFdjGnGdFskomWEZr+4ApNqziwLabsDusByln9MNwCTV
 6RpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693920790; x=1694525590;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J8JUwOl3+0rNYArdVYIBl5VgxVjojkYgpvX6gWWMyAo=;
 b=RWoQOPxh5xa/++XeEZqV/I7Muar3GdSrvw//dhXDZHKBw4lbQBDqkSH6rRkS4cRM4t
 LH3lcaXaMpCrJiOtz87FGjGG6tN2AQPiKaEqq4GQEfJJMQmOUJPBKINsE6nkeHjN/GVU
 34eW314Ga1+wmeZhibYwbceH8IO5F5lecLy3woz5Z3BuYDd9iv1CyN9AwjG4vobrXihd
 2u+b6fCDXaLmDG+M/PUrNuevPqpPlCT8y0jYXUZg1lLc9WISR1ZqQdF6JOr2tnNMv7gg
 KIr2kTimU5CsN22ajslYae5E7OErowjphGRpM7DI+rebopMf6y4TMmZNbSDz62Ysj1Rq
 wdug==
X-Gm-Message-State: AOJu0YzaubsCZrX7SEMyaMIPb9pMfuZQNH59JgjFdkeHIgoinICeHmfX
 GvG3qJ3/ML8AgNXaFvaAYaYSUg==
X-Google-Smtp-Source: AGHT+IG+ckRbvazXSCj6OeOWng70s5H8wi9xZiZOj8DntFiMoThVXVBP0k6hgsv0U6ZywsvLnkPiEQ==
X-Received: by 2002:a1c:6a03:0:b0:401:b493:f7c0 with SMTP id
 f3-20020a1c6a03000000b00401b493f7c0mr10081334wmc.2.1693920789984; 
 Tue, 05 Sep 2023 06:33:09 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr.
 [176.184.47.79]) by smtp.gmail.com with ESMTPSA id
 z23-20020a1c4c17000000b00401d8181f8bsm20011693wmf.25.2023.09.05.06.33.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 06:33:09 -0700 (PDT)
Message-ID: <fed20880-2171-b601-2bd6-b913f4e51742@linaro.org>
Date: Tue, 5 Sep 2023 15:33:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] block: Make more BlockDriver definitions static
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20230905130607.35134-1-kwolf@redhat.com>
 <20230905130607.35134-3-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230905130607.35134-3-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 5/9/23 15:06, Kevin Wolf wrote:
> Most block driver implementations don't have any reason for their
> BlockDriver to be public. The only exceptions are bdrv_file, bdrv_raw
> and bdrv_qcow2, which are actually used in other source files.
> 
> Make all other BlockDriver definitions static if they aren't yet.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/copy-before-write.c | 2 +-
>   block/preallocate.c       | 2 +-
>   block/snapshot-access.c   | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


