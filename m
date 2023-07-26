Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B14B8763C0D
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 18:11:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOgyU-0002EE-7o; Wed, 26 Jul 2023 12:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qOgyS-0002DJ-O9
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:02:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qOgyR-0004dZ-6q
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690387370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rZZLy8l+7VAilXfQQ7ZH9vv3kVijAPeW8XYe8UBV+I4=;
 b=YITzHG+hp9kV8Vx8Qx6nKEkW+NoM6jNckoXliZEXhiGV6TQRfwDbjp+K2+oe+AZcj7PDUL
 BYxn/b10NRVnSkhLiEJ5yGFnSQFtT0vmavp3lLS3tFQ0889vhigjmLTN6Or0OQzObDa0nw
 BiXICrS3FThsAceTfjaDhgtiL18HsH4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-jt65U20yMhqLJVXHFSVoeQ-1; Wed, 26 Jul 2023 12:02:47 -0400
X-MC-Unique: jt65U20yMhqLJVXHFSVoeQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31444df0fafso3972705f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 09:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690387366; x=1690992166;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rZZLy8l+7VAilXfQQ7ZH9vv3kVijAPeW8XYe8UBV+I4=;
 b=KO4otHJ3z3jZ/oVKSCN0SGny4XFCQQ1wbsWgvLbIT07wsbU4Sy3tu2KOk96fwMOQ4q
 lZ4xejY2kFKW8zOKWUuR38n4ppQQAkK6kb7WpKjXhUHL4Nbykk6wAX7RKGt3fadj9BjG
 NuGvG14v66NbXpNueonp/3JolAotuU+T/uKKyKI+sG78IBzr3wmFH3Zl0inY6WKjP2VZ
 1Pf6ShrPnjHzuA64l0lF9mZ8k01j4rNbj6wI480cHOOZzo0rS/pm82hYUCHklI35vN4d
 uQlKKWbHXorRGo2Ax+3782hmH9xIX2k+Rn3m8xIcgwy7yprUVd7JMrHjVj1dY4tNf1AZ
 Vo3w==
X-Gm-Message-State: ABy/qLYG1ALNMWP1glzYMCdYm6hnjY7NzY+aDqsGEWpYWG1db+DRwWsZ
 bGW/PJSFQDBUWS4ajQjqTpSNYn/ZFrvgca0IwLHY/7Fz61RvfyOwMabR3jH8MjGxJucjPgM+0/r
 jvjUN2rwACDGkfkk=
X-Received: by 2002:a5d:6a85:0:b0:317:61d8:3c7e with SMTP id
 s5-20020a5d6a85000000b0031761d83c7emr1689615wru.26.1690387365978; 
 Wed, 26 Jul 2023 09:02:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlENEFAIWEpwv+cBFcnxTKpWLe+SVN6Bhmmem6FbzFvp+dXBQq4UD/En9Br0bdMc6cm8D1+Flg==
X-Received: by 2002:a5d:6a85:0:b0:317:61d8:3c7e with SMTP id
 s5-20020a5d6a85000000b0031761d83c7emr1689587wru.26.1690387365626; 
 Wed, 26 Jul 2023 09:02:45 -0700 (PDT)
Received: from redhat.com ([2.52.14.22]) by smtp.gmail.com with ESMTPSA id
 h7-20020adfe987000000b003176aa612b1sm6276117wrm.38.2023.07.26.09.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 09:02:44 -0700 (PDT)
Date: Wed, 26 Jul 2023 12:02:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
 slp@redhat.com, marcandre.lureau@redhat.com,
 viresh.kumar@linaro.org, sgarzare@redhat.com,
 takahiro.akashi@linaro.org, erik.schilling@linaro.org,
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Subject: Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user
Message-ID: <20230726120158-mutt-send-email-mst@kernel.org>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <20230706124347-mutt-send-email-mst@kernel.org>
 <20230720195837.GJ210977@fedora>
 <20230720171321-mutt-send-email-mst@kernel.org>
 <CAJSP0QVDBA0Fb+LVjJVWq7Dp7FosXAJsRJUCcAtdNr-VyzYipg@mail.gmail.com>
 <20230720182128-mutt-send-email-mst@kernel.org>
 <20230724180839.GC222590@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230724180839.GC222590@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Mon, Jul 24, 2023 at 02:08:39PM -0400, Stefan Hajnoczi wrote:
