Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEB07E6638
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 10:06:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r10yl-0001Bt-Dn; Thu, 09 Nov 2023 04:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r10yk-0001Bi-3D
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 04:05:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r10yh-0008K3-9v
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 04:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699520729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zX5ScBiDJqgxZHaD8gCMj5eKu2eee9MZH2IffB6fdfw=;
 b=cfdVwT1vYmLB5/OmxDAbwp77LujQZDatDXf3Q4UU1kndmT839jhDR3R+BIh0DzU5p1m0yN
 ElTjcpRyCB6p/Lp0v9UaO9sX5Z4ozfnlzMVuJYuImG0a92vguFZW9inIdkkoeIJPKWwVjX
 BzQLe02x9CJ/7Gj2ZdBT5i8EmqSLmpg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-KZdFq5IkM1izx573Knk2Ig-1; Thu,
 09 Nov 2023 04:05:25 -0500
X-MC-Unique: KZdFq5IkM1izx573Knk2Ig-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18F981C294A1;
 Thu,  9 Nov 2023 09:05:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CAA98492BE7;
 Thu,  9 Nov 2023 09:05:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B9AAD21E6A1F; Thu,  9 Nov 2023 10:05:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  Zhenzhong Duan
 <zhenzhong.duan@intel.com>,  qemu-devel@nongnu.org,
 alex.williamson@redhat.com,  jgg@nvidia.com,  nicolinc@nvidia.com,
 joao.m.martins@oracle.com,  eric.auger@redhat.com,  peterx@redhat.com,
 jasowang@redhat.com,  kevin.tian@intel.com,  yi.l.liu@intel.com,
 yi.y.sun@intel.com,  chao.p.peng@intel.com,  Paolo Bonzini
 <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 26/41] backends/iommufd: Introduce the iommufd object
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-27-zhenzhong.duan@intel.com>
 <da7de379-bd8c-47d1-b7bf-412be92a2756@redhat.com>
 <87r0l0dc9q.fsf@pond.sub.org>
 <d710b361-7078-456c-86bd-6b7f23d56584@redhat.com>
 <87zfzoa65e.fsf@pond.sub.org>
 <20de5dde-2a1a-4d20-bafc-b63a8015fae7@redhat.com>
