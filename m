Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5706D7BD969
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 13:19:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpoHt-0001bE-4p; Mon, 09 Oct 2023 07:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qpoHo-0001WL-7j
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:18:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qpoHl-0006oR-6Z
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696850332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bYZP7/GKK/xt/eBORZQVNhn1nb24eOfUJWk6AJFCUz4=;
 b=dHELV+9K3DqYoreDQm6FHaMNMniuzljYMVDISa84KnC7E1Z5acqI4BBDmAGARF5eoKTD2Y
 EQ+/gZG7BCH+qzjYcrCCYZEqdSfW+g2cuI5QtLlu5FFHW2pGiS3gDLGC3hc3z/bMZ1v9I2
 DJ14nJn/8Vb8HONilCRi1SFJeFRtHuM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-ZyjljX6RM86fd6l4iLmdfg-1; Mon, 09 Oct 2023 07:18:44 -0400
X-MC-Unique: ZyjljX6RM86fd6l4iLmdfg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 720D0811E8E;
 Mon,  9 Oct 2023 11:18:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C3132026D37;
 Mon,  9 Oct 2023 11:18:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D862121E6904; Mon,  9 Oct 2023 13:18:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Bernhard Beschow <shentey@gmail.com>,  Gurchetan Singh
 <gurchetansingh@chromium.org>,  Akihiko Odaki <akihiko.odaki@gmail.com>,
 qemu-devel@nongnu.org,  marcandre.lureau@redhat.com,  ray.huang@amd.com,
 alex.bennee@linaro.org,  hi@alyssa.is,  ernunes@redhat.com,
 manos.pitsidianakis@linaro.org,  philmd@linaro.org
Subject: Re: [PATCH v11 6/9] gfxstream + rutabaga: add initial support for
 gfxstream
References: <20230823012541.485-1-gurchetansingh@chromium.org>
 <20230823012541.485-7-gurchetansingh@chromium.org>
 <B1A4DF8C-3078-48AD-BC8B-F2FD7BA413CF@gmail.com>
 <CAAfnVBk6C7-Vn3buLOh453fz-dRB2vv-4BdkZWjuJDJoWLPAqA@mail.gmail.com>
 <D3C6E21B-E37E-41DA-8131-0C3D9EAF01FD@gmail.com>
 <CAAfnVBngeT8Ezt3osJW2NipFB3r9mJsLXzo1DEo4FtBaZpAO0w@mail.gmail.com>
 <ED6A24A1-42EC-47B2-A5D1-D57135A2D7D6@gmail.com>
 <83364d82-1a1e-4483-aad4-249ce30206a0@gmail.com>
 <CAAfnVBmAJL4TsRFcfwNyXKG7FESNDV_k1m1HW8_oaOio0WdWKA@mail.gmail.com>
 <EF2A76D3-EC1E-4065-8B1A-229E5E9E804F@gmail.com>
 <2c7d6973-befb-6db6-49a7-c08f195758b1@redhat.com>
Date: Mon, 09 Oct 2023 13:18:41 +0200
In-Reply-To: <2c7d6973-befb-6db6-49a7-c08f195758b1@redhat.com> (Thomas Huth's
 message of "Sat, 30 Sep 2023 12:28:08 +0200")
Message-ID: <87ttr011ta.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On 29/09/2023 17.06, Bernhard Beschow wrote:
>> Am 21. September 2023 23:44:42 UTC schrieb Gurchetan Singh <gurchetansin=
gh@chromium.org>:
>>> On Tue, Sep 19, 2023 at 3:07=E2=80=AFPM Akihiko Odaki <akihiko.odaki@gm=
ail.com>
>>> wrote:
>>>
>>>> On 2023/09/20 3:36, Bernhard Beschow wrote:
>>>>>
>>>>>
>>>>> Am 15. September 2023 02:38:02 UTC schrieb Gurchetan Singh <gurchetan=
singh@chromium.org>:

[...]

