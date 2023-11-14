Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E02627EAFD1
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 13:26:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2sUG-0002Fk-Dz; Tue, 14 Nov 2023 07:25:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2sUE-0002FK-RK
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 07:25:46 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2sUD-0006cg-Cr
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 07:25:46 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53e751aeb3cso8588870a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 04:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699964743; x=1700569543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/OaNUIXzZbTozIX8X4xF9tfJTPhcFd4ZMAc/W8lKR1s=;
 b=LSl/GOMtvtoJ99SfZdWjcS8L0Jj3BHe+DbOOypd3xa0M8L6tOBu+y0q+9nfxtMmNTE
 K/UyBpZkSRzt//38z5OGHLiqwqhDaodDugnyqLw5QxLi/AS+besNsxSbvyGclurWF7/O
 pSESxSEvgiDJwR/K/LdAKTn16dzkiLG1l5M0UMoU+FH8+dNwuTJ5MKx/ry3dmOVEcIDo
 nxSpz4JbNSSWxtE5tExPzCpZY+QL9dUjdkapO5dMl0ODoel/IXX41ldts5mzioM2VZtv
 6TzG7ASQX4rJLzLRo/UCEmy214XvxzAzgkuN2zNKpQwIWlnTCnWg1gQutaWS8qdy7ipk
 /J1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699964743; x=1700569543;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/OaNUIXzZbTozIX8X4xF9tfJTPhcFd4ZMAc/W8lKR1s=;
 b=Wn3+Hzaqyn/442XTr352rzl6GEmccG3aV8YiBqsayENfJAmHZy2GsGBEubSyciez5u
 GNHXocjs1/KlSOSVM6ZLreIXCJFo11UV+zPUo/HW3scuMf8heQ74/5wnrvUFnhq81/4n
 G9Q3BvsFXobgx+rLupUBotIUl+3DqzBemaJHmTes3SM2R9NHbjCmoc5kpi72V2mb1R17
 6wSESQUxsqmGCFrfl+qci+ZpvNXWaP2T9qidkz2mtAUlpjKTpnfqTp3hqKkXsSVFGmmx
 IKd7glsVTMZ2+xSt3HaknKJEa8KiQesQVlH6VgvQf+lh1ss0mWHNKvOtVP8z9ts49l2N
 0nBg==
X-Gm-Message-State: AOJu0Yz+eci+e2JQwZH5aunY2+IegyJ5CoLF+XZnouf/pB+/idJVPmBm
 rYDo+donyxD7Y47HSB+JixbNiw==
X-Google-Smtp-Source: AGHT+IHM6IuBxGUDmhvjGjE56b7qH2UrMdIaZaFuXREseUVLlPhT1pToLbIdRgtL7O9mZ4K3ubCdVQ==
X-Received: by 2002:a17:906:5245:b0:9e5:2b1f:13f4 with SMTP id
 y5-20020a170906524500b009e52b1f13f4mr6552715ejm.42.1699964743415; 
 Tue, 14 Nov 2023 04:25:43 -0800 (PST)
Received: from [192.168.69.100] (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 rs4-20020a170907036400b009a1a653770bsm5412508ejb.87.2023.11.14.04.25.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 04:25:42 -0800 (PST)
Message-ID: <86153cf2-129d-4e1e-8949-786764bdf607@linaro.org>
Date: Tue, 14 Nov 2023 13:25:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 07/10] sysemu/xen-mapcache: Check Xen availability
 with CONFIG_XEN_IS_POSSIBLE
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Paul Durrant <paul@xen.org>
References: <20231113152114.47916-1-philmd@linaro.org>
 <20231113152114.47916-8-philmd@linaro.org>
 <9ba10b4a92ac6782d0c581b1e1ee5d5efee44c33.camel@infradead.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9ba10b4a92ac6782d0c581b1e1ee5d5efee44c33.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 13/11/23 20:52, David Woodhouse wrote:
> On Mon, 2023-11-13 at 16:21 +0100, Philippe Mathieu-Daudé wrote:
>> "sysemu/xen.h" defines CONFIG_XEN_IS_POSSIBLE as a target-agnostic
>> version of CONFIG_XEN. Use it in order to use "sysemu/xen-mapcache.h"
>> in target-agnostic files.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Noting that CONFIG_XEN_IS_POSSIBLE is for Xen accelerator support, and
> may not be set in all cases when we're hosting Xen-compatible guests,

As is CONFIG_XEN.

Maybe be worth renaming CONFIG_ACCEL_XEN if you think we need
guest hw specific CONFIG_foo_XEN variables.

> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>

Thanks!

