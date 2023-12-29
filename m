Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5375181FEBA
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 10:39:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ9L3-0003OS-Mj; Fri, 29 Dec 2023 04:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9L0-0003O5-Jd
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:39:30 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9Kw-0003aN-G6
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:39:29 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ccce3bc472so33552611fa.1
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 01:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703842764; x=1704447564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZiS1Z/wIOh4yEIu3wi3QUw0lojTfxRTRJDB2yOipKhU=;
 b=OEV4M4vkdlNmDUODxdc70Q04HR7WLzPudlLwhiEdEjdTFrq97YJZsMQ6uUOfFB/qWC
 pmTKxoJ6UTgQ1xXyU5BvK9h2Ra8rWQIKtYZaB/Ck4z0kPeMBLD+qqxT1PDTp8+tr7Srg
 QsSp8dQzS2GYfOoYjwmtDGydhpgLq3u+9dV46gELvSfrjly/VqMK7JiwULiQOpZ+Ipyw
 drlTzOKxe2hf5Tny0pAHta1Yy2b9y/Nk/dldoNvYGwhVfDbmdbkKK/47bIkDCyHp2HWA
 5GcLGbhnlt1I9w0+LTvJpAvtny6JVuGuYOhozH967dnoyS1nhSWNdBCATGfFrNkUddS/
 RLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703842764; x=1704447564;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZiS1Z/wIOh4yEIu3wi3QUw0lojTfxRTRJDB2yOipKhU=;
 b=cwy9kn8pMQc0SmOZNk+rYDru6+1vICqI+M9qlsD+dppDDyMG1fWNzhboe1YmdJOlTB
 UOJ0XRzYSp72Q/y464BwPrtsf+zpSrEfhjr21V33XtSH6NhPIUNEzJy4Dg/pgXNPAzy/
 SYL6mGMDyLDjEies8OgVqsQsDiuhti0UmDZqLmhLqTJobNY6UnITYSEiBY5yeDi7qWyN
 zp4qKEWXEjkFfiiWkye11tjTVFQqVULJT313jWRiljV+w/KtzfmPklO0ljoA8eVSMQDV
 Fph3BjJmi0s/pwZH+OaWBm1/yifkS4LjUlqz++XjGf8Z2fxFWMCctZuhiSlbuRWX5Og9
 lcaw==
X-Gm-Message-State: AOJu0YwCvSNuMSZQiJiQfXrJDOxO8cCii7cepRXIZp5oKM9KnIrDsCSS
 lGQD3p3gaNAJSlKCWNNwMGzKSxaHYBukUBqNIAVfC1AcIpQ=
X-Google-Smtp-Source: AGHT+IFpClN16wIwEFx78GicPl/uQvKfEqnkF1cs8Ppla9Gc1zuTlsgmTxD3Pi+QjxTY6XC3H81IVA==
X-Received: by 2002:a05:651c:511:b0:2cc:e6cb:88f1 with SMTP id
 o17-20020a05651c051100b002cce6cb88f1mr1325541ljp.65.1703842764500; 
 Fri, 29 Dec 2023 01:39:24 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.55])
 by smtp.gmail.com with ESMTPSA id
 c18-20020a5d4152000000b0033609b71825sm18707263wrq.35.2023.12.29.01.39.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Dec 2023 01:39:24 -0800 (PST)
Message-ID: <a203b757-dc73-4489-ac38-5420b1304024@linaro.org>
Date: Fri, 29 Dec 2023 10:39:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/21] configure: remove unnecessary subshell
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231221171958.59350-1-pbonzini@redhat.com>
 <20231221171958.59350-6-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231221171958.59350-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 21/12/23 18:19, Paolo Bonzini wrote:
> Do not use a subshell to hide the shadowing of $config_host_mak.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configure | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


