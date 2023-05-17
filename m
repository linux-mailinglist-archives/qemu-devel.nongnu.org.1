Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB4E7060FE
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 09:21:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzBRh-0001Yu-Tc; Wed, 17 May 2023 03:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1pzBRf-0001Ye-SU
 for qemu-devel@nongnu.org; Wed, 17 May 2023 03:19:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1pzBRd-000169-UM
 for qemu-devel@nongnu.org; Wed, 17 May 2023 03:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684307972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fifagQl0X5L/DSsYeJNDhEKZnnX3Y08uGE17t7/KKHE=;
 b=SYE6SB/R6W8UuhF0HUOOuYaaRB4ht4+C1N/h1v6odmKt9gXw0b4MVyvYY6ede7oAMvoEuB
 Lvp/crlk6CLzuNg+u6mb+4NBdq+9AERXgmT6b36C+C4jcur/bnkUdIlohQh0jjHuwW1fye
 4/vmha93j+BAfk2PfLKLxZd100Bq2N0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-YW-cJvZnOPWN20n4GRUqVQ-1; Wed, 17 May 2023 03:19:31 -0400
X-MC-Unique: YW-cJvZnOPWN20n4GRUqVQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3062e5d0cd3so148657f8f.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 00:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684307970; x=1686899970;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fifagQl0X5L/DSsYeJNDhEKZnnX3Y08uGE17t7/KKHE=;
 b=PplStGLwTwaBA5JeZImhcT4skrbq/7mg3ihI3xFOfEP+fLWkn+22lx6ZqXPk657rpq
 T1hTK31wV5ZuYfg59rdPK7S2VWWd+qSORIlM3RXC4NH7HwqrCu26c8o6RHO493S04z2k
 j0II5x7cIfI6LaaLldm+yRh/zsJyQ7T9c1Bjw1SZjxPxETUPj0/LX69zV78IXYArPK7E
 gVYQ0nmlBmC1FisL1+u6XrBdzIuR7eAgYn5bJyf0r1SJfFoA1S7YGLCaVdqHnm4X9rmx
 XE6bDpoKCAwOyRRBEmXpKPpmmG80MamNq4U3kcU36t9zfp9b5CO8zGJalhcPGfputQXh
 2/zw==
X-Gm-Message-State: AC+VfDyznEVOlFytedbMtfUZzgnozd/yh30PgsLJjsOXq7G35ppKjYNi
 kR2dUE+nQNNR0IBVpzJyNG5MZoQC0E8Yv70oPuSlYP0ScNQlhERxczsrbWkbuK6c3tlLPbdAm0P
 HTrt4eOUjPTEf+l3l2ORdAek=
X-Received: by 2002:adf:fecf:0:b0:306:4125:8bc0 with SMTP id
 q15-20020adffecf000000b0030641258bc0mr27017802wrs.29.1684307970212; 
 Wed, 17 May 2023 00:19:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6o1rvXX+keYRWIPNyyJfHNPuLgzUH1iiWZ10IcGDzQ5U75Qu90AMeIV5OUz8Wr6E1xHtkVJw==
X-Received: by 2002:adf:fecf:0:b0:306:4125:8bc0 with SMTP id
 q15-20020adffecf000000b0030641258bc0mr27017785wrs.29.1684307969915; 
 Wed, 17 May 2023 00:19:29 -0700 (PDT)
Received: from sgarzare-redhat (93-43-155-175.ip92.fastwebnet.it.
 [93.43.155.175]) by smtp.gmail.com with ESMTPSA id
 h13-20020a5d688d000000b003062b57ffd1sm1711011wru.50.2023.05.17.00.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 00:19:29 -0700 (PDT)
Date: Wed, 17 May 2023 09:19:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jonathon Jongsma <jjongsma@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v3 1/1] block/blkio: use qemu_open() to support fd
 passing for virtio-blk
