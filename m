Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 843FA7FC00F
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 18:12:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r81cQ-0007Jj-R7; Tue, 28 Nov 2023 12:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r81cA-00078m-3j
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 12:11:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r81c7-0004fa-Rw
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 12:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701191469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hku4JAlDcXaOJWdzhB/cXDfnixy0113exg/k7vpOHhM=;
 b=eJjMao2W0QJtwMHQpG84n0OtXwZ4CuL6VTmvgVzjjWiEb+iNWaicFdWCakx6E1wl5bQENq
 pBzcpyq6jSJ1LWUD+bFSpPDifdNEYG30WXnFYopEAEDyVR177dXX1GK+l8UquAZ9AeYEJ4
 DE1Kw9C4eopFZi++6ccHmGkaK/lghfU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-9Gdjm_ZLPVa3T-OTzW_URw-1; Tue, 28 Nov 2023 12:11:08 -0500
X-MC-Unique: 9Gdjm_ZLPVa3T-OTzW_URw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-67a4a82ca63so25340156d6.0
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 09:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701191467; x=1701796267;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hku4JAlDcXaOJWdzhB/cXDfnixy0113exg/k7vpOHhM=;
 b=hgFkSe9A38+QTRJlBivS9CbclmYgtFBKfsI7T33TL+ZVYnijo+09U4NN/1g+dkVlSn
 Qy3Uj86lu2Mxq+4wlq2FeTtoc5Qs1gXl5q+Mgx2J8ZrdPz3fm6m2MLIZ6bqMWnKsr+gT
 rjmy/zuCgaBkBPSSK5RTHJ9ZSIkomXSql9eD8lF0pp7dRfUzQl4DE/Y4Pa02ezf8DpQQ
 pSsexXqUBNSrE9AcDTG1LP7CF7DWMtsTFOzZcxHVpQBl9EppUpRUGBvtQWu1Vp8yMdof
 w0g004bM80/J3aRDnIAe1y17OydQg56ktefiGd/9MyG/pW+fhMqkIOL1mmwD7IMNY7ie
 F9EA==
X-Gm-Message-State: AOJu0YzjztTSL81G4JCQSL0txh8l9LEFPX9oEfcamoqByLnVla5VHTbs
 gFZXptNVNYLEgSyquXlqhc9BUogBPbV71ovmcOnC5vGM45y+2hmHg3jCK+UPEgtpCrF4PouxBQM
 0W+6WV4DySMV2VQM=
X-Received: by 2002:a05:6214:3d0c:b0:67a:24c9:e57d with SMTP id
 ol12-20020a0562143d0c00b0067a24c9e57dmr16221161qvb.4.1701191467642; 
 Tue, 28 Nov 2023 09:11:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0IRfLA3dtC51agSU9tQbD+eOVdjR28hx6lQEGcp8E8kH063NxWxSTwunH0gnq/YQR7D3AoA==
X-Received: by 2002:a05:6214:3d0c:b0:67a:24c9:e57d with SMTP id
 ol12-20020a0562143d0c00b0067a24c9e57dmr16221141qvb.4.1701191467406; 
 Tue, 28 Nov 2023 09:11:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 mk13-20020a056214580d00b0067a1fcbecd2sm3950456qvb.50.2023.11.28.09.11.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 09:11:06 -0800 (PST)
Message-ID: <7c952283-0d41-4b5a-bcc8-43d636500393@redhat.com>
Date: Tue, 28 Nov 2023 18:11:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc/Kconfig: Imply VFIO_PCI
Content-Language: en-US
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20231124080658.893770-1-clg@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231124080658.893770-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/24/23 09:06, Cédric Le Goater wrote:
> When the legacy and iommufd backends were introduced, a set of common
> vfio-pci routines were exported in pci.c for both backends to use :
> 
>    vfio_pci_pre_reset
>    vfio_pci_get_pci_hot_reset_info
>    vfio_pci_host_match
>    vfio_pci_post_reset
> 
> This introduced a build failure on PPC when --without-default-devices
> is use because VFIO is always selected in ppc/Kconfig but VFIO_PCI is
> not.
> 
> Use an 'imply VFIO_PCI' in ppc/Kconfig and bypass compilation of the
> VFIO EEH hooks routines defined in hw/ppc/spapr_pci_vfio.c with
> CONFIG_VFIO_PCI.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>


Applied to vfio-next.

Thanks,

C.




