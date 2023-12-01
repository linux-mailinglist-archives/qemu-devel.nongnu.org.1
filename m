Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F636800E7D
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 16:23:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r95Kx-0004fj-NP; Fri, 01 Dec 2023 10:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r95Kt-0004ao-Nt
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:21:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r95Kr-0006r6-Ml
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701444104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1pZUtyDtMfEOx2qeax6VgIDy5BOz3MQtm97MU3foqM0=;
 b=eQ0Sb/Emn8THmxXt4WkW38fUxoEW55t1LPzI28OIDCADO06eLHVnOA8oNOdqNsi7P+19BJ
 bxQoLgpgPqG+wxDyfDpZy/hOhGZ/pPbnpniFfA76bJUwrrhciTdnXJt9T352nGhfzQsBIO
 TWl+jDvp2h5ICcjood1eX6eI9eHT7X4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-0sJdW9ivNgGZ4mT4p_myYA-1; Fri, 01 Dec 2023 10:21:42 -0500
X-MC-Unique: 0sJdW9ivNgGZ4mT4p_myYA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7275C811E86;
 Fri,  1 Dec 2023 15:21:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF6C636E2;
 Fri,  1 Dec 2023 15:21:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0C14A21E6A1F; Fri,  1 Dec 2023 16:21:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Yong Huang <yong.huang@smartx.com>,  qemu-devel@nongnu.org,  "Michael S
 . Tsirkin" <mst@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 1/2] qapi/virtio: introduce the "show-bits" argument for
 x-query-virtio-status
References: <cover.1699793550.git.yong.huang@smartx.com>
 <2f146005c8573814528f4ffb5a0393eb73b154e3.1699793550.git.yong.huang@smartx.com>
 <87h6llep0o.fsf@pond.sub.org>
 <CAK9dgmYTjQRregoseU7S+8WvJsY4R10KP5hVkcEBKBFtHNv0=A@mail.gmail.com>
 <87v89vleqp.fsf@pond.sub.org>
 <3d4add1a-2dcf-4a35-a3f6-c7eca0275a35@redhat.com>
