Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C517DA8E1
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:21:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwora-0003DJ-0l; Sat, 28 Oct 2023 15:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qworY-0003D6-5r
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:20:48 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qworT-0008Td-I2
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:20:47 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-564b6276941so2590329a12.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698520842; x=1699125642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sir0Jp5pazsoR8nWFEatsEwnVBuUv4meVu0CHGeyV3M=;
 b=I043IXWhz3YO0MLuM+ZLLRFkTimBAcAhp/FzmfX6/OLGBolF0JVDaJeHoZ9wmD0qlL
 xxyOXAKN3/M8KqlTyuUB9wYkTHEZ+iVA4ECoP5vQOk3p4nyabAgsTk/0nlfaLf5f4Ue9
 WpTPXnWV/EPkU0KSNfcHIpGc5dNE+7d3MnrvMVyiAvt6dACNPvO3/D5wQcOlAsO8ATaU
 0V04qrebsGoGwuYdLSUMxK57Pk3WjQRmtcNalY/BlQmooaNYFA41S2cTLdvlFCXxh1qu
 mnCAeNhBtZA0BgFLmt+4gVrNkit7idHK9or7cjp8qttaxoblNEZYxmMxaCL5trVgFe2W
 jehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698520842; x=1699125642;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sir0Jp5pazsoR8nWFEatsEwnVBuUv4meVu0CHGeyV3M=;
 b=G8WzLCFc7wqTAg9mVVyz+JyQPa0izHCQ80xrJHgsx2xeGQNSye2lykyTCwvdw+kWn0
 jbd8p2xqVC6etEn6UYmFltIwrMUoZ3XFHtgaTvOt00+acCtsyZsal18v+miNiT4WtoZb
 XO2pKgReL596FQtgCxKDySk/gJb3RQgoreiZZgWCHObw6Coxa9fp9FP6LeczIYAoLlwG
 4lHOZUjWvz52FyG+bEKz8xftbEcKC4Bh25LGAJOXowji8rqYgNd5UwVJ4ajTsVd/l30v
 U4Q4hDwK3+2D1x+QgHf9dhplKVDCfW355gtnaY7WTjK+7ExlpesfkHm7VkJJygVZB3T4
 PPrA==
X-Gm-Message-State: AOJu0YyoT2fvzFOAUUfGI7klHDw1vjT5JUvreZh0s5cERKDv3jtjIMlN
 cJN2sElpCh3sjnI1e6tZKjbvSQjaSXXVFbe9/Kk=
X-Google-Smtp-Source: AGHT+IH4+2Pa0ETVjmkPGNXjRoqAdv6RDHLNd5Iq+MIXS3/xt/bdGS7uuZoINDnmDE/ovCGMPtom8Q==
X-Received: by 2002:a17:90b:4c87:b0:280:2823:6615 with SMTP id
 my7-20020a17090b4c8700b0028028236615mr2013141pjb.36.1698520841898; 
 Sat, 28 Oct 2023 12:20:41 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a17090abd9200b0028012be0764sm2646030pjr.20.2023.10.28.12.20.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 12:20:41 -0700 (PDT)
Message-ID: <3d64e383-c475-4331-8e2f-ce3a91e3de63@linaro.org>
Date: Sat, 28 Oct 2023 12:20:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] tests/docker: use debian-legacy-test-cross for alpha
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231028103311.347104-1-alex.bennee@linaro.org>
 <20231028103311.347104-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231028103311.347104-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/28/23 03:32, Alex Bennée wrote:
> Maintaining two sets of containers for test building is silly. While
> it makes sense for the QEMU cross-compile targets to have their own
> fat containers built by lcitool we might as well merge the other
> random debian based compilers into the same one used on gitlab.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   configure                                     |  5 +++++
>   .gitlab-ci.d/container-cross.yml              |  6 ------
>   tests/docker/Makefile.include                 |  1 -
>   .../dockerfiles/debian-alpha-cross.docker     | 19 -------------------
>   4 files changed, 5 insertions(+), 26 deletions(-)
>   delete mode 100644 tests/docker/dockerfiles/debian-alpha-cross.docker

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

