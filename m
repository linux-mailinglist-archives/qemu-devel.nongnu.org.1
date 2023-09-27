Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB727AFDFD
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 10:15:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlPgO-0004ET-Rg; Wed, 27 Sep 2023 04:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qlPgJ-0004E9-Ki
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 04:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qlPgG-0008Q8-7v
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 04:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695802437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TkjFzJURATKjLxqpE2Kp+Y0d5bzgUn0t6ifTdy35ehA=;
 b=YZ0B9dMXC16Qe/3gu7unUw4zUo7tkPGr5Rodo1vqGA+sverZ/+5NP6bGih1qGcE1DOW6J/
 G/IcegxMKQuboEDWv1BCW38SIoEPF6VfdbNRSK6OyBWH2enHA8Fqx9XtCbQq9401p8n4fO
 f8e2qxYKt15ULQVZefFBLBukdNzL5OI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-06P5vaPrOeqd5nt9jYd99Q-1; Wed, 27 Sep 2023 04:13:56 -0400
X-MC-Unique: 06P5vaPrOeqd5nt9jYd99Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe182913c5so97070195e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 01:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695802435; x=1696407235;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TkjFzJURATKjLxqpE2Kp+Y0d5bzgUn0t6ifTdy35ehA=;
 b=Slo5taRnbsBXYucQo+gDL89N2JKQnNpL9y7DvA5MOkB0St5s5QT73RufBp5wwt1Kq6
 Uq5UYgT2oKA2sSZDXhnVH2FRMKOmwgztWSpcCpaBlIobd52AzFQ/Qjq4cM6extbRl9ug
 RL0A5EYX0S8QTLbILXryr33/AnGM2O0UiX3/E/1bu5h9ifMvKw1k79Oea+naYK4M4QxQ
 1Os60zp6JaDkSwnLjTVRLYm3gy15GEFDXBoHKFOTyAXlnJ5OQ9PfFxW+uUt/4g7tzGqP
 uA0AJSu2B2Yg1sgJeZGZ9WmI9AGZbIeigRjaMFaz/LnpqQif/zA20SMeNMBU3wKbc1Jd
 K8og==
X-Gm-Message-State: AOJu0YzMOGBAhcWESgVpXw5EMkGqsOp6SxyzpyRae2yl+gs4ubBOnuaG
 5h/SRQYLH1KxJMZh0FljaLpj5+RBacCUt5lGVhvPeFXTTmBMYeZIsc7pP/94kr2tUbXd1CPWdbL
 vi9jul3iosEmM3yE=
X-Received: by 2002:a05:600c:141:b0:402:e68f:888c with SMTP id
 w1-20020a05600c014100b00402e68f888cmr1383292wmm.7.1695802434918; 
 Wed, 27 Sep 2023 01:13:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyVrAwXfsRSE4K+rSPfCUTmdI3HcePVC2DpuRlrG+4XSQ5HPc1oiyvCojB12cRRaEJETb93A==
X-Received: by 2002:a05:600c:141:b0:402:e68f:888c with SMTP id
 w1-20020a05600c014100b00402e68f888cmr1383270wmm.7.1695802434413; 
 Wed, 27 Sep 2023 01:13:54 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 g10-20020a05600c308a00b003fee8793911sm13687555wmn.44.2023.09.27.01.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 01:13:53 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------UnQbM7jNXFMeXGQcfcN0W0uS"
Message-ID: <565ce7ae-d0a1-c40f-f57b-4dc11234e4b0@redhat.com>
Date: Wed, 27 Sep 2023 10:13:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Virtio-fs] [PATCH v3 0/5] vhost-user: Back-end state migration
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "open list:virtiofs" <virtio-fs@redhat.com>,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>
References: <20230915102531.55894-1-hreitz@redhat.com>
 <20230925204852.GG323580@fedora>
 <fc005d50-03ba-0b8f-d9af-64a5297395a3@redhat.com>
 <CAJSP0QWwo6rqwY7F-OZgXBnRCLbF4C=66zLf35Jy43jKHebjDw@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAJSP0QWwo6rqwY7F-OZgXBnRCLbF4C=66zLf35Jy43jKHebjDw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------UnQbM7jNXFMeXGQcfcN0W0uS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.09.23 21:20, Stefan Hajnoczi wrote:
