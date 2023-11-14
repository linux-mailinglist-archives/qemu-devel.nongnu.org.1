Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 982AE7EAD2E
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 10:41:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2puw-0002Pm-PM; Tue, 14 Nov 2023 04:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2puv-0002Pa-5C
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 04:41:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2put-0008N6-Hb
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 04:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699954866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wBT2NAjZ5iSNJI84Bs0/RWjkPQiqSmDLppz6zx34Pfw=;
 b=Ey3ww/Z5F+PuhlB8NBERHPoqv4sxFNvU7IsVB55ONm6FsqSjap2lAnD4aUa+BjQ9bqHeqv
 Nu9WVxdtLfACYPvzCmAl9lLpDmP/geKBWiwcwJV8Gz85tHiZAMFrPmWXtkew9eivjEkZj6
 MvWwrxM7FJ0vOvvf5QlrgCDWLvH2V98=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-1aqmL64oPiae6L63bY0VWw-1; Tue, 14 Nov 2023 04:41:04 -0500
X-MC-Unique: 1aqmL64oPiae6L63bY0VWw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-41ea8e21785so94059271cf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 01:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699954863; x=1700559663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wBT2NAjZ5iSNJI84Bs0/RWjkPQiqSmDLppz6zx34Pfw=;
 b=S1m4j7rXUzkwHzt7L1P26vM0K6zxoYGQWDCJ5OTfIYY2tIa/P8ZQBMH+AztxjJsAL2
 9VpSt9bSv0zrq8d9oisJKpxs0810I6KcNzzVyl23ifxtYxtSZlG0HjkLHHNHawiWUuSW
 J7dB0BJn7QQyKhVcPs2Rb2/90YCK5Y0+3ieOMl8VqTOEj8j1yU/dltax9UGaE8jp02ND
 ngP//HBG+koHdw7uh2X2XwXQfFl3t3xheRjJAfg+c8eo4o5WEDzy7XDX4o5Q++K/Jyzw
 DkNahdOM2jH/8t6twCMh9AB+ucIHIq7gENlfXGxv+ivN7mIYNjJ0RO9hqClDIVLFZoF1
 FFmg==
X-Gm-Message-State: AOJu0YyG4w+cjOhyFINXuVcvspRs9lQbJwLelFc88Bd+ZDW9GGV5IEjC
 D/+RTXQoLkye3wDPlNhxtXb5yk6J4mC3viZ9KWAYXwJXjqi7GUzGZEglnHuTj6oJCtxqNz2+Fqb
 3rROC/AGI5mOadGI=
X-Received: by 2002:a05:622a:5cd:b0:400:9f2c:1211 with SMTP id
 d13-20020a05622a05cd00b004009f2c1211mr2693165qtb.29.1699954863626; 
 Tue, 14 Nov 2023 01:41:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4vwT7bxZ5cG2NStqvbuhTlQWgzDJgqL5MuUjpizbbktqHflem+4/+/H7/PPRimnxun/TJvg==
X-Received: by 2002:a05:622a:5cd:b0:400:9f2c:1211 with SMTP id
 d13-20020a05622a05cd00b004009f2c1211mr2693153qtb.29.1699954863396; 
 Tue, 14 Nov 2023 01:41:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ki10-20020a05622a770a00b00418189b689csm2251204qtb.10.2023.11.14.01.41.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 01:41:03 -0800 (PST)
Message-ID: <7d66d02e-46b3-41fd-9722-eb7f58514c8b@redhat.com>
Date: Tue, 14 Nov 2023 10:40:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/41] backends/iommufd: Introduce the iommufd object
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-27-zhenzhong.duan@intel.com>
 <da7de379-bd8c-47d1-b7bf-412be92a2756@redhat.com>
 <87r0l0dc9q.fsf@pond.sub.org>
 <d710b361-7078-456c-86bd-6b7f23d56584@redhat.com>
 <87zfzoa65e.fsf@pond.sub.org>
 <20de5dde-2a1a-4d20-bafc-b63a8015fae7@redhat.com>
 <871qcz70vg.fsf@pond.sub.org>
 <SJ0PR11MB674457AF8A2E6545B8CEAE6A92AEA@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB674457AF8A2E6545B8CEAE6A92AEA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


>> The only tool we have for configuring the schema is the 'if'
>> conditional.  'if': 'CONFIG_IOMMUFD' compiles to #if
>> defined(CONFIG_IOMMUFD) ... #endif.  Your use of #ifdef CONFIG_IOMMUFD
>> above suggests this is fine here.
>>
>> Symbols that are only defined in target-dependent compiles (see
>> exec/poison.h) can only be used in target-dependent schema modules,
>> i.e. the *-target.json.
> 
> I'm fresh on Kconfig & qapi, but I have a weak idea:
> Remove conditional check for backends/iommufd.c, like:
> 
> system_ss.add(files('iommufd.c'))
> 
> Then iommufd object is common and always supported, we will not see
> "invalid object type: iommufd", even for platform other than i386,s390x,arm.
>
> On those platform not supporting iommufd, we can create an iommufd object
> which is dummy, as no one will link to it to open /dev/iommufd

In that case, the management layer would define a crippled vfio-pci
device. I'd rather let the error occur or find a way to move the
"iommufd" object and properties to a target dependent file. I don't
see how this could be done though.

Thanks,

C.



