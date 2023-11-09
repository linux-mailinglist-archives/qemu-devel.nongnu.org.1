Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3DB7E6421
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 08:02:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0z2Q-0006SI-5c; Thu, 09 Nov 2023 02:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r0z2N-0006S5-6y
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 02:01:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r0z2K-0000nc-13
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 02:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699513265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FNkpCgZCLGMWVXiZsG85x8HSjKr0xjK17BhIKUyjc/Y=;
 b=NAA2v2TrZiUIcjEfpDgelfcXXk2WT4rWOCOLBaDijQXpSztg5B1WaOW+kKtbAar3A+N1x8
 YKHTPFYYE86tpbyk+sxVZA84okB232iia5xVz0mS5gndNewP+QqpzVrKTTS/zVJtmMFC0u
 ZkT3n+ufpMnLnmScjlaalu4toGGFNq4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-G4nBLgTcPQCRHYes_LUrwA-1; Thu, 09 Nov 2023 02:01:02 -0500
X-MC-Unique: G4nBLgTcPQCRHYes_LUrwA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C1FA85FBE0;
 Thu,  9 Nov 2023 07:01:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D647E1121306;
 Thu,  9 Nov 2023 07:01:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 91D2A21E6A1F; Thu,  9 Nov 2023 08:01:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kamay Xutax <admin@xutaxkamay.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?Q?Ma?=
 =?utf-8?Q?rc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH RFC v1 0/1] clipboard sharing implementation for SDL
References: <20231108022139.12503-1-admin@xutaxkamay.com>
Date: Thu, 09 Nov 2023 08:01:00 +0100
In-Reply-To: <20231108022139.12503-1-admin@xutaxkamay.com> (Kamay Xutax's
 message of "Wed, 8 Nov 2023 03:21:38 +0100")
Message-ID: <87pm0j76mr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

Kamay Xutax <admin@xutaxkamay.com> writes:

> Hello,
>
> This is my first try contributing to QEMU,

Welcome!

> and I would like some advices before merging my patch into master branch.

First piece of advice: it's a busy mailing list, and to get people's
attention, cc: them.  For a patch, you want to cc: maintainers of the
code you patch.  To find them, use scripts/get_maintainer.pl and
exercise judgement.  Let me show you:

    $ scripts/get_maintainer.pl ./0001-*patch

    Gerd Hoffmann <kraxel@redhat.com> (odd fixer:Graphics)
    "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com> (odd fixer:Graph=
ics)
    Paolo Bonzini <pbonzini@redhat.com> (maintainer:Meson)
    "Daniel P. Berrang=C3=A9" <berrange@redhat.com> (reviewer:Meson)
    Thomas Huth <thuth@redhat.com> (reviewer:Meson)
    "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org> (reviewer:Meson)
    qemu-devel@nongnu.org (open list:All patches CC here)

Since the patch's Meson part is straightforward, I'd just cc: the two
Graphics people,  I'm doing it in this message, so you don't have to.

[...]


