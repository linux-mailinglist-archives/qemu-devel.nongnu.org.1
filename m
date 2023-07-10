Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E9D74CC9D
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 08:06:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIk1v-0000ub-E4; Mon, 10 Jul 2023 02:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qIk1r-0000uP-So
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 02:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qIk1n-0000Cd-1j
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 02:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688969140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LJUmKsDa9EA+ysRT1Gmgcs625eMA+pXzOtK59EBu9Go=;
 b=CgJG+FWim9nm9tL72lP4UdIIYPksTUC56h1fNH/o40b11u1nRuzHYgpfjc9P29tpqghEBE
 R+/5wKMKuUsPPvwHFJqiPygfFS3D4OcXZG/1enlyOr0Fk99ZNluoAVXn/KqbgCsa9IwbSU
 xhzXQENqHTZxZ26v2qKplT9mSrhQHSo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-PlBeqFL7MB2wmk29yW6ChA-1; Mon, 10 Jul 2023 02:05:39 -0400
X-MC-Unique: PlBeqFL7MB2wmk29yW6ChA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0DD43811803;
 Mon, 10 Jul 2023 06:05:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82E514067A00;
 Mon, 10 Jul 2023 06:05:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E0B721E6A1F; Mon, 10 Jul 2023 08:05:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: <qemu-devel@nongnu.org>,  <kraxel@redhat.com>,  <berrange@redhat.com>,
 <philmd@linaro.org>,  <marcandre.lureau@redhat.com>,
 <vivek.kasireddy@intel.com>
Subject: Re: [RFC PATCH 6/9] ui/gtk: Add a new parameter to assign
 connectors/monitors to GFX VCs
References: <20230621004355.19920-1-dongwon.kim@intel.com>
 <20230621004355.19920-7-dongwon.kim@intel.com>
 <87h6r1mkhc.fsf@pond.sub.org>
 <46dc1ac2-2ab5-48f7-73da-4160c26c3171@intel.com>
 <878rbrizmo.fsf@pond.sub.org>
 <6351a85a-db49-7d6b-2a55-1ea7c65b3a8e@intel.com>
Date: Mon, 10 Jul 2023 08:05:37 +0200
In-Reply-To: <6351a85a-db49-7d6b-2a55-1ea7c65b3a8e@intel.com> (Dongwon Kim's
 message of "Fri, 7 Jul 2023 10:16:50 -0700")
Message-ID: <87r0pgb8su.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

"Kim, Dongwon" <dongwon.kim@intel.com> writes:

> On 7/7/2023 7:07 AM, Markus Armbruster wrote:
>> "Kim, Dongwon" <dongwon.kim@intel.com> writes:
>>
>>> Hi Markus,
>>>
>>> So I've worked on the description of this param. Can you check if this =
new version looks ok?
>>>
>>> # @connectors:=C2=A0 List of physical monitor/connector names where the=
 GTK
>>> # =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 windows containing the respec=
tive graphics virtual consoles (VCs)
>>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 are to be=
 placed. Index of the connector name in the array directly
>>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indicates=
 the id of the VC.
>>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For examp=
le, with "-device gtk,connectors.0=3DDP-1, connectors.1=3DDP-2",
>>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a physica=
l display connected to DP-1 port will be the target monitor
>>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for VC0 a=
nd the one on DP-2 will be the target for VC1. If there is
>>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no connec=
tor associated with a VC, then that VC won't be placed anywhere
>>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 before th=
e QEMU is relaunched with a proper connector name set for it.
>>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If a conn=
ector name exists for a VC but the display cable is not plugged
>>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in when g=
uest is launched, the VC will be just hidden but will show up
>>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as soon a=
s the cable is plugged in. If a display is connected in the beginning
>>> #=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 but later disconnected, =
VC will immediately be hidden and guest will detect
>>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 it as a d=
isconnected display. This option does not force 1 to 1 mapping
>>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 between t=
he connector and the VC, which means multiple VCs can be placed
>>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 on the sa=
me display but vice versa is not possible (a single VC duplicated
>>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 on a mult=
iple displays)
>>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Since 8.=
1)
>> Better!
>>
>> Suggest to replace "that VC won't be placed anywhere" by "that VC won't
>> be displayed".
>
> yeah, I will update it in v2 and send the new patch shortly.
>
>>
>> Ignorant questions:
>>
>> 1. How would I plug / unplug display cables?
>
> I am not sure if I understood your question correctly but 1 or more guest=
 displays (GTK windows) are bound to a certain physical displays like HDMI =
or DP monitors. So plug/unplug means we disconnect those physical HDMI or D=
P cables manually. Or this manual hot plug in can be emulated by you write =
something to sysfs depending on what display driver you use.

Let's see whether I understand.

A VC is placed on a *physical* monitor, i.e. a window appears on that
monitor.  That monitor's plug / unplug state is passed through to the
guest, i.e. if I physically unplug / plug the monitor, the guest sees an
unplug / plug of its virtual monitor.  Correct?

Permit me another ignorant question...  Say I have a single monitor.  I
configured my X windows manager to show four virtual desktops.  Can I
use your feature to direct on which virtual desktop each VC is placed?

>> 2. If I connect multiple VCs to the same display, what will I see?  Are
>> they multiplexed somehow?
>
> Yeah multiple VCs will be shown on that display. But those could be overl=
apped since those are all placed at (0, 0) of display in many cases.. but t=
his all depends on how the windows manager determines the starting location=
s.

Got it, thanks!

>> Old question not yet answered: Using a list for the mapping means the
>> mapping must be dense, e.g. I can't map #0 and #2 but not #1.  Is this
>> what we want?
>
> No, it doesn't have to be dense. In your example, you can just leave the =
place for VC1 blank. For example, you could do connectors.0=3DDP-1,connecto=
rs.2=3DHDMI-1. But in this case, VC1 won't be activated and stay as disconn=
ected from guest's perspective. I think this info is also needed in v2.

Have you tried this?  I believe it'll fail with something like
"Parameter 'connectors.1' missing".

>> [...]


