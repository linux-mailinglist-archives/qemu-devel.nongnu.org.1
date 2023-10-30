Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA837DB245
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 04:26:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxIuF-00019E-7S; Sun, 29 Oct 2023 23:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxIuA-00018M-G3
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:25:30 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxIu7-0007Br-Sn
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:25:30 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53db360294fso6677632a12.3
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 20:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698636326; x=1699241126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CA4Cc5NcuqRSXETvF3rFlUbu9tsfX9/DuNOw/i/MYE0=;
 b=ITPzb87mrEgn8vjYIRhxyQVKCDcxnCiIlJ+X9kwVJK7QhpvqcteCtMs2XiWnahYTdD
 wFgsMEwv8t9XLNZC+htIVopR5A/OXnH3RzqTq+TCGXY3mnvDpOozXYhyn/9CVqInkBSW
 OFjF9vwEWLFo/GT3JoKhDvDfVwWV5/81qt57b/oYYvjqlFkixEw3b6ZpgPoxBvHDpGcn
 bLRAzmg1+06J0ex9ZW2aOtmCixcJQN22hXdLT5FHkxEFZV4I4qXo0ORb6HueQTdpL30T
 yiGoeMsoJW/jEmWsNRgfGFGKcS+3egABDYkaJ0WemvaJyL+sN0dWvFpUWYDv/rRqq84M
 ITeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698636326; x=1699241126;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CA4Cc5NcuqRSXETvF3rFlUbu9tsfX9/DuNOw/i/MYE0=;
 b=nXxwO98OJ/m7+AhORZfZrNEWEqL7Kqj7WvK3vhHwt4iZHdL96zC9OhHCapUXUmukZh
 AsT41ov3iSpbmMII/laVht8oZ0KSH4Ko5o0gOUoVfAuPnB1mlBY3jV/4oceYoIfkzdBV
 bDjTsAf0E6n3Q6HG3pY/svAiPhxFo72tTkp4z7C5ent/SIIGODETd+O+xFhgRnkAKLvP
 5c3AdCXdcbeU77ga6agAeJTOaX1BhaAlPOIYnZK4OndtBwLKQyIoCI39yn7+DSbRjL90
 m5Sb9PuAvy0Bkuu8Cyf2GUvuIgd0+I2bBF6CGx+LzRA1hSr05zT/46v7h1y2D+bUCN72
 qUyQ==
X-Gm-Message-State: AOJu0YxiajAs7YmhAtKVtB/I4rNK83eanYJd/+viZbhcJbPSvq5AWRQT
 vpuyF4lnKv7JC5U9r7kwK9/C8zOKrZCDRxgkhY0=
X-Google-Smtp-Source: AGHT+IEJLs2a2xM+QqoGhbyw1CrXlFbeMsTZv4pEdx5UH+hWrvRd+kJpk7Xt5wEVsSW/oayJp/CvsQ==
X-Received: by 2002:aa7:c1cb:0:b0:53e:3839:fc81 with SMTP id
 d11-20020aa7c1cb000000b0053e3839fc81mr6230351edp.32.1698636325662; 
 Sun, 29 Oct 2023 20:25:25 -0700 (PDT)
Received: from [192.168.69.115] ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 y8-20020a50bb08000000b005400dc94f43sm5445469ede.45.2023.10.29.20.25.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 20:25:25 -0700 (PDT)
Message-ID: <43cd9b97-54b6-f57b-6194-de7a3e5e07ca@linaro.org>
Date: Mon, 30 Oct 2023 04:25:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 5/6] hw/i2c/pm_smbus: Convert DPRINTF to trace events
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231028122415.14869-1-shentey@gmail.com>
 <20231028122415.14869-6-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231028122415.14869-6-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.972,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/10/23 14:24, Bernhard Beschow wrote:
> Let the trace messages slightly deviate from the function names
> ("smb" -> "smbus") being traced in order to avoid conflights with the SMB
> protocol.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i2c/pm_smbus.c   | 18 ++++--------------
>   hw/i2c/trace-events |  6 ++++++
>   2 files changed, 10 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


