Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BC17CA73A
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 13:56:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsMD0-0004GZ-Dm; Mon, 16 Oct 2023 07:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1qsMCx-0004G2-Tm
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:56:27 -0400
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1qsMCu-0005WZ-IP
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:56:26 -0400
Received: from blackfin.pond.sub.org (p4fd04c8c.dip0.t-ipconnect.de
 [79.208.76.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id A20C626A3A;
 Mon, 16 Oct 2023 14:14:49 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7DDD321E6A26; Mon, 16 Oct 2023 13:56:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org,  alex.williamson@redhat.com,  clg@redhat.com,
 jgg@nvidia.com,  nicolinc@nvidia.com,  joao.m.martins@oracle.com,
 eric.auger@redhat.com,  peterx@redhat.com,  jasowang@redhat.com,
 kevin.tian@intel.com,  yi.l.liu@intel.com,  yi.y.sun@intel.com,
 chao.p.peng@intel.com,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 17/27] backends/iommufd: Introduce the iommufd object
In-Reply-To: <20231016083223.1519410-18-zhenzhong.duan@intel.com> (Zhenzhong
 Duan's message of "Mon, 16 Oct 2023 16:32:13 +0800")
Date: Mon, 16 Oct 2023 12:00:49 +0200
Lines: 119
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
 <20231016083223.1519410-18-zhenzhong.duan@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Message-ID: <878r82ixwb.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Zhenzhong Duan <zhenzhong.duan@intel.com> writes:

> From: Eric Auger <eric.auger@redhat.com>
>
> Introduce an iommufd object which allows the interaction
> with the host /dev/iommu device.
>
> The /dev/iommu can have been already pre-opened outside of qemu,
> in which case the fd can be passed directly along with the
> iommufd object:
>
> This allows the iommufd object to be shared accross several
> subsystems (VFIO, VDPA, ...). For example, libvirt would open
> the /dev/iommu once.
>
> If no fd is passed along with the iommufd object, the /dev/iommu
> is opened by the qemu code.
>
> The CONFIG_IOMMUFD option must be set to compile this new object.
>
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  MAINTAINERS              |   7 +
>  qapi/qom.json            |  18 ++-
>  include/sysemu/iommufd.h |  46 +++++++
>  backends/iommufd-stub.c  |  59 +++++++++
>  backends/iommufd.c       | 268 +++++++++++++++++++++++++++++++++++++++
>  backends/Kconfig         |   4 +
>  backends/meson.build     |   5 +
>  backends/trace-events    |  12 ++
>  qemu-options.hx          |  13 ++
>  9 files changed, 431 insertions(+), 1 deletion(-)
>  create mode 100644 include/sysemu/iommufd.h
>  create mode 100644 backends/iommufd-stub.c
>  create mode 100644 backends/iommufd.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9e7dec4a58..a7cdeb7825 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2081,6 +2081,13 @@ F: hw/vfio/ap.c
>  F: docs/system/s390x/vfio-ap.rst
>  L: qemu-s390x@nongnu.org
>  
> +iommufd
> +M: Yi Liu <yi.l.liu@intel.com>
> +M: Eric Auger <eric.auger@redhat.com>
> +S: Supported
> +F: backends/iommufd.c
> +F: include/sysemu/iommufd.h
> +
>  vhost
>  M: Michael S. Tsirkin <mst@redhat.com>
>  S: Supported
> diff --git a/qapi/qom.json b/qapi/qom.json
> index c53ef978ff..3f964e57f5 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -794,6 +794,18 @@
>  { 'struct': 'VfioUserServerProperties',
>    'data': { 'socket': 'SocketAddress', 'device': 'str' } }
>  
> +##
> +# @IOMMUFDProperties:
> +#
> +# Properties for IOMMUFDbackend objects.

This is the only occurence of "IOMMUFDbackend".  Do you mean iommufd?

> +#
> +# fd: file descriptor name

Awfully terse.  Like many existing FOOProperties.  Would it make sense
to document what objects of type iommufd are good for, and how they use
@fd?  Or is it already documented elsewhere?

> +#
> +# Since: 7.2

Since: 8.2.

> +##
> +{ 'struct': 'IOMMUFDProperties',
> +        'data': { '*fd': 'str' } }
> +
>  ##
>  # @RngProperties:
>  #
> @@ -948,6 +960,8 @@
>      'qtest',
>      'rng-builtin',
>      'rng-egd',
> +    { 'name': 'iommufd',
> +      'if': 'CONFIG_IOMMUFD' },
>      { 'name': 'rng-random',
>        'if': 'CONFIG_POSIX' },
>      'secret',

Please keep the members sorted.

> @@ -1029,7 +1043,9 @@
>        'tls-creds-x509':             'TlsCredsX509Properties',
>        'tls-cipher-suites':          'TlsCredsProperties',
>        'x-remote-object':            'RemoteObjectProperties',
> -      'x-vfio-user-server':         'VfioUserServerProperties'
> +      'x-vfio-user-server':         'VfioUserServerProperties',
> +      'iommufd':                    { 'type': 'IOMMUFDProperties',
> +                                      'if': 'CONFIG_IOMMUFD' }

Likewise.

>    } }
>  
>  ##

[...]

