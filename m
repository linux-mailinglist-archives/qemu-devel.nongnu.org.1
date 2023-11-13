Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 102D57EA0B5
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 16:56:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ZHq-0003LQ-1a; Mon, 13 Nov 2023 10:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2ZHj-0003Id-3n
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:55:36 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2ZHf-0000tN-VU
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:55:34 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53ed4688b9fso6921018a12.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 07:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699890930; x=1700495730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dxv16UtdmVdbCzvzY2Bg6F8fAMUYqMB+2EpmnKVWWGw=;
 b=YWNzgxEUlk8KYl5+sNF0XSRReMjXqbrtCG99D0PYBYZiQvpfPZb6Tsqe53K2+LaE90
 vz2FWQnKUDoxsoU63wjxiQucVcl0XbBEIJM0ae/HiyRpRGkGV27r6vj+qPAwdUfIeO85
 DhGoSnIfyn1qQwKx4ivowd7dNsMZxVFHsYFYdSpXP+/Wrq9O93yOx7mb8CbRayNyz+Cm
 w6RaDy7vmhMTw8cXkCFZHtnoIQh9QJcmi7Xs0GM18qemrXKu/t1ATjfp7hCEAFQOCjFE
 7Ykqtkuwzc58SkEgB/OdXlcpS0Zqbddz3lsZa6FGNgux7H0kxnKxkrhZu9yoUXiCa4Qi
 bHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699890930; x=1700495730;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dxv16UtdmVdbCzvzY2Bg6F8fAMUYqMB+2EpmnKVWWGw=;
 b=RIJtBRj/pw9Lq9tk1DZG5etCC5W+VAc5UrPXfS8HnJLPLMy8MofAks65e8+Br1jxcb
 AYVaiIqiRQ5bwcc8O62SEMIJrWdM/uZnSWpENIj7S0eQtgHTq7fnLoTaf5IjhWmkbriA
 F0tutEfMp/anpC7S0+c+VKLtkv0fyw77SmMZyJMnfRRfma8oKgPCzZ5IVGyd+aglXdU8
 Q9LgNamyjWWKtrF9SJj/e8W9Pik5mUhC+mzbJVj3uUXPvDJVshfhiVGhSSrYmQOA/2gP
 1i+xX3l/OH+2Yl6117YOnaTxel0mvUk7x8C9C4SHdVCRXb79qEMZtlLhUlPWRHrUazvj
 Wk0g==
X-Gm-Message-State: AOJu0YzzeFWJ08Dre2UVPxqu0R5xhECh9Mf57WYxztkDUWbpyLp4CmJN
 r8NmZoIW0iLWFneEQFahqV1moQ==
X-Google-Smtp-Source: AGHT+IGDpP4xrPDnRNniNALjcLTYRXzBqbgzq6WgOMEO7kxGCVNA6N77jTOD1fJlbuHzWWHGGHXEng==
X-Received: by 2002:aa7:c387:0:b0:543:65ab:2f09 with SMTP id
 k7-20020aa7c387000000b0054365ab2f09mr5269573edq.34.1699890930134; 
 Mon, 13 Nov 2023 07:55:30 -0800 (PST)
Received: from [192.168.69.100] ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 a25-20020a509b59000000b00544817db5b0sm3867029edj.61.2023.11.13.07.55.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 07:55:29 -0800 (PST)
Message-ID: <962cb048-cfca-4a56-8903-888bac2c720b@linaro.org>
Date: Mon, 13 Nov 2023 16:55:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/vmware_vga: fix probably typo
Content-Language: en-US
To: Alexandra Diupina <adiupina@astralinux.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
References: <20231110174104.13280-1-adiupina@astralinux.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231110174104.13280-1-adiupina@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 10/11/23 18:41, Alexandra Diupina wrote:
> When calling trace_vmware_verify_rect_greater_than_bound() replace
> "y" with "h" and y with h
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 02218aedb1 ("hw/display/vmware_vga: replace fprintf calls with trace events")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
>   hw/display/vmware_vga.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, patch queued!


