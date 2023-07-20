Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DB075B996
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 23:33:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMbF6-0000ip-GU; Thu, 20 Jul 2023 17:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qMbF1-0000iW-Km
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 17:31:20 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qMbEz-0004OA-Ux
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 17:31:19 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5607cdb0959so742848eaf.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 14:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689888675; x=1690493475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYnwVoad0z06tEGWWE6B+6FVidBFj6m4jwOyFwM/GMQ=;
 b=suzW1Z+S91eYmQ5/ZmlZjgZ6X4oGfQEMHjzUbCXHEZUQVkQ5loqwgKl57gg0fIX9Qy
 HFm9jq0f8I8ETJpgMlc7JHSiG15w34+D4srpfUoP+tvlcS0cxT9zvFV+5EVxt7ssb7Hb
 LOj6WFJaVVQwZ7CPr00nTlQiyACV8gfQgAAoqF7wAxoT3OxYHf1xmbCI+FZBlrC5g0mV
 N40WpjLjVBP06FM1FnE72/K/oF+e/MKmWmgfWtQI3xL0Wv5aWTgyPtW/V+KAIoHm/2/5
 4oRxCFLgS1qychydt/cYlTHRJy+t4Ker6EcjjvI4Ye1hGUycW1cTlusI+XP78h788oMc
 UsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689888675; x=1690493475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uYnwVoad0z06tEGWWE6B+6FVidBFj6m4jwOyFwM/GMQ=;
 b=ZtbTG84wZia+Vq2iZRKjVGaVt+LaCfcHQrNzHrGzmCV4nEguDgOLOmb9ioMWSZdnx1
 mVxwpyZvMmlzqdOS6cf222uDHB9nkvixf6QHWlVpDkpET8W0Jn6bK43a2/L+/tySGgjZ
 bVolkXujIMbAOUs5FjJ6pzU134K0R+cwQPAL9DcilsaGVLXVtHvJDHCDsUyyvufa9/1Q
 pJElKky0WjzJ9MeJ5nrEKLKHh3LGu79RE+U+VVllOxFAktZIiSCjHgvp0rxalaWY94dB
 E3VvpkN9Wb++JZfEmLvX+Qe8aLXGDoDYGwjMPoS4Qn6SRnEejyCYrQ+lym8/2r8fMQ7H
 +LQA==
X-Gm-Message-State: ABy/qLZnGBGrjRjpn/1gz111kwEHhM508IPfcVDiU6tS+RAYUJpzydXN
 6gSugiJwhP6oOX/fbuTFE73ShtC+Ow4+vVaOf1c=
X-Google-Smtp-Source: APBJJlFHjIt2SUlUPDtrTGr/m0yb/PPL8tPs6Q/0cgZ/Zwgh7RuYmbRAMM3nvIR8DA6mHTcvQDjq4zi4sm1CVRR/u5A=
X-Received: by 2002:a4a:9cc5:0:b0:566:fefe:bea0 with SMTP id
 d5-20020a4a9cc5000000b00566fefebea0mr62155ook.6.1689888675175; Thu, 20 Jul
 2023 14:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <20230706124347-mutt-send-email-mst@kernel.org>
 <20230720195837.GJ210977@fedora>
 <20230720171321-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230720171321-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 20 Jul 2023 17:31:03 -0400
Message-ID: <CAJSP0QVDBA0Fb+LVjJVWq7Dp7FosXAJsRJUCcAtdNr-VyzYipg@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com, 
 marcandre.lureau@redhat.com, viresh.kumar@linaro.org, sgarzare@redhat.com, 
 takahiro.akashi@linaro.org, erik.schilling@linaro.org, 
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 20 Jul 2023 at 17:15, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jul 20, 2023 at 03:58:37PM -0400, Stefan Hajnoczi wrote:
> > On Thu, Jul 06, 2023 at 12:48:20PM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Benn=C3=A9e wrote:
> > > > Currently QEMU has to know some details about the back-end to be ab=
le
> > > > to setup the guest. While various parts of the setup can be delegat=
ed
> > > > to the backend (for example config handling) this is a very pieceme=
al
> > > > approach.
> > >
> > > > This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STAND=
ALONE)
> > > > which the back-end can advertise which allows a probe message to be
> > > > sent to get all the details QEMU needs to know in one message.
> > >
> > > The reason we do piecemeal is that these existing pieces can be reuse=
d
> > > as others evolve or fall by wayside.
> > >
> > > For example, I can think of instances where you want to connect
> > > specifically to e.g. networking backend, and specify it
> > > on command line. Reasons could be many, e.g. for debugging,
> > > or to prevent connecting to wrong device on wrong channel
> > > (kind of like type safety).
> > >
> > > What is the reason to have 1 message? startup latency?
> > > How about we allow pipelining several messages then?
> > > Will be easier.
> >
> > This flag effectively says that the back-end is a full VIRTIO device
> > with a Device Status Register, Configuration Space, Virtqueues, the
> > device type, etc. This is different from previous vhost-user devices
> > which sometimes just offloaded certain virtqueues without providing the
> > full VIRTIO device (parts were emulated in the VMM).
> >
> > So for example, a vhost-user-net device does not support the controlq.
> > Alex's "standalone" device is a mode where the vhost-user protocol is
> > used but the back-end must implement a full virtio-net device.
> > Standalone devices are like vDPA device in this respect.
> >
> > I think it is important to have a protocol feature bit that advertises
> > that this is a standalone device, since the semantics are different for
> > traditional vhost-user-net devices.
>
> Not sure what that would gain as compared to a feature bit per
> message as we did previously.

Having a single feature bit makes it easier to distinguish between a
traditional vhost-user device and a standalone device.

For example, the presence of VHOST_USER_F_GET_DEVICE_ID doesn't tell
you whether this device is a standalone device that is appropriate for
a new generic QEMU --device vhost-user-device feature that Alex is
working on. It could be a traditional vhost-user device that is not
standalone but implements the VHOST_USER_GET_DEVICE_ID message.

How will we detect standalone devices? It will be messy if there is no
single feature bit that advertises that this back-end is a standalone
device.

Stefan

