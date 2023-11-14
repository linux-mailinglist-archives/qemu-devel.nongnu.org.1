Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ADE7EB7FC
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 21:44:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r30FA-0008GP-Vr; Tue, 14 Nov 2023 15:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r30F0-0008G7-Ps
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 15:42:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r30Ex-0004OV-Vu
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 15:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699994549;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3TtpAY4W+fJ6zZr9vVeLASJtJazbGOpu7CvZJWcTqXQ=;
 b=aFVwNITJ6Weeu51qB0xu9jp9Rs2T8SAK+XFoyeRxxspNzWOkHN8MgyfPcBxMhoQzoYFrG9
 XVVSl1uMVx4CaiYXFk8A2cOnkbCGtzYIVeaFtB2rxPN1Z3F/8HftqkUvF74W6/e/vNuvlV
 /a2OrWhDZEZ2HTa8Izt5UTurnmCigGw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-8BoyrllsNi-ZriyXe9FNUQ-1; Tue, 14 Nov 2023 15:42:28 -0500
X-MC-Unique: 8BoyrllsNi-ZriyXe9FNUQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-670991f8b5cso2851936d6.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 12:42:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699994547; x=1700599347;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3TtpAY4W+fJ6zZr9vVeLASJtJazbGOpu7CvZJWcTqXQ=;
 b=XdQTqSOpvzsoq6WowEffaa+XvqUe0zOHI2COhlgnF5jP68n+DT3xWj6OVoHwzm0mTf
 nzMBFn/yPfxxZTtPEUfC6vVuXKuoe5z7Lwe4+hNH1lapMfuzkmk9icn6+0NlLuNHp9Ek
 uX48ieYmi55pYIxQ0Yx//ax91rqEZqiaDE3+KCIdz0jsXb+wL5xPMODwU+kZyPI/AjbV
 tW51rFQxptTO4IaYX/J/n3Hdp00KBTicc39mwIAir9LvXMhf3BBjjftkVlYMXmPpkeB8
 a4FLxnxHw+X6nx7mwvk7vaFzCAGyS8LD+i7uktUORvU6cmL8eIhoFXbsT+h/GrmRvBBI
 vPhQ==
X-Gm-Message-State: AOJu0YyDaxmGY/mGRjjOE1pKjhWTr99iAXb+XL3na0rBT+LsAmtGJ2HX
 6H/AzBTQJ9ivRWh/6aYd1F5tTzSEWgFNFuvOuln1hjOcf2v2SEGKvcj+TpnuFVixvxRhvB1KzRR
 VFDtCh4jU0XB3xTQ=
X-Received: by 2002:a05:6214:412:b0:66d:7f65:71c9 with SMTP id
 z18-20020a056214041200b0066d7f6571c9mr6543219qvx.9.1699994547699; 
 Tue, 14 Nov 2023 12:42:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSYRZCt/8CkyKdAzwrNX4NZyAH5f4EmPiboOPyvQwWHc54WsRNnERPclUmmQGqDSqL/AJ8Tg==
X-Received: by 2002:a05:6214:412:b0:66d:7f65:71c9 with SMTP id
 z18-20020a056214041200b0066d7f6571c9mr6543180qvx.9.1699994547370; 
 Tue, 14 Nov 2023 12:42:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a0cf807000000b0065b1f90ff8csm3177960qvn.40.2023.11.14.12.42.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 12:42:26 -0800 (PST)
Message-ID: <5f09ba2a-3e62-454a-8665-0f80508b5168@redhat.com>
Date: Tue, 14 Nov 2023 21:42:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado/intel_iommu: Add asset hashes to avoid
 warnings
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20231114143531.291820-1-thuth@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20231114143531.291820-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Thomas,

On 11/14/23 15:35, Thomas Huth wrote:
> The intel_iommu test is currently succeeding with annoying warnings.
nit: you may have precised the nature of the warning or quotes
> Add the proper asset hashes to avoid those.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/avocado/intel_iommu.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tests/avocado/intel_iommu.py b/tests/avocado/intel_iommu.py
> index 474d62f6bf..77635ab56c 100644
> --- a/tests/avocado/intel_iommu.py
> +++ b/tests/avocado/intel_iommu.py
> @@ -54,9 +54,11 @@ def common_vm_setup(self, custom_kernel=None):
>              return
>  
>          kernel_url = self.distro.pxeboot_url + 'vmlinuz'
> +        kernel_hash = '5b6f6876e1b5bda314f93893271da0d5777b1f3c'
>          initrd_url = self.distro.pxeboot_url + 'initrd.img'
> -        self.kernel_path = self.fetch_asset(kernel_url)
> -        self.initrd_path = self.fetch_asset(initrd_url)
> +        initrd_hash = 'dd0340a1b39bd28f88532babd4581c67649ec5b1'
> +        self.kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        self.initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
>  
>      def run_and_check(self):
>          if self.kernel_path:
Besides,
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


