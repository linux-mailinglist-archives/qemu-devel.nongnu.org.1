Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F18737AD4
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 07:52:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBqkb-0001Xt-MD; Wed, 21 Jun 2023 01:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qBqkT-0001Sm-J4
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 01:51:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qBqkR-0000ek-L8
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 01:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687326678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94bWjgmPQTS0VM/ViW1Pt7rQuKWrmWuAteKaUKpuzMM=;
 b=BjOAQjZIFvQ65xio7CKMLK/kqqYVNmyUaFN7iFjqshfXoeZr6VmsIT58bQjAtWfAIrqGtb
 qwo6sHbFBAvI3aqQQu+dPHEKpaq8JJWmP6isHocX72hpIuuZUjPVxmZjlGRSc7AFgXR5Hu
 e+lxsaIOLkPkh6p+DSmiVPs3DXUOErE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-US3R7pDLObOTqOwqCuV_cg-1; Wed, 21 Jun 2023 01:51:13 -0400
X-MC-Unique: US3R7pDLObOTqOwqCuV_cg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FD1D800CAC;
 Wed, 21 Jun 2023 05:51:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27BB82166B32;
 Wed, 21 Jun 2023 05:51:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E38FB21E676C; Wed, 21 Jun 2023 07:51:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org,  kraxel@redhat.com,  berrange@redhat.com,
 philmd@linaro.org,  marcandre.lureau@redhat.com, vivek.kasireddy@intel.com
Subject: Re: [RFC PATCH 6/9] ui/gtk: Add a new parameter to assign
 connectors/monitors to GFX VCs
References: <20230621004355.19920-1-dongwon.kim@intel.com>
 <20230621004355.19920-7-dongwon.kim@intel.com>
Date: Wed, 21 Jun 2023 07:51:11 +0200
In-Reply-To: <20230621004355.19920-7-dongwon.kim@intel.com> (Dongwon Kim's
 message of "Tue, 20 Jun 2023 17:43:52 -0700")
Message-ID: <87h6r1mkhc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Dongwon Kim <dongwon.kim@intel.com> writes:

> From: Vivek Kasireddy <vivek.kasireddy@intel.com>
>
> The new parameter named "connector" can be used to assign physical
> monitors/connectors to individual GFX VCs such that when the monitor
> is connected or hotplugged, the associated GTK window would be
> moved to it. If the monitor is disconnected or unplugged, the
> associated GTK window would be hidden and a relevant disconnect
> event would be sent to the Guest.
>
> Usage: -device virtio-gpu-pci,max_outputs=3D2,blob=3Dtrue,...
>        -display gtk,gl=3Don,connectors.0=3DeDP-1,connectors.1=3DDP-1.....
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>

[...]

> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -1315,13 +1315,22 @@
>  # @show-menubar: Display the main window menubar.  Defaults to "on".
>  #     (Since 8.0)
>  #
> +# @connectors:  List of physical monitor/connector names where the GTK
> +#               windows containing the respective graphics virtual conso=
les
> +#               (VCs) are to be placed. If a mapping exists for a VC, it
> +#               will be moved to that specific monitor or else it would
> +#               not be displayed anywhere and would appear disconnected
> +#               to the guest.
> +#               (Since 8.1)

Please format like

   # @connectors: List of physical monitor/connector names where the GTK
   #     windows containing the respective graphics virtual consoles
   #     (VCs) are to be placed.  If a mapping exists for a VC, it will
   #     be moved to that specific monitor or else it would not be
   #     displayed anywhere and would appear disconnected to the guest.
   #     (Since 8.1)

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

The meaning of @connectors is less than clear.  The phrase "If a mapping
exists for a VC" suggests it is a mapping of sorts.  "List of physical
monitor/connector names" indicates it maps to physical monitor /
connector name.  What does it map from?  VC number?  How are VCs
numbered?  Is it the same number we use in QOM /backend/console[NUM]?

Using a list for the mapping means the mapping must be dense, e.g. I
can't map #0 and #2 but not #1.  Is this what we want?

The sentence "If a mapping exists" confusing has a dangling else
ambiguity of sorts.  I can interpret it as

    If a mapping exists for a VC:
        the window will be moved to that specific monitor
        or else it would not be displayed anywhere and would appear ...

or as

    If a mapping exists for a VC:
        the window will be moved to that specific monitor
    or else it would not be displayed anywhere and would appear ...

I think we have three cases:

0. No mapping provided

1. Mapping provided, and the named monitor / connector exists

2. Mapping provided, and the named monitor / connector does not exist

We can go from case 1 to 2 (disconnect) and vice versa (connect) at any
time.

Please spell out behavior for each case, and for the transitions between
case 1 and 2.

> +#
>  # Since: 2.12
>  ##
>  { 'struct'  : 'DisplayGTK',
>    'data'    : { '*grab-on-hover' : 'bool',
>                  '*zoom-to-fit'   : 'bool',
>                  '*show-tabs'     : 'bool',
> -                '*show-menubar'  : 'bool'  } }
> +                '*show-menubar'  : 'bool',
> +                '*connectors'    : ['str'] } }
>=20=20
>  ##
>  # @DisplayEGLHeadless:

[...]


