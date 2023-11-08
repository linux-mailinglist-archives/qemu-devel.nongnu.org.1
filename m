Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3DC7E5823
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 14:50:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0ivi-0000wb-1E; Wed, 08 Nov 2023 08:49:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0ive-0000vL-3u
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 08:49:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0ivc-0004kZ-44
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 08:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699451345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dLEkoYp9XyGL4CCu4/Qw361jSNUBD4H52C3/UgahnyA=;
 b=KytgFBqZPKdkkUx0lGYmBxUMQ6Q0dsFpQvVWD4CE9DMIz3WfAl4GtEULxu3t2OoIVqlNMr
 4RzCFqkufuZV2Pt9ffqFKvf5ECF3PiGO2VYUbiMR3u8Fsu0bXCQQmvXwAZo/qFuErrL8bS
 44PfqviZ/QwUplPtZDCukEAHP34L8jk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-l-xnUwhlMCGVN1VlxbDESg-1; Wed, 08 Nov 2023 08:49:03 -0500
X-MC-Unique: l-xnUwhlMCGVN1VlxbDESg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-67049a2c8b3so83647706d6.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 05:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699451340; x=1700056140;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dLEkoYp9XyGL4CCu4/Qw361jSNUBD4H52C3/UgahnyA=;
 b=xEbJOjkD/cnLDbAWx9zFVoFH7ocfEtb2LsU/gkndEB/gbbjoIpAlwv/F1Li5UdnbVT
 EW4DfFZMBIM8AYthfGuLgjh68XMysTx8ZfBkXhqQUk1GcTB69M497/oYbsgvwZl1yM1l
 q+jcOj/BJpM1ciaLxPE2XodtXU3chv8MedpYdoj6t1VWq+rj/dVdB4McS6LrhRxUInDJ
 xqVSJCQ4SdYIxeieoGTNfxWoRSyywHkMlIty/HdyoKtBOhese4a5MoZMZOezZgF0/gB/
 mdt/h0nvU4R/q2KI4OsJVjrtaqC7ShVOcN6k0aNe5buNbsdtGZMS3sCb8SAQoyIA75R6
 Zb8w==
X-Gm-Message-State: AOJu0YxaZi/GvTSyuabh7SWXZPSR3q+aOqeZ5BObx63v/sVXSxlBjuly
 7sXroCIoVPYw0/H5EwAfU9WO+l6+K74X8IGlSFWozbcC7aA+A9MyxXy+WCwYuEEZzylwNSZGpww
 vOpKTED6nWDed2r8=
X-Received: by 2002:a05:6214:212e:b0:66d:9d71:9b28 with SMTP id
 r14-20020a056214212e00b0066d9d719b28mr2447625qvc.11.1699451340231; 
 Wed, 08 Nov 2023 05:49:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwsf5pFPVV5fL6aPq30haHq+EZVDvoETdaJi2hYQXvkrXAWGQTmpVV2yOJCxsSqmLIDbqUGg==
X-Received: by 2002:a05:6214:212e:b0:66d:9d71:9b28 with SMTP id
 r14-20020a056214212e00b0066d9d719b28mr2447599qvc.11.1699451339950; 
 Wed, 08 Nov 2023 05:48:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 lf18-20020a0562142cd200b0065afedf3aabsm1080337qvb.48.2023.11.08.05.48.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 05:48:59 -0800 (PST)
Message-ID: <20de5dde-2a1a-4d20-bafc-b63a8015fae7@redhat.com>
Date: Wed, 8 Nov 2023 14:48:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/41] backends/iommufd: Introduce the iommufd object
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-27-zhenzhong.duan@intel.com>
 <da7de379-bd8c-47d1-b7bf-412be92a2756@redhat.com>
 <87r0l0dc9q.fsf@pond.sub.org>
 <d710b361-7078-456c-86bd-6b7f23d56584@redhat.com>
 <87zfzoa65e.fsf@pond.sub.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <87zfzoa65e.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11/8/23 11:30, Markus Armbruster wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