Date: Thu, 09 Nov 2023 10:05:23 +0100
In-Reply-To: <20de5dde-2a1a-4d20-bafc-b63a8015fae7@redhat.com>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Wed, 8 Nov 2023 14:48:55 +0100")
Message-ID: <871qcz70vg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> On 11/8/23 11:30, Markus Armbruster wrote:
>> C=C3=A9dric Le Goater <clg@redhat.com> writes:
>>=20
>>> Hello Markus,
>>>
>>> On 11/8/23 06:50, Markus Armbruster wrote:
>>>> C=C3=A9dric Le Goater <clg@redhat.com> writes:
>>>>
>>>>> On 11/2/23 08:12, Zhenzhong Duan wrote:
>>>>>> From: Eric Auger <eric.auger@redhat.com>
>>>>>> Introduce an iommufd object which allows the interaction
>>>>>> with the host /dev/iommu device.
>>>>>> The /dev/iommu can have been already pre-opened outside of qemu,
>>>>>> in which case the fd can be passed directly along with the
>>>>>> iommufd object:
>>>>>> This allows the iommufd object to be shared accross several
>>>>>> subsystems (VFIO, VDPA, ...). For example, libvirt would open
>>>>>> the /dev/iommu once.
>>>>>> If no fd is passed along with the iommufd object, the /dev/iommu
>>>>>> is opened by the qemu code.
>>>>>> The CONFIG_IOMMUFD option must be set to compile this new object.
>>>>>> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>> ---
>>>>>> v4: add CONFIG_IOMMUFD check, document default case
>>>>>>     MAINTAINERS              |   7 ++
>>>>>>     qapi/qom.json            |  22 ++++
>>>>>>     include/sysemu/iommufd.h |  46 +++++++
>>>>>>     backends/iommufd-stub.c  |  59 +++++++++
>>>>>>     backends/iommufd.c       | 257 +++++++++++++++++++++++++++++++++=
++++++
>>>>>>     backends/Kconfig         |   4 +
>>>>>>     backends/meson.build     |   5 +
>>>>>>     backends/trace-events    |  12 ++
>>>>>>     qemu-options.hx          |  13 ++
>>>>>>     9 files changed, 425 insertions(+)
>>>>>>     create mode 100644 include/sysemu/iommufd.h
>>>>>>     create mode 100644 backends/iommufd-stub.c
>>>>>>     create mode 100644 backends/iommufd.c
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index cd8d6b140f..6f35159255 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -2135,6 +2135,13 @@ F: hw/vfio/ap.c
>>>>>>     F: docs/system/s390x/vfio-ap.rst
>>>>>>     L: qemu-s390x@nongnu.org
>>>>>>     +iommufd
>>>>>> +M: Yi Liu <yi.l.liu@intel.com>
>>>>>> +M: Eric Auger <eric.auger@redhat.com>
>>>>>> +S: Supported
>>>>>> +F: backends/iommufd.c
>>>>>> +F: include/sysemu/iommufd.h
>>>>>> +
>>>>>>     vhost
>>>>>>     M: Michael S. Tsirkin <mst@redhat.com>
>>>>>>     S: Supported
>>>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>>>> index c53ef978ff..27300add48 100644
>>>>>> --- a/qapi/qom.json
>>>>>> +++ b/qapi/qom.json
>>>>>> @@ -794,6 +794,24 @@
>>>>>>     { 'struct': 'VfioUserServerProperties',
>>>>>>       'data': { 'socket': 'SocketAddress', 'device': 'str' } }
>>>>>> +##
>>>>>> +# @IOMMUFDProperties:
>>>>>> +#
>>>>>> +# Properties for iommufd objects.
>>>>>> +#
>>>>>> +# @fd: file descriptor name previously passed via 'getfd' command,
>>>>>> +#     which represents a pre-opened /dev/iommu.  This allows the
>>>>>> +#     iommufd object to be shared accross several subsystems
>>>>>> +#     (VFIO, VDPA, ...), and the file descriptor to be shared
>>>>>> +#     with other process, e.g. DPDK.  (default: QEMU opens
>>>>>> +#     /dev/iommu by itself)
>>>>>> +#
>>>>>> +# Since: 8.2
>>>>>> +##
>>>>>> +{ 'struct': 'IOMMUFDProperties',
>>>>>> +  'data': { '*fd': 'str' },
>>>>>> +  'if': 'CONFIG_IOMMUFD' }
>>>>>
>>>>>
>>>>> Activating or not IOMMUFD on a platform is a configuration choice
>>>>> and it is not a dependency on an external resource. I would make
>>>>> things simpler and drop all the #ifdef in the documentation files.
>>>>
>>>> What exactly are you proposing?
>>>
>>> I would like to simplify the configuration part of this new IOMMUFD
>>> feature and avoid a ./configure option to enable/disable the feature
>>> since it has no external dependencies and can be compiled on all
>>> platforms.
>>>
>>> However, we know that it only makes sense to have the IOMMUFD backend
>>> on platforms s390x, aarch64, x86_64. So I am proposing as an improvement
>>> to enable IOMMUFD only on these platforms with this addition :
>>>
>>>    imply IOMMUFD
>>>
>>> to hw/{i386,s390x,arm}/Kconfig files.
>>>
>>> This gives us the possibility to compile out the feature downstream
>>> if something goes wrong, using the files under : configs/devices/.
>>=20
>> Shouldn't we then compile out the relevant parts of the QAPI schema,
>> too?
>
> Is it possible with Kconfig options ?

See below.

>>> Given that the IOMMUFD feature doesn't have any external dependencies
>>> and that the IOMMUFD backend object is common to all platforms, I am
>>> also proposing to remove all the CONFIG_IOMMUFD define usage in the
>>> documentation file "qemu-options.hx" and the schema file "qapi/qom.json=
".
>>=20
>> Any CONFIG_IOMMUFD left elsewhere?
>
> There are. To expose or not vfio properties. Stuff like :
>
> ifdef CONFIG_IOMMUFD
>      DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
>                       TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> #endif
>      DEFINE_PROP_END_OF_LIST(),
>
> and
>
> #ifdef CONFIG_IOMMUFD
>      object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
> #endif
>
>
>>>> The use of 'if': 'CONFIG_IOMMUFD' in the QAPI schema enables
>>>> introspection with query-qmp-schema: when ObjectType @iommufd exists,
>>>> QEMU supports creating the object.  Or am I confused?
>>>
>>> Object iommufd should always exist since it is common to all.
>>>
>>> Is that acceptable ?
>>=20
>> Perhaps the question to ask is whether a management application needs to
>> know whether this version of QEMU supports iommufd objects.  If yes,
>> then query-qmp-schema is an obvious way to find out.=20=20
>
> Thanks for reminding me of this possibility. In that case, we should
> indeed avoid returning iommufd support when !CONFIG_IOMMUFD.
>
> Can it be implemented in qapi/qom.json with Kconfig options ?

The only tool we have for configuring the schema is the 'if'
conditional.  'if': 'CONFIG_IOMMUFD' compiles to #if
defined(CONFIG_IOMMUFD) ... #endif.  Your use of #ifdef CONFIG_IOMMUFD
above suggests this is fine here.

Symbols that are only defined in target-dependent compiles (see
exec/poison.h) can only be used in target-dependent schema modules,
i.e. the *-target.json.

>> What could go
>> wrong when this returns "supported" when it actually isn't?
>=20=20=20
> The management layer would build an invalid QEMU command line and
> QEMU would return "invalid object type: iommufd"
>
> Thanks,
>
> C.


