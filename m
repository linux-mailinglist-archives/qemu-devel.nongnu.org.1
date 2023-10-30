Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA14B7DB7D6
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 11:20:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxPNP-0000BU-UB; Mon, 30 Oct 2023 06:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxPNI-00006R-UP
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:20:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxPNH-0005EF-E3
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:20:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40891d38e3fso32788695e9.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 03:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698661197; x=1699265997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5ri9gI+9BLZStDY8YQ7Jf6dBJZJYvFZ/KkRcVvDJ1fU=;
 b=AxnaUWYCtcGTJ89E+zRF24FUEj6eJWHPloNK84QcVtVd5hxZJF+XTwZQIbHslaARfS
 EtdhMJU/i04ZkRJfuu5dM/SDYNkXU3Fpw2hjupxm/LJuhEhJoAAP0bVgbTqggR95uQyS
 /IH/onnuzbEHv07g5zTD5zI9LUpaqZLxAnzhQm1ouwSPgDNe4GSlvHLuQKtHMvIwI6hK
 V5bmCfG3x0sKPSK3EKjfNGzB0MF2p8k9IEjVTUt7VRq1LUv0AUlnniXg9jnJZdUwSq0+
 IhJ2Apx65fxREhKGu07/LC1Lwd8sAG/oYTuTIrrzyYTQQApObAQPDXhVivrHuVkRc+NB
 7ikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698661197; x=1699265997;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ri9gI+9BLZStDY8YQ7Jf6dBJZJYvFZ/KkRcVvDJ1fU=;
 b=jSDU1SmeKtD9A3ETS6ZVYPmxdLI5r3g4w3hSbtjYxbeN4XeusYrrGfXfWUMOuPNRB9
 slrqDy+EJSCnX9NyyGx6CZA5yBK6bptxMCGzOxUZQW0Gc/eX1Bc81Zpi/oWScpy6/j6T
 9NaKe+Xycs642eTOlE3VbM7a2yoeqapizERnfJ5GOP6osKb1qh6e+juKJftpPaqw92PK
 tHmdwK80yKMsaqzE6ATA8tA/MHLSJY0lZX5Idk9tVgLJ9NegZ86/yo7ibVhx33qhggIw
 5L6RBck+1JZIPZw6wMs996kLiKlTv2nYoe7gsBiP5fwGkl6RhP5aydjEJESKpoh8zCAH
 CpSw==
X-Gm-Message-State: AOJu0YxzYRoexX8e6NrysUvOwo+noZz7g6ooWvNt4syFJ8H7EuB2o2DF
 8pendoWa+c4W8+G7pSsq1+LWPQ==
X-Google-Smtp-Source: AGHT+IEmubai3GURhwwHog0vvZAZr7c19cWXp/07bRzI9Ne1hSNdV9ZklzAWPkotAS2JyfDOSp8csw==
X-Received: by 2002:a7b:c7c6:0:b0:409:255:5e05 with SMTP id
 z6-20020a7bc7c6000000b0040902555e05mr7748229wmk.20.1698661197495; 
 Mon, 30 Oct 2023 03:19:57 -0700 (PDT)
Received: from [192.168.69.115] ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a05600c19d200b00401b242e2e6sm12339167wmq.47.2023.10.30.03.19.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 03:19:57 -0700 (PDT)
Message-ID: <9d80aef7-084a-b9ee-832f-4e4b7549713e@linaro.org>
Date: Mon, 30 Oct 2023 11:19:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] vl: constify default_list
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20231030101529.105266-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231030101529.105266-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.972,
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

On 30/10/23 11:15, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> It's not modified, let's make it const.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   system/vl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


