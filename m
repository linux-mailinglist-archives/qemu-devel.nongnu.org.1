Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 599CD7B0444
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 14:34:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlTjp-0005Hm-AI; Wed, 27 Sep 2023 08:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlTjl-0005Dn-M6
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 08:33:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlTji-0008PX-NF
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 08:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695818029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FhPoILsI2P3hSv+nVubJ4n26bwJOifcxdteCq3Fu/a4=;
 b=i9IynWgsszNJOLtcCD6k2ekzWmLyYA51w9kUOOixW/b5Up5wMld9boKYp0mwTC9xmnA7oz
 ISJD8PeJzfY4q6l+4Zs/e/QN1A1m2G94drsxQ2AvJ5UrM2djLDR0mtEFSe/kzcPLzATFWy
 lAMXXAC9Nq/eFsKX8lOH/gkGrQvTsEw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-mHIu2WhpMnquVnOV4GqG8w-1; Wed, 27 Sep 2023 08:33:44 -0400
X-MC-Unique: mHIu2WhpMnquVnOV4GqG8w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 073DC280FEC5;
 Wed, 27 Sep 2023 12:33:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB1DE40C2064;
 Wed, 27 Sep 2023 12:33:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AD71A21E6900; Wed, 27 Sep 2023 14:33:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Bernhard Beschow <shentey@gmail.com>,  Gurchetan Singh
 <gurchetansingh@chromium.org>,  qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com,  akihiko.odaki@gmail.com,
 ray.huang@amd.com,  alex.bennee@linaro.org,  hi@alyssa.is,
 ernunes@redhat.com,  manos.pitsidianakis@linaro.org,  philmd@linaro.org
Subject: Re: [PATCH v11 6/9] gfxstream + rutabaga: add initial support for
 gfxstream
References: <20230823012541.485-1-gurchetansingh@chromium.org>
 <20230823012541.485-7-gurchetansingh@chromium.org>
 <B1A4DF8C-3078-48AD-BC8B-F2FD7BA413CF@gmail.com>
 <CAAfnVBk6C7-Vn3buLOh453fz-dRB2vv-4BdkZWjuJDJoWLPAqA@mail.gmail.com>
 <D3C6E21B-E37E-41DA-8131-0C3D9EAF01FD@gmail.com>
 <CAAfnVBngeT8Ezt3osJW2NipFB3r9mJsLXzo1DEo4FtBaZpAO0w@mail.gmail.com>
 <ED6A24A1-42EC-47B2-A5D1-D57135A2D7D6@gmail.com>
 <a54c47b2-6465-ee7a-4815-9c8ca8588191@redhat.com>
Date: Wed, 27 Sep 2023 14:33:42 +0200
In-Reply-To: <a54c47b2-6465-ee7a-4815-9c8ca8588191@redhat.com> (Thomas Huth's
 message of "Wed, 27 Sep 2023 13:34:48 +0200")
Message-ID: <87wmwbbxsp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> On 19/09/2023 20.36, Bernhard Beschow wrote:
>> Am 15. September 2023 02:38:02 UTC schrieb Gurchetan Singh <gurchetansin=
gh@chromium.org>:
>>> On Thu, Sep 14, 2023 at 12:23=E2=80=AFAM Bernhard Beschow <shentey@gmai=
l.com> wrote:
>>>
>>>>
>>>>
>>>> Am 14. September 2023 04:38:51 UTC schrieb Gurchetan Singh <gurchetans=
ingh@chromium.org>:
>>>>> On Wed, Sep 13, 2023 at 4:58=E2=80=AFAM Bernhard Beschow <shentey@gma=
il.com> wrote:

[...]

>>>>>> First, sorry for responding after such a long time. I've been busy w=
ith
>>>>>> work and I'm doing QEMU in my free time.
>>>>>>
>>>>>> In iteration 1 I've raised the topic on capset_names [1] and I haven=
't
>>>>>> seen it answered properly. Perhaps I need to rephrase a bit so here =
we go:
>>>>>> capset_names seems to be colon-separated list of bit options managed=
 by
>>>>>> rutabaga. This introduces yet another way of options handling. There=
 have
