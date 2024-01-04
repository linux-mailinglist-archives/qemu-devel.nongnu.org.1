Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FE2824658
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:37:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQhd-0004Jp-Kc; Thu, 04 Jan 2024 11:36:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQhW-0004Io-Pi
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:36:10 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQhV-0005jF-9G
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:36:10 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33674f60184so624128f8f.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704386167; x=1704990967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fCEdlFQgTfhi304D/CI1xIMqPWs524/Tf2DNOWvo43g=;
 b=xPdwLWeJ77ndTnWgBwEkEULvlspXyJQTjsOrsN8QX6Nk85YvS2uOpQuD/IG+f6NReQ
 FYUyoJW3fZRaorlKaRZf8dGvwmXNpes5a/cyflpmnjb2uGXTTVo4iE/F3zAToaEIEBFy
 qWvAFRtBoDMs5h3UcegVaNOkd72K/+gPo+U6aXtgrRJRe0L2xEP4V/qmiQnps9vYJcw2
 663SialaIa1gWeZ/y7M8dYhk5oPKosWjomQeZxEYkbrQe2tYfUqOoknxcZCSeaAUFOkZ
 gtN/M799sFDPeUpo122K9Rq9elmssyoDqmqKdKxmqYAE8atlA8SKdREc0bnIUTiQQgCc
 /8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704386167; x=1704990967;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fCEdlFQgTfhi304D/CI1xIMqPWs524/Tf2DNOWvo43g=;
 b=GdxDdVbw5o4/ORzmKFbfFhpipAkWRxcpbO36OO7fRDrBoJnkNL+Lxs5NHC6iy+mAu8
 xU+joIRMTu/cJz/0hWgNkdLU09Fnb8qdY32MqyDICCFSY1lOE8ANp+xWRHlcpvc5Ccnm
 85i3LXPO6gHwEet8JjO1mb8WmmErrXuDSjpEA39FjAk8YEkjneHaH/KBU+FyBOQ0HcGd
 75JnymdeUq4hBI7V5evyWnwmnu8Fni1+XSillHAHQh3xr8dBW2RHLYjt/2kgH57X0NeD
 ADJhDQsGqqUwjnl6JjqQXFMRv4XKCRw2gFfGqtVFJ/X7ycMGiC11O0zwO0svOsEK38mj
 rPAQ==
X-Gm-Message-State: AOJu0Yzi+fjlS+D77l/hJ1gkFs/BZxmu+xfRWVekYXPK873O3co2UbmE
 CbO1cAf+Uy7MAichj2D81QmJyaNRv8WUrg==
X-Google-Smtp-Source: AGHT+IHIBkKrOIUMtXUrM8Us7WmZ3fMlNAYwq5CcNF8GST2LKxKT4wdjz/LjnEnnebwfTWShTjgR+w==
X-Received: by 2002:a05:600c:539b:b0:40d:3d92:a01e with SMTP id
 hg27-20020a05600c539b00b0040d3d92a01emr402131wmb.230.1704386167484; 
 Thu, 04 Jan 2024 08:36:07 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a05600c350f00b0040d8810efc9sm6222191wmq.17.2024.01.04.08.36.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 08:36:07 -0800 (PST)
Message-ID: <2a2e84ce-c8a2-4d4b-bd09-01fe50b3e310@linaro.org>
Date: Thu, 4 Jan 2024 17:36:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm: add cache controller for Freescale i.MX6
Content-Language: en-US
To: Nikita Ostrenkov <n.ostrenkov@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org
References: <20231219105510.4907-1-n.ostrenkov@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231219105510.4907-1-n.ostrenkov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 19/12/23 11:55, Nikita Ostrenkov wrote:

Per "i.MX 6Dual/6Quad Applications Processor Reference Manual, Rev. 4, 
09/2017", Chapter 2 "Memory Maps", 2.2 ARM Platform Memory Map,
Table 2-1. System memory map.

> Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
> ---
>   hw/arm/Kconfig    | 1 +
>   hw/arm/fsl-imx6.c | 3 +++
>   2 files changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


