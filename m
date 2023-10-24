Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA667D4FA4
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 14:18:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvGKk-0001wx-Hr; Tue, 24 Oct 2023 08:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvGKg-0001wF-Ed; Tue, 24 Oct 2023 08:16:26 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvGKd-0004Hs-Qe; Tue, 24 Oct 2023 08:16:25 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32dff202b4bso1282006f8f.1; 
 Tue, 24 Oct 2023 05:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698149780; x=1698754580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XqhLs0VKE4eYGQf3IxDeRGyPalLn8V/39qWJijHHo24=;
 b=AGuWTHs25CmWoUVBFXgZEdELdOTx329tw4exZBuEKjcwRiSX2eShtTCg4reDILczzs
 ystDYlWjcUMA1SPVckUWAuWZtfskXyWM8SVloLdwSrU0dT4hcAMg66nTYv9q2y6eJyQQ
 8khiva8BxQu5iPvQSN/7VyxfiZoog9G59D7w68VFeu+KDfh/N96rmB9he77axEjQu+6e
 jrerItxdQpqNTNNKMdwvsRVtZMdfZPCnyW1Be9BXxANyCm7MD2Nh9zYfmhPckLnrFtLt
 ux2kyBTgLM5VZTu+92K7/3ORgR3sR03FndcpBDNRBKestQTqMHQNsb4qhm/4FMnfO627
 aoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698149780; x=1698754580;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqhLs0VKE4eYGQf3IxDeRGyPalLn8V/39qWJijHHo24=;
 b=DdNQINNK10X/TcrMEyb6FBfXe/WNC4Os9sgee5+dyrisueQJB92pFOjD0prrnVyrOe
 eXnoSn9NVBXTCi+cEINwKRLVfCmcgjlsmdfLUJZvwAHp6EcWgbHV9QB2NtdGh3J08Ff9
 3XIzaV5dbkHYuEC1woP2LNwzXVF2QyPBuypt+kHXdi9OgtkaORI3/ho7YYKwQV+OLYld
 EZ31N4wj0/h4VAhwEnn63QkqYELFmtlWzrktuY9QQb3SEqms65eeh2niH2TWZgu4uPrv
 P7CYkn9SYhF05EOZ4IuNGuXzDw/sa/HVA1g9Ax5qVut4rYdjjeDt/l8AT1heRTGlPpQY
 iCeg==
X-Gm-Message-State: AOJu0Yw0f9XdbXsqsbJgjcjz4xRY5g9bFKS5aTIsYIWuT26H3R0KIhLG
 1tfauNtv2E5sCnvBr0Wbyjw=
X-Google-Smtp-Source: AGHT+IE4Z5n2fmffxWcQ/sQr9yuXr/uNARW3iYvgNsmcZBaWl9xNE3uVkib5/sqcnF5f4lyc4e1dbQ==
X-Received: by 2002:adf:e650:0:b0:32d:92fd:9f73 with SMTP id
 b16-20020adfe650000000b0032d92fd9f73mr7885913wrn.10.1698149779261; 
 Tue, 24 Oct 2023 05:16:19 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-238.amazon.com. [54.240.197.238])
 by smtp.gmail.com with ESMTPSA id
 w5-20020adfee45000000b00317a04131c5sm9822690wro.57.2023.10.24.05.16.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 05:16:18 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <456aae8e-ea07-4861-a91b-7c7e28d2a22b@xen.org>
Date: Tue, 24 Oct 2023 13:16:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] i386/xen: fix per-vCPU upcall vector for Xen
 emulation
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
References: <20231016151909.22133-1-dwmw2@infradead.org>
 <20231016151909.22133-2-dwmw2@infradead.org>
Organization: Xen Project
In-Reply-To: <20231016151909.22133-2-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 16/10/2023 16:18, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The per-vCPU upcall vector support had two problems. Firstly it was
> using the wrong hypercall argument and would always return -EFAULT.
> And secondly it was using the wrong ioctl() to pass the vector to
> the kernel and thus the *kernel* would always return -EINVAL.
> 
> Linux doesn't (yet) use this mode so it went without decent testing
> for a while.
> 
> Fixes: 105b47fdf2d0 ("i386/xen: implement HVMOP_set_evtchn_upcall_vector")
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   target/i386/kvm/xen-emu.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Paul Durrant <paul@xen.org>


