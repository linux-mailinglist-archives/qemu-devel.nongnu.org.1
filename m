Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56748A9C036
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Apr 2025 09:58:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Dvt-0001Ms-2F; Fri, 25 Apr 2025 03:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Dvn-0001Lk-9m
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 03:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Dvl-0005qF-7S
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 03:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745567823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VBgSjHHR8L1rE9HgtpbD89aGZZDwYnUTgeGhhdNBhzs=;
 b=P/Zw5IbqdZcWhzv8fIqUXmypd33oozi6gPjTe+fYliI9FYLtDLQSjnvzwPRpE0VVvvEcpJ
 nYrfeXtQSETCIFUdsv0NOGZvhlN5STUQei1ob+lM2cCoLOnLQ3u3R1TYlVOMGv0FtEtjaF
 cx+XW5ay2Dr0Bo6nIRzfqmRd4R8RcGI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-71G2BDfkPAyWyMMIbS-zfA-1; Fri, 25 Apr 2025 03:57:01 -0400
X-MC-Unique: 71G2BDfkPAyWyMMIbS-zfA-1
X-Mimecast-MFC-AGG-ID: 71G2BDfkPAyWyMMIbS-zfA_1745567820
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39c1b1c0969so1229710f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 00:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745567820; x=1746172620;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VBgSjHHR8L1rE9HgtpbD89aGZZDwYnUTgeGhhdNBhzs=;
 b=Yez/3FmhpEcZd3KpQyVjKsBGu8AlLJaViF2W+yUHzNzqi+ijD/Yg382+7+qZj9vs9r
 OyOKrLSdQiAsiJ1oYu8YPY1xujqhzLKcOvDJRUiqaq1y2L7yG3P/bCUMpXcLc1XsVKC8
 jEr00KEjZ/yhj0hGfslpGcGNAfEx/FbxAxz1lxizz95N8w3Ea77Gqim1jpPssVyM59E+
 /H5MQcjefys3QXqaUhw8PM5B7/QuUeau7BS7eGLeUbtuh0BvIY/031nxPXJevcQz2G19
 k2xf4W+4u3cRX3P3r2pkCzjkh+TUZtM6rL+owwJ91WvGcvy7ryZ08PrEwiSksZ0aMckh
 wOCQ==
X-Gm-Message-State: AOJu0YyJw8YZAI5sS08vg8knflpIQqTl3k6QSQe8s7wrhh43tXqplmTR
 CxM0V1F2x8OHbxgFq+7Sz0m7joE6r3pDX+sUvMyWqMBUGbJiWSYrQCpBZ5ETLEEqUdVbnBQQMM2
 6wfYGQXUFkkU7gJBVjQxcyRddMOCK74Xw95tHOi0LCQiPz1ZxGwIKQz37fLqlgDX2X0H5S02q9k
 c8Q4s+VK0/6fFlSCqJ+6RlUY2DtFT/ew==
X-Gm-Gg: ASbGnctz0b9Il0k3fIZbTy6Fh1slvMlm2JzcvQRQynPtYL4+pRffbe+fral+TtY7cVp
 ORbWUp++PzAKxx38i23XFg+6fOxxO7DtwZVm3rIknqmCntXacTuEMJycPV8ma4iPrjAv/tfXjnB
 2uaO5hSMmQiC8+m04vqsaO8VZuozaG3DlB5l1ozED8Vwqrxg/Upz9a0uulvgbo6BhAFq3OgE4bR
 CTk9OComX8JFPlCm6KOsYx57STA0YB0wiy5rdudj+I0/swesZE6AWkxNPCQhK4rOIvNsofnYUg6
 4T8Zt9OC6nEoPpL+SfL6sohxI1QNQjleItkyBEJyklVj8jE=
X-Received: by 2002:a5d:47aa:0:b0:391:13d6:c9e5 with SMTP id
 ffacd0b85a97d-3a074e1df48mr960158f8f.19.1745567819852; 
 Fri, 25 Apr 2025 00:56:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV2YZpRCEdHr1eN77E+1+a3G1iejAaVH8RoVAiBlyC/2IK3Nph0x6NAVRMZqfNXdnmsb4l+g==
X-Received: by 2002:a5d:47aa:0:b0:391:13d6:c9e5 with SMTP id
 ffacd0b85a97d-3a074e1df48mr960139f8f.19.1745567819411; 
 Fri, 25 Apr 2025 00:56:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cbf030sm1572634f8f.46.2025.04.25.00.56.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 00:56:58 -0700 (PDT)
Message-ID: <c5266e7c-96e9-409e-a83f-ba3420fbddd9@redhat.com>
Date: Fri, 25 Apr 2025 09:56:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add a maintainer for util/vfio-helpers.c
To: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
References: <20250422162954.210706-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250422162954.210706-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/22/25 18:29, Cédric Le Goater wrote:
> The NVMe Block device driver makes use of a reduced VFIO library
> managing the host interface. These routines are VFIO related and do
> not have a maintainer. Move util/vfio-helpers.c under VFIO jurisdiction.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d54b5578f88392667fd9713fc0eb6a7406d445fa..66006b68499ece21cf7f60ba477890b706ba2892 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2184,6 +2184,7 @@ M: Alex Williamson <alex.williamson@redhat.com>
>   M: Cédric Le Goater <clg@redhat.com>
>   S: Supported
>   F: hw/vfio/*
> +F: util/vfio-helpers.c
>   F: include/hw/vfio/
>   F: docs/devel/migration/vfio.rst
>   F: qapi/vfio.json


Applied to vfio-next.

Thanks,

C.



