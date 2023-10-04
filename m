Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4A17B779B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 08:05:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnuzo-0003dL-TY; Wed, 04 Oct 2023 02:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnuzk-0003aV-WE
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:04:29 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnuzj-0003uP-9h
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:04:28 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3231dff4343so289273f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 23:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696399462; x=1697004262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s166DMcWX/SI07ZHQSP8+LPeD4C9jklh+KSNrpikDe8=;
 b=JKRrtom4BkzA6swDa0GpujZcqlh2QM3Rmcsp9bok+qUmTw9fAI24Matf6hRvM9DBTQ
 lux/5CP26pPFXLN0pK9bZnYS4Zm0NEzKTf2xdrWkn2jRHQsg95YBmO1Ap9YajU8USdTy
 ZVKXXfELjcUTsJLrAXrIGfzueHo5eJXqUH8d3QnOif0YhkO6jF+9fCK6MK6fa7R4cgy0
 X/i2F3uW6fQIQyooYI7rNoc61rmlH9NUMDQbGwm2IHjW7KoYpUJ0+a6xLSiv/JX5XQH8
 3anIpwbKeQW7fubm8MUnp49VyRXEH/TadgADLSbNmWi6hoAPr2pz9jmjSIWRIrJJNTPE
 NO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696399462; x=1697004262;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s166DMcWX/SI07ZHQSP8+LPeD4C9jklh+KSNrpikDe8=;
 b=bVQTo2olerYLYYhcfYTOyNpZpFIRiAqLGCbEIP6uc72hI4BbKauLeAvSPTs2AZ32+m
 UUK2G1mnoZmWxTVakLwwjhMRzTEoIeyMuBz4u08PxGcuLPWAeC0Nha2fJUVxLN+O6dgG
 Ox50SnCq37wQlTPHNjCnDyCEdlL79IjvsGl4tOqZYiFpjPSERuEROAcN5cl+Cls81fqX
 hnAGqAS+Wzg9S8WVctpbmwCIGUWx6x2uaOWfnTV3AZACWRIZyzNa3cXB8LDLMnFcUWEm
 cuDEF9+vRTU0hX2UBrpjbiBw8ZXe/SU7N6+AXkDzasLiZaFrZR5WGvFSVzeExsCZzY8P
 XoAQ==
X-Gm-Message-State: AOJu0YyUqBY4OqMOqUgrP/BzUD+B1XGPxo67opG2HXa+YP7f+4dN7eTJ
 JrpPd+xmzpHtQar4TdB0WdXKhypb9RanUmYVURU=
X-Google-Smtp-Source: AGHT+IFB8DSNhn1CLRJSSFMtwZB/TPVyRw5dNcqyIvsNZogclrrmaXBW10opX+pipKaL7gcK1GtMBg==
X-Received: by 2002:a5d:4944:0:b0:318:416:a56a with SMTP id
 r4-20020a5d4944000000b003180416a56amr3927036wrs.13.1696399462373; 
 Tue, 03 Oct 2023 23:04:22 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 y9-20020adfd089000000b0031aef72a021sm3143676wrh.86.2023.10.03.23.04.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 23:04:21 -0700 (PDT)
Message-ID: <5d79a3d1-6fa7-e698-c3d0-40e6bc85e4c0@linaro.org>
Date: Wed, 4 Oct 2023 08:04:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] linux-user: Propagate failure in mmap_reserve_or_unmap
 back to target_munmap
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, Andreas Schwab <schwab@suse.de>
References: <20231003210220.1713908-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003210220.1713908-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 3/10/23 23:02, Richard Henderson wrote:
> Do not assert success, but return any failure received.
> Additionally, fix the method of earlier error return in target_munmap.
> 
> Reported-by: Andreas Schwab <schwab@suse.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 30 +++++++++++++++++-------------
>   1 file changed, 17 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


