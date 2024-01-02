Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CC282185F
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 09:30:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKa9e-0002cI-4z; Tue, 02 Jan 2024 03:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rKa9c-0002aq-9X
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 03:29:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rKa9a-0006zp-GL
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 03:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704184177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0TLgzPGcmiqviAgQwr03gZhATeilhnj+lahe1UapOB0=;
 b=fgAER8WId081Srk6uh0CjZhQ1zL4haitopMKGe4DolmO1Mzkdh1ILWwMH4Cupxbqr4/rw8
 UXLSS24qtlrpEBcAimMV7tiwhcORVJdFwPubeeyC+wpjxLWm1A4MDSgys1NKMnLV1P++RQ
 ZWCRThXSnursRkJdjsWh3wBFpG3/OLc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-cSTq-PPYPGWSCHkLSi_yHA-1; Tue, 02 Jan 2024 03:29:36 -0500
X-MC-Unique: cSTq-PPYPGWSCHkLSi_yHA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-67f8aefa7d3so117324486d6.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 00:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704184176; x=1704788976;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0TLgzPGcmiqviAgQwr03gZhATeilhnj+lahe1UapOB0=;
 b=b9GXyzKtglhbnbljh0fMr7SKvumW8F8BKg9WrHdQKy5L1B5VIiXnkDUmbzfq7ByVVH
 6h/znulTxsGRNFpUNXA96yQ1XxAaoaCbGUhwUeMxuur69Qyha5FFTXUYhpOprJ9jgmrY
 Syqe/Mj0IEFBEigrQ8oalKzvwWnFpZ/DT7uyfE5CtY4T/uuSHhoYh8n5FoGyCfzAISni
 eoLLBuWOmiKmJUzX5ebdDozQtiRBBSFqleiwl7HrM12BXcYSw7Njsd2Ba+skIjrzH1gI
 kSXxJrWFnbDs4WEmWU1Xjcawz2F/OB7z7nekTK2FNPtxyJpv4qL5Nndo3Lb7dLV5swk8
 kC6w==
X-Gm-Message-State: AOJu0Yx1wA9WEQrS5ESPp7UVNqU4PZzUW5gTPoAsJxgymtQeuZiGffx/
 rS6ODU/WVjRpmamuMbb3F3xKJW37/ztUR3x8weT+FqbmuBH4b/knT+jFHhkHwEvVN7W05GaJ2bN
 ebsX/4EP7/ZugM151rxH2xFg=
X-Received: by 2002:a05:6214:24a:b0:67f:dd6e:9f53 with SMTP id
 k10-20020a056214024a00b0067fdd6e9f53mr11203630qvt.112.1704184175861; 
 Tue, 02 Jan 2024 00:29:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsroV0yOEASpW5+aequpbU9V5xwSIDAfrRJUvrdehLMfpHTzEm/mw5TsUYSkZ2xMJT87MR7A==
X-Received: by 2002:a05:6214:24a:b0:67f:dd6e:9f53 with SMTP id
 k10-20020a056214024a00b0067fdd6e9f53mr11203627qvt.112.1704184175651; 
 Tue, 02 Jan 2024 00:29:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 g12-20020ad4514c000000b0067f70fffc7bsm9930843qvq.2.2024.01.02.00.29.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 00:29:35 -0800 (PST)
Message-ID: <0a514e4b-c012-4959-bbde-432a14cb727b@redhat.com>
Date: Tue, 2 Jan 2024 09:29:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/s390x/ccw: Replace dirname() with
 g_path_get_dirname()
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
References: <20231221171921.57784-1-zhao1.liu@linux.intel.com>
 <20231221171921.57784-3-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231221171921.57784-3-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.246,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 12/21/23 18:19, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> As commit 3e015d815b3f ("use g_path_get_basename instead of basename")
> said, g_path_get_dirname() should be preferred over dirname() since
> the former is a portable utility function that has the advantage of not
> modifing the string argument.
> 
> Replace dirname() with g_path_get_dirname().
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
> Suggested by credit:
>    Cédric: Referred his words for g_path_get_basename() and
>            g_path_get_dirname() has the same advantage.
> ---
>   hw/s390x/s390-ccw.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
> index ab7022a3abe8..5261e66724f1 100644
> --- a/hw/s390x/s390-ccw.c
> +++ b/hw/s390x/s390-ccw.c
> @@ -77,6 +77,7 @@ static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
>   {
>       unsigned int cssid, ssid, devid;
>       char dev_path[PATH_MAX] = {0};
> +    g_autofree char *tmp_dir = NULL;
>       g_autofree char *tmp = NULL;
>   
>       if (!sysfsdev) {
> @@ -93,7 +94,8 @@ static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
>   
>       cdev->mdevid = g_path_get_basename(dev_path);
>   
> -    tmp = g_path_get_basename(dirname(dev_path));
> +    tmp_dir = g_path_get_dirname(dev_path);
> +    tmp = g_path_get_basename(tmp_dir);
>       if (sscanf(tmp, "%2x.%1x.%4x", &cssid, &ssid, &devid) != 3) {
>           error_setg_errno(errp, errno, "Failed to read %s", tmp);
>           return;