> On Thu, Jul 20, 2023 at 06:22:08PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 20, 2023 at 05:31:03PM -0400, Stefan Hajnoczi wrote:
> > > On Thu, 20 Jul 2023 at 17:15, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Jul 20, 2023 at 03:58:37PM -0400, Stefan Hajnoczi wrote:
> > > > > On Thu, Jul 06, 2023 at 12:48:20PM -0400, Michael S. Tsirkin wrote:
> > > > > > On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Bennée wrote:
> > > > > > > Currently QEMU has to know some details about the back-end to be able
> > > > > > > to setup the guest. While various parts of the setup can be delegated
> > > > > > > to the backend (for example config handling) this is a very piecemeal
> > > > > > > approach.
> > > > > >
> > > > > > > This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
> > > > > > > which the back-end can advertise which allows a probe message to be
> > > > > > > sent to get all the details QEMU needs to know in one message.
> > > > > >
> > > > > > The reason we do piecemeal is that these existing pieces can be reused
> > > > > > as others evolve or fall by wayside.
> > > > > >
> > > > > > For example, I can think of instances where you want to connect
> > > > > > specifically to e.g. networking backend, and specify it
> > > > > > on command line. Reasons could be many, e.g. for debugging,
> > > > > > or to prevent connecting to wrong device on wrong channel
> > > > > > (kind of like type safety).
> > > > > >
> > > > > > What is the reason to have 1 message? startup latency?
> > > > > > How about we allow pipelining several messages then?
> > > > > > Will be easier.
> > > > >
> > > > > This flag effectively says that the back-end is a full VIRTIO device
> > > > > with a Device Status Register, Configuration Space, Virtqueues, the
> > > > > device type, etc. This is different from previous vhost-user devices
> > > > > which sometimes just offloaded certain virtqueues without providing the
> > > > > full VIRTIO device (parts were emulated in the VMM).
> > > > >
> > > > > So for example, a vhost-user-net device does not support the controlq.
> > > > > Alex's "standalone" device is a mode where the vhost-user protocol is
> > > > > used but the back-end must implement a full virtio-net device.
> > > > > Standalone devices are like vDPA device in this respect.
> > > > >
> > > > > I think it is important to have a protocol feature bit that advertises
> > > > > that this is a standalone device, since the semantics are different for
> > > > > traditional vhost-user-net devices.
> > > >
> > > > Not sure what that would gain as compared to a feature bit per
> > > > message as we did previously.
> > > 
> > > Having a single feature bit makes it easier to distinguish between a
> > > traditional vhost-user device and a standalone device.
> > > 
> > > For example, the presence of VHOST_USER_F_GET_DEVICE_ID doesn't tell
> > > you whether this device is a standalone device that is appropriate for
> > > a new generic QEMU --device vhost-user-device feature that Alex is
> > > working on. It could be a traditional vhost-user device that is not
> > > standalone but implements the VHOST_USER_GET_DEVICE_ID message.
> > > 
> > > How will we detect standalone devices? It will be messy if there is no
> > > single feature bit that advertises that this back-end is a standalone
> > > device.
> > > 
> > > Stefan
> > 
> > Looks like standalone implies some 5-6 messages to be supported.
> > So just test the 6 bits are all ones.
> 
> It's not clear to me that the individual bits together mean this is
> really a standalone device, but let's go with individual commands and
> see if a front-end can distinguish standalone devices or not. If not,
> then we can still add "standalone" feature bit before merging the code.
> 
> Stefan


I think it just shows that what a "standalone" device is just isn't
that well defined ;).

-- 
MST


