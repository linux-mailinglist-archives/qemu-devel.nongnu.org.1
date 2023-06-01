Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4047971F4A7
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 23:29:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4prD-0000AO-9c; Thu, 01 Jun 2023 17:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4prA-00009m-Ny
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 17:29:16 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4pr8-00021O-Ur
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 17:29:16 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2565a9107d2so1102853a91.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685654953; x=1688246953;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=knoW7xL4iQoGd9eYjhfbs0eae67mM3+rWs4mX3ncXro=;
 b=CoUFGLRIz5PwqXvls4A3KLX7FrfjcIwUqubwC65/mdUHwmxDYrpmeLnlTGihX0K/mL
 PDA8l7idj5aC9gk88OXSZUguuptLMTRRTlSpadSzeycMsqU6UGAS9n8VhZ5JKgabba7z
 QOnWnhPMDMGSlZRY6HqiaCuHoMiI1sGCtzDhggn1Aat6UMMuJcvEIKR+DY+2yoQ2AWXD
 p2BRfeehC15ivjvzoOEgWf2KUH+zMAZuaBUn3Gis7d5kG/fSsf2FJcU0qZVKCqIAeEBO
 4b0GymzbjllWdY0RTMQHdxk0vbtj7Om01ZfT4DteEa8vDPStPgIcYlCnifloCPBFk5lU
 O8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685654953; x=1688246953;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=knoW7xL4iQoGd9eYjhfbs0eae67mM3+rWs4mX3ncXro=;
 b=NVurHp93gUhR33XbkOtq6m8hU9wXe6VnVw0Z/ujrVxtxZ4AvhEYVYoE+ZdI1oT0jTZ
 hzJyhGl0vCGlKrjciJpnSOawARPiyHexVxj/zSUE/aOiy8eznwjshKOvdfr60SN9GMbX
 +7dmaRzfqjg3CMuorDRhPXtMinh02FzBDnLKfft1xDSc+Y5aMYO6Pf8+uXeSFlzZ6+yA
 /KT00gB/1G8w/nYceS/OsSsBaP2ILoc3r1xUYnP4we5/qfgFkHyQlHaQLo8q7016NeZ/
 mPbP0fH0o9unFf4wG38qzgbBVLBoSxsXiueTWLCIbWeVuES+CI1nHJrYOQ6Tg6emLzy7
 swUw==
X-Gm-Message-State: AC+VfDyleuiC9Utf2+SzyxuQAFIobQk1f4rKSC8RXn7FPZk+f3pGKS+h
 bnhZxRoX0wwt0+09NAGjmtTzwA==
X-Google-Smtp-Source: ACHHUZ4epcdWcOyL+D8ZrxbIfswuocjgrxru1DSlnWTVQYygZvpijeLTKTK+ir+kQAwUNEjyxhsPOQ==
X-Received: by 2002:a17:90b:3510:b0:247:6ead:d0ed with SMTP id
 ls16-20020a17090b351000b002476eadd0edmr566712pjb.28.1685654952619; 
 Thu, 01 Jun 2023 14:29:12 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c935:f07f:4b59:7091?
 ([2602:ae:1598:4c01:c935:f07f:4b59:7091])
 by smtp.gmail.com with ESMTPSA id
 y2-20020a17090a154200b0025621aa4c6bsm1931139pja.25.2023.06.01.14.29.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 14:29:12 -0700 (PDT)
Message-ID: <ccff610b-9e2a-9fa0-bba9-7c7376bb20f7@linaro.org>
Date: Thu, 1 Jun 2023 14:29:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/8] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20230601152552.1603119-1-stefanha@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230601152552.1603119-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 6/1/23 08:25, Stefan Hajnoczi wrote:
> The following changes since commit c6a5fc2ac76c5ab709896ee1b0edd33685a67ed1:
> 
>    decodetree: Add --output-null for meson testing (2023-05-31 19:56:42 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git  tags/block-pull-request
> 
> for you to fetch changes up to 98b126f5e3228a346c774e569e26689943b401dd:
> 
>    qapi: add '@fdset' feature for BlockdevOptionsVirtioBlkVhostVdpa (2023-06-01 11:08:21 -0400)
> 
> ----------------------------------------------------------------
> Pull request
> 
> - Stefano Garzarella's blkio block driver 'fd' parameter
> - My thread-local blk_io_plug() series

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


