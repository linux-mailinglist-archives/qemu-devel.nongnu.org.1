Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE777C88E3
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:40:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrKGS-0008DL-RE; Fri, 13 Oct 2023 11:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKGB-0008Cx-Qb
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:39:33 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKG9-0004G3-7a
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:39:31 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3231dff4343so1459805f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 08:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697211566; x=1697816366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQIxvvIWlTQ0TufsfbYrkO0pdzMtxEVo3MShesomyWA=;
 b=e8pbxi0M1SECJIxKsQ/1kA+DPlMFAWytMjUrwsTilyd7RBgO4BU4JRV99L8BPhHk/O
 UGuKby35GciwefuZTrkGyv79S6sevcPPKrSGMvi+vwjKQqOGf3vXsTS5vzJtiGo/E/ad
 /dR1WCHhVwbqfl8uf7mUMc/vEQ7n5vnnLJ8in5CAeTHMu8SAJvrxTU9FlqGJMrrxIxJu
 6oruE2V1VXB/R307vRwpZMNsfJiT6nTOHtZkkcW+vzzei9aXBsU0BTkjUTtbAI9+5wiF
 KU0DViZQrbWdVp0ep1D6UHUNHCStuPFFi1UGQWAnM6E0dXK73OEWvGo0BsGM2EXDGICt
 HU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697211566; x=1697816366;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cQIxvvIWlTQ0TufsfbYrkO0pdzMtxEVo3MShesomyWA=;
 b=TErA4ZMkFGqRAlKqIxFlxQuvLtlJZ7JIB/tM4VNVG3dmlu3HboYC8riM7uQ7FSbEM/
 eSCPWrmUqDiuen3HIZdPODbb4x+tDfdGUJ6oaMt55YWy/rU6ClkfQ7zW1iUQ2z+QkL3J
 bcRm+SdsKjLV4CHZdCNUIEoGY3kxplugE128C73SFlFzc0EJO6ZDalQ1F0j3pU10+6Nj
 YumAcTDOwpFdrDsJGd95ftqwM7gTxEnApYFWPBBiBQ9c62wBytiPnHKq5/S3D0XNbLNA
 xYgFdoOT5d29GMnL/irJ2WX7AAgeQdeu0eIICq0d3QjFcVOjauiL9HBfqVXNhoCPtLHc
 VG3Q==
X-Gm-Message-State: AOJu0YxyjLs6GKkFufGcwPQkgSgJRQTl4KdS1V1uvGl0wSDyvhnSGOft
 fRAXm692OgBG4mMJr3LRUsQNPQ==
X-Google-Smtp-Source: AGHT+IEFgsTcOcnUkR/lqmLAKb59Ksf/auwQopfjKVTjWtWuI403wfyMHneFaa5rXTql8+6aNzKflw==
X-Received: by 2002:adf:8b98:0:b0:31f:f95c:dd7f with SMTP id
 o24-20020adf8b98000000b0031ff95cdd7fmr383736wra.12.1697211565945; 
 Fri, 13 Oct 2023 08:39:25 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a05600c444600b004064288597bsm464289wmn.30.2023.10.13.08.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 08:39:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ECC911FFBB;
 Fri, 13 Oct 2023 16:39:24 +0100 (BST)
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-2-hreitz@redhat.com>
 <20231005170852.GB1342722@fedora>
 <20231005131352-mutt-send-email-mst@kernel.org>
 <00272da3-0a48-5544-6ba8-5dfde00be241@redhat.com>
 <20231006043518-mutt-send-email-mst@kernel.org>
 <a8b9d842-0925-38d0-2f0d-f2560bab251b@redhat.com>
 <20231006051802-mutt-send-email-mst@kernel.org>
 <a4af0357-12ee-fc7f-e249-239da34409b0@redhat.com>
 <20231006055229-mutt-send-email-mst@kernel.org>
 <e35f9f71-8d9d-6250-cbaa-70412b5a1149@nvidia.com>
 <3f28b1a4-d618-39df-57e6-6152f61cac6e@redhat.com>
 <8f3694c1-48d4-f34b-8f91-3bc217182ffa@redhat.com>
 <e19eb113-89b1-92ed-3375-8bc93c1ff39c@redhat.com>
 <8f51f02b-4676-c566-7304-f63e76df74ba@nvidia.com>
 <9a36a319-4567-f297-f14a-2025792ae93f@redhat.com>
 <87lecapxi4.fsf@linaro.org>
 <fbe05651-a65a-23d0-52be-2d611cc5740d@redhat.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 Eugenio =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>,
 "maxime.coquelin@redhat.com"
 <maxime.coquelin@redhat.com>, Parav Pandit <parav@nvidia.com>, Anton
 Kuchin <antonkuchin@yandex-team.ru>, Yajun Wu <yajunw@nvidia.com>, Viresh
 Kumar <viresh.kumar@linaro.org>
Subject: Re: [Virtio-fs] (no subject)
Date: Tue, 10 Oct 2023 15:35:28 +0100
In-reply-to: <fbe05651-a65a-23d0-52be-2d611cc5740d@redhat.com>
Message-ID: <87lec6mt03.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


