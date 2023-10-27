Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7A27D9196
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 10:31:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwIFR-0000di-U7; Fri, 27 Oct 2023 04:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qwIF8-0000Rs-QF
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 04:31:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qwIF6-0005bU-UP
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 04:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698395456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0ccpLcixCnAUfkV3WWYrUXiRXLJs4dNbayEk1D0V4o=;
 b=LY2xaPcpFEpNV2MXS9DuepI+nNeIvbkuhLJEq9ZrVTWZC4M8AS10yfq7Dn7ieqFQsrqv5Q
 5elvIW3rtzCl3ZmBEs2rvWUWSYZz2mKRJxkx+USiAKHcjbi7i9tZODjabldN4oDKjbSJo2
 mAQXmlwilP6dAyV9M2pkDjEuygknN70=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-TT3w7WIqNTiY9k5io8xruA-1; Fri,
 27 Oct 2023 04:30:49 -0400
X-MC-Unique: TT3w7WIqNTiY9k5io8xruA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1527A381CBFB;
 Fri, 27 Oct 2023 08:30:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3EB01C060AE;
 Fri, 27 Oct 2023 08:30:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A1F7B21E6A1F; Fri, 27 Oct 2023 10:30:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,  "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,  "Martins, Joao"
 <joao.m.martins@oracle.com>,  "eric.auger@redhat.com"
 <eric.auger@redhat.com>,  "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,  "Tian, Kevin"
 <kevin.tian@intel.com>,  "Liu, Yi L" <yi.l.liu@intel.com>,  "Sun, Yi Y"
 <yi.y.sun@intel.com>,  "Peng, Chao P" <chao.p.peng@intel.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel =?utf-8?Q?P=2EBerrang=C3=A9?=
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 24/37] backends/iommufd: Introduce the iommufd object
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-25-zhenzhong.duan@intel.com>
 <87msw5a4z3.fsf@pond.sub.org>
 <SJ0PR11MB6744685EB6B526484F334AB692DCA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Date: Fri, 27 Oct 2023 10:30:47 +0200
In-Reply-To: <SJ0PR11MB6744685EB6B526484F334AB692DCA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 (Zhenzhong Duan's message of "Fri, 27 Oct 2023 07:50:00 +0000")
Message-ID: <87ttqc31s8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

"Duan, Zhenzhong" <zhenzhong.duan@intel.com> writes:

>>-----Original Message-----
>> From: Markus Armbruster <armbru@redhat.com>
>> Sent: Thursday, October 26, 2023 9:28 PM
>> Subject: Re: [PATCH v3 24/37] backends/iommufd: Introduce the iommufd ob=
ject
>>
>> Zhenzhong Duan <zhenzhong.duan@intel.com> writes:
>>
>>> From: Eric Auger <eric.auger@redhat.com>
>>>
>>> Introduce an iommufd object which allows the interaction
>>> with the host /dev/iommu device.
>>>
>>> The /dev/iommu can have been already pre-opened outside of qemu,
>>> in which case the fd can be passed directly along with the
>>> iommufd object:
>>>
>>> This allows the iommufd object to be shared accross several
>>> subsystems (VFIO, VDPA, ...). For example, libvirt would open
>>> the /dev/iommu once.
>>>
>>> If no fd is passed along with the iommufd object, the /dev/iommu
>>> is opened by the qemu code.
>>>
>>> The CONFIG_IOMMUFD option must be set to compile this new object.
>>>
>>> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
>>> ---
>>>  MAINTAINERS              |   7 +
>>>  qapi/qom.json            |  20 +++
>>>  include/sysemu/iommufd.h |  46 +++++++
>>>  backends/iommufd-stub.c  |  59 +++++++++
>>>  backends/iommufd.c       | 268 +++++++++++++++++++++++++++++++++++++++
>>>  backends/Kconfig         |   4 +
>>>  backends/meson.build     |   5 +
>>>  backends/trace-events    |  12 ++
>>>  qemu-options.hx          |  13 ++
>>>  9 files changed, 434 insertions(+)
>>>  create mode 100644 include/sysemu/iommufd.h
>>>  create mode 100644 backends/iommufd-stub.c
>>>  create mode 100644 backends/iommufd.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 7f9912baa0..7aa57ab16f 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2109,6 +2109,13 @@ F: hw/vfio/ap.c
>>>  F: docs/system/s390x/vfio-ap.rst
>>>  L: qemu-s390x@nongnu.org
>>>
>>> +iommufd
>>> +M: Yi Liu <yi.l.liu@intel.com>
>>> +M: Eric Auger <eric.auger@redhat.com>
>>> +S: Supported
>>> +F: backends/iommufd.c
>>> +F: include/sysemu/iommufd.h
>>> +
>>>  vhost
>>>  M: Michael S. Tsirkin <mst@redhat.com>
>>>  S: Supported
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index c53ef978ff..ef0b50f107 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json
>>> @@ -794,6 +794,22 @@
>>>  { 'struct': 'VfioUserServerProperties',
>>>    'data': { 'socket': 'SocketAddress', 'device': 'str' } }
>>>
>>> +##
>>> +# @IOMMUFDProperties:
>>> +#
>>> +# Properties for iommufd objects.
>>> +#
>>> +# @fd: file descriptor name previously passed via 'getfd' command,
>>> +#     which represents a pre-opened /dev/iommu. This allows the
>>
>> Two spaces between sentences for consistency, please.
>
> Presume you mean "  'data': { '*fd': 'str' } }" line, not above line.

I'd like you to format the doc comment like this:


     # @fd: file descriptor name previously passed via 'getfd' command,
     #     which represents a pre-opened /dev/iommu.  This allows the

Note the two spaces after the period in "/dev/iommu.  This allows".

>>
>>> +#     iommufd object to be shared accross several subsystems
>>> +#     (VFIO, VDPA, ...) and file descriptor to be shared with
>>
>> Comma before "and file".
>>
>> Either "the file descriptor", or "file descriptors".
>>
>>> +#     other process, e.g: DPDK.
>>
>> e.g.
>>
>> Alternatively "such as DPDK."
>
> Will fix.
>
>>
>>> +#
>>> +# Since: 8.2
>>> +##
>>> +{ 'struct': 'IOMMUFDProperties',
>>> +        'data': { '*fd': 'str' } }
>>
>> @fd is optional.  How does the iommufd object behave when @fd is absent?
>
> If no fd is passed along with the iommufd object, the /dev/iommu
> is opened by the qemu code. Let me know if this also needs to be document=
ed.

When something is optional, we pretty much always need to document
behavior when it's absent.

Ideally, behavior when absent is identical to behavior when present with
a certain default value.  Then documenting the default value suffices.
We commonly do this like (default: VALUE).

>>> +
>>>  ##
>>>  # @RngProperties:
>>>  #
>>> @@ -934,6 +950,8 @@
>>   ##
>>   # @ObjectType:
>>
>> None of the enum members are documented.  I'm not asking you to fix that
>> now.
>>
>>   #
>>   # Features:
>>   #
>>   # @unstable: Member @x-remote-object is experimental.
>>   #
>>   # Since: 6.0
>>   ##
>>   { 'enum': 'ObjectType',
>>     'data': [
>>       [...]
>>>      'input-barrier',
>>>      { 'name': 'input-linux',
>>>        'if': 'CONFIG_LINUX' },
>>> +    { 'name': 'iommufd',
>>> +      'if': 'CONFIG_IOMMUFD' },
>>
>> Should struct IOMMUFDProperties also have 'if': 'CONFIG_IOMMUFD'?
>
> Yes, thanks for point out, will fix.

You're welcome!


