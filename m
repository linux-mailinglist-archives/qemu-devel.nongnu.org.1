Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B806C812CC0
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 11:18:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDim7-00037H-NX; Thu, 14 Dec 2023 05:17:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rDim5-00036z-C9
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 05:17:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rDim3-0002fp-Ld
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 05:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702549018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eVsxdwSnhSBTVnkRkStkb4tnqQlrdDPUllcCzcZOG50=;
 b=XM4e25+6dzqvxtynA3QXIZF7dJV3jy6OtK+ui6CJhMxCzg07xrSpa3T1/JvUo6ryeW4yY4
 LlA9+GlLgjfudoHtIZGai+Hf5/LXKBu7nExOEtnNjeZcZZ0uy6py11ymc0IaWGhzsdnmtL
 rulCwPQQuvwGb1m0q3lVDJUaHCMZpag=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-3Jxa8wC9NHqrppmBq8lzxA-1; Thu, 14 Dec 2023 05:16:54 -0500
X-MC-Unique: 3Jxa8wC9NHqrppmBq8lzxA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-77f37b54031so999533585a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 02:16:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702549014; x=1703153814;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVsxdwSnhSBTVnkRkStkb4tnqQlrdDPUllcCzcZOG50=;
 b=C3AQx6rqXw8OcjhVhWZoJLB62mGJOiYUe7czyUKvoVlt0ffNwm0YSnLjUS3neeHyBz
 pA5VnTi5biqIbXx7KATGwHOg9jLSL7wPyDRPTnSxspFDRHTP9BXmXOtT5sqoSGxL9xUr
 CN26O/PRwmOpgCThDQdK9EFhee2IvOxI6h16K3Hnmau7tj5PbdzBP4WWytAakPqjhszi
 5we4b93VsKDxJ3ua0RG8SRaaEOcs67VHMLuBoWpAJWjfduieiVjsJGLa5pKosZK32k//
 0tPKULsfbPjswtmKrddbYWallVaTEkbFIib6sARPnvUo3/Kz01pE1gkJ/vQpSrO2jG9E
 G8ZQ==
X-Gm-Message-State: AOJu0YykVEa8l36MukounLhI3E+sVTONBFe9VJqRZPXuFZB531gkVotq
 arS7CoRwnK8XR4FoEB2gi5mjdyCsBHiE4tpBSJTqtdUU82b8eKiG4EPc1CO2wyTjWp/HEpYpJhl
 vXMSetX9PfGjDGKQ=
X-Received: by 2002:a05:620a:1004:b0:77f:3f0b:219d with SMTP id
 z4-20020a05620a100400b0077f3f0b219dmr9244804qkj.128.1702549014342; 
 Thu, 14 Dec 2023 02:16:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbKcTJAxkGFBG/AANcU05rTEXnr9LCdxZwiSkHvHvwd24U2jpyZl4gesqUnQ/7b/Xj7+m5gQ==
X-Received: by 2002:a05:620a:1004:b0:77f:3f0b:219d with SMTP id
 z4-20020a05620a100400b0077f3f0b219dmr9244799qkj.128.1702549014057; 
 Thu, 14 Dec 2023 02:16:54 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-178-144.web.vodafone.de.
 [109.43.178.144]) by smtp.gmail.com with ESMTPSA id
 qg1-20020a05620a664100b0077f01c11e3bsm5187655qkn.61.2023.12.14.02.16.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Dec 2023 02:16:53 -0800 (PST)
Message-ID: <f0fa608f-5420-4438-875c-c65ac0e15e7a@redhat.com>
Date: Thu, 14 Dec 2023 11:16:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu-options: Clarify handling of commas in options
 parameters
To: Yihuan Pan <xun794@gmail.com>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20231213141706.629833-2-xun794@gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231213141706.629833-2-xun794@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 13/12/2023 15.17, Yihuan Pan wrote:
> Provide explicit guidance on dealing with option parameters as arbitrary
> strings containing commas, such as in "file=my,file" and "string=a,b". The
> updated documentation emphasizes the need to double commas when they
> appear within such parameters.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1839
> Signed-off-by: Yihuan Pan <xun794@gmail.com>
> ---
>   docs/system/invocation.rst   | 5 +++++
>   docs/system/qemu-manpage.rst | 5 +++++
>   qemu-options.hx              | 4 ++++
>   3 files changed, 14 insertions(+)
> 
> Changes since the previous version:
> - Added a generic comment about doubling the commas to the
>    documentation.
> 
> diff --git a/docs/system/invocation.rst b/docs/system/invocation.rst
> index 4ba38fc23d..14b7db1c10 100644
> --- a/docs/system/invocation.rst
> +++ b/docs/system/invocation.rst
> @@ -10,6 +10,11 @@ Invocation
>   disk_image is a raw hard disk image for IDE hard disk 0. Some targets do
>   not need a disk image.
>   
> +When dealing with options parameters as arbitrary strings containing
> +commas, such as in "file=my,file" and "string=a,b", it's necessary to
> +double the commas. For instance,"-fw_cfg name=z,string=a,,b" will be
> +parsed as "-fw_cfg name=z,string=a,b".
> +
>   .. hxtool-doc:: qemu-options.hx
>   
>   Device URL Syntax
> diff --git a/docs/system/qemu-manpage.rst b/docs/system/qemu-manpage.rst
> index c47a412758..3ade4ee45b 100644
> --- a/docs/system/qemu-manpage.rst
> +++ b/docs/system/qemu-manpage.rst
> @@ -31,6 +31,11 @@ Options
>   disk_image is a raw hard disk image for IDE hard disk 0. Some targets do
>   not need a disk image.
>   
> +When dealing with options parameters as arbitrary strings containing
> +commas, such as in "file=my,file" and "string=a,b", it's necessary to
> +double the commas. For instance,"-fw_cfg name=z,string=a,,b" will be
> +parsed as "-fw_cfg name=z,string=a,b".
> +
>   .. hxtool-doc:: qemu-options.hx
>   
>   .. include:: keys.rst.inc
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 42fd09e4de..a935aaae44 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4086,9 +4086,13 @@ DEF("fw_cfg", HAS_ARG, QEMU_OPTION_fwcfg,
>   SRST
>   ``-fw_cfg [name=]name,file=file``
>       Add named fw\_cfg entry with contents from file file.
> +    If the filename contains comma, you must double it (for instance,
> +    "file=my,,file" to use file "my,file").
>   
>   ``-fw_cfg [name=]name,string=str``
>       Add named fw\_cfg entry with contents from string str.
> +    If the string contains comma, you must double it (for instance,
> +    "string=my,,string" to use file "my,string").
>   
>       The terminating NUL character of the contents of str will not be
>       included as part of the fw\_cfg item data. To insert contents with

Looks fine to me, thanks!

Reviewed-by: Thomas Huth <thuth@redhat.com>

If nobody objects, I can queue it for my next pull request.

  Thomas