Hanna Czenczek <hreitz@redhat.com> writes:

(adding Viresh to CC for Xen Vhost questions)

> On 10.10.23 12:36, Alex Benn=C3=A9e wrote:
>> Hanna Czenczek <hreitz@redhat.com> writes:
>>
>>> On 10.10.23 06:00, Yajun Wu wrote:
>>>> On 10/9/2023 5:13 PM, Hanna Czenczek wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On 09.10.23 11:07, Hanna Czenczek wrote:
>>>>>> On 09.10.23 10:21, Hanna Czenczek wrote:
>>>>>>> On 07.10.23 04:22, Yajun Wu wrote:
>>>>>> [...]
>>>>>>
>> <snip>
>>> So as far as I understand, the feature is supposed to rely on
>>> implementation-specific behavior between specifically qemu as a
>>> front-end and dpdk as a back-end, nothing else.=C2=A0 Honestly, that to=
 me
>>> is a very good reason to deprecate it.=C2=A0 That would make it clear t=
hat
>>> any implementation that implements it does so because it relies on
>>> implementation-specific behavior from other implementations.
>>>
>>> Option 2 is to fix it.=C2=A0 It is not right to use this broadly defined
>>> feature with its clear protocol as given in the virtio specification
>>> just to set and clear a single bit (DRIVER_OK).=C2=A0 The vhost-user
>>> specification points to that virtio protocol.=C2=A0 We must adhere to t=
he
>>> protocol.=C2=A0 And note that we must not reset devices just because th=
e VM
>>> is paused/resumed.=C2=A0 (That is why I wanted to deprecate SET_STATUS,=
 so
>>> that Stefan=E2=80=99s series would introduce RESET_DEVICE where we need=
 it,
>>> and we can (for now) ignore the SET_STATUS 0 in vhost_dev_stop().)
>>>
>>> Option 3 would be to just be honest in the specification, and limit
>>> the scope of F_STATUS to say the only bit that matters is DRIVER_OK.
>>> I would say this is not really different from deprecating, though it
>>> wouldn=E2=80=99t affect your case.=C2=A0 However, I understand Alex rel=
ies on a
>>> full status byte.=C2=A0 I=E2=80=99m still interested to know why that i=
s.
>> For an F_TRANSPORT backend (or whatever the final name ends up being) we
>> need the backend to have full control of the status byte because all the
>> handling of VirtIO is deferred to it. Therefor it has to handle all the
>> feature negotiation and indicate when the device needs resetting.
>>
>> (side note: feature negotiation is another slippery area when QEMU gets
>> involved in gating which feature bits may or may not be exposed to the
>> backend. The only one it should ever mask is F_UNUSED which is used
>> (sic) to trigger the vhost protocol negotiation)
>
> That=E2=80=99s the thing, feature negotiation is done with GET_FEATURES a=
nd
> SET_FEATURES.=C2=A0 Configuring F_REPLY_ACK lets SET_FEATURES return
> errors.

OK but then what - QEMU fakes up FEATURES_OK in the Device Status field
on the behalf of the backend?

I should point out QEMU doesn't exist in some of these use case. When
using the rust-vmm backends with Xen for example there is no VMM to talk
to so we have a Xen Vhost Frontend which is entirely concerned with
setup and then once connected up leaves the backend to do its thing. I'd
rather leave the frontend as dumb as possible rather than splitting
logic between the two.

> Indicating that the device needs reset is a good point, there is no
> other feature to do that.=C2=A0 (And something qemu currently ignores, ju=
st
> like any value the device returns through GET_STATUS, but that=E2=80=99s
> besides the point.)
>
>>> Option 4 is of course not to do anything, and leave everything as-is,
>>> waiting for the next person to stir the hornet=E2=80=99s nest.
>>>
>>>>>> Cc-ing Alex on this mail, because to me, this seems like an important
>>>>>> detail when he plans on using the byte in the future. If we need a
>>>>>> virtio status byte, I can=E2=80=99t see how we could use the existin=
g F_STATUS
>>>>>> for it.
>> What would we use instead of F_STATUS to query the Device Status field?
>
> We would emulate it in the front-end, just like we need to do for
> back-ends without F_STATUS.=C2=A0 We can=E2=80=99t emulate the DEVICE_NEE=
DS_RESET
> bit, though, that=E2=80=99s correct.
>
> Given that qemu currently ignores DEVICE_NEEDS_RESET, I=E2=80=99m not 100=
 %
> convinced that your use case has a hard dependency on F_STATUS.
> However, this still does make a fair point in general that it would be
> useful to keep it.

OK/

> That still leaves us with the situation that currently, the only
> implementations with F_STATUS support are qemu and dpdk, which both
> handle it incorrectly.=C2=A0

I was going to say there is also the rust-vmm vhost-user-master crates
which we've imported:

  https://github.com/vireshk/vhost

for the Xen Vhost Frontend:

  https://github.com/vireshk/xen-vhost-frontend

but I can't actually see any handling for GET/SET_STATUS at all which
makes me wonder how we actually work. Viresh?

