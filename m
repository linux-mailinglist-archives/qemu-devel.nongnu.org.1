Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C42CB759AE4
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 18:35:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMA7x-0004Fv-Nc; Wed, 19 Jul 2023 12:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMA7v-0004F0-Qm
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 12:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMA7t-0006C1-FF
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 12:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689784448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qL86k9wPRjmQbUe8ggF0837DEkcFRuPpqFERy6fLtcM=;
 b=YvIPR+TWeTOU8hmx/OPgkHL+w6vxCY4g3rVUogX1yC5reqMIcqjcmq0lAjblA4Cy8Fal1a
 DQr05Nkl5YludApvEXhTgdhbdgiXhWfNtEzxWBXccfu/orR3XZjGzrzFGiWBAQXHrVvvQe
 tHNF06fG/Kc39pvFGagRiHAPBNqo1W0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-CeXspUIbPASeGqjlrK88Kg-1; Wed, 19 Jul 2023 12:34:05 -0400
X-MC-Unique: CeXspUIbPASeGqjlrK88Kg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b6f97c9d54so65663321fa.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 09:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689784442; x=1692376442;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qL86k9wPRjmQbUe8ggF0837DEkcFRuPpqFERy6fLtcM=;
 b=fVgEwJMOonhoJej2WlJ9ApCtV75aZetHMDn0biOKtofnWvTERB6l9NUGRyqUSLOW71
 ALKiaK+QKXve7qW+r88dhQdVEqzGQ+YJecaVPkwVvgPuWMnm3M8L6zg/j7Q+Ug/lG40E
 mnKeL3rT+QLoX6YIf4/4YXYNjAEaj5diLWeznbMIaRELOz/acEAaIqV8PiEXGUmbno75
 Eaj3SGF1Rumkb3qe3vYx42TBXrgKugZL1Av7kBvnD7Mh6eM4hl/wy/P1mAAt8M0EshAW
 3uU5vog9HQmsryRquDf38Xpf5eGNZ+kj832pFpG0Mw715zrI+xj6/aKYlSVqh0cX20Yh
 K+TQ==
X-Gm-Message-State: ABy/qLbgZf9M1/6XsjGXvPzTaFVmGrGWjBWX1eeKk5BmoE2NVgxiF7GG
 lOC3ITEZiPge4/o0caStzvCQMya4w4/iW+aN/OQZ3ln81MtKSePS6jnks3JEJYNVwv0rrTHo+rF
 p5uYEez5qpFanZFw=
X-Received: by 2002:a2e:9c81:0:b0:2b6:d790:d1a3 with SMTP id
 x1-20020a2e9c81000000b002b6d790d1a3mr311772lji.11.1689784441773; 
 Wed, 19 Jul 2023 09:34:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGGajB7eYnGd6Uc3kFQNW0nalVfseUQwq5UggTouXraHg6L1YQ/JCtkfmsaMnam46G6/LhhxQ==
X-Received: by 2002:a2e:9c81:0:b0:2b6:d790:d1a3 with SMTP id
 x1-20020a2e9c81000000b002b6d790d1a3mr311756lji.11.1689784441298; 
 Wed, 19 Jul 2023 09:34:01 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 a25-20020a17090682d900b009829d2e892csm2585256ejy.15.2023.07.19.09.34.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 09:34:00 -0700 (PDT)
Message-ID: <940a0545-c4ec-cd99-62b2-9e5d007ce9bf@redhat.com>
Date: Wed, 19 Jul 2023 18:33:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/4] vhost-user.rst: Migrating back-end-internal state
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 German Maglione <gmaglione@redhat.com>, =?UTF-8?Q?Eugenio_P=c3=a9rez?=
 <eperezma@redhat.com>
References: <20230712111703.28031-1-hreitz@redhat.com>
 <20230712111703.28031-2-hreitz@redhat.com> <20230718155700.GJ44841@fedora>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230718155700.GJ44841@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 18.07.23 17:57, Stefan Hajnoczi wrote:
> On Wed, Jul 12, 2023 at 01:16:59PM +0200, Hanna Czenczek wrote:
>> For vhost-user devices, qemu can migrate the virtio state, but not the
>> back-end's internal state.  To do so, we need to be able to transfer
>> this internal state between front-end (qemu) and back-end.
>>
>> At this point, this new feature is added for the purpose of virtio-fs
>> migration.  Because virtiofsd's internal state will not be too large, we
>> believe it is best to transfer it as a single binary blob after the
>> streaming phase.
>>
>> These are the additions to the protocol:
>> - New vhost-user protocol feature VHOST_USER_PROTOCOL_F_MIGRATORY_STATE
> It's not 100% clear whether "migratory" is related to live migration or
> something else. I don't like the name :P.
>
> The name "VHOST_USER_PROTOCOL_F_DEVICE_STATE" would be more obviously
> associated with SET_DEVICE_STATE_FD and CHECK_DEVICE_STATE than
> "MIGRATORY_STATE".