>>>>>> been talks about harmonizing options handling in QEMU since apparent=
ly it
>>>>>> is considered too complex [2,3].
>>>>>>
>>>>>> Why not pass the "capset" as a bitfield like capset_mask and have QE=
MU
>>>>>> create "capset" from QOM properties?
>>>>>> IIUC these flags could come from virtio_gpu.h which is already prese=
nt in
>>>>>> the QEMU tree. This would not inly shortcut the dependency on rutaba=
ga here
>>>>>> but would also be more idiomatic QEMU (since it makes the options mo=
re
>>>>>> introspectable by internal machinery).
>>>>>>
>>>>>> Of course the bitfield approach would require modifications in QEMU
>>>>>> whenever rutabaga gains new features. However, I figure that in the =
long
>>>>>> term rutabaga will be quite feature complete such that the benefits =
of
>>>>>> idiomatic QEMU handling will outweigh the decoupling of the projects.
>>>>>>
>>>>>> What do you think?
>>>>>>
>>>>>
>>>>> I think what you're suggesting is something like -device
>>>>> virtio-gpu-rutabaga,capset_mask=3D0x10100 [40, which would be
>>>>> gfxstream_vulkan + cross_domain]?
>>>>
>>>> I was thinking more along the lines of
>>>> `virtio-gpu-rutabaga,gfxstream_vulkan=3Don,cross_domain=3Don` where
>>>> gfxstream_vulkan and cross_domain are boolean QOM properties. This wou=
ld
>>>> make for a human-readable format which follows QEMU style.
>>>>
>>>>>
>>>>> We actually did consider something like that when adding the
>>>>> --context-types flag [with crosvm], but there was a desire for a
>>>>> human-readable format rather than numbers [even if they are in the
>>>>> virtio-gpu spec].
>>>>>
>>>>> Additionally, there are quite a few context types that people are pla=
ying
>>>>> around with [gfxstream-gles, gfxstream-composer] that are launchable =
and
>>>>> aren't in the spec just yet.
>>>>
>>>> Right, QEMU had to be modified for this kind of experimentation. I
>>>> considered this in my last paragraph and figured that in the long run =
QEMU
>>>> *may* prefer more idiomatic option handling since it tries hard to not
>>>> break its command line interface. I'm just pointing this out -- the
>>>> decision is ultimately up to the community.
>>>>
>>>> Why not have dedicated QEMU development branches for experimentation?
>>>> Wouldn't upstreaming new features into QEMU be a good motivation to ge=
t the
>>>> missing pieces into the spec, once they are mature?
>>>
>>>
>>>>>
>>>>> Also, a key feature we want to explicitly **not** turn on all availab=
le
>>>>> context-types and let the user decide.
>>>>
>>>> How would you prevent that with the current colon-separated approach?
>>>> Splitting capset_mask in multiple parameters is just a different
>>>> syntactical representation of the same thing.
>>>>
>>>>> That'll allow guest Mesa in
>>>>> particular to do its magic in its loader.  So one may run Zink + ANV =
with
>>>>> ioctl forwarding, or Iris + ioctl forwarding and compare performance =
with
>>>>> the same guest image.
>>>>>
>>>>> And another thing is one needs some knowledge of the host system to c=
hoose
>>>>> the right context type.  You wouldn't do Zink + ANV ioctl forwarding =
on
>>>>> MacOS.  So I think the task of choosing the right context type will f=
all to
>>>>> projects that depend on QEMU (such as Android Emulator) which have so=
me
>>>>> knowledge of the host environment.
>>>>>
>>>>> We actually have a graphics detector somewhere that calls VK/OpenGL b=
efore
>>>>> launching the VM and sets the right options.  Plan is to port into
>>>>> gfxstream, maybe we could use that.
>>>>
>>>> You could bail out in QEMU if rutabaga_calculate_capset_mask() detects
>>>> conflicting combinations, no?
>>>>
>>>>>
>>>>> So given the desire for human readable formats, being portable across=
 VMMs
>>>>> (crosvm, qemu, rust-vmm??) and experimentation, the string -> capset =
mask
>>>>> conversion was put in the rutabaga API.  So I wouldn't change it for =
those
>>>>> reasons.
>>>>
>>>> What do you mean by being portable across VMMs?
>>>
>>>
>>> Having the API inside rutabaga is (mildly) useful when multiple VMMs ha=
ve
>>> the need to translate from a human-readable format to flags digestible =
by
>>> rutabaga.
>>>
>>> https://android.googlesource.com/device/google/cuttlefish/+/refs/heads/=
main/host/libs/vm_manager/qemu_manager.cpp#452
>>>
>>> https://android.googlesource.com/device/google/cuttlefish/+/refs/heads/=
main/host/libs/vm_manager/crosvm_manager.cpp#353
>>>
>>> https://chromium.googlesource.com/chromiumos/platform2/+/refs/heads/mai=
n/vm_tools/concierge/vm_builder.cc#505
>>>
>>> For these crosvm/qemu launchers, I imagine capset names will be plumbed=
 all
>>> the way through eventually (launch_cvd
>>> --gpu_context=3Dgfxstream-vulkan:cross-domain if you've played around w=
ith
>>> Cuttlefish, or vmc start --gpu_contexts=3Dgfxstream-vulkan if you played
>>> around with Termina VMs).
>>>
>>> I think rust-vmm could also use the same API ("--capset_names") too.
>>>
>>>
>>>> Sure, QEMU had to be taught new flags before being able to use new
>>>> rutabaga features. I agree that this comes with a certain inconvenienc=
e.
>>>> But it may also be inconvenient for QEMU to deal with additional ad-hoc
>>>> options parsing when there are efforts for harmonization.
>>>>
>>>> Did my comments shed new light into the discussion?
>>>
>>>
>>> Yes, they do.  I agree with you that both crosvm/qemu have too many fla=
gs,
>>> and having a stable command line interface is important.  We are aiming=
 for
>>> stability with the `--capset_names=3D{colon string}` command line, and =
at
>>> least for crosvm looking to deprecate older options [since we've never =
had
>>> an official release of crosvm yet].
>>>
>>> I do think:
>>>
>>> 1) "capset_names=3Dgfxstream-vulkan:cross-domain"
>>> 2) "cross-domain=3Don,gfxstream-vulkan=3Don"
>>>
>>> are similar enough.  I would choose (1) for since I think not duplicati=
ng
>>> the [name] -> flag logic and having a similar interface across VMMs + V=
MM
>>> launchers is ever-so slightly useful.
>>
>> I think we've now reached a good understanding of the issue. It's now up=
 to the QEMU community to make a choice. So I'm cc'ing Markus and Thomas as=
 the experts of the topic.
>
> Sorry for the late reply ... but I'm also not really an expert here. But =
I think the colon string (1) looks like a less common way for handling sett=
ings in QEMU. The option (2) looks preferable to me.

For CLI option arguments, we definitely want (2) and not (1), and we
definitely want to use an existing parser.

For complex configuration, I'd recommend a QAPI-based approach.

To provide more specific advice, I'd have to understand the structure of
your intended configuration first.


