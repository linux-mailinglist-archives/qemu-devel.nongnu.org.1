Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 713AC75BA88
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 00:23:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMc2P-0001OS-7z; Thu, 20 Jul 2023 18:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qMc2N-0001OG-3t
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 18:22:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qMc2L-0000kO-Hm
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 18:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689891736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/5ZSWgQ7hYPT6II/PNiOy01U/I9L4WpoP4ciI4EhJlU=;
 b=JoRAb9nldQtgq74IBiieCE2T8Vl259Q5y/IYUHWl1zPiQ2L7CpCsGycUqto/q0AgY9JDsW
 JP/tuwD8g8UR4SzGpVICxDDHPiBt2rA8Uqfo5rpEhyDJM7mmmPyCggr8NWQBsfVIVVlJPB
 0a/wXukd19pULnbnyj74CWaQVHHVlwY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-kUCB3r8FNUWOfqfyLI2SpQ-1; Thu, 20 Jul 2023 18:22:14 -0400
X-MC-Unique: kUCB3r8FNUWOfqfyLI2SpQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b9525b64d2so12835401fa.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 15:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689891733; x=1690496533;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/5ZSWgQ7hYPT6II/PNiOy01U/I9L4WpoP4ciI4EhJlU=;
 b=kvWOQXdIkDIltx09TJNk1LVvQ+A0u7sB7j6Z0mAVaQccQkz8vM+I1USr9m9L2NGDLH
 HpVVeTHU0THd83vhlwYUOhVllLLyXPPQDKJ8Uau5peSYVOKRJOmCiDOqP4q1KwTQto24
 l0L3KDK02qRStIpAlmj4cFKeWj2HRlDZjPzl+mx0Z+uds5J/jdzXkXenIFCSCwn6O7da
 AWYlfIOcZCritrhA71plC69wrfYRg+147+FceNAwFe2oO3wKDPPNACNOcU+w8/S0U0CK
 JhN1eDyXHnmHm83x4OlPrwmprhrILl68JBq6NhSxFVFch6KfBJgSy0ktrluQHM2A0VsN
 pu6Q==
X-Gm-Message-State: ABy/qLb/G6uER5HSMWPwCNgLIrndou2HowCcz/pK1dBHxL5/RTnv6fCl
 /DiefFbkZmJuQTJPishHthMrMQSoWvhjzE7nH6lidfpD494XJkrbmXf5t8ACXHzkEiUEQu2HPRE
 mYqRkudPQIlF6zPg=
X-Received: by 2002:a2e:7813:0:b0:2b0:297c:cbdf with SMTP id
 t19-20020a2e7813000000b002b0297ccbdfmr214456ljc.1.1689891733054; 
 Thu, 20 Jul 2023 15:22:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH3KHrbBmUCxPgfPpbLxqktxIENvAldsQp/fzQUmaan/5XD49H+rZTOplA2Kz67oIrPn2OCTQ==
X-Received: by 2002:a2e:7813:0:b0:2b0:297c:cbdf with SMTP id
 t19-20020a2e7813000000b002b0297ccbdfmr214436ljc.1.1689891732691; 
 Thu, 20 Jul 2023 15:22:12 -0700 (PDT)
Received: from redhat.com ([2.52.16.41]) by smtp.gmail.com with ESMTPSA id
 f3-20020a0560001b0300b0030e52d4c1bcsm2422680wrz.71.2023.07.20.15.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 15:22:11 -0700 (PDT)
Date: Thu, 20 Jul 2023 18:22:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
 slp@redhat.com, marcandre.lureau@redhat.com,
 viresh.kumar@linaro.org, sgarzare@redhat.com,
 takahiro.akashi@linaro.org, erik.schilling@linaro.org,
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Subject: Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user
Message-ID: <20230720182128-mutt-send-email-mst@kernel.org>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <20230706124347-mutt-send-email-mst@kernel.org>
 <20230720195837.GJ210977@fedora>
 <20230720171321-mutt-send-email-mst@kernel.org>
 <CAJSP0QVDBA0Fb+LVjJVWq7Dp7FosXAJsRJUCcAtdNr-VyzYipg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QVDBA0Fb+LVjJVWq7Dp7FosXAJsRJUCcAtdNr-VyzYipg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Thu, Jul 20, 2023 at 05:31:03PM -0400, Stefan Hajnoczi wrote:
> On Thu, 20 Jul 2023 at 17:15, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jul 20, 2023 at 03:58:37PM -0400, Stefan Hajnoczi wrote:
> > > On Thu, Jul 06, 2023 at 12:48:20PM -0400, Michael S. Tsirkin wrote:
> > > > On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Bennée wrote:
> > > > > Currently QEMU has to know some details about the back-end to be able
> > > > > to setup the guest. While various parts of the setup can be delegated
> > > > > to the backend (for example config handling) this is a very piecemeal
> > > > > approach.
> > > >
> > > > > This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
> > > > > which the back-end can advertise which allows a probe message to be
> > > > > sent to get all the details QEMU needs to know in one message.
> > > >
> > > > The reason we do piecemeal is that these existing pieces can be reused
> > > > as others evolve or fall by wayside.
> > > >
> > > > For example, I can think of instances where you want to connect
> > > > specifically to e.g. networking backend, and specify it
> > > > on command line. Reasons could be many, e.g. for debugging,
> > > > or to prevent connecting to wrong device on wrong channel
> > > > (kind of like type safety).
> > > >
> > > > What is the reason to have 1 message? startup latency?
> > > > How about we allow pipelining several messages then?
> > > > Will be easier.
> > >
> > > This flag effectively says that the back-end is a full VIRTIO device
> > > with a Device Status Register, Configuration Space, Virtqueues, the
> > > device type, etc. This is different from previous vhost-user devices
> > > which sometimes just offloaded certain virtqueues without providing the
> > > full VIRTIO device (parts were emulated in the VMM).
> > >
> > > So for example, a vhost-user-net device does not support the controlq.
> > > Alex's "standalone" device is a mode where the vhost-user protocol is
> > > used but the back-end must implement a full virtio-net device.
> > > Standalone devices are like vDPA device in this respect.
> > >
> > > I think it is important to have a protocol feature bit that advertises
> > > that this is a standalone device, since the semantics are different for
> > > traditional vhost-user-net devices.
> >
> > Not sure what that would gain as compared to a feature bit per
> > message as we did previously.
> 
> Having a single feature bit makes it easier to distinguish between a
> traditional vhost-user device and a standalone device.
> 
> For example, the presence of VHOST_USER_F_GET_DEVICE_ID doesn't tell
> you whether this device is a standalone device that is appropriate for
> a new generic QEMU --device vhost-user-device feature that Alex is
> working on. It could be a traditional vhost-user device that is not
> standalone but implements the VHOST_USER_GET_DEVICE_ID message.
> 
> How will we detect standalone devices? It will be messy if there is no
> single feature bit that advertises that this back-end is a standalone
> device.
> 
> Stefan

Looks like standalone implies some 5-6 messages to be supported.
So just test the 6 bits are all ones.

-- 
MST


