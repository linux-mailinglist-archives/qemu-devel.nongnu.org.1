Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC50B70F1FE
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:18:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kcv-0008Dh-DO; Wed, 24 May 2023 05:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kct-0008DV-1l
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:17:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kcr-0002dU-A7
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:17:46 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f611ccd08cso5791465e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684919863; x=1687511863;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TCNjNl4Ctm8lg8hBacptZvWBBK+jcutSIYAIOZHkiCg=;
 b=TYVFUM6ZPwnJM7YIXPBXfqOqM8Vw9ULSODNImx6WZi+eqZA6oxjibcVr2PvgpcCLtg
 1bnmQfkIkSrJXxe4q1xm3fTsvSBkGnzG8D0iN5lT6D746L0AxI7/+lweXe+RRhPAvY6L
 iQ6gXSAuKRownJJ/qHtBsNKR9hs072Q2Owg8tEw9BEOmozdlAlu50BRfnVGGygvNspa7
 byocF1Hxg7R9joHrQvMIAeJnjWLlE/gdtOOU8NJDNejxNY9PRdAtHyk+etnXMSslnHXI
 oHzqCdipk+uAyf1lMm0IuRj1FePwQFfAZCYNgH1LtVuknyJBodkRR8iOrw6P+HW+F1X4
 1N8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684919863; x=1687511863;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TCNjNl4Ctm8lg8hBacptZvWBBK+jcutSIYAIOZHkiCg=;
 b=TanSjLZuIF+zYCYHJ0DUquxYoaCvlWEED2ORrrie0x8su0iazCFOl7noI+KNRY4BZW
 uaCriu+3sBvm9A2BnXj1B2uDVlNPY93Iw0smkeAx4tx3LQRW01CORHr6db+/HkAk1c8x
 0YwRuiSyzjOT3AM/0bcXArMw3VsOVZWXBq81IvlfqyObLJ2X4RMGRY/spKAZY73HYftP
 dao9CHxeNo+3Cx+Icyqr4lklOdoe3AF259mTPRgZsQ0Z71J43nC3jLxU2ZM3Fxkhkg56
 6ftOBPaWDpqvht3/8jS1O+J3bVOCuWz5EMdgNhwjcwMTrpwvDqQpsySuBnxF15PJxz6h
 NXHw==
X-Gm-Message-State: AC+VfDw9kML8m95kqmW/xNqXixWIFxb5ksFXpaGEBdUyyTCCvZXcCcrW
 negnUhJ/kW5c9HmqScW3uVvUFxhCPzy101qH2Py4tQ==
X-Google-Smtp-Source: ACHHUZ5K1us5spWHqgZW5DyN04NApd8ALoXEmD8rg45zal9SYAgE32eCBDXd/QtszdIGRSRYXO69tw==
X-Received: by 2002:a05:600c:5114:b0:3f1:80d0:906b with SMTP id
 o20-20020a05600c511400b003f180d0906bmr12490786wms.4.1684919863365; 
 Wed, 24 May 2023 02:17:43 -0700 (PDT)
Received: from [192.168.69.115] (fac34-h02-176-184-31-246.dsl.sta.abo.bbox.fr.
 [176.184.31.246]) by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c059300b003f60119ee08sm1590169wmd.43.2023.05.24.02.17.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 02:17:42 -0700 (PDT)
Message-ID: <e3468060-43d7-40bb-5c26-ba9a6699ecaa@linaro.org>
Date: Wed, 24 May 2023 11:17:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v4 05/10] qapi: make the vcpu parameters deprecated for 8.1
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Riku Voipio <riku.voipio@iki.fi>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Yanan Wang <wangyanan55@huawei.com>
References: <20230523125000.3674739-1-alex.bennee@linaro.org>
 <20230523125000.3674739-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230523125000.3674739-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 23/5/23 14:49, Alex Bennée wrote:
> I don't think I can remove the parameters directly but certainly mark
> them as deprecated.
> 
> Message-Id: <20230420150009.1675181-6-alex.bennee@linaro.org>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20230503091756.1453057-6-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20230505155336.137393-6-alex.bennee@linaro.org>
> 
> ---
> v4
>    - used @deprecated in json
>    - added note to deprecated.rst
> ---
>   docs/about/deprecated.rst |  9 +++++++++
>   qapi/trace.json           | 38 ++++++++++++++++++--------------------
>   2 files changed, 27 insertions(+), 20 deletions(-)


> @@ -52,19 +53,17 @@
>   #
>   # @name: Event name pattern (case-sensitive glob).
>   #
> -# @vcpu: The vCPU to query (any by default; since 2.7).
> +# @vcpu: The vCPU to query (since 2.7).
> +#
> +# Features:
> +# @deprecated: Member @vcpu is deprecated, and always false.
>   #
>   # Returns: a list of @TraceEventInfo for the matching events
>   #
>   # An event is returned if:
>   #
> -# - its name matches the @name pattern, and
> -# - if @vcpu is given, the event has the "vcpu" property.
> -#
> -# Therefore, if @vcpu is given, the operation will only match per-vCPU
> -# events, returning their state on the specified vCPU. Special case:
> -# if @name is an exact match, @vcpu is given and the event does not
> -# have the "vcpu" property, an error is returned.
> +# - its name matches the @name pattern
> +#   There are no longer any per-vCPU events

Maybe convert the 2 spaces by a newline, or even better simply:

   # An event is returned if its name matches the @name pattern
   # (There are no longer any per-vCPU events).

>   #
>   # Since: 2.2
>   #
> @@ -75,7 +74,8 @@
>   # <- { "return": [ { "name": "qemu_memalign", "state": "disabled", "vcpu": false } ] }
>   ##
>   { 'command': 'trace-event-get-state',
> -  'data': {'name': 'str', '*vcpu': 'int'},
> +  'data': {'name': 'str',
> +           '*vcpu': {'type': 'int', 'features': ['deprecated'] } },
>     'returns': ['TraceEventInfo'] }
>   
>   ##
> @@ -91,15 +91,13 @@
>   #
>   # @vcpu: The vCPU to act upon (all by default; since 2.7).
>   #
> -# An event's state is modified if:
> +# Features:
> +# @deprecated: Member @vcpu is deprecated, and always false.
>   #
> -# - its name matches the @name pattern, and
> -# - if @vcpu is given, the event has the "vcpu" property.
> +# An event's state is modified if:
>   #
> -# Therefore, if @vcpu is given, the operation will only match per-vCPU
> -# events, setting their state on the specified vCPU. Special case: if
> -# @name is an exact match, @vcpu is given and the event does not have
> -# the "vcpu" property, an error is returned.
> +# - its name matches the @name pattern
> +#   There are no longer any per-vCPU events

Ditto.

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

