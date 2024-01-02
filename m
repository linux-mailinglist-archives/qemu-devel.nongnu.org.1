Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9193A82183E
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 09:18:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKZxN-0000jQ-LQ; Tue, 02 Jan 2024 03:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rKZxC-0000iv-Kr
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 03:16:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rKZxA-000586-RB
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 03:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704183405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2n8JVT3Ac2sYr3v+vSPtlJKP0Ja3Wze2CZMSRVb7v6U=;
 b=ImgB69eAp9yjnuowzv517e59/gLbL/D2tUwxMf8/ptiMAh2w41bKL6V+CtJBWHt9f1Uv3p
 lbrwYVjyEjbcpQuHgFXOdtLaVw5UVoTzTESn1iry/uEmQ35rPAKk/EU6DgCp7vlWeXIcKM
 0t7S9ZLI6OU2J2ybasIFDArpg3BikaM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-JFUpEz5sNmOM41QDEV7n3w-1; Tue, 02 Jan 2024 03:16:43 -0500
X-MC-Unique: JFUpEz5sNmOM41QDEV7n3w-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-428205848e9so27146001cf.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 00:16:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704183403; x=1704788203;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2n8JVT3Ac2sYr3v+vSPtlJKP0Ja3Wze2CZMSRVb7v6U=;
 b=uOcT3X2Z8FUz3TYEYo9QfUJm4tNoc241fv1hRF/M8guLjcVSW0LKzEWcaqLwTaO1nW
 QtDjo4YDy99gZTikRTPfR/cCFRxwqRotWn2kiXOT44p54mg2JUIWfop+vY3RcIByFWly
 j71puF7hmQkgUaaUE6epIiJCFQwiVL4HvzgM38sANGxsNl54j2MSb4y+BPuqrg0qjta6
 T3/818hLjNc8HRzA1xUW6Ro5RU0V3bn4pL5IMTjFywq0sBhAQBFlVbeLOtRr2H02Kc1s
 BTgWi21ZQTL4aYRK5OB7jj0vo9v3CqDM+K9EMfpnC915sicsVTn28L6/UKEavy3cIcOR
 VY4g==
X-Gm-Message-State: AOJu0YwEaIeTJygU9Bb7RICRBkR/artv05Vuufo2xIK90b6NMWPHrSEO
 gOudgR88z6QQy7jdWBm3cBmB1gHaERSFzlC/Hzw+5Ey++vPj4nqJcuFYXv87eohScA5vWfmD9On
 +noh44dBw+mt9DxNdCiKGDqk=
X-Received: by 2002:ac8:5911:0:b0:428:206c:6c30 with SMTP id
 17-20020ac85911000000b00428206c6c30mr4177605qty.52.1704183403209; 
 Tue, 02 Jan 2024 00:16:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHueYHpLzQ4/aNfuIqm0ZnARD0LEnqjCwvXmbB1AP4mZ6lflU29xndB9cFeXE8qf6qAE595EA==
X-Received: by 2002:ac8:5911:0:b0:428:206c:6c30 with SMTP id
 17-20020ac85911000000b00428206c6c30mr4177599qty.52.1704183403027; 
 Tue, 02 Jan 2024 00:16:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 fw11-20020a05622a4a8b00b00419801b1094sm6016734qtb.13.2024.01.02.00.16.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 00:16:42 -0800 (PST)
Message-ID: <8139f1b3-9608-4013-b11e-fd5e0afb17f8@redhat.com>
Date: Tue, 2 Jan 2024 09:16:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/container: Rename vfio_init_container to
 vfio_set_iommu
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20231221024517.254074-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231221024517.254074-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.246,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12/21/23 03:45, Zhenzhong Duan wrote:
> vfio_container_init() and vfio_init_container() names are confusing
> especially when we see vfio_init_container() calls vfio_container_init().
> 
> vfio_container_init() operates on base container which is consistent
> with all routines handling 'VFIOContainerBase *' ops.
> 
> vfio_init_container() operates on legacy container and setup IOMMU
> context with ioctl(VFIO_SET_IOMMU).
> 
> So choose to rename vfio_init_container to vfio_set_iommu to avoid
> the confusion.
> 
> No functional change intended.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Applied to vfio-next.

Thanks,

C.