>
>
> On Tue, Sep 26, 2023, 09:33 Hanna Czenczek <hreitz@redhat.com> wrote:
>
>     On 25.09.23 22:48, Stefan Hajnoczi wrote:
>     > On Fri, Sep 15, 2023 at 12:25:25PM +0200, Hanna Czenczek wrote:
>     >> RFC:
>     >>
>     https://lists.nongnu.org/archive/html/qemu-devel/2023-03/msg04263.html
>     >>
>     >> v1:
>     >>
>     https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg01575.html
>     >>
>     >> v2:
>     >>
>     https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg02604.html
>     >>
>     >> Hi,
>     >>
>     >> I’ve decided not to work on vhost-user SUSPEND/RESUME for now –
>     it is
>     >> not technically required for virtio-fs migration, which is the
>     actual
>     >> priority for me now.  While we do want to have SUSPEND/RESUME
>     at some
>     >> point, the only practically existing reason for it is to be able to
>     >> implement vhost-level resetting in virtiofsd, but that is not
>     related to
>     >> migration.
>     > QEMU sends VHOST_USER_SET_STATUS 0 in vhost_dev_stop(). Are you
>     assuming
>     > that virtiofs back-ends do not reset the device upon receiving this
>     > message?
>
>
>     Absolutely.  vhost_dev_stop() is not in the migration-specific
>     path, but
>     is called whenever the vCPUs are stopped, which indeed happens to be
>     part of migration, but is also used in other cases, like QMP
>     stop.  We
>     have identified that it is wrong that we reset the back-end just
>     because
>     the vCPUs are stopped (e.g. on migration), but it is what we do right
>     now when the VM is paused (e.g. through QMP stop).
>
>     Therefore, stateful back-ends cannot implement reset lest stop/cont
>     breaks the device.  I don’t think anybody really cares whether a
>     vhost-user back-end actually resets its internal state (if there
>     is any)
>     when the guest driver asks for a reset on the virtio level, as
>     long as
>     the guest driver is then able to initialize the device afterwards.
>
>
> Some devices send configuration change notifications. For example, 
> virtio-net speed and duplex changes.
>
> Imagine a network boot ROM runs and the firmware resets the virtio-net 
> device when transferring control to the loaded kernel. Before the 
> kernel driver initializes the device again, the vhost-user-net 
> back-end reports a speed or duplex change and sends a Configuration 
> Change Notification to the guest. The guest receives a spurious 
> interrupt because the vhost-user-net device wasn't actually reset.

I don’t see how this relates to my argument that no stateful back-end 
can implement a full reset because doing so would break stop/cont.

If vhost-user-net were stateful (which it isn’t, AFAIK), it could choose 
to implement a work-around such that it would stop sending notifications 
on reset, but not reset its internal state.  Then, when qemu restores 
vring state in vhost_dev_start(), it would resume sending 
notifications.  But again, I fail to see how this is not already an 
issue for stop/cont.

> I'm concerned that ignoring reset matters (admittedly in corner cases) 
> and think that stateful device functionality shouldn't be added to the 
> vhost-user protocol without a solution for reset.

I disagree.  We have a stateful device already, whether we add 
functionality acknowledging this to the protocol or not.  The problem 
exists.  It is independent of migration.  If there’s a problem because 
of this with migration, there’s a problem with stop/cont, too, that must 
already have been worked around.

> This patch series changes the vhost-user protocol, which is used by 
> many different devices, not just virtiofs. The solution should work 
> for vhost-user devices of any type and not be based on what we can get 
> away with when running the current QEMU + virtiofsd.

My argument was generic.  Any existing stateful device implementation 
must implement reset in such a way that it won’t break stop/cont, i.e., 
it must not reset its internal state.

>
>     I do
>     think people care that stop/cont works, so it follows to me that no
>     stateful back-end will reset its internal state when receiving a
>     virtio/vhost reset.  If they do, stop/cont breaks, which is a
>     user-visible bug that needs to be addressed – either properly by
>     implementing SUSPEND/RESUME in both qemu and the affected
>     back-ends, or
>     by using a similar work-around to virtiofsd, which is to ignore reset
>     commands.
>
>
> Properly, please.

You misunderstand me.  I’m not presenting the choice I have.  I’m 
presenting the choices existing implementations *have had until this 
point*.  *None* chose to do it properly.  I don’t know of stateful 
implementations besides virtiofsd, but virtiofsd chose to be content 
with not implementing reset and thus having things “just work”.

The work-arounds must exist already.