> Furthermore, the specification leaves much to
> be desired, specifically in how F_STATUS interacts with other
> vhost-user commands (which is something I cited as a reason for my
> original patch), i.e. whether RESET_DEVICE and SET_STATUS 0 are
> equivalent, and whether failures in feature negotiation must result in
> both SET_FEATURES returning an error (with F_REPLY_ACK), and
> FEATURES_OK being reset in the status byte, or whether either is
> sufficient.=C2=A0 What happens when DEVICE_NEEDS_RESET is set, i.e. do we
> just need RESET_DEVICE / SET_STATUS 0, or do we also need to reset
> some protocol state?=C2=A0 (This is also connected to the fact that what
> happens on RESET_DEVICE is largely undefined, which I said on Stefan=E2=
=80=99s
> series.)

I'm all for strengthening the vhost-user protocol definitions. I'm just
wary of encoding QEMU<->backend implementation details.

> In general, because we have our own transport, we should make a note
> how it interacts with the status negotiation phases, i.e. that
> GET_FEATURES must not be called before S_ACKNOWLEDGE | S_DRIVER are
> set, that FEATURES_OK must be set after the SET_FEATURES call, and
> that DRIVER_OK must not be set without FEATURES_OK set / SET_FEATURES
> having returned success.=C2=A0 Here we would also answer the question abo=
ut
> the interaction of F_REPLY_ACK+SET_FEATURES with F_STATUS,
> specifically whether an implementation with F_REPLY_ACK even needs to
> read back the status byte after setting FEATURES_OK because it could
> have got the feature negotiation result already as a result of the
> SET_FEATURES call.

Some sequence diagrams would remove a lot of the ambiguity from parsing
the words. I wonder if there is a pretty way to do that to render nicely
in our published docs?

> After migration, can you just set all flags immediately or do we need
> to follow this step-by-step protocol?=C2=A0 I think we do need to do it
> step-by-step, mostly for simplicity in the back-end, i.e. that it just
> sees a normal device start-up.

Makes sense.

> We should also clarify whether SET_STATUS can fail, i.e. whether
> setting an invalid status (is setting FEATURES_OK when the device
> doesn=E2=80=99t think so invalid?) has SET_STATUS fail (with F_REPLY_ACK)
> and/or immediately gets the device into DEVICE_NEEDS_RESET.
>
> We should clarify whether SET_STATUS can block.=C2=A0 The current use of
> DRIVER_OK seems to indicate to me that dpdk does do time-consuming
> operations when it sees DRIVER_OK (code looks like it, too) and only
> returns when that=E2=80=99s done, but na=C3=AFvely, I would expect SET_ST=
ATUS to be
> just setting some value and doing whatever needs to be done in the
> background, not actually launching and blocking on an operation.

Shouldn't the guest driver be reading the status bit until it flips? So
potentially there could be multiple GET_STATUS calls.

> I think it is dangerous to just push ahead with using F_STATUS without
> acknowledging that its implementation is broken right now, and that it
> is so *on purpose* because the DRIVER_OK bit is the only thing that it
> was supposed to be used for.=C2=A0 Using it for its purported original use
> (actually the virtio status byte) is contradictory to that.=C2=A0 It=E2=
=80=99s
> probably fixable, but I think it requires taking a step back and
> seeing what needs to be done to remedy the conflict.=C2=A0 If you rip out
> all the existing STATUS code and replace it such that qemu will let
> the guest have full control over the status byte (except for
> migration, where we restore it on the destination, which will result
> in DRIVER_OK being set at the end, fulfilling that requirement), that
> will fix the implementation in qemu.=C2=A0 I think.=C2=A0 But the specifi=
cation
> should be amended to think about all these corner cases, not least
> because I think they will also affect your implementation.
>
> (The answers to many of the questions I raise for documentation may be
> obvious to you, based on =E2=80=9Cin virtio, it=E2=80=99s just an MMIO by=
te that=E2=80=99s
> written and read, so the rest follows from there=E2=80=9D.=C2=A0 But evid=
ently the
> implementation we have kind of ignores that e.g. SET_STATUS 0 is a
> reset (6f8be29ec17d44496b9ed67599bceaaba72d1864 is a work-around, not
> much more) or that there is actually a protocol to setting the status
> flags and you can=E2=80=99t just set them all at once, so I don=E2=80=99t=
 think the
> answers are immediately obvious, and should be documented.)
>
> As for me and the original patch: I claimed nobody really needs
> F_STATUS, you say you do, so plainly, I assumed wrong and will
> naturally take my hands off of F_STATUS and just ensure not to
> implement it in any back-end until you=E2=80=99ve fixed it, as Yajun has
> advised.=C2=A0 I=E2=80=99d still prefer mentioning this advice in the doc=
umentation
> until it=E2=80=99s fixed, but, you know, I wouldn=E2=80=99t be the first =
one to say =E2=80=9CI
> now know about the quirk, so I can work around it, no need to tell
> anyone else as long as my stuff works=E2=80=9D.
>
> Hanna


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

