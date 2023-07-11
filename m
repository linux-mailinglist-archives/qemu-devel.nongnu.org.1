Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C781574E771
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 08:38:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ6za-0004K1-6p; Tue, 11 Jul 2023 02:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qJ6zK-0004I5-Ev
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 02:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qJ6zD-0004UH-Mf
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 02:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689057392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qF18PCVin5fjDpmyimvgqhqbqQpjAWXRvTu3RAOwcLA=;
 b=iP6hOUe5zHeMn+l2EZjBAVHiFctQUC0DbBLAqV9sW4mAo5PieatWc38i3hOaW6ysQcPRP+
 GksEm8qTy02Cded5GNLPbUBkLI+JqmKRRQkwVY/TFCN1svA5EERp3TKOThj04ILTfm2OW0
 juWQ0bYQ6MZJtQbD41dG+IcEnndjr04=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-rkDNa8MDN1SWeAJEebI8Kg-1; Tue, 11 Jul 2023 02:36:30 -0400
X-MC-Unique: rkDNa8MDN1SWeAJEebI8Kg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26894830F46;
 Tue, 11 Jul 2023 06:36:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8BA32166B26;
 Tue, 11 Jul 2023 06:36:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DB5A721E6A1F; Tue, 11 Jul 2023 08:36:28 +0200 (CEST)
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
 <87r0pgb8su.fsf@pond.sub.org>
 <ed732fc3-bb1d-42da-e179-0dcd08c663a8@intel.com>
Date: Tue, 11 Jul 2023 08:36:28 +0200
In-Reply-To: <ed732fc3-bb1d-42da-e179-0dcd08c663a8@intel.com> (Dongwon Kim's
 message of "Mon, 10 Jul 2023 13:31:01 -0700")
Message-ID: <878rbnymxf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

"Kim, Dongwon" <dongwon.kim@intel.com> writes:

> On 7/9/2023 11:05 PM, Markus Armbruster wrote:
>> "Kim, Dongwon" <dongwon.kim@intel.com> writes:
>>
>>> On 7/7/2023 7:07 AM, Markus Armbruster wrote:

[...]

>>>> Ignorant questions:
>>>>
>>>> 1. How would I plug / unplug display cables?
>>>
>>> I am not sure if I understood your question correctly but 1 or more guest displays (GTK windows) are bound to a certain physical displays like HDMI or DP monitors. So plug/unplug means we disconnect those physical HDMI or DP cables manually. Or this manual hot plug in can be emulated by you write something to sysfs depending on what display driver you use.
>>
>> Let's see whether I understand.
>>
>> A VC is placed on a *physical* monitor, i.e. a window appears on that
>> monitor.  That monitor's plug / unplug state is passed through to the
>> guest, i.e. if I physically unplug / plug the monitor, the guest sees an
>> unplug / plug of its virtual monitor.  Correct?
>
> This is correct. When a display is disconnected, "monitor-changed" GTK event will be triggered then it will call gd_ui_size(0,0) which makes the guest display connection status to "disconnected".

Thanks!

>> Permit me another ignorant question...  Say I have a single monitor.  I
>> configured my X windows manager to show four virtual desktops.  Can I
>> use your feature to direct on which virtual desktop each VC is placed?
>
> Would those virtual desktops will be their own connector names like HDMI or DP? We use the connector name for the actual physical display you see when running xrandr.

Output of xrandr is identical on different virtual desktops for me.

> I don't know how virtual desktops are created and managed but if they don't have their own connector names that GTK API can read, it won't work within our current implementation.

After searching around a bit...  Virtual desktops, a.k.a. workspaces,
are a window manager thing.  Completely different from X displays and
monitors.  Programs can mess with placement (wmctrl does).  No idea
whether GDK provides an interface for it.  No need to discuss this
further at this time.

[...]

>>>> Old question not yet answered: Using a list for the mapping means the
>>>> mapping must be dense, e.g. I can't map #0 and #2 but not #1.  Is this
>>>> what we want?
>>>
>>> No, it doesn't have to be dense. In your example, you can just leave the place for VC1 blank. For example, you could do connectors.0=DP-1,connectors.2=HDMI-1. But in this case, VC1 won't be activated and stay as disconnected from guest's perspective. I think this info is also needed in v2.
>>
>> Have you tried this?  I believe it'll fail with something like
>> "Parameter 'connectors.1' missing".
>
> Just tested it. Yeah you are correct. I think I had a bad assumption. Let me take a look to see if I can make it work as I assumed.

If sparse mappings make sense, we should provide for them, I think.

An array like '*connectors': ['str'] maps from integers 0, 1, ...  It
can't do sparse (you can't omit integers in the middle).

Instead of omitting them, we could map them to null: '*connectors':
['StrOrNull'].  JSON input looks like [null, "HDMI-A-0"].  Since dotted
key syntax does not support null at this time, you'd have to use JSON.

Only an object can do sparse.  However, the QAPI schema language can't
express "object where the keys are integers and the values are strings".
We'd have to use 'any', and check everything manually.

Hmm.  Thoughts?

>>>> [...]


