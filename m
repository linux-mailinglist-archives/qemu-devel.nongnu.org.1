Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D14EE76F98A
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 07:26:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRnKG-0007Yh-Q9; Fri, 04 Aug 2023 01:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRnKD-0007YW-UN
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:26:09 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRnKA-0002Oz-S2
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:26:08 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-686f8614ce5so1593124b3a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 22:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691126764; x=1691731564;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NyuV8A4740CQUMlzJkLcg0GyTJF1n2ZgiAciACg9RrA=;
 b=UM3Hf+Fyn+H8HcUyHqOqSwGmCJAUISDycTFYWuWO60iO8nZA+uHVcnawaZvCp8Amus
 xc68dywcq959k/TSuZfpk1+xOFDdjykejvzdMlYmsBpCp7JVqpKollwxP4FwjT9jBB5W
 DNu3DFK8tKtORXtQTDbjQ7a/R/K6E7cIZ1aU+Gx4YsHN36S7uTanYlnnXVDXFiAZaehm
 AU1LtcgES2LuQsCV+1wlB1dBYH+FxupXV/xjUWkRp6cO3iq8l43x+sQEgQxCZLOaFAzk
 Z1HPEaInTaXeskfjOb48yZ7LcfgPWJb0O2x15vqg8VAYpS3XrWCPkfYcPmHAob81VgBc
 Wfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691126764; x=1691731564;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NyuV8A4740CQUMlzJkLcg0GyTJF1n2ZgiAciACg9RrA=;
 b=KImVR7EL4nzeiQrNYsgF6fYz0cPERQJdtndqRHyDwcB7gEyoufyqB7F8ES+SbB6Z/c
 knl1yOCsroQf1S0oaeDoArevioUV33Y9kiwWYZh4Yk53QO+blbLLfvgcftoKyNSmpYLP
 JCFS8P9GJXkm448kfVGZoYE0ktB7UZp1h3GX5bKOzh4+YGgBya3Q/U7NRwgpWmmUXWe9
 uUNjByhntZqlHcUIJY4AHeawsSTb+4SqEi2iP8H+YNeit0dY5tYQQxbJX0ReP2S46WTe
 KjSybezQxRVG6QGBGhEk0AwGSWDvSgD9l6Ve2S/+0n4C0VALE/lIC0zoM3ef5S+nWsFr
 d41Q==
X-Gm-Message-State: AOJu0YwbW7PL87dlzLOlIUa01qzYT97GWD7zBu50cFHZFD9fusCpfw2I
 yc85MI3/HxjvQ15Wp2YaMkaZRA==
X-Google-Smtp-Source: AGHT+IFnzAqp8mJohn3y4zsOu6UFweY2hqSqIf3JSua0yYV5TwPDVFQ9YsxenT2iy81U/GaOVpoZRg==
X-Received: by 2002:a05:6a20:1453:b0:13d:b8ed:a5b8 with SMTP id
 a19-20020a056a20145300b0013db8eda5b8mr858615pzi.12.1691126764161; 
 Thu, 03 Aug 2023 22:26:04 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 jh21-20020a170903329500b001b8c3c7b102sm764864plb.127.2023.08.03.22.26.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 22:26:03 -0700 (PDT)
Message-ID: <d04fd2de-4295-5fba-347b-ea16aea206b5@daynix.com>
Date: Fri, 4 Aug 2023 14:26:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/17] linux-user: Adjust initial brk when interpreter
 is close to executable
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: joel@jms.id.au, laurent@vivier.eu, deller@gmx.de
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-14-richard.henderson@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230804014517.6361-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/08/04 10:45, Richard Henderson wrote:
> From: Helge Deller <deller@gmx.de>
> 
> While we attempt to load a ET_DYN executable far away from
> TASK_UNMAPPED_BASE, we are not completely in control of the
> address space layout.  If the interpreter lands close to
> the executable, leaving insufficient heap space, move brk.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> [rth: Re-order after ELF_ET_DYN_BASE patch so that we do not
>   "temporarily break" tsan, and also to minimize the changes required.
>   Remove image_info.reserve_brk as unused.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

