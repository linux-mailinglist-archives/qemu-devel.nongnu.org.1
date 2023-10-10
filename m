Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AF17BFD2F
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 15:20:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqCdm-0001ro-30; Tue, 10 Oct 2023 09:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qqCdg-0001rI-KF
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qqCdc-00020W-Vz
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696943943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Pi6QvtQ1nli4QHu9oMf2VDMP1Wgd7DI3B0maQoIyE0=;
 b=HqAIaq687N5qSI3m138b+f7t7CE4NuOpzxOWU9qwEWbJFCIONkI/1tekg7XBSl+2NKe2a6
 qj8aocX234hrppwjJz73RcEzd5UtsrSLWSfVts8yXKb9BAZqKMza/81a8xi7vAm9FecLcJ
 1sE4dtTPiWnlekO05X8EeePvgCec5jQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-ojHkiY6DNVmw3IELzk9-eg-1; Tue, 10 Oct 2023 09:19:01 -0400
X-MC-Unique: ojHkiY6DNVmw3IELzk9-eg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32d58708cd5so258180f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 06:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696943940; x=1697548740;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Pi6QvtQ1nli4QHu9oMf2VDMP1Wgd7DI3B0maQoIyE0=;
 b=paQcO2Ety6cyiRIDWEjxygtrkfFaLOBwh5WVEJWbWdn6DQNfE73E6XQwrJaE08w3A4
 xiHv9t1D9QsG476dn3CLPRuz6VqUWxfp8Xj2s8pDmx7/dgqLnQKVjrDgPlbTGiy0liA+
 AZfWw/61iIeiwQ1/i63kEeHcNWtvoErRRzZUijsmsU3Jl3DJvdyHCQyGyTNlwBOelEWK
 24wMOhHq9jAmpzjzpnkoNoeoo7c+uQmdw3hgL2nMgAhrJsbmgKgcn01Iuz9lB54kWDOg
 jFluiijcaecNQ+r4GeBpr4FvZMjn+2lHgl72Mh/LR/QveVGtQYrU0N+rTcq0Cq0ui95t
 tlYA==
X-Gm-Message-State: AOJu0YxFfm0uaCVa/0s56KPmyCi7PvNjV+i+Idau8Zt4WWHjrDd/q2zP
 FD4xN8Wf1GlE43fzRfkQuqij/BgOZsSuQwfx7fY6NbAOqLmmt/hZi/qzOygNW7oKBAQn8bjIgad
 j0EBuVgMIunwy14c=
X-Received: by 2002:a5d:5052:0:b0:31f:fc6c:8b75 with SMTP id
 h18-20020a5d5052000000b0031ffc6c8b75mr15043883wrt.7.1696943940603; 
 Tue, 10 Oct 2023 06:19:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpxiFMb4utvDT6n7Q/jUxcjfYYhkGM999kVxeFgSAuSw122ejrpUGIeNLB7fp+ZefqNWQN2A==
X-Received: by 2002:a5d:5052:0:b0:31f:fc6c:8b75 with SMTP id
 h18-20020a5d5052000000b0031ffc6c8b75mr15043860wrt.7.1696943940088; 
 Tue, 10 Oct 2023 06:19:00 -0700 (PDT)
Received: from ?IPV6:2003:cf:d746:c551:3d67:278e:c0a1:87a2?
 (p200300cfd746c5513d67278ec0a187a2.dip0.t-ipconnect.de.
 [2003:cf:d746:c551:3d67:278e:c0a1:87a2])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a5d66c7000000b0031fd849e797sm12659346wrw.105.2023.10.10.06.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 06:18:59 -0700 (PDT)
