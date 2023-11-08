Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7B67E502E
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 06:51:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0bSW-0004NS-TP; Wed, 08 Nov 2023 00:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r0bSV-0004NF-GJ
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 00:50:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r0bST-0006cl-P7
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 00:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699422632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FDKDdLOV2u0CVj0/MYwvUvjyg6dOy8Xhrkpv9Yw8sFk=;
 b=OiVRYWvNIUzfRDGd8GECEzB+KWWIg6tt+QTtZvCEGxXXkPYRyquhrrywUNNCQlJQH9uJLs
 eiUDopgvbafP/qY8FGgsIkcdDnKfgBl3QiW8/aQo7mV2cuvOO2WT/yr3tDsf/edLbGwggo
 FF7FH9+I1NA+dBPEDyK7zUo5Z0BkmeU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-Wb8IN6iOOTWWwGumzrKgmg-1; Wed, 08 Nov 2023 00:50:27 -0500
X-MC-Unique: Wb8IN6iOOTWWwGumzrKgmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B80680F8F7;
 Wed,  8 Nov 2023 05:50:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29AE710F5A;
 Wed,  8 Nov 2023 05:50:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0926521E6A1F; Wed,  8 Nov 2023 06:50:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,  qemu-devel@nongnu.org,
 alex.williamson@redhat.com,  jgg@nvidia.com,  nicolinc@nvidia.com,
 joao.m.martins@oracle.com,  eric.auger@redhat.com,  peterx@redhat.com,
 jasowang@redhat.com,  kevin.tian@intel.com,  yi.l.liu@intel.com,
 yi.y.sun@intel.com,  chao.p.peng@intel.com,  Paolo Bonzini
 <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 26/41] backends/iommufd: Introduce the iommufd object
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-27-zhenzhong.duan@intel.com>
 <da7de379-bd8c-47d1-b7bf-412be92a2756@redhat.com>
Date: Wed, 08 Nov 2023 06:50:25 +0100
In-Reply-To: <da7de379-bd8c-47d1-b7bf-412be92a2756@redhat.com>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Tue, 7 Nov 2023 14:33:13 +0100")
Message-ID: <87r0l0dc9q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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

> On 11/2/23 08:12, Zhenzhong Duan wrote:
>> From: Eric Auger <eric.auger@redhat.com>
>> Introduce an iommufd object which allows the interaction
>> with the host /dev/iommu device.
>> The /dev/iommu can have been already pre-opened outside of qemu,
>> in which case the fd can be passed directly along with the
>> iommufd object:
>> This allows the iommufd object to be shared accross several
>> subsystems (VFIO, VDPA, ...). For example, libvirt would open
>> the /dev/iommu once.
>> If no fd is passed along with the iommufd object, the /dev/iommu
>> is opened by the qemu code.
>> The CONFIG_IOMMUFD option must be set to compile this new object.
>> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>> v4: add CONFIG_IOMMUFD check, document default case
>>   MAINTAINERS              |   7 ++
>>   qapi/qom.json            |  22 ++++
>>   include/sysemu/iommufd.h |  46 +++++++
>>   backends/iommufd-stub.c  |  59 +++++++++
>>   backends/iommufd.c       | 257 +++++++++++++++++++++++++++++++++++++++
>>   backends/Kconfig         |   4 +
>>   backends/meson.build     |   5 +
>>   backends/trace-events    |  12 ++
>>   qemu-options.hx          |  13 ++
>>   9 files changed, 425 insertions(+)
>>   create mode 100644 include/sysemu/iommufd.h
>>   create mode 100644 backends/iommufd-stub.c
>>   create mode 100644 backends/iommufd.c
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cd8d6b140f..6f35159255 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2135,6 +2135,13 @@ F: hw/vfio/ap.c
>>   F: docs/system/s390x/vfio-ap.rst
>>   L: qemu-s390x@nongnu.org
>>   +iommufd
>> +M: Yi Liu <yi.l.liu@intel.com>
>> +M: Eric Auger <eric.auger@redhat.com>
>> +S: Supported
>> +F: backends/iommufd.c
>> +F: include/sysemu/iommufd.h
>> +
>>   vhost
>>   M: Michael S. Tsirkin <mst@redhat.com>
>>   S: Supported
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index c53ef978ff..27300add48 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -794,6 +794,24 @@
>>   { 'struct': 'VfioUserServerProperties',
>>     'data': { 'socket': 'SocketAddress', 'device': 'str' } }
>> +##
>> +# @IOMMUFDProperties:
>> +#
>> +# Properties for iommufd objects.
>> +#
>> +# @fd: file descriptor name previously passed via 'getfd' command,
>> +#     which represents a pre-opened /dev/iommu.  This allows the
>> +#     iommufd object to be shared accross several subsystems
>> +#     (VFIO, VDPA, ...), and the file descriptor to be shared
>> +#     with other process, e.g. DPDK.  (default: QEMU opens
>> +#     /dev/iommu by itself)
>> +#
>> +# Since: 8.2
>> +##
>> +{ 'struct': 'IOMMUFDProperties',
>> +  'data': { '*fd': 'str' },
>> +  'if': 'CONFIG_IOMMUFD' }
>
>
> Activating or not IOMMUFD on a platform is a configuration choice
> and it is not a dependency on an external resource. I would make
> things simpler and drop all the #ifdef in the documentation files.

What exactly are you proposing?

The use of 'if': 'CONFIG_IOMMUFD' in the QAPI schema enables
introspection with query-qmp-schema: when ObjectType @iommufd exists,
QEMU supports creating the object.  Or am I confused?

> There might be a way to remove the documentation also. Not a big
> issue for now.
>
>
>> +
>>   ##
>>   # @RngProperties:
>>   #
>> @@ -934,6 +952,8 @@
>>      'input-barrier',
>>      { 'name': 'input-linux',
>>        'if': 'CONFIG_LINUX' },
>> +    { 'name': 'iommufd',
>> +      'if': 'CONFIG_IOMMUFD' },
>>      'iothread',
>>      'main-loop',
>>      { 'name': 'memory-backend-epc',
>> @@ -1003,6 +1023,8 @@
>>        'input-barrier':              'InputBarrierProperties',
>>        'input-linux':                { 'type': 'InputLinuxProperties',
>>                                         'if': 'CONFIG_LINUX' },
>> +      'iommufd':                    { 'type': 'IOMMUFDProperties',
>> +                                      'if': 'CONFIG_IOMMUFD' },
>>        'iothread':                   'IothreadProperties',
>>        'main-loop':                  'MainLoopProperties',
>>        'memory-backend-epc':         { 'type': 'MemoryBackendEpcProperti=
es',

[...]


