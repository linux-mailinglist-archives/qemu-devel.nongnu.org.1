Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E97D76A208
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 22:38:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQZdy-0001Wj-A2; Mon, 31 Jul 2023 16:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQZdv-0001Vo-I2
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 16:37:27 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQZdt-00088a-SZ
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 16:37:27 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-686be28e1a8so3293694b3a.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 13:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690835844; x=1691440644;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AJPzZsYrkQgwAwKOdYAGlHwCWQTA7Pd07yBgQK2WZgk=;
 b=bXqi1Y8eQmTCqnXud86e4NNpmrHa8RjWgjLTHrbLS4o5+kmpDplVrerXboqRvwuu/c
 h6GMDVRSZiYoIplfhvp9uxR/lUXZsi01r+KQ/+ZGf7+Oo2d732dP0WHi/voq+5/Qezmw
 pI6Q1Jmen23fRzvb1I6aEQq2IbwHclhY3lfaWJHq3OibS6ldVjr1nDY0ZrcGBDvduEzp
 tb2gEJMAsWbze3YSQC1ig2MCzg0UKNMF7cBG0F14squapJywj25V8TXXVhFLuby2Z+Ft
 aaxaFHUhCp7QFW1AlIjf7z6I5S+xREZJU6iSZalOQfgocEE3YdpKO3GGhUev6n3U6rfa
 hQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690835844; x=1691440644;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AJPzZsYrkQgwAwKOdYAGlHwCWQTA7Pd07yBgQK2WZgk=;
 b=bTE9vNfvFmmHBndS3QkKZ/iO9rQpXzT6Ta0TNUuCy5sFiGKj82rI84Z2c/6b3ifINp
 lnpTi+7wJ6bHcb3klbsEXRErAbySElTmWSwftsr/VDk6IVnULD/lYkBBqkQslvmdfiw4
 gGAQ4rnj+bK+d+McsZwLWByMeeFX7zrhenqfJilkb6oItnWjcsN15nhSFIX5ZTXoPWOj
 VdIk3I9GKf4XB3nnfXttOAEIsICEvYBFBiu17Fzbwd9SuW01fov5zkVTbNFJ15PEoObg
 m7A/ky4qel3bkkmmoqZBH936UZgXdmcCIqpN2XtWzZEeAligR/dXJobru5NtYf2dUINa
 jEgQ==
X-Gm-Message-State: ABy/qLY1XejRI8LVludZLlKB4TgFUxRWMr7WczQBU/iCa1sZhMBhRXc8
 1AL9EzOzt3CjtL5kWDgALujS8w==
X-Google-Smtp-Source: APBJJlG2UYVfxWG8LZ4LXSyFJHIo3jc6hjf8qBqD4VgzNcA+yXVRMCePwE3S29ZRjZ+et7Rl1LavDA==
X-Received: by 2002:a05:6a20:6a0f:b0:130:b19d:ec1f with SMTP id
 p15-20020a056a206a0f00b00130b19dec1fmr11160296pzk.11.1690835844070; 
 Mon, 31 Jul 2023 13:37:24 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:4f6f:6b:2de4:e0cb?
 ([2602:47:d490:6901:4f6f:6b:2de4:e0cb])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a62ed03000000b00682a839d0aesm7993190pfh.112.2023.07.31.13.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 13:37:23 -0700 (PDT)
Message-ID: <4b38596d-1db6-e03f-8b42-65c4464132ab@linaro.org>
Date: Mon, 31 Jul 2023 13:37:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] disas/riscv: Further correction to LUI disassembly
Content-Language: en-US
To: Richard Bagley <rbagley@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 dbarboza@ventanamicro.com
References: <20230731183320.410922-1-rbagley@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230731183320.410922-1-rbagley@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/31/23 11:33, Richard Bagley wrote:
> The recent commit 36df75a0a9 corrected one aspect of LUI disassembly
> by recovering the immediate argument from the result of LUI with a
> shift right by 12. However, the shift right will left-fill with the
> sign. By applying a mask we recover an unsigned representation of the
> 20-bit field (which includes a sign bit).

Why would you want that?  Surely

     lui r1, -1

is more accurate than

     lui r1, 0xfffff


r~

