Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA7870E978
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:24:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1bLp-00088x-Lw; Tue, 23 May 2023 19:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bLn-00088m-E3
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:23:31 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bLl-0008R8-LO
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:23:30 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d30ab1ef2so82322b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684884208; x=1687476208;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GtM93wOpYenhPlRPlFCtCxIQAcVXrZFRAiIyX7giBko=;
 b=siKP+vPlirwZ+IJVDfs1/3E2ICKE1YTeKRlB6VN7ZMBzEyJT++H3yI5+zLgghiYvjg
 rBpmB3XqqdmTyhpEY0gDi7lv7ydvUCNYXuYNnSxuUM50airOj2kV3eA1oklx1jq16Epi
 DceEPyosXma6JTPe6WfJkPjZ9JtyPFYdzZPwCwNsi9LpOYRLD8eyu5Fkyk3vbwyr56FZ
 O3Grgp/1BbsSOhiMNyeVndxrlG95sJkpMDA7GBA1f2YNzI/tv8Ndx+hED8a0700dZwcq
 s4mbb9h52OCLEIH/nLXYOKM5MEym63Y8rwG2Trbm1x+Yv/9Gi2eqVv8+886imN0gP9DR
 PaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684884208; x=1687476208;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GtM93wOpYenhPlRPlFCtCxIQAcVXrZFRAiIyX7giBko=;
 b=bziNCyMDFp2nqsDr7TyNN32iq7yVOZrTzXK33TqW2iZ/O/YGPJpjiG94SS6F2aq0Wo
 9EmDeG0AKJXe63sadl18kXRtjb4OpJLlZDiEpGRc5W6ziHhyLxV/vI0C5Ma78g6OKihD
 rUXIIo4yNbxD6jeeVLTY1Cz5xc02XpwYgfE/R2dFk6SOWR51NuK3Z6ZXmJ8cNB574cW7
 6KshJSPlqPeH69MC7X3Z7WxPkwjLtnyJfkrR0o6WHSGBJkhoIdVepUEF4gYpIRi83bbP
 kkfCjOoQas3j2yDHAOzjYbHhrftnheXWoQ8Kwf8GF65bA0e1Vs3DzM7NVtp9iYiDk+od
 VT3Q==
X-Gm-Message-State: AC+VfDwwyz4ZNnp1YkLG44IwWFi8ScZ4JrKKwBnc17+VBV1h2NbeyLZb
 wWTRzso4N1v/aXQqRQV+1+K38A==
X-Google-Smtp-Source: ACHHUZ7ECJUnEd9BQzxs+mFfaLWX8f83dZhpRpxOgBQsHglRoL9dIn17trjsh4Q58aIH3kDNcykIwg==
X-Received: by 2002:a05:6a20:1611:b0:10c:d33a:5c50 with SMTP id
 l17-20020a056a20161100b0010cd33a5c50mr2052568pzj.36.1684884208031; 
 Tue, 23 May 2023 16:23:28 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 q26-20020a62e11a000000b0063b675f01a5sm5831914pfh.11.2023.05.23.16.23.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 16:23:27 -0700 (PDT)
Message-ID: <d6fdda38-5303-5acd-18af-bb93feb11b3d@linaro.org>
Date: Tue, 23 May 2023 16:23:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/11] hw/virtio: Introduce VHOST_VSOCK_COMMON symbol in
 Kconfig
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523163600.83391-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 5/23/23 09:35, Philippe Mathieu-Daudé wrote:
> Instead of adding 'vhost-vsock-common.c' twice (for VHOST_VSOCK
> and VHOST_USER_VSOCK), have it depend on VHOST_VSOCK_COMMON,
> selected by both symbols.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/virtio/Kconfig     | 6 ++++++
>   hw/virtio/meson.build | 5 +++--
>   2 files changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

