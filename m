Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E81805326
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 12:38:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rATk5-0006tO-JY; Tue, 05 Dec 2023 06:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rATjz-0006sx-DO
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 06:37:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rATjx-0006eA-5b
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 06:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701776242;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=a0g33fUeIqndU/tZnQCWcSkks3lKBHB8K+CHOKgUlLM=;
 b=GnetmbmbE8oEgVUV1KeEoobw4tHEujVw/M09h2pD64RmIUXvPA580UEuXYBc/7fxGHmVm6
 YXHQ84/D86bSbRSkEoQwLjXI+wje9hg1js1b5y0SYOh+p1qL3iqgVFkWI4w490Zl4IQk4p
 MSL+eSd5VTvl35md4nndad+gP/oJ2rE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-5MbGQUjgPe-ONK2KX_9nIw-1; Tue, 05 Dec 2023 06:37:20 -0500
X-MC-Unique: 5MbGQUjgPe-ONK2KX_9nIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D961785A58A;
 Tue,  5 Dec 2023 11:37:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA1082166B31;
 Tue,  5 Dec 2023 11:37:18 +0000 (UTC)
Date: Tue, 5 Dec 2023 11:37:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC 0/8] Support generic Luks encryption
Message-ID: <ZW8LbPcGOE10hQZD@redhat.com>
References: <cover.1701705003.git.yong.huang@smartx.com>
 <ZW39KzXUbWrJUdQH@redhat.com>
 <CAK9dgmapfxO93ZMSiw+aT6E1XLLrs+sXXprwCxgB8egeznsLBQ@mail.gmail.com>
 <ZW4Dm2TI9d4XBDtT@redhat.com>
 <CAK9dgmZ75OBDCNi-oMm-FKfzmfSo116dqYKi9PJucZa9DbSu8A@mail.gmail.com>
 <ZW4P20Ib7vJZW77V@redhat.com>
 <CAK9dgmbhJ+UVn3oTkjsshMOPAqdmXnywNk1jZsQ3BD+BN131fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK9dgmbhJ+UVn3oTkjsshMOPAqdmXnywNk1jZsQ3BD+BN131fQ@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Dec 05, 2023 at 09:51:21AM +0800, Yong Huang wrote:
> Let me make a conclusion about our discussion, if i
> misunderstand something,
> point that out please:
> 
> 1. To achieve the generic encryption,  extending the pre-existing LUKS QEMU
>    block driver is suggested in practice.

yes

> 
> 2. Introducing a optional field called "header-file" that store the LUKS
> header
>    independently, and once "header-file" was specified, we should use it to
>    encrypt/decrypt the blockdev node referenced by the "file" field.

Yes.

> 
> The blockdev tree is like:
>          virtio-blk/vhost-user-blk...(frontend device)
>                        ^
>                         |
>                     LUKS
>              /                     \
>          file               header-file
>          /                             \
> data protocol node    LUKS header protocol node


That is one possible blockdev tree, but there are many possible
variations.

> 3. The usage of the generic LUKS is like:
> 
> Take the qcow2 as an example:
> 
> 1. add a protocol blockdev node of data disk
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
>   "arguments":{"node-name": "libvirt-1-storage", "driver": "file",
>   "filename": "/path/to/test_disk.qcow2"}}'
> 
> 2. add a protocol blockdev node of Luks header as above.
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
>   "arguments":{"node-name": "libvirt-2-storage", "driver": "file",
>   "filename": "/path/to/cipher.gluks" }}'
> 
> 3. add the secret for decrypting the cipher stored in Gluks header as
>    above
> $ virsh qemu-monitor-command vm '{"execute":"object-add",
>   "arguments":{"qom-type": "secret", "id":
>   "libvirt-2-storage-secret0", "data": "abc123"}}'
> 
> 4. add the qcow2-drived blockdev format node:
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
>   "arguments":{"node-name": "libvirt-1-format", "driver": "qcow2",
>   "file": "libvirt-1-storage"}}'
> 
> 5. add the luks-drived blockdev to connect the qcow2 disk with Luks
>    header by specifying the field "header-file"
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
>   "arguments":{"node-name": "libvirt-2-format", "driver": "luks",
>   "file": "libvirt-1-format", "header-file": "libvirt-2-storage",
>   "key-secret": "libvirt-2-format-secret0"}}'
> 
> 6. add the device finally
> $ virsh qemu-monitor-command vm '{"execute":"device_add",
>   "arguments": {"num-queues": "1", "driver": "virtio-blk-pci", "scsi":
>   "off", "drive": "libvirt-2-format", "id": "virtio-disk2"}}'

Yes, that looks like a valid sequence of steps.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


