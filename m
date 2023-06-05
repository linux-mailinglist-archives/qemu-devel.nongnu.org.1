Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF99722F6D
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 21:13:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Fd9-0001qb-3S; Mon, 05 Jun 2023 15:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Fd6-0001qQ-Kl
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 15:12:36 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Fd5-00054M-0v
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 15:12:36 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-55b00ad09feso83631eaf.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 12:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685992353; x=1688584353;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=99juCDt61XrCqUmCTApHoXfoHrrAVbjSrYI7d5SmGT8=;
 b=T9qoI7OzuPsWWb0y2Ditk+y805RTTL3sIyCJ6PnkKb1Yag77pUdqTtGpCb75mh30OE
 m1SgoxaxboFp2MK7RBWpB7NwaNgA6PqfyjQ6f8K3IRxLgP0k/BJAqSabEvmiAq4g0/iZ
 qRp9OjBgUiCQKVh62jHpNq7o6HFUKEEC03WwGR0LIUFPVBoJTdh6jzmQrR6PqxSjMfZ3
 DnD+0EVeEsViKDiIMxjBvWglhNxaorFKrwJXAHaqagU76GxOQigmfcxu85oVTHGnqKFQ
 z+pA2I4gluczYVpawICFPBxaPQxL1qyj4Y7mInarOAOhhPKkxf8CxLPuqRI3pdpuDUml
 jNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685992353; x=1688584353;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=99juCDt61XrCqUmCTApHoXfoHrrAVbjSrYI7d5SmGT8=;
 b=UjsskMPvt9hxZHB9Lub4W7UQLp10EGgvRW5B7loiBKEvcloqcSktiDZ+xTuM7Hr8wU
 JLU4vzRJUX2GcEygcl9zV4oyLYgtOBgo0b6UpVtpgsph8G03Zd0Ya8hs51+xwOZVRr2R
 02xO18hSVFuAmUMsCFIg7hZEIB5s+2kNURQQomVX8PL5GUbRYXYZQb1PfpL2zRTVOWVm
 pmp3k2D4G2kBiEFlLl5svY4oZVJsUjvErMkfwZZgkdQ/ePeKmbfIjO0U8QSjKv+4ZY0t
 NnKN/eQLK+yyulNlPkMJ8jW8R6fKvs4nPBiaqYMtzp4YK3YqoiP4KaVhCy7E0GseUQoQ
 G9EQ==
X-Gm-Message-State: AC+VfDwIqQvn1P27sbJbIWlW/XiYX6/ywtodBomthoGCoaYV2X/vSKzE
 bcIiEZGWflIIYEwZcsi3MHkfSQ==
X-Google-Smtp-Source: ACHHUZ5ZG+8HOXLe/LY4RP2xorpsLyqpc7183+Kk8L7IrKqBj82vgMfoHTDjJN/CqEj7sKsyEyOMsQ==
X-Received: by 2002:a05:6359:205:b0:128:35ec:587c with SMTP id
 ej5-20020a056359020500b0012835ec587cmr151561rwb.4.1685992353572; 
 Mon, 05 Jun 2023 12:12:33 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3f85:a600:6a3e:e465?
 ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a17090a67c900b0024de3dff70esm6127351pjm.56.2023.06.05.12.12.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 12:12:33 -0700 (PDT)
Message-ID: <65849228-30b7-8b4d-605b-88973ba11a22@linaro.org>
Date: Mon, 5 Jun 2023 12:12:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] accel/tcg: Unmap perf_marker
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230605114134.1169974-1-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230605114134.1169974-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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

On 6/5/23 04:41, Ilya Leoshkevich wrote:
> Coverity complains that perf_marker is never unmapped. Fix by unmapping
> it in perf_exit().
> 
> Fixes: Coverity CID 1507929
> Fixes: 5584e2dbe8c9 ("tcg: add perfmap and jitdump")
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   accel/tcg/perf.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

and applied to tcg-next.


r~

