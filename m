Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FB1800EAE
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 16:38:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r95Zz-0000UI-IW; Fri, 01 Dec 2023 10:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1r95Zx-0000U2-5c
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:37:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1r95Zv-0007VG-90
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:37:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701445038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aEJil3WgET9TYkNOrWrBij37drP7+Bcm4B5NxStFXyw=;
 b=fw4U3c0IArQxCG8xhHU7kgwwV+xC39AfjR51xfP3dxqVlKqTTkg4BSS79yoYTaJx/79rG3
 SgYj7L8D8SAXQb5LsrbghkpTDXqSc+e46YHq0Lzg9iph3QFpSaTN6o/0gXqu1+N5nh01xD
 wCrwJJOmH1QlMd4gviITfxJIthjTDTk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-At2ddZYONiycJNXTI4_0tg-1; Fri, 01 Dec 2023 10:37:14 -0500
X-MC-Unique: At2ddZYONiycJNXTI4_0tg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-332f56ab391so1882920f8f.3
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 07:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701445033; x=1702049833;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aEJil3WgET9TYkNOrWrBij37drP7+Bcm4B5NxStFXyw=;
 b=NUY29kzTQDipps9bUGdN2bA6gyEPiU/8/lVqcoNv1OVRALmyxTA8JholBqwkgEg/Gw
 ys7Lg576ElDE3OW+J0IKTmoz+D99biEOXBOMzBCw7tMHV+X5caqsPK7PkLJKDSV1ENG2
 9PgSFg6vM7aK6azXZ2ogHpubXi2cth77ZHlCRCPGC5vMQYwEDlpUcPJNfR/Nh5RwYRbJ
 66HATbGIKO4SaNYDqRQdKVasy6kgU4TBal4EL5kfhlLa3nvyehGX3g/Q2wqpAKJY2gbC
 KXKf9ice9Xt6+DaPA2ZT+aLnNzEw1omk9HJGmcl6rCfog2EkG79fufzVhQ+YLKFqF7u1
 lYZw==
X-Gm-Message-State: AOJu0YyBk93ulv92dXg+YZVru4ASyaKXRGZqUAhT6Pg6cTgAkcI7Oi73
 GlT+m7s7oUC7oVqlEk1jmgVdoP2lz93Umtjbqrfg5HdeGdQmBYtmszGuFLgjMc9zHolI8VhFKau
 isqU6rEg6WyMykN8=
X-Received: by 2002:adf:cc8b:0:b0:333:ef6:fec4 with SMTP id
 p11-20020adfcc8b000000b003330ef6fec4mr1024791wrj.59.1701445033386; 
 Fri, 01 Dec 2023 07:37:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZq9HUNw0oMH6hEIkczcxFBdx/U4h4lP+wvoVDW4lc2oAnkr0VRMDpeaNX+age225pvOeBnA==
X-Received: by 2002:adf:cc8b:0:b0:333:ef6:fec4 with SMTP id
 p11-20020adfcc8b000000b003330ef6fec4mr1024782wrj.59.1701445032987; 
 Fri, 01 Dec 2023 07:37:12 -0800 (PST)
Received: from [192.168.100.30] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 d25-20020adfa419000000b003333152b3f7sm1917341wra.103.2023.12.01.07.37.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 07:37:12 -0800 (PST)
Message-ID: <e4f0491e-c915-4d9b-80a5-953e0ad27528@redhat.com>
Date: Fri, 1 Dec 2023 16:37:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] qapi/virtio: introduce the "show-bits" argument for
 x-query-virtio-status
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1699793550.git.yong.huang@smartx.com>
 <2f146005c8573814528f4ffb5a0393eb73b154e3.1699793550.git.yong.huang@smartx.com>
 <87h6llep0o.fsf@pond.sub.org>
 <CAK9dgmYTjQRregoseU7S+8WvJsY4R10KP5hVkcEBKBFtHNv0=A@mail.gmail.com>
 <87v89vleqp.fsf@pond.sub.org>
 <3d4add1a-2dcf-4a35-a3f6-c7eca0275a35@redhat.com>
 <87jzpyuewq.fsf@pond.sub.org>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <87jzpyuewq.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 12/1/23 16:21, Markus Armbruster wrote:
