Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D7B722F27
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 21:05:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6FUV-0007XT-AV; Mon, 05 Jun 2023 15:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6FUT-0007XC-Vu
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 15:03:42 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6FUR-0000q3-UC
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 15:03:41 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1b1806264e9so28086655ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 12:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685991818; x=1688583818;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ui0yurgFBNlcmFUNuM4AL6tTAnEb4ZXivtteCWmlWPA=;
 b=kil81xYF6FxJah+o7fq/3p4rd0KNS+S7jkFTRBVtBF+Cdv8TMtCVrKJhz+dvEyqDVb
 xfPd+nvtgusM+jlNmoISDnK3TWQph41d+B6/N6REFs/f5+WeBhMt69+Lu3AfrKu16o7H
 p7bvCxVWNNUH8Ml76xqC56PkfkBBPniip3+WkSZRT0jAeXO367y6Hz78ZPlIX0mMnh0/
 Vs9O0nvq1iJLP+Wxm9siNBo7xnPL9RQ4k6LZTXiXfn2yDCVE4776GkFCH/emyKAogzFT
 ItkllG6YhJ8UZ49pdiY1PvOLCjkSFfhShP20pfAe6KfpFSyo/PbNwIa6R3nkFLwRHfvU
 5s9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685991818; x=1688583818;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ui0yurgFBNlcmFUNuM4AL6tTAnEb4ZXivtteCWmlWPA=;
 b=iFmCnD5ZvLklDl+DbB3LtFyjq5L9hrGsv64nwhUUJNmuCelevCm1Xqr9jNmOznXfs1
 eVuPtcFYqEUEp72apGeT9/d/9uMYJYntzvEoKQ4fXmjvF6krwVtpH2KcVbB3nacnzRP2
 yhKPE85Y2lhDCzpKcYKt4vcAzItH06HLYHsoc4QFVozZB5cLxYG2WrMcdqZRPYm9caqd
 AP8sZl29YS+UBPzSwqr1/4FEtqZNe4EgDkkDRvA076ovOfItP7LrIhQNeCBpEyjzW3GY
 5Pi90xzyY6T79HB5pqBqwOMk3hdu/tIIK9oaBgILBMgmOYDigFGBpBNhB9icIzf46nFU
 ct0A==
X-Gm-Message-State: AC+VfDyUsn44/uER6VJqPxTDNMmcTa7R2st6XZ4K/eL/5jaaVg/KsRRz
 GZS/KM8GCnWuJmGkVyCHSEOyOQ==
X-Google-Smtp-Source: ACHHUZ4J+DrZZW9CgulsZvvCvtcMH7Snh9wt4CkvRyGh+mndnK1w8X1KfPdq5al5s8aYWTnBd4C6FA==
X-Received: by 2002:a17:902:f54b:b0:1b1:80ba:39dd with SMTP id
 h11-20020a170902f54b00b001b180ba39ddmr5718606plf.30.1685991818065; 
 Mon, 05 Jun 2023 12:03:38 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3f85:a600:6a3e:e465?
 ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 13-20020a170902c14d00b001aaec7a2a62sm6896845plj.188.2023.06.05.12.03.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 12:03:37 -0700 (PDT)
Message-ID: <08db760d-d8d2-2758-be39-12039e2c1570@linaro.org>
Date: Mon, 5 Jun 2023 12:03:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/17] Block patches
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20230605154541.1043261-1-hreitz@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230605154541.1043261-1-hreitz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 6/5/23 08:45, Hanna Czenczek wrote:
> The following changes since commit 848a6caa88b9f082c89c9b41afa975761262981d:
> 
>    Merge tag 'migration-20230602-pull-request' ofhttps://gitlab.com/juan.quintela/qemu  into staging (2023-06-02 17:33:29 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/hreitz/qemu.git  tags/pull-block-2023-06-05
> 
> for you to fetch changes up to 42a2890a76f4783cd1c212f27856edcf2b5e8a75:
> 
>    qcow2: add discard-no-unref option (2023-06-05 13:15:42 +0200)
> 
> ----------------------------------------------------------------
> Block patches
> 
> - Fix padding of unaligned vectored requests to match the host alignment
>    for vectors with 1023 or 1024 buffers
> - Refactor and fix bugs in parallels's image check functionality
> - Add an option to the qcow2 driver to retain (qcow2-level) allocations
>    on discard requests from the guest (while still forwarding the discard
>    to the lower level and marking the range as zero)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