>
>
>     It’s hard for me to imagine that people don’t care that stop/cont
>     breaks
>     some vhost-user back-end, but suddenly would start to care that
>     migration doesn’t work – especially given that first of all
>     someone will
>     need to manually implement any migration support in that back-end
>     even
>     with this series, which means that really, the only back-end we are
>     talking about here is our virtiofsd.  To this day I’m not even
>     aware of
>     any other back-end that has internal state.
>
>
> Another one I can think of is vhost-user-gpu.

I sure hope stop/cont works for them.

> Why did you give up on implementing SUSPEND/RESUME?

Because I think it’s unnecessary for implementing migration, and 
migration is what’s on my priority list.  None of these issues are new, 
they have always existed with stop/cont, work-arounds must be in place 
to make stop/cont work, and because I don’t see the difference in how 
stop/cont is used outside of migration and how it is used during 
migration, I assume those work-arounds must work for migration as well.

Implementing virtio-fs migration is a chain of dependencies.  We need at 
least the specification to be in qemu before we can start sending merge 
requests to the vhost Rust crates to implement support there.  We need 
that support there before we can make the changes to virtiofsd.

Adding SUSPEND/RESUME adds another hard dependency to the whole 
discussion (this would have to go on before this series), which has 
proven absolutely clearly in the past months that it is a very complex 
finnicky isue that would take a ton of time still.  And I can’t justify 
that for myself, given that I don’t see any practically existing problem.

PS: As far as I remember, vhost-user doesn’t even have a working reset 
today.  vhost_dev_stop() calls vhost_reset_status(), which is a no-op 
unless the back-end supports SET_STATUS.  The only back-end 
implementation we found (while discussing SUSPEND/RESUME) to support 
SET_STATUS was dpdk, but while it logs SET_STATUS 0 as a reset, it 
doesn’t do a reset, i.e. doesn’t call reset_device(), which it would do 
on RESET_OWNER.

Hanna
--------------UnQbM7jNXFMeXGQcfcN0W0uS
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 26.09.23 21:20, Stefan Hajnoczi
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAJSP0QWwo6rqwY7F-OZgXBnRCLbF4C=66zLf35Jy43jKHebjDw@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr">
          <div dir="ltr">
            <div dir="auto">
              <div><br>
                <br>
                <div class="gmail_quote">
                  <div dir="ltr" class="gmail_attr">On Tue, Sep 26,
                    2023, 09:33 Hanna Czenczek &lt;<a
                      href="mailto:hreitz@redhat.com" target="_blank"
                      moz-do-not-send="true"
                      class="moz-txt-link-freetext">hreitz@redhat.com</a>&gt;
                    wrote:<br>
                  </div>
                  <blockquote class="gmail_quote" style="margin:0px 0px
                    0px 0.8ex;border-left:1px solid
                    rgb(204,204,204);padding-left:1ex">On 25.09.23
                    22:48, Stefan Hajnoczi wrote:<br>
                    &gt; On Fri, Sep 15, 2023 at 12:25:25PM +0200, Hanna
                    Czenczek wrote:<br>
                    &gt;&gt; RFC:<br>
                    &gt;&gt; <a
href="https://lists.nongnu.org/archive/html/qemu-devel/2023-03/msg04263.html"
                      rel="noreferrer noreferrer" target="_blank"
                      moz-do-not-send="true"
                      class="moz-txt-link-freetext">https://lists.nongnu.org/archive/html/qemu-devel/2023-03/msg04263.html</a><br>
                    &gt;&gt;<br>
                    &gt;&gt; v1:<br>
                    &gt;&gt; <a
href="https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg01575.html"
                      rel="noreferrer noreferrer" target="_blank"
                      moz-do-not-send="true"
                      class="moz-txt-link-freetext">https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg01575.html</a><br>
                    &gt;&gt;<br>
                    &gt;&gt; v2:<br>
                    &gt;&gt; <a