> Laurent Vivier <lvivier@redhat.com> writes:
> 
>> On 11/21/23 08:58, Markus Armbruster wrote:
>>> Laurent, there's a question for you at the end.
>>>
>>> Yong Huang <yong.huang@smartx.com> writes:
>>>
>>>> On Thu, Nov 16, 2023 at 10:44 PM Markus Armbruster <armbru@redhat.com>
>>>> wrote:
>>>>
>>>>> Hyman Huang <yong.huang@smartx.com> writes:
>>>>>
>>>>>> This patch allows to display feature and status bits in virtio-status.
>>>>>>
>>>>>> An optional argument is introduced: show-bits. For example:
>>>>>> {"execute": "x-query-virtio-status",
>>>>>>    "arguments": {"path": "/machine/peripheral-anon/device[1]/virtio-backend",
>>>>>>                  "show-bits": true}
>>>>>>
>>>>>> Features and status bits could be helpful for applications to compare
>>>>>> directly. For instance, when an upper application aims to ensure the
>>>>>> virtio negotiation correctness between guest, QEMU, and OVS-DPDK, it use
>>>>>> the "ovs-vsctl list interface" command to retrieve interface features
>>>>>> (in number format) and the QMP command x-query-virtio-status to retrieve
>>>>>> vhost-user net device features. If "show-bits" is added, the application
>>>>>> can compare the two features directly; No need to encoding the features
>>>>>> returned by the QMP command.
>>>>>>
>>>>>> This patch also serves as a preparation for the next one, which implements
>>>>>> a vhost-user test case about acked features of vhost-user protocol.
>>>>>>
>>>>>> Note that since the matching HMP command is typically used for human,
>>>>>> leave it unchanged.
>>>>>>
>>>>>> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> 
> [...]
> 
>>>>> Double-checking...  @feature-bits provides the exact same information as
>>>>> @features, only in another encoding.  Correct?
>>>>
>>>>
>>>>> Same for all the other new -bits.  Correct?
>>>>
>>>> Yes, all the new fields are only about providing another encoding.
>>>
>>> Why do we want to return the same information in two different
>>> encodings?  I figure the commit message tries to answer this question:
>>>
>>>        Features and status bits could be helpful for applications to compare
>>>        directly. For instance, when an upper application aims to ensure the
>>>        virtio negotiation correctness between guest, QEMU, and OVS-DPDK, it use
>>>        the "ovs-vsctl list interface" command to retrieve interface features
>>>        (in number format) and the QMP command x-query-virtio-status to retrieve
>>>        vhost-user net device features. If "show-bits" is added, the application
>>>        can compare the two features directly; No need to encoding the features
>>>        returned by the QMP command.
>>>
>>>        This patch also serves as a preparation for the next one, which implements
>>>        a vhost-user test case about acked features of vhost-user protocol.
>>>
>>> I guess you're trying to simplify use cases where the QMP client wants
>>> to compare entire feature sets without caring for individual features.
>>>
>>> The comparison is easy if both sets are represented the same way,
>>> e.g. both are numbers, or both are lists of symbols.
>>>
>>> With different representations, we first have to map to a common
>>> representation.  Unfortunately, the design of x-query-virtio-status
>>> makes this harder than it should be.
>>>
>>> We use QAPI types VirtioDeviceStatus, VhostDeviceProtocols,
>>> VirtioDeviceFeatures to represent feature sets.  They all work the same
>>> way: array of strings plus a number.  For each bit QEMU knows, there's a
>>> string in the array.  Any remaining bits go into the number.
>>>
>>> The format of the string is undocumented.  They look like
>>>
>>>       "WELL_KNOWN_SYMBOL: human readable explanation"
>>>
>>> Mapping from bit to this string in a client would require duplicating
>>> QEMU's code exactly.
>>>
>>> Mapping both bit and string to just "WELL_KNOWN_SYMBOL" could perhaps be
>>> done.
>>>
>>> The mapping between symbols and bits is not visible in QMP.  Mapping
>>> from string to bit requires exploiting the undocumented format: extract
>>> the well-known symbol and decode it.
>>>
>>> This encoding of feature sets goes back to commit f3034ad71fc (qmp:
>>> decode feature & status bits in virtio-status) v7.2.  Before that, the
>>> command returned the bits as a number.
>>>
>>> For example, return value "member "status":
>>>
>>>       Before f3034ad71fc:
>>>
>>>           "status": 15,
>>>
>>>       Since f3034ad71fc:
>>>
>>>           "status": {
>>>               "statuses": [
>>>                   "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
>>>                   "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
>>>                   "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
>>>                   "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
>>>               ]},
>>>
>>>       With your patch:
>>>
>>>           "status": {
>>>               "statuses": [
>>>                   "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
>>>                   "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
>>>                   "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
>>>                   "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
>>>               ]},
>>>           "status-bits": 15,
>>>
>>> Looks like commit f3034ad71fc improved one use case at the expense of
>>> another, and your patch tries to revert the damage.  Which one exactly
>>> it improved is unclear; the commit message doesn't tell.  Laurent?
>>>
>>> [...]
>>>
>>
>> The first idea of the series "hmp,qmp: Add commands to introspect virtio devices"
>> including commit f3034ad71fc was to help developer to debug virtio devices, so for this
>> purpose it was interesting to display the status in a human readable manner.
>>
>> Of course, if you want to run automatic tests and be able to compare the result to have
>> the status bits result seems to be better.
>>
>> As these are two different use cases, it's understandable to have two different
>> representations of the same information.
> 
> Thanks!
> 
> Both use cases are valid, but I dislike both the existing and the
> proposed interface.
> 
> We can change it: x-query-virtio-status isn't stable (it's for debugging
> and testing).  But even unstable interfaces should only be changed for
> good, clear reasons.
> 
> I feel the change from "bits encoded as a number" to "bits as list of
> descriptive strings plus number for the unknown ones" fell short.  Let
> me explain.
> 
> The initial version of the command had "bits encoded as number".  Unless
> we understand why that was done, we should assume it was done for a
> reason.  We now know it was: Hyman Huang posted a patch to get it back.
> 
> Instead of "bits as list of descriptive strings plus number for the
> unknown ones", we could have done "bits encoded as number, plus list of
> descriptive strings", or plus some other human-readable encoding.
> 
> QMP output of the form "WELL_KNOWN_SYMBOL: human readable explanation"
> smells of encoding structured information in strings, which is a no-no.
> 
> Perhaps we could have added human-readable output just in HMP.  That's
> what we normally do.
> 
> Here are a few possible alternatives to Hyman Huang's patch:
> 
> 1. Revert commit f3034ad71fc for QMP, keep it for HMP.
> 
> 2. Replace @unknown-FOO (just the unknown bits) by @FOO-bits (all bits).
> 
> 3. Add @FOO-bits next to @unknown-FOO, deprecate @unknown-FOO.
> 
> 4. Create a QAPI enum for the known bits.  Clients can use introspection
>     to learn the mapping between symbols and bits.  Requires dumbing down
>     the descriptive strings to just the symbols.  This feels
>     both overengineered and cumbersome to use.
> 
> For 2 and 3, I'd prefer to also dumb down the descriptive strings to
> just the symbols.
> 
> Thoughts?
> 

I agree with you. As x-CMD are unstable, perhaps we can go directly to 2?
(and of course to remove the descriptive strings. Is it easily possible to keep them for 
the HMP version?)

Thanks,
Laurent