Message-ID: <vcinivshe3tf4iod7ys236fq5ovzhyhei5zvo2uf636fpb2vtr@swcn25px5h5z>
References: <20230511091527.46620-1-sgarzare@redhat.com>
 <20230511091527.46620-2-sgarzare@redhat.com>
 <1a89ee2e-2368-4051-f9ec-018641721484@redhat.com>
 <q2odwrndg3gt6z25hdxb3t2xxavd64hkp4b23zhzycevhrwx64@25r5r6sidyok>
 <e8fcb4cf-3667-2bdf-a163-d81bdfb71bfa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8fcb4cf-3667-2bdf-a163-d81bdfb71bfa@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

CCing Markus for some advice.

On Tue, May 16, 2023 at 11:04:21AM -0500, Jonathon Jongsma wrote:
>On 5/15/23 5:10 AM, Stefano Garzarella wrote:
>>On Thu, May 11, 2023 at 11:03:22AM -0500, Jonathon Jongsma wrote:
>>>On 5/11/23 4:15 AM, Stefano Garzarella wrote:
>>>>The virtio-blk-vhost-vdpa driver in libblkio 1.3.0 supports the new
>>>>'fd' property. Let's expose this to the user, so the management layer
>>>>can pass the file descriptor of an already opened vhost-vdpa character
>>>>device. This is useful especially when the device can only be accessed
>>>>with certain privileges.
>>>>
>>>>If the libblkio virtio-blk driver supports fd passing, let's always
>>>>use qemu_open() to open the `path`, so we can handle fd passing
>>>>from the management layer through the "/dev/fdset/N" special path.
>>>>
>>>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>---
>>>>
>>>>Notes:
>>>>    v3:
>>>>    - use qemu_open() on `path` to simplify libvirt code [Jonathon]
>>>
>>>
>>>Thanks
>>>
>>>The one drawback now is that it doesn't seem possible for libvirt 
>>>to introspect whether or not qemu supports passing an fd to the 
>>>driver or not.
>>
>>Yep, this was because the libblkio library did not support this new way.
>>
>>>When I was writing my initial patch (before I realized that it was 
>>>missing fd-passing), I just checked for the existence of the 
>>>virtio-blk-vhost-vdpa device. But we actually need to know both 
>>>that this device exists and supports fd passing.
>>
>>Yep, this was one of the advantages of using the new `fd` parameter.
>>Can't libvirt handle the later failure?
>
>Not very well. libvirt tries to provide useful errors to the user. So 
>for example if the qemu executable doesn't support a device, we would 
>want to provide an error indicating that the device is not supported 
>rather than a possibly-inscrutable qemu error.
>
>For example, in this scenario, we would want an error such as:
>
>error: unsupported configuration: vhostvdpa disk is not supported with 
>this QEMU binary
>
>Instead of:
>
>error: internal error: qemu unexpectedly closed the monitor: 
>2023-05-16T15:17:36.666129Z qemu-system-x86_64: -blockdev {"driver":"virtio-blk-vhost-vdpa","path":"/dev/fdset/0","node-name":"libvirt-1-storage","cache":{"direct":true,"no-flush":false},"auto-read-only":true,"discard":"unmap"}: 
>blkio_connect failed: Failed to connect to vDPA device: Input/output 
>error
>
>And we can only do that if we can determine that the binary has the 
>proper support for fds.

I see the problem, thanks for explaining this!

>
>>
>>>As far as I can tell, versions 7.2.0 and 8.0.0 include this device 
>>>but won't accept fds.
>>
>>Right.
>>
>>How do you suggest to proceed?
>
>I need some way to determine that the particular qemu binary can 
>accept a /dev/fdset/ path for vdpa block devices. libvirt uses a 
>variety of methods to determine capabilities for a given qemu binary, 
>including querying the qmp schema, commands, object types, specific 
>device/object properties, etc. For example, right now I can determine 
>(via querying the qmp schema) whether virtio-blk-vhost-vdpa is a valid 
>type for the blockdev-add command by querying the qmp schema. I need 
>something more than that but I'm not sure how to do it without 
>introducing a separate 'fd' parameter. Any ideas?

The only thing I can think of is to make a mix between v2 and v3. I mean 
add both the new `fd` parameter, and support qemu_open() on `path`.

That way libvirt (or other users) can check that fd passing is supported 
and use `fd` or fdset with `path`.

Obviously I would have liked to implement only one of the two methods, 
but if this helps, maybe it makes sense to support both.

What do you think?

Thanks,
Stefano


