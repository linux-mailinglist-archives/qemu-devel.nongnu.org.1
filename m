Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF13C77E533
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 17:33:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWIVl-00005h-W0; Wed, 16 Aug 2023 11:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWIUx-0008V7-Pp
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:31:52 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWIUv-0002NK-2i
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:31:51 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-688787570ccso1013720b3a.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 08:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692199907; x=1692804707;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sUYtPB2cB+0eX8q2qX9UUxrNI7swhlDJ4S6Feu8LVPc=;
 b=O3FtmQo+0kMlo5SbADc+Frern78gkDw0wYftZ/bDpiHB1SNFt3hMyO7z9U1I4YXePn
 qI23tz1UIO/YJZTdsE6cHavevRrrHJAshpaNZM7OtxAijzt7r1HR6h4W9IkpRYHzH4vh
 5XLePP32E3DAlv41DI9yL8cJ8Hrx8hlbsMODW2RXazfSXXiJn6pydO5mdNB/jWeoGw6h
 exmOgm/wg690OxbMsedwXjwJPkuce0VlHTm0SHP8jqEtCqHjsPyT3+DMzGraPPZr03F2
 MyMGFKoOks2Rm8+s6Lz59szWyGAFM4iFvQ1YrNVu0NfDzG9TuecLHQF2558NGyPscn44
 vE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692199907; x=1692804707;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sUYtPB2cB+0eX8q2qX9UUxrNI7swhlDJ4S6Feu8LVPc=;
 b=em8Bi+fUR342Yv5fdg3av0oWEHIdYYMLqMaZqDOlO10Xv1d5Ow/AFeGFeLSWFLsccR
 K3ijWPuaA3htdMpZV9TJvfdfUtsuO6CeLxhsZBXNNyqfosxwrB9nx5SESh/CVf3jOGkw
 Q3kPoKvzYpPBN+oHvLwrimNfdHlMMHop99meSPSKFEJbP2gq7reo9vffzMPfTheAvJYF
 9UxKCYVwCRXtxlwvanrsEUb8AASDbfSF5P5wlZ3J8rj7cddJxU85q1fpuT3sqvH/cMO8
 ZGPPWMxIq94fXFRp1IqMzsUUUXsXkjw4y3RTcmJ1drDOW8M8HhPkw/6raPoua5vmkWg5
 rdfg==
X-Gm-Message-State: AOJu0Yz/IMHfPn0sOTJg+xsmCk84WnXVJMt1ouqG8WiFCIZq/Js6GRCb
 /O+SZUSFzFD5ZYoGF3zTcaZBLg==
X-Google-Smtp-Source: AGHT+IEEpK0sMOcYRcMSOC9WHnOGxr4YQyhAmdy2KkU4+glHzWEIRbKejf/HJUnJ+8qRiAwN90NHNA==
X-Received: by 2002:a05:6a00:3a02:b0:64c:c5f9:1533 with SMTP id
 fj2-20020a056a003a0200b0064cc5f91533mr2801966pfb.33.1692199907365; 
 Wed, 16 Aug 2023 08:31:47 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:a064:e3f9:a812:973b?
 ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 bu29-20020a63295d000000b005501b24b1c9sm3520290pgb.62.2023.08.16.08.31.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 08:31:46 -0700 (PDT)
Message-ID: <97ec8394-ad8c-9b54-4f81-b70e751f74cc@linaro.org>
Date: Wed, 16 Aug 2023 08:31:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 02/25] gdbstub: Introduce GDBFeature structure
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20230816145155.21049-1-akihiko.odaki@daynix.com>
 <20230816145155.21049-3-akihiko.odaki@daynix.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230816145155.21049-3-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 8/16/23 07:51, Akihiko Odaki wrote:
> Before this change, the information from a XML file was stored in an
> array that is not descriptive. Introduce a dedicated structure type to
> make it easier to understand and to extend with more fields.
> 
> Signed-off-by: Akihiko Odaki<akihiko.odaki@daynix.com>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   MAINTAINERS             |  2 +-
>   meson.build             |  2 +-
>   include/exec/gdbstub.h  |  9 ++++--
>   gdbstub/gdbstub.c       |  4 +--
>   stubs/gdbstub.c         |  6 ++--
>   scripts/feature_to_c.py | 48 ++++++++++++++++++++++++++++
>   scripts/feature_to_c.sh | 69 -----------------------------------------
>   7 files changed, 62 insertions(+), 78 deletions(-)
>   create mode 100755 scripts/feature_to_c.py
>   delete mode 100644 scripts/feature_to_c.sh

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