Sure, sure.  Naming things is hard. :)

>> - SET_DEVICE_STATE_FD function: Front-end and back-end negotiate a pipe
>>    over which to transfer the state.
> Does it need to be a pipe or can it be another type of file (e.g. UNIX
> domain socket)?

It’s difficult to say, honestly.  It can be anything, but I’m not sure 
how to describe that in this specification.

It must be any FD into which the state sender can write the state and 
signal end of state by closing its FD; and from which the state receiver 
can read the state, terminated by seeing an EOF.  As you say, that 
doesn’t mean that the sender has to write the state into the FD, nor 
that the receiver has to read it (into memory), it’s just that either 
side must ensure the other can do it.

> In the future the fd may become bi-directional. Pipes are
> uni-directional on Linux.
>
> I suggest calling it a "file descriptor" and not mentioning "pipes"
> explicitly.

Works here in the commit message, but in the document, we need to be 
explicit about the requirements for this FD, i.e. the way in which 
front-end and back-end can expect the FD to be usable.  Calling it a 
“pipe” was a simple way, but you’re right, it’s more general than that.

>> - CHECK_DEVICE_STATE: After the state has been transferred through the
>>    pipe, the front-end invokes this function to verify success.  There is
>>    no in-band way (through the pipe) to indicate failure, so we need to
>>    check explicitly.
>>
>> Once the transfer pipe has been established via SET_DEVICE_STATE_FD
>> (which includes establishing the direction of transfer and migration
>> phase), the sending side writes its data into the pipe, and the reading
>> side reads it until it sees an EOF.  Then, the front-end will check for
>> success via CHECK_DEVICE_STATE, which on the destination side includes
>> checking for integrity (i.e. errors during deserialization).
>>
>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   docs/interop/vhost-user.rst | 87 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 87 insertions(+)
>>
>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> index ac6be34c4c..c98dfeca25 100644
>> --- a/docs/interop/vhost-user.rst
>> +++ b/docs/interop/vhost-user.rst
>> @@ -334,6 +334,7 @@ in the ancillary data:
>>   * ``VHOST_USER_SET_VRING_ERR``
>>   * ``VHOST_USER_SET_BACKEND_REQ_FD`` (previous name ``VHOST_USER_SET_SLAVE_REQ_FD``)
>>   * ``VHOST_USER_SET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
>> +* ``VHOST_USER_SET_DEVICE_STATE_FD``
>>   
>>   If *front-end* is unable to send the full message or receives a wrong
>>   reply it will close the connection. An optional reconnection mechanism
>> @@ -497,6 +498,44 @@ it performs WAKE ioctl's on the userfaultfd to wake the stalled
>>   back-end.  The front-end indicates support for this via the
>>   ``VHOST_USER_PROTOCOL_F_PAGEFAULT`` feature.
>>   
>> +.. _migrating_backend_state:
>> +
>> +Migrating back-end state
>> +^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +If the back-end has internal state that is to be sent from source to
>> +destination,
> Migration and the terms "source" and "destination" have not been
> defined. Here is a suggestion for an introductory paragraph:
>
>    Migrating device state involves transferring the state from one
>    back-end, called the source, to another back-end, called the
>    destination. After migration, the destination transparently resumes
>    operation without requiring the driver to re-initialize the device at
>    the VIRTIO level. If the migration fails, then the source can
>    transparently resume operation until another migration attempt is
>    made.

You’re right, thanks!  Maybe I’ll try to be even more verbose here, and 
include what VM and guest do.

>> the front-end may be able to store and transfer it via an
>> +internal migration stream.  Support for this is negotiated with the
>> +``VHOST_USER_PROTOCOL_F_MIGRATORY_STATE`` feature.
>> +
>> +First, a channel over which the state is transferred is established on
>> +the source side using the ``VHOST_USER_SET_DEVICE_STATE_FD`` message.
>> +This message has two parameters:
>> +
>> +* Direction of transfer: On the source, the data is saved, transferring
>> +  it from the back-end to the front-end.  On the destination, the data
>> +  is loaded, transferring it from the front-end to the back-end.
>> +
>> +* Migration phase: Currently, only the period after memory transfer
> "memory transfer" is vague. This sentence is referring to VM live
> migration and guest RAM but it may be better to focus on just the device
> perspective and not the VM:

