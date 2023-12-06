Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 483DD806881
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 08:37:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAmRY-000379-8j; Wed, 06 Dec 2023 02:35:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1rAmRG-00034q-Tz
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 02:35:23 -0500
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1rAmRD-0005ae-VX
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 02:35:21 -0500
Received: from blackfin.pond.sub.org
 (p200300d36f057900e5cb4c6407d058fa.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f05:7900:e5cb:4c64:7d0:58fa])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id BEE2521285;
 Wed,  6 Dec 2023 08:53:20 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4547821E6A01; Wed,  6 Dec 2023 08:35:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  Yong Huang
 <yong.huang@smartx.com>,  qemu-devel@nongnu.org,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 1/2] qapi/virtio: introduce the "show-bits" argument for
 x-query-virtio-status
References: <cover.1699793550.git.yong.huang@smartx.com>
 <2f146005c8573814528f4ffb5a0393eb73b154e3.1699793550.git.yong.huang@smartx.com>
 <87h6llep0o.fsf@pond.sub.org>
 <CAK9dgmYTjQRregoseU7S+8WvJsY4R10KP5hVkcEBKBFtHNv0=A@mail.gmail.com>
 <87v89vleqp.fsf@pond.sub.org>
 <3d4add1a-2dcf-4a35-a3f6-c7eca0275a35@redhat.com>
 <87jzpyuewq.fsf@pond.sub.org>
 <e4f0491e-c915-4d9b-80a5-953e0ad27528@redhat.com>
Date: Wed, 06 Dec 2023 08:35:11 +0100
Message-ID: <87cyvj6axc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

> On 12/1/23 16:21, Markus Armbruster wrote:

[...]

>> Both use cases are valid, but I dislike both the existing and the
>> proposed interface.
>>
>> We can change it: x-query-virtio-status isn't stable (it's for debugging
>> and testing).  But even unstable interfaces should only be changed for
>> good, clear reasons.
>>
>> I feel the change from "bits encoded as a number" to "bits as list of
>> descriptive strings plus number for the unknown ones" fell short.  Let
>> me explain.
>>
>> The initial version of the command had "bits encoded as number".  Unless
>> we understand why that was done, we should assume it was done for a
>> reason.  We now know it was: Hyman Huang posted a patch to get it back.
>>
>> Instead of "bits as list of descriptive strings plus number for the
>> unknown ones", we could have done "bits encoded as number, plus list of
>> descriptive strings", or plus some other human-readable encoding.
>>
>> QMP output of the form "WELL_KNOWN_SYMBOL: human readable explanation"
>> smells of encoding structured information in strings, which is a no-no.
>>
>> Perhaps we could have added human-readable output just in HMP.  That's
>> what we normally do.
>>
>> Here are a few possible alternatives to Hyman Huang's patch:
>>
>> 1. Revert commit f3034ad71fc for QMP, keep it for HMP.
>>
>> 2. Replace @unknown-FOO (just the unknown bits) by @FOO-bits (all bits).
>>
>> 3. Add @FOO-bits next to @unknown-FOO, deprecate @unknown-FOO.
>>
>> 4. Create a QAPI enum for the known bits.  Clients can use introspection
>>    to learn the mapping between symbols and bits.  Requires dumbing down
>>    the descriptive strings to just the symbols.  This feels
>>    both overengineered and cumbersome to use.
>>
>> For 2 and 3, I'd prefer to also dumb down the descriptive strings to
>> just the symbols.
>>
>> Thoughts?
>> 
>
> I agree with you. As x-CMD are unstable, perhaps we can go directly to 2?

We can.  It might incovenience existing users of @unknown-FOO.

> (and of course to remove the descriptive strings. Is it easily possible to keep them for the HMP version?)

We could change qmp_virtio_feature_map_t to

    typedef struct {
        int virtio_bit;
        const char *feature_name;
        const char *feature_desc;
    } qmp_virtio_feature_map_t;

and FEATURE_ENTRY() to

    #define FEATURE_ENTRY(bit, name, desc) (qmp_virtio_feature_map_t) \
        { .virtio_bit = (bit), .feature_name = (name), .feature_desc = (desc) }

Aside: POSIX reserves names ending with _t.  An actual clash is of
course vanishingly unlikely.  But avoiding _t suffix is a good habit.

qmp_x_query_virtio_status() could then convert bits to a list of known names
using .feature_name.

To keep the descriptions in HMP, simply print the bits using
.feature_name and .feature_desc, ignoring list of known names returned
by qmp_x_query_virtio_status().

Alternatively, make the code to convert bits to list of strings flexible
enough to be usable in both places.

If qmp_virtio_feature_map_t is still only used in virtio-qmp.c, move its
there.

