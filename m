Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A098386D6
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 06:44:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS9aC-00054u-EV; Tue, 23 Jan 2024 00:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rS9aA-00054B-Bp
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 00:44:22 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rS9a8-0007j2-Uy
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 00:44:22 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40ebf37314fso804575e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 21:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705988659; x=1706593459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8QiAzTgH2CtvVh8gUYdFf3w4YBT2g3x8jeISe60mQK4=;
 b=XpbspbYSe5EWPP/IgnIqQirQ+1OQhTzclZ9K6FFcLHi8ApTHvXFh40YaSmjhybQY6Q
 miJcKU476TRAS+ti0nSlO75OAp1X7uKqBMhBEiVKZ3MWm2sFQXyDUEX65UnWeigv4zlm
 pAC7luf5zqBN5CzDi+hMrXpMW/8i6O/LnbcWucNdbQ/yzlKiP4xSpvHRMJgfEjI6CN2K
 P/GMCLwAlcqCacuY4uEH9W7jwTIgsjaytBnbXqxeqEz5wosV6lUgFy7RRLR+otLqc/0n
 nsutP12IiFtZPZ2lzDhxrWw+RYE2wQFdOdJp7mv6nDPX5zD9+6F7xzVPWZsO3jOjFNr0
 dbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705988659; x=1706593459;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8QiAzTgH2CtvVh8gUYdFf3w4YBT2g3x8jeISe60mQK4=;
 b=gQ3awf9V+8MENcLB215p6FfSc/jt9GIcQgUgCClyeW6h5SQywu0zm2wyLWD3mtWZh9
 hMvlcgomKrOWzMOcBwyy/FUp/gpyMmCQTRxDMjcd/Vb30N02/Z92AyfPvlTQktY1bQmL
 Jv9q1JoXaRwpUrOF7hex/qA+jvmVBaY2gAKGysm3X29zJc935g+B/gnJWyUSAjekdDB9
 0M58KrHrP6dK1uIcLlanteAaclQpcHx6cXkunjENgll4U1E7nc85xhNRNsJ3Jqj9FjTY
 auZAc/e0arTjIYK4nwO3hP742QzU1zvW69k8jNI5YuuKtYd6OfowcaxH/xxoY8xjwCkm
 EH0w==
X-Gm-Message-State: AOJu0YyWMv8PLeHLHGRWN92/ZFyKMYYvRVd/JVOvtiop+RhVdl96TueB
 MYl3rOdgqZ66Op3aL4VK/PoWe2mQEu15F1Uc16KNPVf5WaAetR9rYta7TQjwMDQ=
X-Google-Smtp-Source: AGHT+IG7CB+iBC09JWQCezo2eHkHsZEF9VgANNWVdGRcPqO/7IkDk0xu3wyqg+SNFeqkZvTmmtISkg==
X-Received: by 2002:a05:600c:3115:b0:40e:7852:bc85 with SMTP id
 g21-20020a05600c311500b0040e7852bc85mr232519wmo.41.1705988659379; 
 Mon, 22 Jan 2024 21:44:19 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 m35-20020a05600c3b2300b0040e541ddcb1sm41322468wms.33.2024.01.22.21.44.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 21:44:19 -0800 (PST)
Message-ID: <0527965d-ed44-485e-8683-d7e16b2d8f3e@linaro.org>
Date: Tue, 23 Jan 2024 06:44:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] hw/riscv/virt.c: use g_autofree in virt_machine_init()
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20240122221529.86562-1-dbarboza@ventanamicro.com>
 <20240122221529.86562-7-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240122221529.86562-7-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 22/1/24 23:15, Daniel Henrique Barboza wrote:
> Move 'soc_name' to the loop, and give it g_autofree, to avoid the manual
> g_free().
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   hw/riscv/virt.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


