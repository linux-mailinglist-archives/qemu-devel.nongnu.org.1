Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41496720A21
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 22:04:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5B00-00069b-9y; Fri, 02 Jun 2023 16:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Azx-000692-4S
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 16:03:45 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Azt-0001th-Hf
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 16:03:44 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-30ae141785bso2440227f8f.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 13:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685736220; x=1688328220;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gYrdCoiyy4c3T36hdBCvufBH+VFWjZejrce+DXZy1BQ=;
 b=Y1prcXKzk51qnRQZJG8CyDFnGhOWkkqnR7N+/fPT1DzbD9x9WCYEIGtV7vo5yFD4q9
 Oi05tm0JJhN5SPWBUmpnWB7k/mWsDWxnMhoo4lyg/vO0p0u3eeopeEJr6Pfj26pIa05G
 lUI8klQ6rcpdEINt4X2inbiJCHQUlPBu1aACJ4QTUI6mx2eohs4sDyHEUL/1cPS0dkwp
 GLK0ay7pHC2ERFDtvcM6t6nLNqo95LrGTp4lisxuWS7StkPw8rXL4xWu/Vsdx9MnepbO
 cG+38KaWS+S4I3mjTSqN7RVlD4M5DfeFzRXl4x53lRnWRS4/lFn+5aGU9TUWOhPhvJS7
 BrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685736220; x=1688328220;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gYrdCoiyy4c3T36hdBCvufBH+VFWjZejrce+DXZy1BQ=;
 b=bkt9zf4nax3VXAuN/UL3bBvXQpTB52uiGMxAh4HR8uA9gS0RJ2zXkD+Jzir52YcRKw
 flMH/OgJYc/1Vy7falBuOKBBWdHl3S64PG1NY09Pf5kw8s8LCF4oNPbMc8WCm7QG/uW7
 B/Pa+RJpTjeB+/Fwsx4sUYq0uiBu8NaoToLvdt/uINBPfnJS4dWq1DLnGcsdfcLoSr2K
 iPr6u3EEvKqiRkXFTMzwy5OHWuQloxagVsrQ60UseE96OnI6PwXpULz3BfRJ55SVanL8
 FaM5+jUOeDY0vGZh8bMuLQH0+km4K1ts1QDZQBmAsA/Idaw/tO+imdIFp+Hwe/3ydyfm
 GDLQ==
X-Gm-Message-State: AC+VfDx4k5w+F/4J8IvbIyVj+kX3FEkeFiaufW1prAiOsYvLs/Zoc5NN
 py9qAr+R5A6Ge775fcTW+ZRjgQ==
X-Google-Smtp-Source: ACHHUZ4nosV/SgWc6tRjIZmQXdJoc/hn8xt2MNOi9uW66e9eJRd+bIEH0mPT0Hx25f6TVJZvVhKq4w==
X-Received: by 2002:a5d:4d90:0:b0:30a:e65a:1b14 with SMTP id
 b16-20020a5d4d90000000b0030ae65a1b14mr752877wru.28.1685736220086; 
 Fri, 02 Jun 2023 13:03:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a5d4c42000000b00306415ac69asm2503281wrt.15.2023.06.02.13.03.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 13:03:39 -0700 (PDT)
Message-ID: <57a5cb12-c905-43ab-5190-4bb16022a312@linaro.org>
Date: Fri, 2 Jun 2023 22:03:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] meson.build: Group the audio backend entries in a
 separate summary section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20230602171832.533739-1-thuth@redhat.com>
 <20230602171832.533739-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230602171832.533739-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 2/6/23 19:18, Thomas Huth wrote:
> Let's make it easier for the users to spot audio-related entries
> in the summary of the meson output.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   meson.build | 32 ++++++++++++++++++--------------
>   1 file changed, 18 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


