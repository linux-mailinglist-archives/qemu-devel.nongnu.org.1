Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 293F47846A6
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 18:14:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYU0o-0005Oh-Jm; Tue, 22 Aug 2023 12:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYU0m-0005Mz-D4
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:13:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYU0j-0008KJ-Ge
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692720819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ODSgnTlXPRjb++f0tFvoo5ruAz/4ONPqSLiE7Oabybc=;
 b=TFMvxzzmoMniGfEkMdvf1PQGtIb/oT+lbLTgIVZwGH+VtahjHbQGFHzuVZOnKfUrHdxjGZ
 oCnHTLslSwQhulxwxWnrFpUWSFvRRk7ex7KIzaIAJZYT5PaRElOzJE4W6S/LPdSIJPvGPI
 +rbBAaWzVbZJH3lzRxWDXG8ygFMyHvQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-7QVbU-i8OPO-BDwrwpNiqA-1; Tue, 22 Aug 2023 12:13:37 -0400
X-MC-Unique: 7QVbU-i8OPO-BDwrwpNiqA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe57d0e11eso30462685e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 09:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692720816; x=1693325616;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ODSgnTlXPRjb++f0tFvoo5ruAz/4ONPqSLiE7Oabybc=;
 b=ho3A/OjhjxlDGfnSCCRAQHY6x1T3apooMs3gmmANicmr08tD8jTPGXp56uxea9GIom
 Js85Rb+PKyK7SZEuIr48KXxTic362i8Oj7JLVCetP8tp67zunlfX/c7MDwOgxwsfZavG
 3Xadv6s7nnPSP0Fj2HXno8b/43Q9xQjROX9O8CqDc090I/PLWWlJEp6jobhrBW5p8FVy
 x+nKE432G94L2YTTJ1S0ulGn3nCE5L7zT9P5Cwyn4ARS648jA62mUG0SNZOKTEWxqJfa
 XfLVvVxdjvESQw6hFxS08x763QsmKEUvdsNUKQhOIprUoAX/3UQx5B2E6UZD6+wRh3LD
 a05A==
X-Gm-Message-State: AOJu0Yy6J5bfRCB62HsLTzjUF9dwD2b7pT0NqicMcakNMtrSWAkUFMLU
 ioQSoI2U62HGUT6Q/Xq5d5vhI+3NM4a9HcLVv24ecmNGLMwxV9wh10Gj9PDFrOKr0L2aiZii2jT
 EH7uhINsMgR9Rso4nOsKTuJQMQg==
X-Received: by 2002:a1c:4b09:0:b0:3fe:d1b9:7ea8 with SMTP id
 y9-20020a1c4b09000000b003fed1b97ea8mr8138789wma.28.1692720816393; 
 Tue, 22 Aug 2023 09:13:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+Pp1ZDn8GmIr2zFcGNtnUtIF7N4k9KdPOzLpbTEOcsg9F+8SQTPrmR3j9MtGwJyGtAFvqGg==
X-Received: by 2002:a1c:4b09:0:b0:3fe:d1b9:7ea8 with SMTP id
 y9-20020a1c4b09000000b003fed1b97ea8mr8138773wma.28.1692720815995; 
 Tue, 22 Aug 2023 09:13:35 -0700 (PDT)
Received: from [192.168.8.100] (tmo-099-195.customers.d1-online.com.
 [80.187.99.195]) by smtp.gmail.com with ESMTPSA id
 z26-20020a1c4c1a000000b003fed1ba0b8esm15342945wmf.8.2023.08.22.09.13.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 09:13:35 -0700 (PDT)
Message-ID: <b311bb8e-d2c0-ced9-b5d3-05558abaa800@redhat.com>
Date: Tue, 22 Aug 2023 18:13:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] docs/style: permit inline loop variables
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
References: <20230822155004.1158931-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230822155004.1158931-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.767, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 22/08/2023 17.50, Alex Bennée wrote:
> I've already wasted enough of my time debugging aliased variables in
> deeply nested loops. While not scattering variable declarations around
> is a good aim I think we can make an exception for stuff used inside a
> loop.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/devel/style.rst | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index 3cfcdeb9cd..2f68b50079 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -204,7 +204,14 @@ Declarations
>   
>   Mixed declarations (interleaving statements and declarations within
>   blocks) are generally not allowed; declarations should be at the beginning
> -of blocks.
> +of blocks. To avoid accidental re-use it is permissible to declare
> +loop variables inside for loops:
> +
> +.. code-block:: c
> +
> +    for (int i = 0; i < ARRAY_SIZE(thing); i++) {
> +        /* do something loopy */
> +    }

Reviewed-by: Thomas Huth <thuth@redhat.com>


