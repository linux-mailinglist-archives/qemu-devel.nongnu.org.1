Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBF57F0D79
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 09:26:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4zac-0007kZ-RL; Mon, 20 Nov 2023 03:25:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r4zaZ-0007jt-UE
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 03:25:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r4zaU-0006cF-5N
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 03:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700468696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YVwz01YET3quPX8xuyuQoxS8CSjWLJpuvStKFpbFP9c=;
 b=NfLQd+bS04BuzFqpy6M066qn3ZvUG8+JZWN94JcI8XbFAJpuBMDIXIfyyQso1IqpyacOqQ
 3uIEAZzKuFbQPsPQ19kwiMNQ59KVgCfZsxtKYUaF016z7RMAuUWamXS0mWZAD2uKfj69uw
 vLjaDeYElQ2ji1Xpy7KSj8isDIdpKl4=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-cK6qvu5RMvigr-DchMfihQ-1; Mon, 20 Nov 2023 03:24:52 -0500
X-MC-Unique: cK6qvu5RMvigr-DchMfihQ-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-1f594e9674dso4118324fac.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 00:24:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700468691; x=1701073491;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YVwz01YET3quPX8xuyuQoxS8CSjWLJpuvStKFpbFP9c=;
 b=dDpFDxuUZ7uAjBVYkrjN/JLia5kjY4I3AI71o82Meh/7WEO+HiT5wEURduS5GWxqRo
 vmo28vvMNMpciKuCPn/GOvzwV88nGJb8MBG7I6FKzijdP5VNMUbvkDFeANnBa7a+b893
 Y00ltWkjFJPqyghc+MNTuCO4f/sqxWnYLsbtFYuXuIXjmjm+a0U4G6Q/yOcV8traF7O5
 HMa4HbRuBVn21p3gxukAMIwbvbgKsL2QWgRtnyCEUtDOe3LUYLjFbtqFpTfbyFeUHTbN
 xlJxrhl0foZNACPBQH6Q+ILpqRCwh5PaFZtGcimdocpjOlSy8/w6AtJZIjkrDkQwX96S
 cCgg==
X-Gm-Message-State: AOJu0Yyu7k15SDcz2RmlOh7VAcybIHo2koXJiN+iKTYW5M0oY34mQFyv
 evbuFqMMsykKIbSbkQiFKUXbGGP/JKtQfGOoVL5RVp9ZN2t0zexx6xFSwpWXKJpwGJPe66cgL/Y
 oCraqC8baTPY1tnc=
X-Received: by 2002:a05:6870:b6aa:b0:1f5:c729:e92e with SMTP id
 cy42-20020a056870b6aa00b001f5c729e92emr8101178oab.29.1700468691746; 
 Mon, 20 Nov 2023 00:24:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRr6E9HnQ8vL1Z0xka7BBwEyEFgY0Yg2AT+fVN+vC2vUjYre6prWKrwqPvq0K5akQEHJdCnQ==
X-Received: by 2002:a05:6870:b6aa:b0:1f5:c729:e92e with SMTP id
 cy42-20020a056870b6aa00b001f5c729e92emr8101158oab.29.1700468691476; 
 Mon, 20 Nov 2023 00:24:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a05620a144500b007757868e75csm2483518qkl.117.2023.11.20.00.24.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 00:24:51 -0800 (PST)
Message-ID: <ebc65641-4597-4679-8214-0f4555f9bd21@redhat.com>
Date: Mon, 20 Nov 2023 09:24:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "lersek@redhat.com" <lersek@redhat.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-2-zhenzhong.duan@intel.com>
 <c964fdf3-d6ef-40cd-b4c0-32f1fb8501ae@redhat.com>
 <SJ0PR11MB6744B1B91C890A9A1B81E89792B7A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <248389a7-3f89-42ae-98e7-34d6612cf186@redhat.com>
 <c0c265d6-aaea-4071-b280-b93df459165e@redhat.com>
 <SJ0PR11MB67444672699A62007207FB3492B4A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67444672699A62007207FB3492B4A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

>>>> A similar issue with a fix submitted below, ccing related people.
>>>> https://lists.gnu.org/archive/html/qemu-devel/2023-11/msg02937.html
>>>> It looks the fix will not work for hotplug.
>>>>
>>>> Or below qemu cmdline may help:
>>>> "-cpu host,host-phys-bits-limit=39"
>>>
>>> don't you have the same issue with legacy VFIO code, you should?
>>
>> I tend to be lazy and use seabios for guests on the command line.
>> I do see the error with legacy VFIO and uefi.
>>
>> However, with the address space size work-around and iommufd, the
>> error is different, an EFAULT now. Some page pinning issue it seems.
> 
> Yes, this reminds me of iommufd not supporting p2p mapping yet.

OK. Should we transform this error in a warning ? The code needs
at least a comment.

> So EFAULT is expected. Maybe I should add a comment in docs/devel/vfio-iommufd.rst

Yes. It would be good to have a list of gaps and effects in the
documentation. See Jason's presentation at LPC.

   https://lpc.events/event/17/contributions/1418/attachments/1297/2607/LPC2023_iommufd.pdf

Thanks,

C.


