Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F19EB746002
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 17:42:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLgk-0002IO-QR; Mon, 03 Jul 2023 11:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGLge-0002I1-75
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGLgb-0007xh-P8
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688398915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTwpI7xyCW99g5VOmq0xahLyZyU8opyN4OmSkTlhxXQ=;
 b=WnIwAbKJYNvtN3fsyL/YtB2d0/ruTdj2ikndxlhI8wBZKVO3gMja64ayWPKUpopqbxKaHY
 l6gaQAFcy2aqhWhPzCDftbajz/Qh2UvFiDb54xfA72MRLTMj5d/8wXQdzo+nA6i2vFvKnD
 6vKvWihLXbEZeV95JgqU2+oQnb0h9O4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-edr1sOy1MTmHFPcUdyfQKA-1; Mon, 03 Jul 2023 11:41:51 -0400
X-MC-Unique: edr1sOy1MTmHFPcUdyfQKA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6349a78b1aaso27126106d6.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 08:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688398910; x=1690990910;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lTwpI7xyCW99g5VOmq0xahLyZyU8opyN4OmSkTlhxXQ=;
 b=GGSxw0k0JmHIdE8yfyYKgXw+CqkQt5M14KZ0Wx4ooz+Js3Sg7jssLOPdPHnBmSCp0A
 65meSy7l/ZwEI3aEMhTZa+Lnz6qBrgXa3n5K80EximrQypsMGlu3AWewXBjilinLhgsM
 08G7bGViJjiXTGBJoYE5r1L84uzNywnz7tk3ha//RBIx25CsqnINyMy6Ar/JosuqlyJn
 m4Tjs6+ErBIr/eBb2uCu82SWfyMJd4UM3lKPo0MIeczpGatPwbj1Tl8yUPjPJTlGj4H+
 2KPYZMxq3DK9hurPyqeo1l98gM9Jr7VWIVOZpPy4M6bP4DhUNtDgSVaSDRnAPOO305u0
 Uysw==
X-Gm-Message-State: ABy/qLaJKZEeXCU5aAgju+4I7uHBrjSS+R+zd92u2Fe5EcbUkMVSMT/z
 DTEtwH1ZVg+Hoto7NM9umKSlSxezSZb1iDlJhwvGdco2il7hFoVj3U6uixk++pVm51lXf2/AoMX
 nBnFZzzKcBXFCTlc=
X-Received: by 2002:a05:6214:1092:b0:621:6804:b8c0 with SMTP id
 o18-20020a056214109200b006216804b8c0mr9991542qvr.8.1688398910553; 
 Mon, 03 Jul 2023 08:41:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHJ35K98qayzt9AB0464cbkKWGfwcgdygOoBQiLhJHFoNAmYwcbSMaC0MWxHiafYKI5BbMHuQ==
X-Received: by 2002:a05:6214:1092:b0:621:6804:b8c0 with SMTP id
 o18-20020a056214109200b006216804b8c0mr9991529qvr.8.1688398910308; 
 Mon, 03 Jul 2023 08:41:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 dr16-20020a05621408f000b00632209f7157sm11340806qvb.143.2023.07.03.08.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 08:41:50 -0700 (PDT)
Message-ID: <e99f062d-3378-bd14-2b8b-644cea82c937@redhat.com>
Date: Mon, 3 Jul 2023 17:41:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 5/7] vfio/migration: Free resources when
 vfio_migration_realize fails
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, joao.m.martins@oracle.com,
 chao.p.peng@intel.com
References: <20230703071510.160712-1-zhenzhong.duan@intel.com>
 <20230703071510.160712-4-zhenzhong.duan@intel.com>
 <b94df333-17d8-81e5-da5e-40d935131396@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <b94df333-17d8-81e5-da5e-40d935131396@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/3/23 17:34, Avihai Horon wrote:
