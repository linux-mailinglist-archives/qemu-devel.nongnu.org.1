Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7570F828372
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 10:46:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN8gU-0003PK-Dl; Tue, 09 Jan 2024 04:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN8g7-0003Ff-N1
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 04:46:06 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN8fy-0006jV-33
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 04:45:42 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6dbb8698312so845570a34.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 01:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704793536; x=1705398336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h///6VR4NKCMWERJOW4/MgQYa9QP2gRlZfc3iKJYG6c=;
 b=qJMm54wnMenaFO+H50VvmlddEw3peFEWOt1dNGlKCCk836IWNGfjL2hPvx1nKHoGbg
 EmqSX2niIoF85DIWQj/6zg4TitpveHfrv7uo05/w7yMp15mFSBHYtneg24T+AyO1BEu1
 6uFm320LFDy5C5F211zvgUre6XJO1U/OkUEYVeyWehJNuaqSpA24TXIArTifhdXPn6Zd
 2kPtFSRIDYGqGMB3UcyCi10akabLFN/Ub8uThLtneZGPpg71lhR51b3cmjXlJEsoX8h2
 wxMtzOZ0YwJbfy/34mqQoMIS7n1mrUwUGFubbD6+ocUxkFejgqBk8whRtW9g80ptGros
 IiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704793536; x=1705398336;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h///6VR4NKCMWERJOW4/MgQYa9QP2gRlZfc3iKJYG6c=;
 b=IVqEmm0Etu0LJX8wOrLeo+BuuNJMnJbwBLc1krN4HuIaxmGmWH5CeCAgfKC2rckJE2
 TMQyhzmNrnZUoz5ySWApHV9P0eUgfh95BT4zGkUL63RlvOu4HioxE2MCst/DL3aNja15
 cKBWgxLlE8CYbc4YlYlx2LiwdtPWn8xi+jK5gXms0L6zwE6Gd9X47YTlYQZydz5EiYky
 OtHNpkZ1rLDosSAsEZ7Ly6k2KF3z926q3UoMPt0oW/spMj4IbdGa3tBi5RQZhyLkczT+
 LJM+yYAOsYXVaRCjQ/+Tr9H+K+hFIFDJ6Diouom/VqELc0oN29rPfz3HYBcODfpB6j7R
 2Ucw==
X-Gm-Message-State: AOJu0YzBwgFYHo447L/Fbmr76PzwSXEUDtXiW1t4Q0k351cm/hKBvB3x
 Jgnc94PTyRi1cwc8hwhcnzkiCqPQ2O6oNQ==
X-Google-Smtp-Source: AGHT+IFfK2qrlUu7vPvczPtRp+3q8dYjXqSDTtgyDdHSH8TldhFNAoKkxQ/+j1K79YnmIqT6SaM6+A==
X-Received: by 2002:a9d:7a56:0:b0:6dd:e334:f2cf with SMTP id
 z22-20020a9d7a56000000b006dde334f2cfmr493336otm.23.1704793536423; 
 Tue, 09 Jan 2024 01:45:36 -0800 (PST)
Received: from [192.168.51.162] ([172.58.109.255])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a9d76c4000000b006dbc5410868sm309275otl.21.2024.01.09.01.45.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 01:45:36 -0800 (PST)
Message-ID: <c495e107-4094-45b7-9166-7674910e7781@linaro.org>
Date: Tue, 9 Jan 2024 20:21:40 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] hw/hppa/machine: Allow up to 3840 MB total memory
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>, Helge Deller <deller@gmx.de>
References: <20240107132237.50553-1-deller@kernel.org>
 <20240107132237.50553-2-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240107132237.50553-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

On 1/8/24 00:22, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> The physical hardware allows DIMMs of 4 MB size and above, allowing up
> to 3840 MB of memory, but is restricted by setup code to 3 GB.
> Increase the limit to allow up to the maximum amount of memory.
> 
> Btw. the memory area from 0xf000.0000 to 0xffff.ffff is reserved by
> the architecture for firmware and I/O memory and can not be used for
> standard memory.
> 
> An upcoming 64-bit SeaBIOS-hppa firmware will allow more than 3.75GB
> on 64-bit HPPA64. In this case the ram_max for the pa20 case will change.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Noticed-by: Nelson H. F. Beebe <beebe@math.utah.edu>
> Fixes: b7746b1194c8 ("hw/hppa/machine: Restrict the total memory size to 3GB")
> ---
>   hw/hppa/machine.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