Message-ID: <fbe05651-a65a-23d0-52be-2d611cc5740d@redhat.com>
Date: Tue, 10 Oct 2023 15:18:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Virtio-fs] (no subject)
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 Parav Pandit <parav@nvidia.com>, Anton Kuchin <antonkuchin@yandex-team.ru>,
 Yajun Wu <yajunw@nvidia.com>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-2-hreitz@redhat.com> <20231005170852.GB1342722@fedora>
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
 <9a36a319-4567-f297-f14a-2025792ae93f@redhat.com> <87lecapxi4.fsf@linaro.org>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <87lecapxi4.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 10.10.23 12:36, Alex Bennée wrote:
> Hanna Czenczek <hreitz@redhat.com> writes:
>
>> On 10.10.23 06:00, Yajun Wu wrote:
>>> On 10/9/2023 5:13 PM, Hanna Czenczek wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 09.10.23 11:07, Hanna Czenczek wrote:
>>>>> On 09.10.23 10:21, Hanna Czenczek wrote:
>>>>>> On 07.10.23 04:22, Yajun Wu wrote:
>>>>> [...]
>>>>>
> <snip>
>> So as far as I understand, the feature is supposed to rely on
>> implementation-specific behavior between specifically qemu as a
>> front-end and dpdk as a back-end, nothing else.  Honestly, that to me
>> is a very good reason to deprecate it.  That would make it clear that
>> any implementation that implements it does so because it relies on
>> implementation-specific behavior from other implementations.
>>
>> Option 2 is to fix it.  It is not right to use this broadly defined
>> feature with its clear protocol as given in the virtio specification
>> just to set and clear a single bit (DRIVER_OK).  The vhost-user
>> specification points to that virtio protocol.  We must adhere to the
>> protocol.  And note that we must not reset devices just because the VM
>> is paused/resumed.  (That is why I wanted to deprecate SET_STATUS, so
>> that Stefan’s series would introduce RESET_DEVICE where we need it,
>> and we can (for now) ignore the SET_STATUS 0 in vhost_dev_stop().)
>>
>> Option 3 would be to just be honest in the specification, and limit
>> the scope of F_STATUS to say the only bit that matters is DRIVER_OK.
>> I would say this is not really different from deprecating, though it
>> wouldn’t affect your case.  However, I understand Alex relies on a
>> full status byte.  I’m still interested to know why that is.
> For an F_TRANSPORT backend (or whatever the final name ends up being) we
> need the backend to have full control of the status byte because all the
> handling of VirtIO is deferred to it. Therefor it has to handle all the
> feature negotiation and indicate when the device needs resetting.
>
> (side note: feature negotiation is another slippery area when QEMU gets
> involved in gating which feature bits may or may not be exposed to the
> backend. The only one it should ever mask is F_UNUSED which is used
> (sic) to trigger the vhost protocol negotiation)

That’s the thing, feature negotiation is done with GET_FEATURES and 
SET_FEATURES.  Configuring F_REPLY_ACK lets SET_FEATURES return errors.

Indicating that the device needs reset is a good point, there is no 
other feature to do that.  (And something qemu currently ignores, just 
like any value the device returns through GET_STATUS, but that’s besides 
the point.)

>> Option 4 is of course not to do anything, and leave everything as-is,
>> waiting for the next person to stir the hornet’s nest.
>>
>>>>> Cc-ing Alex on this mail, because to me, this seems like an important
>>>>> detail when he plans on using the byte in the future. If we need a
>>>>> virtio status byte, I can’t see how we could use the existing F_STATUS
>>>>> for it.
> What would we use instead of F_STATUS to query the Device Status field?

We would emulate it in the front-end, just like we need to do for 
back-ends without F_STATUS.  We can’t emulate the DEVICE_NEEDS_RESET 
bit, though, that’s correct.

Given that qemu currently ignores DEVICE_NEEDS_RESET, I’m not 100 % 
convinced that your use case has a hard dependency on F_STATUS. However, 
this still does make a fair point in general that it would be useful to 
keep it.

