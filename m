Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F287412FA
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 15:50:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVXn-0000JN-Ov; Wed, 28 Jun 2023 09:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEVXe-0000IZ-Ml
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 09:49:08 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEVXc-0001Dd-QI
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 09:49:06 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4f004cc54f4so8296480e87.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 06:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687960142; x=1690552142;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8+TGWwDdh316XHfiE6TmrekXs2eaqAeCFDGAyge3NUE=;
 b=hGjCHZRIQn/rElfdqQPQ8YxaBXjcv9NSLYR9RGI1d3nURtMRi3yjnUMhRmF0qqco9/
 z9b49wcf/NAoa35Q8pEm2/BlWx1vCayLUK4elh9dPt0e4A6+MHKzpGr0OQFi7C1JZXeV
 bLIc0au9Sh+C5sh/fhpXwMp5Tv0lH4O0pRNGDuXnRmCtqbbkGOG5hB76XrULizQv6qjq
 6wds9b7KmWY6Vr0emUd+1JHDmvgvGdU9jENoqhGR4SfGlyH22T8YGDXgyZOipijlvOwU
 3vmaxCkegYPFeNzfqc8BJT+4cyfKZ1k1ncv1JXJIvXVEVTWEk062hwuXzU6CEsao5iWx
 Z5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687960142; x=1690552142;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8+TGWwDdh316XHfiE6TmrekXs2eaqAeCFDGAyge3NUE=;
 b=PtbZyOsI3AyOOi6/0pT/PjupoVml+VG3lCyt7dXu7oAJRMzlpv+B60E7WiRncFoQo4
 jhVeP8wD0o3aQj/QtXX6mjntXpJQLIjyhgXzwL3PdeSRfaNjIRbjNqi4rx2nY6CxVbEo
 7echYmcE/W4W3YDur3rSEdQcGHr1gLmEytk6pjwErXurSF8Y2XQ0/T1MCcV9KRZEmdTs
 qpqWwFAZGC9+m2TdoTQ1+B2pIW17DnHdEq13JDFqSUY1DYhitwaKBG0AbNump4qz7QUa
 AMaO2JIHdNtqWVs+BOzrblJ09H8OPyyuL6DuFPv32W3RzP8cJ/ClL6JDZbW7U7qDxU5P
 C3AQ==
X-Gm-Message-State: AC+VfDzeCM9whkmT1EICfKPh0W3TYHXtape57RNueLPfpsnGd1kQiUhA
 OhMbx6xSZsLkB2eFX0GsblZpuA==
X-Google-Smtp-Source: ACHHUZ4Tzc3wdlphTuXxf0U2Tya7jtDP9U0pfZHXjmBaKOhQEe67WIH5z2Y9yk/CaxrIozv5fEih5A==
X-Received: by 2002:a19:2d4b:0:b0:4f8:631b:bf77 with SMTP id
 t11-20020a192d4b000000b004f8631bbf77mr20345138lft.22.1687960142452; 
 Wed, 28 Jun 2023 06:49:02 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a05600c1c0400b003fbb1ce274fsm2273326wms.0.2023.06.28.06.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 06:49:02 -0700 (PDT)
Message-ID: <c01a1ffc-5df5-fe56-eca3-5e5c9b8904ca@linaro.org>
Date: Wed, 28 Jun 2023 15:49:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/7] hw/nvme updates
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>
References: <20230628092453.39602-9-its@irrelevant.dk>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230628092453.39602-9-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/28/23 11:24, Klaus Jensen wrote:
> From: Klaus Jensen<k.jensen@samsung.com>
> 
> Hi,
> 
> The following changes since commit 4329d049d5b8d4af71c6b399d64a6d1b98856318:
> 
>    Merge tag 'pull-tcg-20230626' ofhttps://gitlab.com/rth7680/qemu  into staging (2023-06-26 17:40:38 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/birkelund/qemu.git  tags/nvme-next-pull-request
> 
> for you to fetch changes up to e409c9057b55e890a6e5f70386a36932a5137bcf:
> 
>    docs: update hw/nvme documentation for TP4146 (2023-06-28 11:22:49 +0200)
> 
> ----------------------------------------------------------------
> hw/nvme updates
> 
> Small set of fixes and some updates for the FDP support.
> -----BEGIN PGP SIGNATURE-----

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


