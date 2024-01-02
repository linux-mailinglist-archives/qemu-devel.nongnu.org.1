Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1787821826
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 08:59:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKZfn-00054W-K2; Tue, 02 Jan 2024 02:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rKZfk-000528-Jo
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 02:58:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rKZfi-0001hs-RL
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 02:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704182325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GTKWiTdbmJanmz141SH4msraPtvzGFRVXDb6ZOwPH+0=;
 b=YtflPPaK+MDs54M08TBYadMF+ZnR7EgEoQxnoiEwaOeLZ2qAWItCOOf8lAEnnIc1d1Ev2z
 aLmBFg3c7OmvzzkMASCx+yPAZj1YFtSdQlh5ybZ4tSAZyIMdeTlDH8n45eI3Llbs2nrqLd
 XMIbbRqSsJzCac2Awqbz0KrZI6ve82k=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-QrrybPjAOBu4K2afKsDx7w-1; Tue, 02 Jan 2024 02:58:44 -0500
X-MC-Unique: QrrybPjAOBu4K2afKsDx7w-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-680971002e3so52717366d6.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 23:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704182324; x=1704787124;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GTKWiTdbmJanmz141SH4msraPtvzGFRVXDb6ZOwPH+0=;
 b=H/IMizEyZYPiLLT9UUFko0XiGgP0tfBWsHvkLwO35x5LzkStOg1GiD/IU/5g4zjfft
 Mb/TF4MoQg8L7Or0w6ONKIbR9MqdaiO2tE6zBP8gZFlkjeVsGaS5g3rbCcW+qUTcp9SX
 ERJ9VxFs5K0Ahat+lxPZ9fVE88jSeg6cn/kBHz92gCZn57zgHxaFimJEp9TNEbkuovir
 2OMRaP1BcqGLNQExtk120Oaj/5esMtAOiOs8GZsV4sjjuSFi/eneGsPy+t+K+iT0LJZe
 0XQtQtH4ORS3PsC2VEvgjAImgCWQw6LWMrlkHwcd/JVFLe5QRPLddA94n9dBn/t2aRdq
 yMNQ==
X-Gm-Message-State: AOJu0YzCWc70yB8HoskzyxoVO6XUr535YPiQpiDygyfUxjdzsuMRS0MZ
 Va1kkmfWpPje37z+KzeYcgDD3RfZsv92tB3OGn6AyxoZCZt1YqL21NuzKw97MfL6tFXqTp6Tz1s
 U6HSDiR7vehw7mL18XxJajfw=
X-Received: by 2002:a05:6214:2608:b0:67f:49ae:9adb with SMTP id
 gu8-20020a056214260800b0067f49ae9adbmr28953326qvb.41.1704182323858; 
 Mon, 01 Jan 2024 23:58:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwGs/dLKBrb+Nl0R2+SrN+1LLJ6i9w4/vD11hdGElpBeB4KLIpu1/ZLkUbTevT2k5XBqWhsw==
X-Received: by 2002:a05:6214:2608:b0:67f:49ae:9adb with SMTP id
 gu8-20020a056214260800b0067f49ae9adbmr28953317qvb.41.1704182323622; 
 Mon, 01 Jan 2024 23:58:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 bp13-20020a05621407ed00b00680b1731d9asm1423324qvb.5.2024.01.01.23.58.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jan 2024 23:58:43 -0800 (PST)
Message-ID: <b33c1eef-533c-44fa-b8e3-a59c20bb31fa@redhat.com>
Date: Tue, 2 Jan 2024 08:58:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio: fix iteration over global VFIODevice list
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 'YangHang Liu' <yanghliu@redhat.com>
References: <20231229203854.8281-1-vr_qemu@t-online.de>
 <SJ0PR11MB674437F64A9154EDD0055A799261A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB674437F64A9154EDD0055A799261A@SJ0PR11MB6744.namprd11.prod.outlook.com>
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

On 1/2/24 05:27, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Volker Rümelin <vr_qemu@t-online.de>
>> Subject: [PATCH] hw/vfio: fix iteration over global VFIODevice list
>>
>> Commit 3d779abafe ("vfio/common: Introduce a global VFIODevice list")
>> introduced a global VFIODevice list, but forgot to update the list
>> element field name when iterating over the new list. Change the code
>> to use the correct list element field.
>>
>> Fixes: 3d779abafe ("vfio/common: Introduce a global VFIODevice list")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2061
>> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> 
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> My fault, thanks for fixing!
> 
> I also digged into why I didn't reproduce this issue with two vfio devices before.
> This issue only reproduce with two vfio devices in one reset group(same slot or bus)
> plus a third vfio device in a different reset group. Then the two vfio devices will
> miss reset due to this bug.

Thanks for digging.

C.



> BRs.
> Zhenzhong
> 
>> ---
>> hw/vfio/common.c | 8 ++++----
>> 1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 08a3e57672..3ba892d7d3 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -74,7 +74,7 @@ bool vfio_mig_active(void)
>>          return false;
>>      }
>>
>> -    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
>> +    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
>>          if (vbasedev->migration_blocker) {
>>              return false;
>>          }
>> @@ -95,7 +95,7 @@ static bool
>> vfio_multiple_devices_migration_is_supported(void)
>>      unsigned int device_num = 0;
>>      bool all_support_p2p = true;
>>
>> -    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
>> +    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
>>          if (vbasedev->migration) {
>>              device_num++;
>>
>> @@ -1367,13 +1367,13 @@ void vfio_reset_handler(void *opaque)
>> {
>>      VFIODevice *vbasedev;
>>
>> -    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
>> +    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
>>          if (vbasedev->dev->realized) {
>>              vbasedev->ops->vfio_compute_needs_reset(vbasedev);
>>          }
>>      }
>>
>> -    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
>> +    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
>>          if (vbasedev->dev->realized && vbasedev->needs_reset) {
>>              vbasedev->ops->vfio_hot_reset_multi(vbasedev);
>>          }
>> --
>> 2.35.3
> 