href="https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg02604.html"
                      rel="noreferrer noreferrer" target="_blank"
                      moz-do-not-send="true"
                      class="moz-txt-link-freetext">https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg02604.html</a><br>
                    &gt;&gt;<br>
                    &gt;&gt; Hi,<br>
                    &gt;&gt;<br>
                    &gt;&gt; I’ve decided not to work on vhost-user
                    SUSPEND/RESUME for now – it is<br>
                    &gt;&gt; not technically required for virtio-fs
                    migration, which is the actual<br>
                    &gt;&gt; priority for me now.  While we do want to
                    have SUSPEND/RESUME at some<br>
                    &gt;&gt; point, the only practically existing reason
                    for it is to be able to<br>
                    &gt;&gt; implement vhost-level resetting in
                    virtiofsd, but that is not related to<br>
                    &gt;&gt; migration.<br>
                    &gt; QEMU sends VHOST_USER_SET_STATUS 0 in
                    vhost_dev_stop(). Are you assuming<br>
                    &gt; that virtiofs back-ends do not reset the device
                    upon receiving this<br>
                    &gt; message?<br>
                  </blockquote>
                </div>
              </div>
              <div dir="auto">
                <div class="gmail_quote">
                  <blockquote class="gmail_quote" style="margin:0px 0px
                    0px 0.8ex;border-left:1px solid
                    rgb(204,204,204);padding-left:1ex">
                    <br>
                    Absolutely.  vhost_dev_stop() is not in the
                    migration-specific path, but <br>
                    is called whenever the vCPUs are stopped, which
                    indeed happens to be <br>
                    part of migration, but is also used in other cases,
                    like QMP stop.  We <br>
                    have identified that it is wrong that we reset the
                    back-end just because <br>
                    the vCPUs are stopped (e.g. on migration), but it is
                    what we do right <br>
                    now when the VM is paused (e.g. through QMP stop).<br>
                    <br>
                    Therefore, stateful back-ends cannot implement reset
                    lest stop/cont <br>
                    breaks the device.  I don’t think anybody really
                    cares whether a <br>
                    vhost-user back-end actually resets its internal
                    state (if there is any) <br>
                    when the guest driver asks for a reset on the virtio
                    level, as long as <br>
                    the guest driver is then able to initialize the
                    device afterwards.</blockquote>
                  <div><br>
                  </div>
                  <div>Some devices send configuration change
                    notifications. For example, virtio-net speed and
                    duplex changes.</div>
                  <div><br>
                  </div>
                  <div>Imagine a network boot ROM runs and the firmware
                    resets the virtio-net device when transferring
                    control to the loaded kernel. Before the kernel
                    driver initializes the device again, the
                    vhost-user-net back-end reports a speed or duplex
                    change and sends a Configuration Change Notification
                    to the guest. The guest receives a spurious
                    interrupt because the vhost-user-net device wasn't
                    actually reset.</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    I don’t see how this relates to my argument that no stateful
    back-end can implement a full reset because doing so would break
    stop/cont.<br>
    <br>
    If vhost-user-net were stateful (which it isn’t, AFAIK), it could
    choose to implement a work-around such that it would stop sending
    notifications on reset, but not reset its internal state.  Then,
    when qemu restores vring state in vhost_dev_start(), it would resume
    sending notifications.  But again, I fail to see how this is not
    already an issue for stop/cont.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAJSP0QWwo6rqwY7F-OZgXBnRCLbF4C=66zLf35Jy43jKHebjDw@mail.gmail.com">
      <div dir="ltr">
        <div dir="ltr">
          <div dir="ltr">
            <div dir="auto">
              <div dir="auto">
                <div class="gmail_quote">
                  <div>I'm concerned that ignoring reset matters
                    (admittedly in corner cases) and think that stateful
                    device functionality shouldn't be added to the
                    vhost-user protocol without a solution for reset.</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    I disagree.  We have a stateful device already, whether we add
    functionality acknowledging this to the protocol or not.  The
    problem exists.  It is independent of migration.  If there’s a
    problem because of this with migration, there’s a problem with
    stop/cont, too, that must already have been worked around.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAJSP0QWwo6rqwY7F-OZgXBnRCLbF4C=66zLf35Jy43jKHebjDw@mail.gmail.com">
      <div dir="ltr">
        <div dir="ltr">
          <div dir="ltr">
            <div dir="auto">
              <div dir="auto">
                <div class="gmail_quote">
                  <div>This patch series changes the vhost-user
                    protocol, which is used by many different devices,
                    not just virtiofs. The solution should work for
                    vhost-user devices of any type and not be based on
                    what we can get away with when running the current
                    QEMU + virtiofsd.<br>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    My argument was generic.  Any existing stateful device
    implementation must implement reset in such a way that it won’t
    break stop/cont, i.e., it must not reset its internal state.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAJSP0QWwo6rqwY7F-OZgXBnRCLbF4C=66zLf35Jy43jKHebjDw@mail.gmail.com">
      <div dir="ltr">
        <div dir="ltr">
          <div dir="ltr">
            <div dir="auto">
              <div dir="auto">
                <div class="gmail_quote">
                  <div><br>
                  </div>
                  <blockquote class="gmail_quote" style="margin:0px 0px
                    0px 0.8ex;border-left:1px solid
                    rgb(204,204,204);padding-left:1ex">I do <br>
                    think people care that stop/cont works, so it
                    follows to me that no <br>
                    stateful back-end will reset its internal state when
                    receiving a <br>
                    virtio/vhost reset.  If they do, stop/cont breaks,
                    which is a <br>
                    user-visible bug that needs to be addressed – either
                    properly by <br>
                    implementing SUSPEND/RESUME in both qemu and the
                    affected back-ends, or <br>
                    by using a similar work-around to virtiofsd, which
                    is to ignore reset <br>
                    commands.<br>
                  </blockquote>
                </div>
              </div>
              <div dir="auto"><br>
              </div>
              <div>Properly, please.<br>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    You misunderstand me.  I’m not presenting the choice I have.  I’m
    presenting the choices existing implementations *have had until this
    point*.  *None* chose to do it properly.  I don’t know of stateful
    implementations besides virtiofsd, but virtiofsd chose to be content
    with not implementing reset and thus having things “just work”.<br>
    <br>
    The work-arounds must exist already.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAJSP0QWwo6rqwY7F-OZgXBnRCLbF4C=66zLf35Jy43jKHebjDw@mail.gmail.com">
      <div dir="ltr">
        <div dir="ltr">
          <div dir="ltr">
            <div dir="auto">
              <div dir="auto"><br>
              </div>
              <div dir="auto">
                <div class="gmail_quote">
                  <blockquote class="gmail_quote" style="margin:0px 0px
                    0px 0.8ex;border-left:1px solid
                    rgb(204,204,204);padding-left:1ex">
                    <br>
                    It’s hard for me to imagine that people don’t care
                    that stop/cont breaks <br>
                    some vhost-user back-end, but suddenly would start
                    to care that <br>
                    migration doesn’t work – especially given that first
                    of all someone will <br>
                    need to manually implement any migration support in
                    that back-end even <br>
                    with this series, which means that really, the only
                    back-end we are <br>
                    talking about here is our virtiofsd.  To this day
                    I’m not even aware of <br>
                    any other back-end that has internal state.<br>
                  </blockquote>
                  <div><br>
                  </div>
                  <div>Another one I can think of is vhost-user-gpu.</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    I sure hope stop/cont works for them.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAJSP0QWwo6rqwY7F-OZgXBnRCLbF4C=66zLf35Jy43jKHebjDw@mail.gmail.com">
      <div dir="ltr">
        <div dir="ltr">
          <div dir="ltr">
            <div dir="auto">
              <div dir="auto">
                <div class="gmail_quote">
                  <div>Why did you give up on implementing
                    SUSPEND/RESUME?<br>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    Because I think it’s unnecessary for implementing migration, and
    migration is what’s on my priority list.  None of these issues are
    new, they have always existed with stop/cont, work-arounds must be
    in place to make stop/cont work, and because I don’t see the
    difference in how stop/cont is used outside of migration and how it
    is used during migration, I assume those work-arounds must work for
    migration as well.<br>
    <br>
    Implementing virtio-fs migration is a chain of dependencies.  We
    need at least the specification to be in qemu before we can start
    sending merge requests to the vhost Rust crates to implement support
    there.  We need that support there before we can make the changes to
    virtiofsd.<br>
    <br>
    Adding SUSPEND/RESUME adds another hard dependency to the whole
    discussion (this would have to go on before this series), which has
    proven absolutely clearly in the past months that it is a very
    complex finnicky isue that would take a ton of time still.  And I
    can’t justify that for myself, given that I don’t see any
    practically existing problem.<br>
    <br>
    PS: As far as I remember, vhost-user doesn’t even have a working
    reset today.  vhost_dev_stop() calls vhost_reset_status(), which is
    a no-op unless the back-end supports SET_STATUS.  The only back-end
    implementation we found (while discussing SUSPEND/RESUME) to support
    SET_STATUS was dpdk, but while it logs SET_STATUS 0 as a reset, it
    doesn’t do a reset, i.e. doesn’t call reset_device(), which it would
    do on RESET_OWNER.<br>
    <br>
    Hanna<br>
  </body>
</html>

--------------UnQbM7jNXFMeXGQcfcN0W0uS--


