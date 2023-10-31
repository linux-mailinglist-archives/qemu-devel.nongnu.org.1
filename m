Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F397DCBBF
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 12:26:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxmsr-0006CY-2f; Tue, 31 Oct 2023 07:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxmsn-0006C5-OJ
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxmsm-0002h4-2M
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698751562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JRve8Lq4rtpXPfSgqsWmf33sSO6UUrLUEb/5zY+jDNI=;
 b=Mk2cZYprusmzz/qiIAqmKLapSx04giY1Qaic4tgpxqEoSEvGwHgVDuTqS0jQ4oW6x7tW/k
 hDJfxmH7fVIzKRk4xHiI70OCHJNfzg7wML6P6rpYIBROxBJR+BQySlh/Eu3JrEzbviwQJL
 +pYI+BSKQU1qebUaPRMakjFb0T+yUj8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-1PVIvN6-Nm2ngdOWvVwT_Q-1; Tue, 31 Oct 2023 07:25:50 -0400
X-MC-Unique: 1PVIvN6-Nm2ngdOWvVwT_Q-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3b2e44c8664so7899594b6e.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 04:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698751549; x=1699356349;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JRve8Lq4rtpXPfSgqsWmf33sSO6UUrLUEb/5zY+jDNI=;
 b=iOCbmDD+m/1C7a41JNQ4t+XrzRLuSkSu7cyYhXrjHat3h8Q4UGtdkNyLvbL6fdF6Bp
 dfAE4YxsYue+p/TKL7g0F/xRYDlc4vDP3zLc5SHIydd+f7+QkRrAN9eoz0syAC9wuxak
 cTo5uAzk5Rwl7EwHBYbAObqF632nfRquiPC9rsxPgSl+3sVa82L2zv8UGgAJCSmzfvk1
 4gKWhqjHiXvAqTQIJ/JLzIz/7lMI9EMubHtfjuNW/KKey54fJOanFLKo2BaDSO0VlOQy
 5kfNw/uwIMQ1BdBAuN+apiQpDFBSK071+ORTNOedSprLURFQhY9DI6QWZvK/8ZQkw4C8
 K/yw==
X-Gm-Message-State: AOJu0YyWChp0T7wr4qaIKczZtxNB/Yb/JNI7nhkti3/DqkBTG0H1t/WA
 8gyN3NhdEAXHVcLD4JHhlkHaavmD2OZuz+jiGAfXOc7fr90zrW1sCyJltts9zbIcVUF9jyzu9mm
 pkU572Jeb8vdssDY=
X-Received: by 2002:aca:2806:0:b0:3ae:3d0:d74a with SMTP id
 6-20020aca2806000000b003ae03d0d74amr13116044oix.52.1698751549516; 
 Tue, 31 Oct 2023 04:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu+C2E9TTCXD0iq6vRGUMKBBlmNAEFmJtGhhZNvUndI+lj+0bMaK7eGiTVwfjhI6BJ23iAMA==
X-Received: by 2002:aca:2806:0:b0:3ae:3d0:d74a with SMTP id
 6-20020aca2806000000b003ae03d0d74amr13116029oix.52.1698751549311; 
 Tue, 31 Oct 2023 04:25:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 bi8-20020a05620a318800b007777521dca4sm417376qkb.21.2023.10.31.04.25.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 04:25:48 -0700 (PDT)
Message-ID: <58595dab-55b7-4f2f-a2a1-3eb7a5ba34fa@redhat.com>
Date: Tue, 31 Oct 2023 12:25:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/37] Add iommufd configure option
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-24-zhenzhong.duan@intel.com>
 <2400c9be-8c0b-415f-90c5-3a04fbdf6744@redhat.com>
 <SJ0PR11MB67443A43303B9A570DFB216A92A0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67443A43303B9A570DFB216A92A0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

On 10/31/23 11:52, Duan, Zhenzhong wrote:
> Hi All,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Tuesday, October 31, 2023 4:59 PM
>> Subject: Re: [PATCH v3 23/37] Add iommufd configure option
>>
>> On 10/26/23 12:30, Zhenzhong Duan wrote:
>>> This adds "--enable-iommufd/--disable-iommufd" to enable or disable
>>> iommufd support, enabled by default.
>>
>> It should be disabled by default for PPC.
> 
> I didn't find how to disable iommufd for PPC after digging in https://www.qemu.org/docs/master/devel/kconfig.html
> 
> Appreciate any guide or help! Thanks in advance.

I believe the config approach should be changed to use a Kconfig
entry instead.


Thanks,

C.



> 
> BRs.
> Zhenzhong