>>>>>> I do think:
>>>>>>
>>>>>> 1) "capset_names=3Dgfxstream-vulkan:cross-domain"
>>>>>> 2) "cross-domain=3Don,gfxstream-vulkan=3Don"
>>>>>>
>>>>>> are similar enough.  I would choose (1) for since I think not duplic=
ating
>>>>>> the [name] -> flag logic and having a similar interface across VMMs =
+ VMM
>>>>>> launchers is ever-so slightly useful.
>>>>>
>>>>> I think we've now reached a good understanding of the issue. It's now=
 up
>>>>> to the QEMU community to make a choice. So I'm cc'ing Markus and Thom=
as as
>>>>> the experts of the topic.
>>>>
>>>> As a virtio-gpu user, I'm slightly inclined to (2) since it would be
>>>> easier to implement the same option for virtio-gpu-virgl when a need
>>>> arises.
>>>
>>> The rutabaga/virgl implementations will likely be done via DEFINE_PROP_=
BIT,
>>> no?  For virgl, it'll set the virgl flags, and for rutabaga, it'll set =
the
>>> capset mask.  So it would be different.
>>>
>>> That said, the change isn't too bad to make.  Here's the key part:
>>>
>>> +++ b/hw/display/virtio-gpu-rutabaga.c
>>> @@ -1084,6 +1084,14 @@ static Property virtio_gpu_rutabaga_properties[]=
 =3D {
>>>      DEFINE_PROP_STRING("wayland_socket_path", VirtIOGPURutabaga,
>>>                         wayland_socket_path),
>>>      DEFINE_PROP_STRING("wsi", VirtIOGPURutabaga, wsi),
>>> +    DEFINE_PROP_BIT("gfxstream-vulkan-experimental", VirtIOGPURutabaga,
>>> +                    capset_mask, RUTABAGA_CAPSET_GFXSTREAM_VULKAN, fal=
se),
>>> +    DEFINE_PROP_BIT("cross-domain-experimental", VirtIOGPURutabaga,
>>> +                    capset_mask, RUTABAGA_CAPSET_CROSS_DOMAIN, false),
>>> +    DEFINE_PROP_BIT("gfxstream-gles-experimental", VirtIOGPURutabaga,
>>> +                    capset_mask, RUTABAGA_CAPSET_GFXSTREAM_GLES, false=
),
>>> +    DEFINE_PROP_BIT("gfxstream-composer-experimental", VirtIOGPURutaba=
ga,
>>> +                    capset_mask, RUTABAGA_CAPSET_GFXSTREAM_COMPOSER,
>>> false),
>>>      DEFINE_PROP_END_OF_LIST(),
>>> };
>>
>> Nice!
>>
>> I think the current approach for experimental and deprecated properties =
is to not pre- or postfix them but issue a warning at runtime when used, se=
e e.g. here: https://lore.kernel.org/qemu-devel/20230710121543.197250-18-th=
uth@redhat.com/ That way, the command line interface won't change once the =
properties become stable. So if you omit the "-experimental" postfixes Andr=
oid Studio wouldn't need to adapt.
>
> That's for deprecated options only. For experimental new properties, plea=
se use the "x-" prefix instead of the "-experimental" suffix.

Thomas is right.

In the QAPI schema, we have the means to avoid renaming on transition
from unstable to stable.  However, device properties remain outside
QAPI.

In case you're curious, docs/devel/qapi-code-gen.rst:

    Special features
    ~~~~~~~~~~~~~~~~

    Feature "deprecated" marks a command, event, enum value, or struct
    member as deprecated.  It is not supported elsewhere so far.
    Interfaces so marked may be withdrawn in future releases in accordance
    with QEMU's deprecation policy.

    Feature "unstable" marks a command, event, enum value, or struct
    member as unstable.  It is not supported elsewhere so far.  Interfaces
    so marked may be withdrawn or changed incompatibly in future releases.

You can even configure policy for handling use of deprecated or unstable
stuff:

    -compat [deprecated-input=3Daccept|reject|crash][,deprecated-output=3Da=
ccept|hide]
                    Policy for handling deprecated management interfaces
    -compat [unstable-input=3Daccept|reject|crash][,unstable-output=3Daccep=
t|hide]
                    Policy for handling unstable management interfaces

For more, see qapi/compat.json and commit 6dd75472d5^..dbb675c19a.


