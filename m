Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40920821860
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 09:30:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKa9Y-0002aO-7I; Tue, 02 Jan 2024 03:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rKa9V-0002Zu-HK
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 03:29:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rKa9T-0006zE-W3
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 03:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704184169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UhYLmYjQYjoMS3FTGnyhZz7SGASRMSLhFrzUhocSTwM=;
 b=D2vYCNyPNL53R3bWdGnyyemNCBq54MYa/cislAvovQhzhEeNK39/pc918/tuLScfFA3zB7
 6PpMLDAYIJCi3K7no2Z2aq7lG3Dbc6ANLyUqIEAXY1Z8BPUeQ3OoG75OcsJl/0NyesOFTV
 Kz0bWTO+rI5/1nbXG4X6lprX7XTOfmo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-X-rGV5HkPnyr2ttrBmzK_w-1; Tue, 02 Jan 2024 03:29:27 -0500
X-MC-Unique: X-rGV5HkPnyr2ttrBmzK_w-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-67f6f90587aso204219686d6.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 00:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704184167; x=1704788967;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UhYLmYjQYjoMS3FTGnyhZz7SGASRMSLhFrzUhocSTwM=;
 b=tuccLJnR5sNSod4M4aBojEC2BIvehljrX1KSNuNqSEg8T/QT+smHv7Grv7dkJOM255
 lt0o8XGKFLWIFHIMi2lf6MavYIYWsomVKjB86BooPf+sxhNQYJiT4N9EdgeeVTwlGIUz
 qCtFTox/1NUsdyFT2dmMRK65SpZz4ZiaR2agb9MoqL0aolqw3vj4/SnCKMv9xeEc6X64
 RDDny/UmPhtWZ/pOKrFRpFNr1DeFDHQl1vkwd5F5dtjImJetDF+r2Pp9uLlNuWp+P1qW
 c1sidincKW1AdMEQHfROzty4sSHij54+7axh3Ck3zyrAnwnoO2k3iHFhsfV9kOgn6LDk
 Usiw==
X-Gm-Message-State: AOJu0Yz4S/2rNYtPjwtJRph+TKB5qcQCnf190MPxz88u/u1AbmPJG6Ja
 piuDJ6mLwkQztEPfVLiHqRKOE8N4YdBQbBxFhDYfxupd6lAdXuLeNmcYPPy3IqdVGKVCJydfe27
 IbsdSa8uKFlI65n9nCXNTZ4k=
X-Received: by 2002:a05:6214:2627:b0:67f:2fcb:66fc with SMTP id
 gv7-20020a056214262700b0067f2fcb66fcmr29639238qvb.18.1704184167395; 
 Tue, 02 Jan 2024 00:29:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzG00O/PsypoAouNDY2bgVgEpgwQ2PhvKO8gq93h4RTMLdARmPwSy2UcDLtfPlYK+AnOeU6g==
X-Received: by 2002:a05:6214:2627:b0:67f:2fcb:66fc with SMTP id
 gv7-20020a056214262700b0067f2fcb66fcmr29639236qvb.18.1704184167191; 
 Tue, 02 Jan 2024 00:29:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 g12-20020ad4514c000000b0067f70fffc7bsm9930843qvq.2.2024.01.02.00.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 00:29:26 -0800 (PST)
Message-ID: <4ba18183-25ba-42ac-9043-94f6902a0c1d@redhat.com>
Date: Tue, 2 Jan 2024 09:29:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/s390x/ccw: Replace basename() with
 g_path_get_basename()
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
 <20231221171921.57784-2-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231221171921.57784-2-zhao1.liu@linux.intel.com>
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
> g_path_get_basename() is a portable utility function that has the
> advantage of not modifing the string argument, so it should be
> preferred over basename().
> 
> And also to avoid potential compile breakage with the Musl C library
> similar to [1], replace basename() with g_path_get_basename().
> 
> [1]: https://lore.kernel.org/all/20231212010228.2701544-1-raj.khem@gmail.com/
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
> Suggested by credit:
>    Cédric: Referred his description of similar cleanup in vfio/container.
> ---
>   hw/s390x/s390-ccw.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
> index e2d86d96e728..ab7022a3abe8 100644
> --- a/hw/s390x/s390-ccw.c
> +++ b/hw/s390x/s390-ccw.c
> @@ -76,7 +76,8 @@ static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
>                                     Error **errp)
>   {
>       unsigned int cssid, ssid, devid;
> -    char dev_path[PATH_MAX] = {0}, *tmp;
> +    char dev_path[PATH_MAX] = {0};
> +    g_autofree char *tmp = NULL;
>   
>       if (!sysfsdev) {
>           error_setg(errp, "No host device provided");
> @@ -92,7 +93,7 @@ static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
>   
>       cdev->mdevid = g_path_get_basename(dev_path);
>   
> -    tmp = basename(dirname(dev_path));
> +    tmp = g_path_get_basename(dirname(dev_path));
>       if (sscanf(tmp, "%2x.%1x.%4x", &cssid, &ssid, &devid) != 3) {
>           error_setg_errno(errp, errno, "Failed to read %s", tmp);
>           return;


