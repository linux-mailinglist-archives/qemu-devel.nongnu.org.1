Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21581A32D0A
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Feb 2025 18:11:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGFv-0002Nw-67; Wed, 12 Feb 2025 12:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiGFc-0002MR-M4
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:10:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiGFa-0000O8-1D
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:10:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739380212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EhSGXd52CR6Si0FGGXbGlfq2PDyMIv+Ch3jyJUj/MKY=;
 b=gE0XkiqPk5usWqz5uYeP2WN7Vk4xlMq9kg6jqp5QG4j+FVB4005f8KL1v3SMAeyafRXv0i
 9MnAJMphNgrHMS5NpTDwy2c/y5nO+AAJlcAuO+NRpCjp9QHMIoDG3gFpCTO+LlWp/rSqRp
 Boce6jFW2oi9dwWHm4WLNCoIGbeWvXs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-ztDwF3B-NrWpahkVqWJbqg-1; Wed, 12 Feb 2025 12:10:07 -0500
X-MC-Unique: ztDwF3B-NrWpahkVqWJbqg-1
X-Mimecast-MFC-AGG-ID: ztDwF3B-NrWpahkVqWJbqg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38dce0d3d34so2689474f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 09:10:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739380206; x=1739985006;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EhSGXd52CR6Si0FGGXbGlfq2PDyMIv+Ch3jyJUj/MKY=;
 b=ODIerRim04rII05UGEDIlq0oCU1PX7dFGzyYL/5GerzbVeXJizE1z8iWjZGz9p5vu6
 cE7J6aePrdQbkvRFFDNmftwIxU5r4truZj3z8r5T1NRPisfQSbkuvj9fZZQQv28BZRpY
 uHSlU9eJiXjlqrYkg6yyMG26oxf585xeW6wcOCZFoqT7AwtG9gqzvpAv/xnKDBxgebiO
 TylJY7EBwxdiKtE0I5W4texpzE5Gfic+uomLWmordh9OgjT6qlnaXCilTwvv5F0bSibf
 ISn1mIMy8gRsKm8cGKu+kHBbxEJwBszK1OjljvNisXpKOhLBpU8NnEigp1g4AAsMm7Za
 o2fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8Q8+bejwigd5XOSnxnbbPDpwfUsDNzKjoDJfsthd2nXqS0NOSugxscYpNwlq4crD+kJZp5yYsHvZR@nongnu.org
X-Gm-Message-State: AOJu0YyIDgnRbYfWV3PyZVO4USLwVvtcM4i15uznk5MWEFZ7+GqIUQpZ
 5KysuYhi4Gy9kobFu5X1oGBQynqMl2adRDNwxgTTEG8gPW9dLbGdcyxLP9eUzj9xPMEHWlSULsQ
 hTvw+8kO6I0zt5Qk4yEfcYyEsSVzMUCrywv+NNNCLydFGCra7PdV/
X-Gm-Gg: ASbGncuQcoBYemCHC0Wf9l8rczsA+G1j1Q9QR22wRIE5dN3FCyhyXeh9IJfATtFB0lk
 NKUFvSDWfDIJa39uVhQVjDWiiKc02KBUZHAKZLGCsFGvQ53s4FTM+diBp5sCEZU+4fLS4bMb0Wv
 sYiZOVTbQnZ9+qMYsH4jkx6b4yESNNbjVffS342Hou9y/jLQXa73QPpv65QHwXQnxx3YVao8Grv
 Kxu9TH2DFeEQF6aP1Iujtft31Oi343X1geAe44X6Iwl9qOyALiFLL8Hk4wwju0u43w3tYDLf/m4
 q44MpnGzOxY0VbmN5zf080zqi9wCgbxTeIAhpSbCS2c=
X-Received: by 2002:a5d:6d0d:0:b0:38d:e3fd:1990 with SMTP id
 ffacd0b85a97d-38dea354aafmr4255239f8f.0.1739380206604; 
 Wed, 12 Feb 2025 09:10:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvTljaEnYDpgWeFwnXlrqnNnZFc99uYiE9/2MLAcRAcZHuqzfylycEXecJgkmty4JESI2jNA==
X-Received: by 2002:a5d:6d0d:0:b0:38d:e3fd:1990 with SMTP id
 ffacd0b85a97d-38dea354aafmr4255198f8f.0.1739380206242; 
 Wed, 12 Feb 2025 09:10:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbf6e4a4bsm17818195f8f.92.2025.02.12.09.10.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 09:10:05 -0800 (PST)
Message-ID: <b50ca5f8-6bf3-4db2-adb3-8f1bc51e22e7@redhat.com>
Date: Wed, 12 Feb 2025 18:10:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 32/33] vfio/migration: Add x-migration-multifd-transfer
 VFIO property
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <e28bae7b59f576136e945663a3b8c78441049e9a.1738171076.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <e28bae7b59f576136e945663a3b8c78441049e9a.1738171076.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

On 1/30/25 11:08, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This property allows configuring at runtime whether to transfer the
> particular device state via multifd channels when live migrating that
> device.
> 
> It defaults to AUTO, which means that VFIO device state transfer via
> multifd channels is attempted in configurations that otherwise support it.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/pci.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 2700b355ecf1..cd24f386aaf9 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3353,6 +3353,8 @@ static void vfio_instance_init(Object *obj)
>       pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
>   }
>   
> +static PropertyInfo qdev_prop_on_off_auto_mutable;
> +
>   static const Property vfio_pci_dev_properties[] = {
>       DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
>       DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
> @@ -3377,6 +3379,10 @@ static const Property vfio_pci_dev_properties[] = {
>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>                               vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP("x-migration-multifd-transfer", VFIOPCIDevice,
> +                vbasedev.migration_multifd_transfer,
> +                qdev_prop_on_off_auto_mutable, OnOffAuto,
> +                .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
>       DEFINE_PROP_ON_OFF_AUTO("x-migration-load-config-after-iter", VFIOPCIDevice,
>                               vbasedev.migration_load_config_after_iter,
>                               ON_OFF_AUTO_AUTO),
> @@ -3477,6 +3483,9 @@ static const TypeInfo vfio_pci_nohotplug_dev_info = {
>   
>   static void register_vfio_pci_dev_type(void)
>   {
> +    qdev_prop_on_off_auto_mutable = qdev_prop_on_off_auto;
> +    qdev_prop_on_off_auto_mutable.realized_set_allowed = true;
> +
>       type_register_static(&vfio_pci_dev_info);
>       type_register_static(&vfio_pci_nohotplug_dev_info);
>   }
> 

This looks wrong. Why not define the property simply with

    DEFINE_PROP("x-migration-multifd-transfer", VFIOPCIDevice,
                 vbasedev.migration_multifd_transfer, ON_OFF_AUTO_AUTO)

? Also "x-migration-multifd" should be enough.


Thanks,

C.