> 
> On 03/07/2023 10:15, Zhenzhong Duan wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> When vfio_realize() succeeds, hot unplug will call vfio_exitfn()
>> to free resources allocated in vfio_realize(); when vfio_realize()
>> fails, vfio_exitfn() is never called and we need to free resources
>> in vfio_realize().
>>
>> In the case that vfio_migration_realize() fails,
>> e.g: with -only-migratable & enable-migration=off, we see below:
>>
>> (qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,enable-migration=off
>> 0000:81:11.1: Migration disabled
>> Error: disallowing migration blocker (--only-migratable) for: 0000:81:11.1: Migration is disabled for VFIO device
>>
>> If we hotplug again we should see same log as above, but we see:
>> (qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,enable-migration=off
>> Error: vfio 0000:81:11.1: device is already attached
>>
>> That's because some references to VFIO device isn't released.
>> For resources allocated in vfio_migration_realize(), free them by
>> jumping to out_deinit path with calling a new function
>> vfio_migration_deinit(). For resources allocated in vfio_realize(),
>> free them by jumping to de-register path in vfio_realize().
> 
> Should we add Fixes tag?

Yes. It would help downstream backports. No need to resend for that.

Thanks,

C.
  
> 
> Thanks.
> 
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/vfio/migration.c | 33 +++++++++++++++++++++++----------
>>   hw/vfio/pci.c       |  1 +
>>   2 files changed, 24 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index e6e5e85f7580..e3954570c853 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -802,6 +802,17 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>>       return 0;
>>   }
>>
>> +static void vfio_migration_deinit(VFIODevice *vbasedev)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    remove_migration_state_change_notifier(&migration->migration_state);
>> +    qemu_del_vm_change_state_handler(migration->vm_state);
>> +    unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
>> +    vfio_migration_free(vbasedev);
>> +    vfio_unblock_multiple_devices_migration();
>> +}
>> +
>>   static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>>   {
>>       int ret;
>> @@ -866,7 +877,7 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>>               error_setg(&err,
>>                          "%s: VFIO device doesn't support device dirty tracking",
>>                          vbasedev->name);
>> -            return vfio_block_migration(vbasedev, err, errp);
>> +            goto add_blocker;
>>           }
>>
>>           warn_report("%s: VFIO device doesn't support device dirty tracking",
>> @@ -875,29 +886,31 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>>
>>       ret = vfio_block_multiple_devices_migration(vbasedev, errp);
>>       if (ret) {
>> -        return ret;
>> +        goto out_deinit;
>>       }
>>
>>       if (vfio_viommu_preset(vbasedev)) {
>>           error_setg(&err, "%s: Migration is currently not supported "
>>                      "with vIOMMU enabled", vbasedev->name);
>> -        return vfio_block_migration(vbasedev, err, errp);
>> +        goto add_blocker;
>>       }
>>
>>       trace_vfio_migration_realize(vbasedev->name);
>>       return 0;
>> +
>> +add_blocker:
>> +    ret = vfio_block_migration(vbasedev, err, errp);
>> +out_deinit:
>> +    if (ret) {
>> +        vfio_migration_deinit(vbasedev);
>> +    }
>> +    return ret;
>>   }
>>
>>   void vfio_migration_exit(VFIODevice *vbasedev)
>>   {
>>       if (vbasedev->migration) {
>> -        VFIOMigration *migration = vbasedev->migration;
>> -
>> -        remove_migration_state_change_notifier(&migration->migration_state);
>> -        qemu_del_vm_change_state_handler(migration->vm_state);
>> -        unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
>> -        vfio_migration_free(vbasedev);
>> -        vfio_unblock_multiple_devices_migration();
>> +        vfio_migration_deinit(vbasedev);
>>       }
>>
>>       if (vbasedev->migration_blocker) {
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index c2cf7454ece6..9154dd929d07 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3210,6 +3210,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>           ret = vfio_migration_realize(vbasedev, errp);
>>           if (ret) {
>>               error_report("%s: Migration disabled", vbasedev->name);
>> +            goto out_deregister;
>>           }
>>       }
>>
>> -- 
>> 2.34.1
>>
> 


