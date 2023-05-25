Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B76DF7105E5
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 09:02:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q24xp-0000fR-76; Thu, 25 May 2023 03:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q24xX-0000Zw-Be
 for qemu-devel@nongnu.org; Thu, 25 May 2023 03:00:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q24xV-00038B-Md
 for qemu-devel@nongnu.org; Thu, 25 May 2023 03:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684998024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A4jYotIEo3d4GX3qK1xIgc8Gxn3eKK+7K37T5a5EjYI=;
 b=a4EQ/mRIcTQd4qg0nEHFDmICU4s8ePrXOOUGnkk5kmrUBnNKm6louuK8S30RdchUobePe0
 AhO9wox4odc1va3HO38bWlMQcC4uRU6+Z34y5u2RVTOnvv19oNighvBk5qC5j7z/nE5pOV
 KuUTfiVEp7uhL3dtiMOJxC/reLlK8SQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-mBvQiR8lOWmZkZ-1-LzkWg-1; Thu, 25 May 2023 03:00:23 -0400
X-MC-Unique: mBvQiR8lOWmZkZ-1-LzkWg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f603b8eb61so1410475e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 00:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684998022; x=1687590022;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A4jYotIEo3d4GX3qK1xIgc8Gxn3eKK+7K37T5a5EjYI=;
 b=l3IjDVqVFgZDXpIlO8iA4xK7nc88qWrd6vXjYLHBUXCgDLzUV2wdE1AZUtFJLzKAx6
 TSvEcYJUhiJvs3G/YzoqCFMxbeOi61o6RskeCJUl/LBk2dE957JHakBSrO3reRvXT1ur
 t38fEh/b1HMFP0oukufsGzMnGccd7vGpNkwNJoaHdvFNgYIrciUdD1407bgs7FtGhxw/
 wZxSg5fw44lfF3hkKs8bcfQetEjQh2Ux6QR7JXFhkwxiAbN0mwSooEJ5u0HDRfYB4iM2
 zEV/ExF1wp5Zltebz/zgrGV1o5Fcp+Yxob4MktJKf6Z6tsZMbZ9T1caWBcxSFNbx2HCi
 Nt3A==
X-Gm-Message-State: AC+VfDxksHlYQX/+qzR0TL2gyrW3g+qm++2BXf23OFUQ7p0iCWHAZ/fO
 xx+14H3r8HcUP2wfwcTq6IREniZSK8SJFwTFnxCatxK4WiLI+OMVr3y4ONyBLgQUfsNijTg4vSK
 GmA1AjpIQMSJRthQ=
X-Received: by 2002:a7b:c4d5:0:b0:3f6:1141:7cc1 with SMTP id
 g21-20020a7bc4d5000000b003f611417cc1mr1584800wmk.26.1684998022033; 
 Thu, 25 May 2023 00:00:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ67sNhXGiCWMEC33rfKm3jKjz1JK7EQKNXMkKM3Vv9dYyOSX5dAEO/BvL0jlv1Hw9ZDOwyVcA==
X-Received: by 2002:a7b:c4d5:0:b0:3f6:1141:7cc1 with SMTP id
 g21-20020a7bc4d5000000b003f611417cc1mr1584782wmk.26.1684998021670; 
 Thu, 25 May 2023 00:00:21 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-30.web.vodafone.de.
 [109.43.177.30]) by smtp.gmail.com with ESMTPSA id
 v24-20020a1cf718000000b003f606c4ad33sm4632454wmh.32.2023.05.25.00.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 00:00:20 -0700 (PDT)
Message-ID: <1d52351d-4559-d632-4161-626fdbf2517d@redhat.com>
Date: Thu, 25 May 2023 09:00:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC 3/3] s390-ccw: Getting rid of ulong
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230510143925.4094-1-quintela@redhat.com>
 <20230510143925.4094-4-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230510143925.4094-4-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 10/05/2023 16.39, Juan Quintela wrote:
> Any good reason why this still exist?
> I can understand u* and __u* to be linux kernel like, but ulong?
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   pc-bios/s390-ccw/helper.h        |  2 +-
>   pc-bios/s390-ccw/s390-ccw.h      |  7 +++----
>   pc-bios/s390-ccw/virtio-blkdev.c | 12 ++++++------
>   pc-bios/s390-ccw/virtio-scsi.c   |  4 ++--
>   pc-bios/s390-ccw/virtio-scsi.h   |  2 +-
>   pc-bios/s390-ccw/virtio.c        | 12 ++++++------
>   pc-bios/s390-ccw/virtio.h        |  4 ++--
>   7 files changed, 21 insertions(+), 22 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


