Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7280F7EA0BB
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 16:57:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ZJM-0005Bo-Ul; Mon, 13 Nov 2023 10:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2ZJJ-0005BE-EX
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:57:13 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2ZJH-00015J-UO
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:57:13 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5446c9f3a77so7178086a12.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 07:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699891030; x=1700495830; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mOglezm6/PT9OtRbHT3rgIl44ivWRoylyUIiQTB7A/w=;
 b=vtkzJMrSNfWdRH/A4eu4hcaBHXsCwwZQcKgHrUneT8r/nZ9LHtztn6rZWUJfhey/Xk
 tXXlJ/hnUWHqtpa4SIys1k/eVMxMXxULbkON70YpGVrlM0TlTZKKNcRZTR08qfi7jR+m
 diIHVToeSKfyMGJYwu5IZT+/nHZbnDiJqhGK3vBEZjlL7oaJXM4iCZbtvTXZJeYe5bFZ
 uDy3dPzNhk9O22Q7Nt8pz1lfkN+opFjK3JepX5YNEcotDk3ApgfOd6KirfZOmt4rdzHq
 9Qimdjx2ZQvjPAb7zMMs9QFDjoCeWtAwNApRJXOwC2ltTxUmBgmJ4WPnssethLNXDsRX
 urWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699891030; x=1700495830;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mOglezm6/PT9OtRbHT3rgIl44ivWRoylyUIiQTB7A/w=;
 b=MJiHterpCHfLggY3zi9Cipov4Em5s+0WGh3rDxUm+xZBpYLTJkcAa3QO9Rt633gcJN
 EInTMjGZQnwYFMpZBdjJUAuv405Ad+Hbe1VUjEBMqrLYwnKsgNkj4gmQ9eoGXJAsgXbI
 KICU5pg6Nhq/qZ6gl6Pu/RxjDOV6KkT1OL87gOJGzz0qxgpccxuK2QTxmMLuckAFTPas
 co5oGff6zXAt1Jk22AJoQxtKV437NF0bfbU9a1ASGK7eGspiTqm5FU42QM4dcS78aGtv
 dNx0TZ/EgIaug6jtRI6wk4oeKP59lHbZFOOt/hB8dPvgPST1BUXhqigbrX+ta5g7/yG5
 i3dQ==
X-Gm-Message-State: AOJu0Ywmags3gS7TvSEb4qY4mVF+QCAbdPUrMYMBQXHnGvy+aRXvvrtA
 b1D06FiwgbGhIqxT63C1J6VYGA==
X-Google-Smtp-Source: AGHT+IFUJUMphpTAPQAWE2IVp9xk27LJhYp4BU1A9pM1bfkGkIPB+RbXThRRQwzhcnfUn7y9/HHpGQ==
X-Received: by 2002:a05:6402:11c8:b0:543:c578:f9d2 with SMTP id
 j8-20020a05640211c800b00543c578f9d2mr7432210edw.2.1699891030376; 
 Mon, 13 Nov 2023 07:57:10 -0800 (PST)
Received: from [192.168.69.100] ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 a25-20020a509b59000000b00544817db5b0sm3867029edj.61.2023.11.13.07.57.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 07:57:09 -0800 (PST)
Message-ID: <6c91b8e2-01cf-4f86-915f-9a01e9c45854@linaro.org>
Date: Mon, 13 Nov 2023 16:57:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update virtio-fs mailing list address
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Vivek Goyal <vgoyal@redhat.com>, German Maglione <gmaglione@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>
References: <20231111004920.148348-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231111004920.148348-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 11/11/23 01:49, Stefan Hajnoczi wrote:
> The old virtio-fs mailing list address is no longer in use. Switch to
> the new mailing list address.
> 
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: German Maglione <gmaglione@redhat.com>
> Cc: Hanna Czenczek <hreitz@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, patch queued.


