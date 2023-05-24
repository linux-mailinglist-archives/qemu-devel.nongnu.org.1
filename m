Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3257870F1C6
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:07:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kRR-00067A-Mu; Wed, 24 May 2023 05:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q1kRP-00066z-UF
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q1kRO-0007dg-64
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684919152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P3HlOCA9AfvZdc4dzDD00FzxjVD8mc+L1QK9Gr9W7Q4=;
 b=EE7hXBK2A1RqJkS1xfj6K7oAwdlQHC43gn7/42YFyctnxa0DT/xxjNzI7k/Kd2kuSKYswS
 t/K3sD0mzSF8OqMkWP817j4eSXBLaO1Dx3VJOm+WRCiNNRqugmLklc1dD5Uvt2T63joVKl
 VYDMr4E/QoLL7zRxi3F9Z+fyjZOJZRg=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-8TyESJvmP4Kl4E_xu7lQDg-1; Wed, 24 May 2023 05:05:51 -0400
X-MC-Unique: 8TyESJvmP4Kl4E_xu7lQDg-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-561d565cb0aso6936407b3.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684919151; x=1687511151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3HlOCA9AfvZdc4dzDD00FzxjVD8mc+L1QK9Gr9W7Q4=;
 b=QtKFligsYD17EymJCuPRGFFMztB/Zallo2/MqPD80rgX8J6FQrp840CA3iwV/C7FoK
 0IA0av/gQC8/5WLTjb/YVHdmvKSLaTsuMliYERJSoszb3XH2sGAHa/C6DQDap05z6RQm
 hRtTm9Ji9kBC5KfxonsJK+ElzMTWGM8t6ZtjlcncJbJP3imLOEYd2CClJcRenYAYleCa
 RH9lcGN9vnOw5Wq6Gd5HGuj16rmloIGrfKyc16Vc0waY3fsoUpPhgEU7gexfRqzaQClt
 yYEKt/RU/Dq4bpCeft8mSoIFHn8WDpFGZDM5F5CqD3I3QynHRdJUuA0KKZuuUHkg+SH8
 5T6A==
X-Gm-Message-State: AC+VfDxKCTt/X154/dK3p84KHPpbN+HxvEMwggKzl8XEfOUWdwzMoA8Z
 HTNQCacn2ScrbbAIQA9JTDxdDjnPUiLkP7EKgRl/ZGsGsMXCD7wLEfb4YM3pUMDM0lCbfc4fuFI
 U2mVkwQ7GMopfEx+E5E38DZVK63Rt+pM=
X-Received: by 2002:a81:480c:0:b0:55a:9020:5074 with SMTP id
 v12-20020a81480c000000b0055a90205074mr17791680ywa.24.1684919150779; 
 Wed, 24 May 2023 02:05:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ67zy1E2GSi1NQNWpfFUXugDdo4yp/QWkrp22yNL7USvUWPxWEA3OULZEQDV0ni+Vckcq2yGLPnx+grnMiJ6a0=
X-Received: by 2002:a81:480c:0:b0:55a:9020:5074 with SMTP id
 v12-20020a81480c000000b0055a90205074mr17791664ywa.24.1684919150513; Wed, 24
 May 2023 02:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230511091527.46620-1-sgarzare@redhat.com>
 <20230511091527.46620-2-sgarzare@redhat.com>
 <1a89ee2e-2368-4051-f9ec-018641721484@redhat.com>
 <q2odwrndg3gt6z25hdxb3t2xxavd64hkp4b23zhzycevhrwx64@25r5r6sidyok>
 <e8fcb4cf-3667-2bdf-a163-d81bdfb71bfa@redhat.com>
 <vcinivshe3tf4iod7ys236fq5ovzhyhei5zvo2uf636fpb2vtr@swcn25px5h5z>
 <20230517143023.GA65838@fedora>
In-Reply-To: <20230517143023.GA65838@fedora>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 24 May 2023 11:05:38 +0200
Message-ID: <CAGxU2F4PV5Cz+d4mG97gETPTg=KiYSDM5FpUM+jRhJJdef1-4g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] block/blkio: use qemu_open() to support fd passing
 for virtio-blk
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, 
 Jonathon Jongsma <jjongsma@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

Gentle ping :-)

