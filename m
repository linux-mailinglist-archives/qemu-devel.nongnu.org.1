Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E230273682D
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:44:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXrl-0000oT-5v; Tue, 20 Jun 2023 05:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qBXrj-0000mc-Sx
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qBXri-0007Cg-AB
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687254093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3It2NZYCXKRzeV7HhNGMTFh0lnlvIJkuzNah3Z/f6V8=;
 b=RC+YkYeXMtd2bR9+h7SA4zEqXHc7xvP3uh3GP7+U1T+9o2mjiQRR+yQCzEmUL3SQPjG7li
 Dm31IkaPEkHJtxMmYPs6kWyOiOJHAgERMdeAKb59bO+iTjYCLdx4RUM18cgiLFyvxc6YVy
 iHYvRzWZtwPoeRNBXqBQJ4ZZw5cx0c4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-ae1SokUPNamv0gV-ky2RfQ-1; Tue, 20 Jun 2023 05:41:25 -0400
X-MC-Unique: ae1SokUPNamv0gV-ky2RfQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E94F0803FE0;
 Tue, 20 Jun 2023 09:41:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AD1B40C200F;
 Tue, 20 Jun 2023 09:41:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3CD1E1807DD4; Tue, 20 Jun 2023 11:41:22 +0200 (CEST)
Date: Tue, 20 Jun 2023 11:41:22 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, 
 Damien Hedde <damien.hedde@greensocs.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>, 
 Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
 Jan Beulich <jbeulich@suse.com>, 
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Robert Beckett <bob.beckett@collabora.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Hildebrand,
 Stewart" <Stewart.Hildebrand@amd.com>, 
 Xenia Ragiadakou <burzalodowa@gmail.com>, "Huang,
 Honglei1" <Honglei1.Huang@amd.com>, 
 "Zhang, Julia" <Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [QEMU PATCH 1/1] virtgpu: do not destroy resources when guest
 suspend
Message-ID: <lgan3p6wqmxht5fpduh5nvg3f5m5n636k7zrrealnu2lilghhh@qlbvgu3l4apw>
References: <20230608025655.1674357-1-Jiqian.Chen@amd.com>
 <20230608025655.1674357-2-Jiqian.Chen@amd.com>
 <CAJ+F1CKjTW7zycr2xAW0x+d_7CEy+LxWur2Tqp2dvsb=PoJ5Dw@mail.gmail.com>
 <q2rpqbg5b4bqxb7oayclzgbf5fplofm3dmxgmpmskjf4mcfzpn@peeiuxwkqxbb>
 <BL1PR12MB58491E2E13F959365AA3F594E75CA@BL1PR12MB5849.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB58491E2E13F959365AA3F594E75CA@BL1PR12MB5849.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

  Hi,

> > The guest driver should be able to restore resources after resume.
> 
> Thank you for your suggestion!
> As far as I know, resources are created on host side and guest has no backup, if resources are destroyed, guest can't restore them.
> Or do you mean guest driver need to send commands to re-create resources after resume?

The later.  The guest driver knows which resources it has created,
it can restore them after suspend.

> If so, I have some questions. Can guest re-create resources by using
> object(virtio_vpu_object) or others? Can the new resources replace the
> destroyed resources to continue the suspended display tasks after
> resume?

Any display scanout information will be gone too, the guest driver needs
re-create this too (after re-creating the resources).

take care,
  Gerd


