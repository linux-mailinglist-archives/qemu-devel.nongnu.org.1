Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4273C7122C8
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:56:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2TEL-0005tM-3Z; Fri, 26 May 2023 04:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2TEJ-0005sn-Ez
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:55:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2TEH-0006Ji-QR
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685091319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BK02zztPL0GoROyCOP6mcsZLiAnqXJ27p3pPuTBXD/g=;
 b=f7QdS+xqhxIDxO8ckTWJrk37VabsLEV/fgMWKCrqwVsAwG2eoQvTL6ieixtTDFmm8Vn8xU
 RjttvT1+2a9zO/DRCT2XuTmhlLyHo6qf7N5SBL5phfry3SX2Hv1NYFfU8Io+tAfRrqaPY3
 bjEuTysKlZhLf6Pxmgzgv7UXzSAwLSc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-q_YreTlaPxef-tIJI0YI4g-1; Fri, 26 May 2023 04:55:01 -0400
X-MC-Unique: q_YreTlaPxef-tIJI0YI4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F14003825BBC
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 08:55:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D129D1121314
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 08:55:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C2D2021E692E; Fri, 26 May 2023 10:54:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: libvir-list@redhat.com,  Andrea Bolognani <abologna@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: query-command-line-options
References: <cover.1677511354.git.pkrempa@redhat.com>
 <8718b22eda052662087087b4ce659b054974c9e0.1677511354.git.pkrempa@redhat.com>
 <CABJz62PHsQHiyo06PtfcDeS1LddYyDw2pC_seObtZcLR5cPQyQ@mail.gmail.com>
 <Y/zng8+7s05O0tRd@angien.pipo.sk>
 <CABJz62OMWXAx_ExYqvvg1DvcHkiP+SkwNMQZ+56QwoHpsNBqGA@mail.gmail.com>
 <87jzzsc320.fsf_-_@pond.sub.org> <ZAdKHkUIKjPLhFn7@angien.pipo.sk>
Date: Fri, 26 May 2023 10:54:59 +0200
In-Reply-To: <ZAdKHkUIKjPLhFn7@angien.pipo.sk> (Peter Krempa's message of
 "Tue, 7 Mar 2023 15:28:46 +0100")
Message-ID: <87sfbjcw0s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Stefan, one question regarding your commit 40e07370f21 inline.

Peter Krempa <pkrempa@redhat.com> writes:

[...]

> In fact I strive to eliminate it after your suggestions, but we can't
> still detect the few outstanding flags from anywhere else.
>
> List of currently outstanding queries using query-command-line-options:

Let me translate these into English questions:

>     { "fsdev", "multidevs", QEMU_CAPS_FSDEV_MULTIDEVS },

Does -fsdev have parameter "multidevs"?

It does since v4.2.

Aside: not documented in -help.

9p seems entirely absent from the QAPI schema.

>     { "machine", "hpet", QEMU_CAPS_MACHINE_HPET },

Does -machine have parameter "hpet"?

Aside: not documented in -help.

Since this is a special case in q-c-l-o (commit 40e07370f21 qemu-config:
restore "machine" in qmp_query_command_line_options()), the actual
question is whether any non-abstract machine class has a property
"hpet".

PC machines do since v5.2. (the HPET device is older, but it wasn't
configured with a machine property until v5.2).

Aside: "any non-abstract machine class"...  I think it used to be just
the current machine.  See the code taken out by commit d8fb7d0969d (vl:
switch -M parsing to keyval).  Accident in commit 40e07370f21?  Stefan?

There's CONFIG_HPET, but I can't see offhand how it plays together with
the machine property.

We could check for the machine property directly: check the properties
of the machine class in question with qom-list-properties, e.g.

    {"execute": "qom-list-properties",
     "arguments": {"typename": "pc-q35-8.1-machine"}}

To find all non-abstract machine classes, use

    {"execute": "qom-list-types", "arguments": {"implements": "machine"}}

>     { "sandbox", NULL, QEMU_CAPS_SECCOMP_SANDBOX },

Does option -sandbox exist?

It does since v1.2.  If CONFIG_SECCOMP is off, actually using it is a
fatal error.  Compiling out the option entirely would be more useful, I
guess.

Is this probe still useful?

>     { "spice", NULL, QEMU_CAPS_SPICE },

Does option -spice exist?

Since v7.0, it exists when CONFIG_SPICE is on.  I believe using it can
still fail when the module can't be loaded.

From v0.14 to v6.2 it exists even when CONFIG_SPICE is off, but actually
using it is a fatal error.

>     { "spice", "gl", QEMU_CAPS_SPICE_GL },

Does option -spice have parameter "gl"?

It does when CONFIG_OPENGL and CONFIG_OPENGL are both on (since v2.6).

query-display-options returns a value "gl" (since v2.12).  *Maybe*
that's a suitable witness.

>     { "spice", "rendernode", QEMU_CAPS_SPICE_RENDERNODE },

Does option -spice have parameter "rendernode"?

It does when CONFIG_OPENGL and CONFIG_OPENGL are both on (since v2.9).

Maybe query-display-options can serve for this one, too.

>     { "vnc", "power-control", QEMU_CAPS_VNC_POWER_CONTROL },

Does option -vnc have parameter "power-control"?

It does since v6.0.

Aside: -help does not document any of its parameters.

query-display-options is not implemented for VNC.  If we implement it,
it might become a suitable witness.


