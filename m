Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C10D742786
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 15:35:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qErne-0008RR-Mq; Thu, 29 Jun 2023 09:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qErnd-0008RA-2w
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:35:05 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qErnb-0007TM-EA
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:35:04 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31409e8c145so736894f8f.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688045701; x=1690637701;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qTgcW5gMFdIvt4cZeYfaKm3UcYMfXtGRNkkLsSlwxPo=;
 b=yTOJHUIV2LVgGQnXm9I4ULmA6JVYb9GTtSrSaDUlWkmbPkrSkOujzhh+eNe+2sZmTP
 I2lBhK0VHlFj5h5RxGWv7tY17dDJFyddAhAE1cLULrrpf5qrXcQcsiIck1oAzX8P52cw
 xc+RJvXwnnjsL77+L4i3zccoTTc5guz+sVoVRtJbMF8xo+RJYeY7nE1MHckqWPIXezEX
 Gvnyok8xOOqLlykJ7JjS6yR8U0dKnHohLQQA/od2oNbq/M22tkQKC5SaQ/ZDAXB1xvey
 +BIMo22MpGR42lgjUcnLOG0kwNWbPA2zPMV/1ox/FprhhacIwwVCRJ4faKJxOwS0505M
 01VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688045701; x=1690637701;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qTgcW5gMFdIvt4cZeYfaKm3UcYMfXtGRNkkLsSlwxPo=;
 b=SpAkvs92Vw9gKT0xDFC5OYmacYBznE0oc4K0uwxuu3WnHmAj+PWXhsZrijuGXpzPC7
 mxkeY/ovo13YVXan6Z2F2tehwEjEc5iCKvf7pvWsv/63poC3RKEvRFTceom3hv7qRIh7
 F6tbUO0i2lwvz+pn6LGTa/dfwjwt6Q9xiEOzcComoARAX1KO2AazZbaQlX/WTaACeWEM
 GZUoDDrv8B1Tg8r7GNH+hTa0xk6L97GYTqyzSvXCJtE3+lkaeHihPlLddfctxYCUmaF/
 qRbb+dY2WNXfMEuYEXH8yrIKnVa0oG7GI70L3l77JIyGS2leteIoKQF0FIC0+HRnhgwj
 vOdw==
X-Gm-Message-State: AC+VfDxH4hQ+Z5OIYopFw7BZqqlti1W4mgz3DKLRg7Zv29pZGa13HoAI
 0uM3UFEzt3aoTNTE//OP11261g==
X-Google-Smtp-Source: ACHHUZ6SrTosdzDnV1pwmn2GjuB/ovl8uNmHfp8xT2+SeT/1N9QHXFhTyrQOfgyHducRJgV1+pcPmQ==
X-Received: by 2002:adf:fb46:0:b0:30f:ce4f:5675 with SMTP id
 c6-20020adffb46000000b0030fce4f5675mr27683781wrs.59.1688045701589; 
 Thu, 29 Jun 2023 06:35:01 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 a25-20020a5d4579000000b003048477729asm15899208wrc.81.2023.06.29.06.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 06:35:00 -0700 (PDT)
Message-ID: <e5605ebb-ea54-6e7f-3c73-16c9ef9cb9be@linaro.org>
Date: Thu, 29 Jun 2023 15:34:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 22/36] include/hw/qdev-core: fixup kerneldoc annotations
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Bandan Das
 <bsd@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
 <20230627160943.2956928-23-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230627160943.2956928-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 27/6/23 18:09, Alex Bennée wrote:
> Fix up the kerneldoc markup and start documenting the various fields
> in QDEV related structures. This involved:
> 
>   - moving overall description to a DOC: comment at top
>   - fixing various markup issues for types and structures
>   - adding missing Return: statements
>   - adding some typedefs to hide QLIST macros in headers
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20230619171437.357374-4-alex.bennee@linaro.org>
> 
> ---
> v3
>    - checkpatch cleanups
> ---
>   include/hw/qdev-core.h | 367 ++++++++++++++++++++++++++++-------------
>   1 file changed, 253 insertions(+), 114 deletions(-)


>   struct DeviceClass {
> -    /*< private >*/
> +    /* private: */
>       ObjectClass parent_class;

New line here?

> -    /*< public >*/
> +    /* public: */

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