The device perspective does include guest RAM, though, because the 
back-end must log its memory modifications, so it is very much involved 
in that process.  I think it’s a good idea to note that the state 
transfer will occur afterwards.

>    Migration is currently only supported while the device is suspended
>    and all of its rings are stopped. In the future, additional phases
>    might be support to allow iterative migration while the device is
>    running.

In any case, I’ll happily add this last sentence.

>> +  before switch-over is supported, in which the device is suspended and
>> +  all of its rings are stopped.
>> +
>> +Then, the writing end will write all the data it has, signalling the end
>> +of data by closing its end of the pipe.  The reading end must read all
>> +of this data and process it:
>> +
>> +* If saving, the front-end will transfer this data to the destination,
> To be extra clear:
>
>    ...transfer this data to the destination through some
>    implementation-specific means.

Yep!

>> +  where it is loaded into the destination back-end.
>> +
>> +* If loading, the back-end must deserialize its internal state from the
>> +  transferred data and be set up to resume operation.
> "and be set up to resume operation" is a little unclear to me. I guess
> it means "in preparation for VHOST_USER_RESUME".

I don’t think the back-end on the destination will receive a RESUME.  It 
never gets a SUSPEND, after all.  So this is about resuming operation 
once the vrings are kicked, and resuming it like it was left on the 
source when the back-end was SUSPEND-ed there.

>> +
>> +After the front-end has seen all data transferred (saving: seen an EOF
>> +on the pipe; loading: closed its end of the pipe), it sends the
>> +``VHOST_USER_CHECK_DEVICE_STATE`` message to verify that data transfer
>> +was successful in the back-end, too.  The back-end responds once it
>> +knows whether the tranfer and processing was successful or not.
>> +
>>   Memory access
>>   -------------
>>   
>> @@ -891,6 +930,7 @@ Protocol features
>>     #define VHOST_USER_PROTOCOL_F_STATUS               16
>>     #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>>     #define VHOST_USER_PROTOCOL_F_SUSPEND              18
>> +  #define VHOST_USER_PROTOCOL_F_MIGRATORY_STATE      19
>>   
>>   Front-end message types
>>   -----------------------
>> @@ -1471,6 +1511,53 @@ Front-end message types
>>     before.  The back-end must again begin processing rings that are not
>>     stopped, and it may resume background operations.
>>   
>> +``VHOST_USER_SET_DEVICE_STATE_FD``
>> +  :id: 43
>> +  :equivalent ioctl: N/A
>> +  :request payload: device state transfer parameters
>> +  :reply payload: ``u64``
>> +
>> +  The front-end negotiates a pipe over which to transfer the back-end’s
>> +  internal state during migration.  For this purpose, this message is
>> +  accompanied by a file descriptor that is to be the back-end’s end of
>> +  the pipe.  If the back-end can provide a more efficient pipe (i.e.
>> +  because it internally already has a pipe into/from which to
>> +  put/receive state), it can ignore this and reply with a different file
>> +  descriptor to serve as the front-end’s end.
>> +
>> +  The request payload contains parameters for the subsequent data
>> +  transfer, as described in the :ref:`Migrating back-end state
>> +  <migrating_backend_state>` section.  That section also explains the
>> +  data transfer itself.
>> +
>> +  The value returned is both an indication for success, and whether a
>> +  new pipe file descriptor is returned: Bits 0–7 are 0 on success, and
>> +  non-zero on error.  Bit 8 is the invalid FD flag; this flag is set
>> +  when there is no file descriptor returned.  When this flag is not set,
>> +  the front-end must use the returned file descriptor as its end of the
>> +  pipe.  The back-end must not both indicate an error and return a file
>> +  descriptor.
> Is the invalid FD flag necessary? The front-end can check whether or not
> an fd was passed along with the result, so I'm not sure why the result
> also needs to communicate this.

If the front-end can check this, shouldn’t the back-end also generally 
be able to check whether the front-end has passed an FD in the ancillary 
data?  We do have this flag in messages sent by the front-end that can 
optionally provide an FD (SET_VRING_KICK, SET_VRING_CALL), so I thought 
it would be good for symmetry to keep this convention every time an FD 
is optional in communication between front-end and back-end, in either 
direction.

Hanna


