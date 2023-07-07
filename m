Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C44D74B2B8
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 16:08:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHm7k-0005hp-1D; Fri, 07 Jul 2023 10:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHm7X-0005e6-LV
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHm7W-0001tr-7H
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688738853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CkVdIs3LEnjs10+GeELpkFDUetEQFuGh+Xdww1go3rc=;
 b=O2mLqGOOv+6uk25eMuMAV5xJsb2l9mMQPD6pB6NFqMWs+5cU8qPmi9sPepuysdnwxJsR2/
 LxkrljZIRs0lIZALoCvNmeBz5Spml9gvuldET1FHi5JpBSbV+0TnLSvwB/hJy+PXSU2Ufm
 IZk2NFinwcQydg8BoFmZ/iSB/eAopkg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-kZt50Z0wN_eQ3AqySftI0g-1; Fri, 07 Jul 2023 10:07:30 -0400
X-MC-Unique: kZt50Z0wN_eQ3AqySftI0g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 528283815F80;
 Fri,  7 Jul 2023 14:07:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30412492C13;
 Fri,  7 Jul 2023 14:07:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 259CB21E6A1F; Fri,  7 Jul 2023 16:07:27 +0200 (CEST)
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
Date: Fri, 07 Jul 2023 16:07:27 +0200
In-Reply-To: <46dc1ac2-2ab5-48f7-73da-4160c26c3171@intel.com> (Dongwon Kim's
 message of "Tue, 27 Jun 2023 11:22:33 -0700")
Message-ID: <878rbrizmo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

> Hi Markus,
>
> So I've worked on the description of this param. Can you check if this ne=
w version looks ok?
>
> # @connectors:=C2=A0 List of physical monitor/connector names where the G=
TK
> # =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 windows containing the respecti=
ve graphics virtual consoles (VCs)
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 are to be p=
laced. Index of the connector name in the array directly
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indicates t=
he id of the VC.
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For example=
, with "-device gtk,connectors.0=3DDP-1, connectors.1=3DDP-2",
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a physical =
display connected to DP-1 port will be the target monitor
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for VC0 and=
 the one on DP-2 will be the target for VC1. If there is
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no connecto=
r associated with a VC, then that VC won't be placed anywhere
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 before the =
QEMU is relaunched with a proper connector name set for it.
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If a connec=
tor name exists for a VC but the display cable is not plugged
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in when gue=
st is launched, the VC will be just hidden but will show up
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as soon as =
the cable is plugged in. If a display is connected in the beginning
> #=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 but later disconnected, VC=
 will immediately be hidden and guest will detect
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 it as a dis=
connected display. This option does not force 1 to 1 mapping
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 between the=
 connector and the VC, which means multiple VCs can be placed
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 on the same=
 display but vice versa is not possible (a single VC duplicated
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 on a multip=
le displays)
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Since 8.1)

Better!

Suggest to replace "that VC won't be placed anywhere" by "that VC won't
be displayed".

Ignorant questions:

1. How would I plug / unplug display cables?

2. If I connect multiple VCs to the same display, what will I see?  Are
they multiplexed somehow?

Old question not yet answered: Using a list for the mapping means the
mapping must be dense, e.g. I can't map #0 and #2 but not #1.  Is this
what we want?

[...]


