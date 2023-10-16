Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0E57CA9F8
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 15:42:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsNqP-00079y-2c; Mon, 16 Oct 2023 09:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsNqL-00079Q-O2
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:41:14 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsNqK-00035P-8A
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:41:13 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40776b1ff73so22975695e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697463670; x=1698068470; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NKh0F+D8dit94+5d9dAK5KWUAxNU4UEikV/9Y2P3yGk=;
 b=ktfoiQTOqe5/kfo5XfvItxH3jIxhbGRzvYhO5NCUU9rs08djr7QjliK5xjZBMBdkwr
 z5DajP6J5H0VEgkSkMP442vaf3/MhJ7sbxEngVvMTLRTw3/tHb9ctt7R5SB7jI4QiqgE
 MXbiGoyn0H/itOCB2LxBSNBjJOANRcLH5aTdOVjl8fDmmJLSEs1c9e2t6WqWS2qSoAzc
 923yR5HpO+4QqOEyWhwnVMb5+FHYAzxf6VVwFo1i+oE+dxblWkTUczdKURKhGhi/AFlh
 odmPHRIdM/3hRqtc3cD/omNldabvJN8uy7Jk+kLFKCg2Q5m1XlPTiL4x1J1OkmthqOWq
 7GiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697463670; x=1698068470;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NKh0F+D8dit94+5d9dAK5KWUAxNU4UEikV/9Y2P3yGk=;
 b=eg0H1d8CT6m9KRTvyCuDby2lahhKQfN6E/fnpsD4+Iv79Pst5KKDRENI02fJL/zyPo
 4o6wHEZ4j7siwi1JFYpos1opqFyK6F/TNwCOAqo0OBHrZv3t/9k9oYcI9pyq7H19CrKz
 6kMk1rCr0Q6YBo0k3VVlFvX97r3kTr1k4LSaD/JzEK4bRIHUugkQkqjpZiMjMtZnmuHI
 g/DKdneBIXR0uqx6EX281EXUk3vbu8pS2WPcp5q9DkrB+r5TqKSa+OI90fgRga6URIxq
 3UvPuEjf29oJWlD16HMMJ8wPbp+JCMk7XEyIFZVWp+tlqiOffx3M/Vn7D6bs4amZx+tS
 bECg==
X-Gm-Message-State: AOJu0YyMCCGTLqJjlnd5gu1EMQDeCbfDSzA05khL9Xz5kbqyWo7/8ip0
 pO3ALIBcU7+dezllPCMJapmByg==
X-Google-Smtp-Source: AGHT+IGyXtKTFpfi1UPodYlCpl7EyNiBrt+DTOAiJT1Ptjfu2KLbdHNZsXW67Uk4kZoVdgRa+/qrVQ==
X-Received: by 2002:a05:600c:3657:b0:406:3f62:e583 with SMTP id
 y23-20020a05600c365700b004063f62e583mr28723057wmq.40.1697463669882; 
 Mon, 16 Oct 2023 06:41:09 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-186.dsl.sta.abo.bbox.fr. [176.171.211.186])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a05600c488600b00405ee9dc69esm7095399wmp.18.2023.10.16.06.41.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 06:41:09 -0700 (PDT)
Message-ID: <55c69393-6662-f32a-a6e8-93bd6d7c8cd9@linaro.org>
Date: Mon, 16 Oct 2023 15:41:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] docs/sphinx: avoid invalid escape in Python string
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20231016094016.173598-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231016094016.173598-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 16/10/23 11:40, Paolo Bonzini wrote:
> This is an error in Python 3.12; fix it by using a raw string literal.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   docs/sphinx/hxtool.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


