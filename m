Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3A574CF4F
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 10:00:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIlo4-00015K-Ov; Mon, 10 Jul 2023 03:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qIlns-00010h-HR
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:59:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qIlnq-0003cm-A9
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688975965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XSECw5Uk/+UlGex7NU7i77E+qX79vNcuCM1xAKBmmRM=;
 b=DtYylXU1x0H+81+fTr1RXb93SZq/i2KRGU6TTmy6/HMzZ4NSdAZSL5QvlsBA5TxQUvJHdF
 KOo1Ypk3qiuWRAelgZv8VEISVRxXkzEw1qFUvpyB20gxBu7BhX+dhrU+U3pt4wf+TSkgkh
 JHNDw6mgmz9rsLqypkz5Puz8PKjXyIU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-C6eLDLEyMFOqbzIRGuVTlQ-1; Mon, 10 Jul 2023 03:59:22 -0400
X-MC-Unique: C6eLDLEyMFOqbzIRGuVTlQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C265C3C0FC83;
 Mon, 10 Jul 2023 07:59:21 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C2F7145414E;
 Mon, 10 Jul 2023 07:59:21 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 1/1] linux-headers: update to v6.5-rc1
In-Reply-To: <20230709212308.370699-2-clg@redhat.com>
Organization: Red Hat GmbH
References: <20230709212308.370699-1-clg@redhat.com>
 <20230709212308.370699-2-clg@redhat.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 10 Jul 2023 09:59:20 +0200
Message-ID: <87v8esyz6v.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Jul 09 2023, C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  include/standard-headers/drm/drm_fourcc.h     |  43 ++++++
>  include/standard-headers/linux/const.h        |   2 +-
>  include/standard-headers/linux/pci_regs.h     |   1 +
>  include/standard-headers/linux/vhost_types.h  |  16 +++
>  include/standard-headers/linux/virtio_blk.h   |  18 +--
>  .../standard-headers/linux/virtio_config.h    |   6 +
>  include/standard-headers/linux/virtio_net.h   |   1 +
>  linux-headers/asm-arm64/bitsperlong.h         |  23 ---
>  linux-headers/asm-arm64/kvm.h                 |  33 +++++
>  linux-headers/asm-generic/bitsperlong.h       |  13 +-
>  linux-headers/asm-generic/unistd.h            | 134 +++++-------------
>  linux-headers/asm-mips/unistd_n32.h           |   1 +
>  linux-headers/asm-mips/unistd_n64.h           |   1 +
>  linux-headers/asm-mips/unistd_o32.h           |   1 +
>  linux-headers/asm-powerpc/unistd_32.h         |   1 +
>  linux-headers/asm-powerpc/unistd_64.h         |   1 +
>  linux-headers/asm-riscv/bitsperlong.h         |  13 --
>  linux-headers/asm-riscv/kvm.h                 | 134 +++++++++++++++++-
>  linux-headers/asm-riscv/unistd.h              |   9 ++
>  linux-headers/asm-s390/unistd_32.h            |   2 +
>  linux-headers/asm-s390/unistd_64.h            |   2 +
>  linux-headers/asm-x86/kvm.h                   |   3 +
>  linux-headers/asm-x86/unistd_32.h             |   1 +
>  linux-headers/asm-x86/unistd_64.h             |   1 +
>  linux-headers/asm-x86/unistd_x32.h            |   1 +
>  linux-headers/linux/const.h                   |   2 +-
>  linux-headers/linux/kvm.h                     |  18 ++-
>  linux-headers/linux/mman.h                    |  14 ++
>  linux-headers/linux/psp-sev.h                 |   7 +
>  linux-headers/linux/userfaultfd.h             |  17 ++-
>  linux-headers/linux/vfio.h                    |  27 ++++
>  linux-headers/linux/vhost.h                   |  31 ++++
>  32 files changed, 423 insertions(+), 154 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>