On Wed, May 17, 2023 at 4:30=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Wed, May 17, 2023 at 09:19:26AM +0200, Stefano Garzarella wrote:
> > CCing Markus for some advice.
> >
> > On Tue, May 16, 2023 at 11:04:21AM -0500, Jonathon Jongsma wrote:
> > > On 5/15/23 5:10 AM, Stefano Garzarella wrote:
> > > > On Thu, May 11, 2023 at 11:03:22AM -0500, Jonathon Jongsma wrote:
> > > > > On 5/11/23 4:15 AM, Stefano Garzarella wrote:
> > > > > > The virtio-blk-vhost-vdpa driver in libblkio 1.3.0 supports the=
 new
> > > > > > 'fd' property. Let's expose this to the user, so the management=
 layer
> > > > > > can pass the file descriptor of an already opened vhost-vdpa ch=
aracter
> > > > > > device. This is useful especially when the device can only be a=
ccessed
> > > > > > with certain privileges.
> > > > > >
> > > > > > If the libblkio virtio-blk driver supports fd passing, let's al=
ways
> > > > > > use qemu_open() to open the `path`, so we can handle fd passing
> > > > > > from the management layer through the "/dev/fdset/N" special pa=
th.
> > > > > >
> > > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > > > ---
> > > > > >
> > > > > > Notes:
> > > > > >     v3:
> > > > > >     - use qemu_open() on `path` to simplify libvirt code [Jonat=
hon]
> > > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > The one drawback now is that it doesn't seem possible for
> > > > > libvirt to introspect whether or not qemu supports passing an fd
> > > > > to the driver or not.
> > > >
> > > > Yep, this was because the libblkio library did not support this new=
 way.
> > > >
> > > > > When I was writing my initial patch (before I realized that it
> > > > > was missing fd-passing), I just checked for the existence of the
> > > > > virtio-blk-vhost-vdpa device. But we actually need to know both
> > > > > that this device exists and supports fd passing.
> > > >
> > > > Yep, this was one of the advantages of using the new `fd` parameter=
.
> > > > Can't libvirt handle the later failure?
> > >
> > > Not very well. libvirt tries to provide useful errors to the user. So
> > > for example if the qemu executable doesn't support a device, we would
> > > want to provide an error indicating that the device is not supported
> > > rather than a possibly-inscrutable qemu error.
> > >
> > > For example, in this scenario, we would want an error such as:
> > >
> > > error: unsupported configuration: vhostvdpa disk is not supported wit=
h
> > > this QEMU binary
> > >
> > > Instead of:
> > >
> > > error: internal error: qemu unexpectedly closed the monitor:
> > > 2023-05-16T15:17:36.666129Z qemu-system-x86_64: -blockdev {"driver":"=
virtio-blk-vhost-vdpa","path":"/dev/fdset/0","node-name":"libvirt-1-storage=
","cache":{"direct":true,"no-flush":false},"auto-read-only":true,"discard":=
"unmap"}:
> > > blkio_connect failed: Failed to connect to vDPA device: Input/output
> > > error
> > >
> > > And we can only do that if we can determine that the binary has the
> > > proper support for fds.
> >
> > I see the problem, thanks for explaining this!
> >
> > >
> > > >
> > > > > As far as I can tell, versions 7.2.0 and 8.0.0 include this
> > > > > device but won't accept fds.
> > > >
> > > > Right.
> > > >
> > > > How do you suggest to proceed?
> > >
> > > I need some way to determine that the particular qemu binary can acce=
pt
> > > a /dev/fdset/ path for vdpa block devices. libvirt uses a variety of
> > > methods to determine capabilities for a given qemu binary, including
> > > querying the qmp schema, commands, object types, specific device/obje=
ct
> > > properties, etc. For example, right now I can determine (via querying
> > > the qmp schema) whether virtio-blk-vhost-vdpa is a valid type for the
> > > blockdev-add command by querying the qmp schema. I need something mor=
e
> > > than that but I'm not sure how to do it without introducing a separat=
e
> > > 'fd' parameter. Any ideas?
> >
> > The only thing I can think of is to make a mix between v2 and v3. I mea=
n add
> > both the new `fd` parameter, and support qemu_open() on `path`.
> >
> > That way libvirt (or other users) can check that fd passing is supporte=
d and
> > use `fd` or fdset with `path`.
> >
> > Obviously I would have liked to implement only one of the two methods, =
but
> > if this helps, maybe it makes sense to support both.
> >
> > What do you think?
>
> Markus: Is a preferred way to make this new path handling behavior
> introspectable? I vaguely remember a way for QMP clients to query
> strings that describe QMP behavior that's not otherwise
> introspectable...

If there is no other way for introspection with QMP, I think adding
`fd` and supporting `qemu_open()` on `path` is the easiest.

Thanks,
Stefano