Date: Fri, 01 Dec 2023 16:21:41 +0100
In-Reply-To: <3d4add1a-2dcf-4a35-a3f6-c7eca0275a35@redhat.com> (Laurent
 Vivier's message of "Fri, 1 Dec 2023 11:41:13 +0100")
Message-ID: <87jzpyuewq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Laurent Vivier <lvivier@redhat.com> writes:

> On 11/21/23 08:58, Markus Armbruster wrote:
>> Laurent, there's a question for you at the end.
>>=20
>> Yong Huang <yong.huang@smartx.com> writes:
>>=20
>>> On Thu, Nov 16, 2023 at 10:44=E2=80=AFPM Markus Armbruster <armbru@redh=
at.com>
>>> wrote:
>>>
>>>> Hyman Huang <yong.huang@smartx.com> writes:
>>>>
>>>>> This patch allows to display feature and status bits in virtio-status.
>>>>>
>>>>> An optional argument is introduced: show-bits. For example:
>>>>> {"execute": "x-query-virtio-status",
>>>>>   "arguments": {"path": "/machine/peripheral-anon/device[1]/virtio-ba=
ckend",
>>>>>                 "show-bits": true}
>>>>>
>>>>> Features and status bits could be helpful for applications to compare
>>>>> directly. For instance, when an upper application aims to ensure the
>>>>> virtio negotiation correctness between guest, QEMU, and OVS-DPDK, it =
use
>>>>> the "ovs-vsctl list interface" command to retrieve interface features
>>>>> (in number format) and the QMP command x-query-virtio-status to retri=
eve
>>>>> vhost-user net device features. If "show-bits" is added, the applicat=
ion
>>>>> can compare the two features directly; No need to encoding the featur=
es
>>>>> returned by the QMP command.
>>>>>
>>>>> This patch also serves as a preparation for the next one, which imple=
ments
>>>>> a vhost-user test case about acked features of vhost-user protocol.
>>>>>
>>>>> Note that since the matching HMP command is typically used for human,
>>>>> leave it unchanged.
>>>>>
>>>>> Signed-off-by: Hyman Huang <yong.huang@smartx.com>

[...]

>>>> Double-checking...  @feature-bits provides the exact same information =
as
>>>> @features, only in another encoding.  Correct?
>>>
>>>
>>>> Same for all the other new -bits.  Correct?
>>>
>>> Yes, all the new fields are only about providing another encoding.
>>=20
>> Why do we want to return the same information in two different
>> encodings?  I figure the commit message tries to answer this question:
>>=20
>>       Features and status bits could be helpful for applications to comp=
are
>>       directly. For instance, when an upper application aims to ensure t=
he
>>       virtio negotiation correctness between guest, QEMU, and OVS-DPDK, =
it use
>>       the "ovs-vsctl list interface" command to retrieve interface featu=
res
>>       (in number format) and the QMP command x-query-virtio-status to re=
trieve
>>       vhost-user net device features. If "show-bits" is added, the appli=
cation
>>       can compare the two features directly; No need to encoding the fea=
tures
>>       returned by the QMP command.
>>=20
>>       This patch also serves as a preparation for the next one, which im=
plements
>>       a vhost-user test case about acked features of vhost-user protocol.
>>=20
>> I guess you're trying to simplify use cases where the QMP client wants
>> to compare entire feature sets without caring for individual features.
>>=20
>> The comparison is easy if both sets are represented the same way,
>> e.g. both are numbers, or both are lists of symbols.
>>=20
>> With different representations, we first have to map to a common
>> representation.  Unfortunately, the design of x-query-virtio-status
>> makes this harder than it should be.
>>=20
>> We use QAPI types VirtioDeviceStatus, VhostDeviceProtocols,
>> VirtioDeviceFeatures to represent feature sets.  They all work the same
>> way: array of strings plus a number.  For each bit QEMU knows, there's a
>> string in the array.  Any remaining bits go into the number.
>>=20
>> The format of the string is undocumented.  They look like
>>=20
>>      "WELL_KNOWN_SYMBOL: human readable explanation"
>>=20
>> Mapping from bit to this string in a client would require duplicating
>> QEMU's code exactly.
>>=20
>> Mapping both bit and string to just "WELL_KNOWN_SYMBOL" could perhaps be
>> done.
>>=20
>> The mapping between symbols and bits is not visible in QMP.  Mapping
>> from string to bit requires exploiting the undocumented format: extract
>> the well-known symbol and decode it.
>>=20
>> This encoding of feature sets goes back to commit f3034ad71fc (qmp:
>> decode feature & status bits in virtio-status) v7.2.  Before that, the
>> command returned the bits as a number.
>>=20
>> For example, return value "member "status":
>>=20
>>      Before f3034ad71fc:
>>=20
>>          "status": 15,
>>=20
>>      Since f3034ad71fc:
>>=20
>>          "status": {
>>              "statuses": [
>>                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found=
",
>>                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with devic=
e",
>>                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation compl=
ete",
>>                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
>>              ]},
>>=20
>>      With your patch:
>>=20
>>          "status": {
>>              "statuses": [
>>                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found=
",
>>                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with devic=
e",
>>                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation compl=
ete",
>>                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
>>              ]},
>>          "status-bits": 15,
>>=20
>> Looks like commit f3034ad71fc improved one use case at the expense of
>> another, and your patch tries to revert the damage.  Which one exactly
>> it improved is unclear; the commit message doesn't tell.  Laurent?
>>=20
>> [...]
>>=20
>
> The first idea of the series "hmp,qmp: Add commands to introspect virtio =
devices"=20
> including commit f3034ad71fc was to help developer to debug virtio device=
s, so for this=20
> purpose it was interesting to display the status in a human readable mann=
er.
>
> Of course, if you want to run automatic tests and be able to compare the =
result to have=20
> the status bits result seems to be better.
>
> As these are two different use cases, it's understandable to have two dif=
ferent=20
> representations of the same information.

Thanks!

Both use cases are valid, but I dislike both the existing and the
proposed interface.

We can change it: x-query-virtio-status isn't stable (it's for debugging
and testing).  But even unstable interfaces should only be changed for
good, clear reasons.

I feel the change from "bits encoded as a number" to "bits as list of
descriptive strings plus number for the unknown ones" fell short.  Let
me explain.

The initial version of the command had "bits encoded as number".  Unless
we understand why that was done, we should assume it was done for a
reason.  We now know it was: Hyman Huang posted a patch to get it back.

Instead of "bits as list of descriptive strings plus number for the
unknown ones", we could have done "bits encoded as number, plus list of
descriptive strings", or plus some other human-readable encoding.

QMP output of the form "WELL_KNOWN_SYMBOL: human readable explanation"
smells of encoding structured information in strings, which is a no-no.

Perhaps we could have added human-readable output just in HMP.  That's
what we normally do.

Here are a few possible alternatives to Hyman Huang's patch:

1. Revert commit f3034ad71fc for QMP, keep it for HMP.

2. Replace @unknown-FOO (just the unknown bits) by @FOO-bits (all bits).

3. Add @FOO-bits next to @unknown-FOO, deprecate @unknown-FOO.

4. Create a QAPI enum for the known bits.  Clients can use introspection
   to learn the mapping between symbols and bits.  Requires dumbing down
   the descriptive strings to just the symbols.  This feels
   both overengineered and cumbersome to use.

For 2 and 3, I'd prefer to also dumb down the descriptive strings to
just the symbols.

Thoughts?