That still leaves us with the situation that currently, the only 
implementations with F_STATUS support are qemu and dpdk, which both 
handle it incorrectly.  Furthermore, the specification leaves much to be 
desired, specifically in how F_STATUS interacts with other vhost-user 
commands (which is something I cited as a reason for my original patch), 
i.e. whether RESET_DEVICE and SET_STATUS 0 are equivalent, and whether 
failures in feature negotiation must result in both SET_FEATURES 
returning an error (with F_REPLY_ACK), and FEATURES_OK being reset in 
the status byte, or whether either is sufficient.  What happens when 
DEVICE_NEEDS_RESET is set, i.e. do we just need RESET_DEVICE / 
SET_STATUS 0, or do we also need to reset some protocol state?  (This is 
also connected to the fact that what happens on RESET_DEVICE is largely 
undefined, which I said on Stefan’s series.)

In general, because we have our own transport, we should make a note how 
it interacts with the status negotiation phases, i.e. that GET_FEATURES 
must not be called before S_ACKNOWLEDGE | S_DRIVER are set, that 
FEATURES_OK must be set after the SET_FEATURES call, and that DRIVER_OK 
must not be set without FEATURES_OK set / SET_FEATURES having returned 
success.  Here we would also answer the question about the interaction 
of F_REPLY_ACK+SET_FEATURES with F_STATUS, specifically whether an 
implementation with F_REPLY_ACK even needs to read back the status byte 
after setting FEATURES_OK because it could have got the feature 
negotiation result already as a result of the SET_FEATURES call.

After migration, can you just set all flags immediately or do we need to 
follow this step-by-step protocol?  I think we do need to do it 
step-by-step, mostly for simplicity in the back-end, i.e. that it just 
sees a normal device start-up.

We should also clarify whether SET_STATUS can fail, i.e. whether setting 
an invalid status (is setting FEATURES_OK when the device doesn’t think 
so invalid?) has SET_STATUS fail (with F_REPLY_ACK) and/or immediately 
gets the device into DEVICE_NEEDS_RESET.

We should clarify whether SET_STATUS can block.  The current use of 
DRIVER_OK seems to indicate to me that dpdk does do time-consuming 
operations when it sees DRIVER_OK (code looks like it, too) and only 
returns when that’s done, but naïvely, I would expect SET_STATUS to be 
just setting some value and doing whatever needs to be done in the 
background, not actually launching and blocking on an operation.

I think it is dangerous to just push ahead with using F_STATUS without 
acknowledging that its implementation is broken right now, and that it 
is so *on purpose* because the DRIVER_OK bit is the only thing that it 
was supposed to be used for.  Using it for its purported original use 
(actually the virtio status byte) is contradictory to that.  It’s 
probably fixable, but I think it requires taking a step back and seeing 
what needs to be done to remedy the conflict.  If you rip out all the 
existing STATUS code and replace it such that qemu will let the guest 
have full control over the status byte (except for migration, where we 
restore it on the destination, which will result in DRIVER_OK being set 
at the end, fulfilling that requirement), that will fix the 
implementation in qemu.  I think.  But the specification should be 
amended to think about all these corner cases, not least because I think 
they will also affect your implementation.

(The answers to many of the questions I raise for documentation may be 
obvious to you, based on “in virtio, it’s just an MMIO byte that’s 
written and read, so the rest follows from there”.  But evidently the 
implementation we have kind of ignores that e.g. SET_STATUS 0 is a reset 
(6f8be29ec17d44496b9ed67599bceaaba72d1864 is a work-around, not much 
more) or that there is actually a protocol to setting the status flags 
and you can’t just set them all at once, so I don’t think the answers 
are immediately obvious, and should be documented.)

As for me and the original patch: I claimed nobody really needs 
F_STATUS, you say you do, so plainly, I assumed wrong and will naturally 
take my hands off of F_STATUS and just ensure not to implement it in any 
back-end until you’ve fixed it, as Yajun has advised.  I’d still prefer 
mentioning this advice in the documentation until it’s fixed, but, you 
know, I wouldn’t be the first one to say “I now know about the quirk, so 
I can work around it, no need to tell anyone else as long as my stuff 
works”.

Hanna