>> Hello Markus,
>>
>> On 11/8/23 06:50, Markus Armbruster wrote:
>>> Cédric Le Goater <clg@redhat.com> writes:
>>>
>>>> On 11/2/23 08:12, Zhenzhong Duan wrote:
>>>>> From: Eric Auger <eric.auger@redhat.com>
>>>>> Introduce an iommufd object which allows the interaction
>>>>> with the host /dev/iommu device.
>>>>> The /dev/iommu can have been already pre-opened outside of qemu,
>>>>> in which case the fd can be passed directly along with the
>>>>> iommufd object:
>>>>> This allows the iommufd object to be shared accross several
>>>>> subsystems (VFIO, VDPA, ...). For example, libvirt would open
>>>>> the /dev/iommu once.
>>>>> If no fd is passed along with the iommufd object, the /dev/iommu
>>>>> is opened by the qemu code.
>>>>> The CONFIG_IOMMUFD option must be set to compile this new object.
>>>>> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>> ---
>>>>> v4: add CONFIG_IOMMUFD check, document default case
>>>>>     MAINTAINERS              |   7 ++
>>>>>     qapi/qom.json            |  22 ++++
>>>>>     include/sysemu/iommufd.h |  46 +++++++
>>>>>     backends/iommufd-stub.c  |  59 +++++++++
>>>>>     backends/iommufd.c       | 257 +++++++++++++++++++++++++++++++++++++++
>>>>>     backends/Kconfig         |   4 +
>>>>>     backends/meson.build     |   5 +
>>>>>     backends/trace-events    |  12 ++
>>>>>     qemu-options.hx          |  13 ++
>>>>>     9 files changed, 425 insertions(+)
>>>>>     create mode 100644 include/sysemu/iommufd.h
>>>>>     create mode 100644 backends/iommufd-stub.c
>>>>>     create mode 100644 backends/iommufd.c
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index cd8d6b140f..6f35159255 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -2135,6 +2135,13 @@ F: hw/vfio/ap.c
>>>>>     F: docs/system/s390x/vfio-ap.rst
>>>>>     L: qemu-s390x@nongnu.org
>>>>>     +iommufd
>>>>> +M: Yi Liu <yi.l.liu@intel.com>
>>>>> +M: Eric Auger <eric.auger@redhat.com>
>>>>> +S: Supported
>>>>> +F: backends/iommufd.c
>>>>> +F: include/sysemu/iommufd.h
>>>>> +
>>>>>     vhost
>>>>>     M: Michael S. Tsirkin <mst@redhat.com>
>>>>>     S: Supported
>>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>>> index c53ef978ff..27300add48 100644
>>>>> --- a/qapi/qom.json
>>>>> +++ b/qapi/qom.json
>>>>> @@ -794,6 +794,24 @@
>>>>>     { 'struct': 'VfioUserServerProperties',
>>>>>       'data': { 'socket': 'SocketAddress', 'device': 'str' } }
>>>>> +##
>>>>> +# @IOMMUFDProperties:
>>>>> +#
>>>>> +# Properties for iommufd objects.
>>>>> +#
>>>>> +# @fd: file descriptor name previously passed via 'getfd' command,
>>>>> +#     which represents a pre-opened /dev/iommu.  This allows the
>>>>> +#     iommufd object to be shared accross several subsystems
>>>>> +#     (VFIO, VDPA, ...), and the file descriptor to be shared
>>>>> +#     with other process, e.g. DPDK.  (default: QEMU opens
>>>>> +#     /dev/iommu by itself)
>>>>> +#
>>>>> +# Since: 8.2
>>>>> +##
>>>>> +{ 'struct': 'IOMMUFDProperties',
>>>>> +  'data': { '*fd': 'str' },
>>>>> +  'if': 'CONFIG_IOMMUFD' }
>>>>
>>>>
>>>> Activating or not IOMMUFD on a platform is a configuration choice
>>>> and it is not a dependency on an external resource. I would make
>>>> things simpler and drop all the #ifdef in the documentation files.
>>>
>>> What exactly are you proposing?
>>
>> I would like to simplify the configuration part of this new IOMMUFD
>> feature and avoid a ./configure option to enable/disable the feature
>> since it has no external dependencies and can be compiled on all
>> platforms.
>>
>> However, we know that it only makes sense to have the IOMMUFD backend
>> on platforms s390x, aarch64, x86_64. So I am proposing as an improvement
>> to enable IOMMUFD only on these platforms with this addition :
>>
>>    imply IOMMUFD
>>
>> to hw/{i386,s390x,arm}/Kconfig files.
>>
>> This gives us the possibility to compile out the feature downstream
>> if something goes wrong, using the files under : configs/devices/.
> 
> Shouldn't we then compile out the relevant parts of the QAPI schema,
> too?

Is it possible with Kconfig options ?
  
>> Given that the IOMMUFD feature doesn't have any external dependencies
>> and that the IOMMUFD backend object is common to all platforms, I am
>> also proposing to remove all the CONFIG_IOMMUFD define usage in the
>> documentation file "qemu-options.hx" and the schema file "qapi/qom.json".
> 
> Any CONFIG_IOMMUFD left elsewhere?

There are. To expose or not vfio properties. Stuff like :

ifdef CONFIG_IOMMUFD
     DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
#endif
     DEFINE_PROP_END_OF_LIST(),

and

#ifdef CONFIG_IOMMUFD
     object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
#endif


>>> The use of 'if': 'CONFIG_IOMMUFD' in the QAPI schema enables
>>> introspection with query-qmp-schema: when ObjectType @iommufd exists,
>>> QEMU supports creating the object.  Or am I confused?
>>
>> Object iommufd should always exist since it is common to all.
>>
>> Is that acceptable ?
> 
> Perhaps the question to ask is whether a management application needs to
> know whether this version of QEMU supports iommufd objects.  If yes,
> then query-qmp-schema is an obvious way to find out.  

Thanks for reminding me of this possibility. In that case, we should
indeed avoid returning iommufd support when !CONFIG_IOMMUFD.

Can it be implemented in qapi/qom.json with Kconfig options ?

> What could go
> wrong when this returns "supported" when it actually isn't?
  
The management layer would build an invalid QEMU command line and
QEMU would return "invalid object type: iommufd"

Thanks,

C.





