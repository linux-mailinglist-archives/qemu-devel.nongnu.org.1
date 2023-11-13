Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D46EF7EA0B3
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 16:56:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ZHG-00035p-R2; Mon, 13 Nov 2023 10:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2ZHE-00035L-A8
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:55:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2ZHC-0000g6-DG
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699890901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Mm5g/oKF5vcP9+nurcTyb+uUJzHdUzry68ElTYh6x3A=;
 b=dge/spYAHZVHmy501tkmn74HQGlZXSZBzY514IFaTmRAZGe6RvGg2/3RVWR5Haa7INrpfw
 nrVh7s4hNTQKcedjsopltpKVQLhZTKHRwtKNeACvdS0MoP4AmavOpkhIfw4rJ3yim6Klxw
 aKfz5fGCTxukdH7otY+ml/vT3800gFA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-542Lo4GkPSiLGRzAvCTvuA-1; Mon, 13 Nov 2023 10:54:57 -0500
X-MC-Unique: 542Lo4GkPSiLGRzAvCTvuA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66d026cae6eso52556116d6.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 07:54:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699890896; x=1700495696;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mm5g/oKF5vcP9+nurcTyb+uUJzHdUzry68ElTYh6x3A=;
 b=KMUp+rvw4qBDNTXZkGJtkj9uPKZoBNdTNXsQlACkUgyuSOFYqKuCQad5bxLXTWhYmB
 UR1+kqHaPOK9EV02+yQN8iGuB9WWmW8quCgmeWJHL7n36jU3q4Rr9Z4FIJZONHwQ0N/l
 imm8LeVMYYA9/hyqw9qVkcETQFY5x0IQvVwwonRmdptEvorp3SZg0PVLXsAn/gAX17fG
 lFRuTi3bya69i4SnCZlSHnE+P7ihiFYFB8IjtzGkAtyQvySxBjL4xSPhAC9UWjv5Jbl/
 smBqXJYddVfEgL4kKncKk3GRjpjsZcHcFRJPJJ4STdYYmCg4Xg9mfCvDN1WONoTBWU+U
 rQdQ==
X-Gm-Message-State: AOJu0Yx6Ok4e7Gr/FGr4WN10jsGDMm6/pLdqEQq5nioreTqK2uJY3cX4
 yE+tWamOd3i0oHV/4iQcQpdJ69uSUCSY7+uRBoK9VsU4UaoWa7El8GBXYywP/RCptoKcZqZJSKu
 majXCMQ49oRBNUaI=
X-Received: by 2002:ad4:4c4d:0:b0:673:72a4:b0bc with SMTP id
 cs13-20020ad44c4d000000b0067372a4b0bcmr7493173qvb.38.1699890896746; 
 Mon, 13 Nov 2023 07:54:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnrM8N5+lHSExDqqBnqdqShfxr2q/xlkLVTGxO5/OMk7cUnCE2vb0pT6ZI3WkuwvQoXFZxhg==
X-Received: by 2002:ad4:4c4d:0:b0:673:72a4:b0bc with SMTP id
 cs13-20020ad44c4d000000b0067372a4b0bcmr7493163qvb.38.1699890896507; 
 Mon, 13 Nov 2023 07:54:56 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-177-79.web.vodafone.de.
 [109.43.177.79]) by smtp.gmail.com with ESMTPSA id
 a4-20020a0cefc4000000b0065af9d1203dsm2169247qvt.121.2023.11.13.07.54.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 07:54:56 -0800 (PST)
Message-ID: <43bf23f8-ef98-453b-a687-5367e39f0c2b@redhat.com>
Date: Mon, 13 Nov 2023 16:54:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs/system/arm: Fix for rename of type
 "xlnx.bbram-ctrl"
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alistair@alistair23.me, edgar.iglesias@gmail.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com, qemu-arm@nongnu.org
References: <20231113134344.1195478-1-armbru@redhat.com>
 <20231113134344.1195478-2-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231113134344.1195478-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 13/11/2023 14.43, Markus Armbruster wrote:
> Fixes: b65b4b7ae3c8 (xlnx-bbram: hw/nvram: Use dot in device type name)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   docs/system/arm/xlnx-versal-virt.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
> index d2d1b26692..a6a77b3799 100644
> --- a/docs/system/arm/xlnx-versal-virt.rst
> +++ b/docs/system/arm/xlnx-versal-virt.rst
> @@ -194,7 +194,7 @@ To use a different index value, N, from default of 0, add:
>   
>   .. code-block:: bash
>   
> -  -global xlnx,bbram-ctrl.drive-index=N
> +  -global xlnx.bbram-ctrl.drive-index=N

Ouch, that's now ugly, too. Imagine that we have a device called "xlnx" one 
day, how's the reader supposed to distinguish between the "xlnx" and the 
"xlnx.bbram-ctrl" device here?

It feels like we should forbid both, "," and "." in device names...

Anyway, for the current state:
Reviewed-by: Thomas Huth <thuth@redhat.com>


