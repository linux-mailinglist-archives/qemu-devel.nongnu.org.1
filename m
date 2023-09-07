Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A68797250
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 14:32:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEAS-0002PZ-Cm; Thu, 07 Sep 2023 08:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeE9q-0002BH-O7
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:30:53 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeE9o-0007Ps-6g
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:30:50 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52bcb8b199aso1199052a12.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 05:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694089847; x=1694694647; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bS68yViKEP+IDsfSNuLfPFjZyNaeY+w/Elhq3vpC6mE=;
 b=REthjoWhBmgr6esiWxf+P1X4OJhfDnSTvE2UeXOa9rvJv6V+dqmEM2PHM1XKr7h1Nm
 ohac9oqOHjvq7OxtWLQLXGuetW5mLJDsps0P/iPGXrWIfHttrnfdt2swvolEF2lGc0NL
 Kk4vItgMjN9HVQ1Jt6P7KoxeIaFfIDd2erbRJ4UEDiakM7pzG+4dx+AUgi3d697RqHa1
 TMMNZuNZRW1NTSxCJEszoZL3B7n9ElYB1MestcdxxsMoaVt/jTGcekXUEdOrnnD0MfL1
 mr1hu6PdqJpU8bQ7NMdezLgrf0Dxt00zzxVLn0zrSze45yzEQsqBbbKpsSgyztYZWjsb
 fijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694089847; x=1694694647;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bS68yViKEP+IDsfSNuLfPFjZyNaeY+w/Elhq3vpC6mE=;
 b=iszIHpHhDowIR635k+fhhzYYvzZ7DsQd11DRuYeaU9CyQYl3jqWz495uSRsrYZOqHn
 h8BnV+TCtbDQhs3Q+V6uXr8/Soz2EMBiWzIdu37LE7cOFe8DmerdsAhS/VOyrh6n43WQ
 ipo/sl3vULqx6MvkmyNMtg2ofbs2FmK6Tn9k0ChgQM3Dm5ljkK89MLduYwqtAjlH+mAf
 bUsYDUVHbWGL+1T3bfE43taeJ43H8PomoWQzDb2kk6bZ+w8LHsR//EhwlorR42eT6lZg
 pTv6KSVpmvkfnkKq7rRW7D/U8Wkn1UZZTyAaz1kf6c6gTu6TQ5ieaDo4Oh1wNrB9wY3O
 Q7yw==
X-Gm-Message-State: AOJu0Yz82R87rNc7OrZKkCVxJ9uVGbuBt3qgPqvRKcv/aIl2yTi4RBqg
 FCwjSnnRqnTnIj2diplpyOaE7Q==
X-Google-Smtp-Source: AGHT+IGSqZuyGSF4dl4f8vL5SDUe8DptUJ+hrvwc2yEue7KF30SYjHpxtGDfQzB83tIn0W9BwRzlRQ==
X-Received: by 2002:aa7:d759:0:b0:52a:1d9c:83ff with SMTP id
 a25-20020aa7d759000000b0052a1d9c83ffmr4614315eds.1.1694089846814; 
 Thu, 07 Sep 2023 05:30:46 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr.
 [176.131.222.226]) by smtp.gmail.com with ESMTPSA id
 ay9-20020a056402202900b0052a198d8a4dsm9721651edb.52.2023.09.07.05.30.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 05:30:46 -0700 (PDT)
Message-ID: <49e0cd0d-bc6a-db43-8eae-11f6c84b729b@linaro.org>
Date: Thu, 7 Sep 2023 14:30:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] contrib/plugins: add Darwin support
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20230907114403.493361-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907114403.493361-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 7/9/23 13:44, Paolo Bonzini wrote:
> Under Darwin, using -shared makes it impossible to have undefined symbols
> and -bundle has to be used instead; so detect the OS and use
> different options.
> 
> Based-on: <20230907101811.469236-1-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>          This replaces Philippe's patch to link with GLib, and also fixes
>          errors like
> 
>            "_qemu_plugin_get_hwaddr", referenced from:
> 	      _vcpu_mem in execlog.o
> 
>          I guess this shows that we're kinda losing in not using Meson
>          for the plugins, but as I said I appreciate the didactic value
>          of using a standalone Makefile (with only a handful of lines
>          in configure).
> 
>   contrib/plugins/Makefile | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

