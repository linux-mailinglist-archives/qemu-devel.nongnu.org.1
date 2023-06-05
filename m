Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 728B4722635
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:46:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69bM-0000hi-1W; Mon, 05 Jun 2023 08:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69bH-0000fi-Gu
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:46:19 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69bF-0005RN-Up
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:46:19 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-30ae967ef74so3758075f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 05:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685969175; x=1688561175;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W6iqa7J5MfH/ldlETnZpjE1piS6ASQbcHx/ap6VcnNk=;
 b=AcyxN07zHqMOIjNZH9McfdMde0HTIonyd5IwqWphGJ7mfplWsZOkF3D3v/DCiRSYUp
 1WSlBuLxQrGx5sA8gcgkquSNmk0l8QSWzESDWi7GBC+rj7GDJsrEMIzHt4ewawHoE4T7
 r0T66Q+O1Dros1r+NAIPd1o9QS8lrcuSoOHZKq38LUxRQJ7CqSccoDYOawQU+RjSaX6X
 cxCF8nvvOLAHAyhbrAMz5rz7ndx/MP9yYYG6NVExtmY+N6ENm1gNGBeUyXYP+IFbR2Ey
 BWUXqm67vqoHE6oCkN/9xxmfIJJTu9z71JBfrFVtX19elNFSbf+oO1Y4OAcFUGbtMhwF
 f4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685969175; x=1688561175;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W6iqa7J5MfH/ldlETnZpjE1piS6ASQbcHx/ap6VcnNk=;
 b=Ely2N8XdcdPesCx9sINCCfTIG7sQQRdY6MwSqtGnk/5oODxha7tBSYjmtr9ZjZGBP6
 ZwFWORsxOevA6rQJOHxF2Chhe6w1fybLIUP6ljwG+Z7LHiHXeGi9Fzm/u0F70YUukeEr
 g2CmSxG558rdlWDDel+XHwW25xqY2bL0j74tnZOHDdp1tCO/78OvKo9H4gzxNNH67dDr
 9av9fyMHYqZ7f1L7bGSj53jQmuzVypBpwkRi7HZBLEa8WA9q4arQp8WbmIIi6yJ0oiof
 GM+uIZcCFaHnwXv0SAfJvrRMDOL+g1KDGVRdvoOyYxmOGVXixS1IvEG7yKH1dQNCJZYl
 4X+g==
X-Gm-Message-State: AC+VfDwKaebb51c+dN6tw7ZtWVR+04bV9vopzXE7EB8zjWwQO3CNdR7m
 Z3jbaVMYIz+zMUn61srtctu/yw==
X-Google-Smtp-Source: ACHHUZ7Odvxn0Mlozt+ycRjmjFKT4zP1wfv20HkpbmhFRVrkHgfFBeJj4zfRj0vVpuAq1AY285ayMw==
X-Received: by 2002:a5d:480b:0:b0:30e:46c3:a179 with SMTP id
 l11-20020a5d480b000000b0030e46c3a179mr1107321wrq.30.1685969175021; 
 Mon, 05 Jun 2023 05:46:15 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 c18-20020adfed92000000b0030ae499da59sm9698978wro.111.2023.06.05.05.46.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 05:46:14 -0700 (PDT)
Message-ID: <266ca9ed-2c0e-290c-efaf-5086875030a2@linaro.org>
Date: Mon, 5 Jun 2023 14:46:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 20/23] q800: don't access Nubus bus directly from the
 mac-nubus-bridge device
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
 <20230604131450.428797-21-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230604131450.428797-21-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 4/6/23 15:14, Mark Cave-Ayland wrote:
> Instead use the qdev_get_child_bus() function which is intended for this exact
> purpose.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/m68k/q800.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


