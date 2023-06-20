Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA41737561
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:51:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhNg-0007sq-Sj; Tue, 20 Jun 2023 15:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc94@poolhem.se>) id 1qBhNY-0007lY-Ow
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 15:51:05 -0400
Received: from mailout12.inleed.net ([2a0b:dc80:cafe:112::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc94@poolhem.se>) id 1qBhNV-0002bs-GY
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 15:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=poolhem.se; 
 s=x;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zQhuoDRUVbzJQe+BYYtfwvkQjxD3rCBDf5NvxUbceCs=; b=uKi71bOTSkFZMgc82KV16KRvhl
 A3+G1Zz+rI+uWtakzrKcDIkqKjMuYjerzf41Igwl09lgbexuuRg2Qwt0zFwUCRd3bE0dCOJMVbySO
 Y8JYKGs2BGzM8DX6HUG/LLzpeFmOoxIAYr8isroMS37SgLbyQH+DmGx7kJApdZ+QuwiZOdeam9JTb
 Woh/tPBTkk4bRowiHQBP7lHH8lhSUV1CKXuUZ8REs39ocBEYA101m4QOsYcmq1n0j9r8/9huwkHLn
 p5cPNTGVy1kzn0YK2twq/P9NgBk2WiYYcUh+TY8sNMr8Q3Apdgt2q4T3I5qTBz14HvzQD1BYrVxwo
 1cOK4/BA==;
Received: from [213.115.245.47] (helo=balrog.lkp.se)
 by ns12.inleed.net with esmtpa (Exim 4.96-58-g4e9ed49f8)
 (envelope-from <hc94@poolhem.se>) id 1qBhNS-00FKjw-2l;
 Tue, 20 Jun 2023 21:50:58 +0200
Date: Tue, 20 Jun 2023 21:50:43 +0200
From: Henrik Carlqvist <hc94@poolhem.se>
To: Daniel P. =?ISO-8859-1?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: hc981@poolhem.se, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org
Subject: Re: [PATCH v7] Emulate dip switch language layout settings on SUN
 keyboard
Message-Id: <20230620215043.6124c450.hc94@poolhem.se>
In-Reply-To: <ZJFv4Hq8RMVOUum/@redhat.com>
References: <20230304220754.0c6ae562.hc981@poolhem.se>
 <ZCLzUyiDeKLfQqWT@redhat.com>
 <20230328191958.3e3eb5e4.hc981@poolhem.se>
 <ZCMq/imcAq0ApLQp@redhat.com>
 <20230328221608.328ab80f.hc981@poolhem.se>
 <20230430225533.1a57879a.hc981@poolhem.se>
 <20230608181439.7ea3a5c5.hc981@poolhem.se>
 <4e8f027a-ca00-c54f-ef2f-f0df1f5b2f9e@ilande.co.uk>
 <20230610122912.0fc157de.hc981@poolhem.se>
 <20230611014751.22f22674.hc94@poolhem.se>
 <ZJFv4Hq8RMVOUum/@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Id: henrik@poolhem.se
Received-SPF: none client-ip=2a0b:dc80:cafe:112::1;
 envelope-from=hc94@poolhem.se; helo=mailout12.inleed.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Tue, 20 Jun 2023 10:22:40 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

Thanks for your feedback!

> Assuming you have docutils installed, QEMU will build the manual by
> default and print any issues on console during build. You can point
> your browser to $BUILD/docs/manual/system/index.html to see the result.

It seems as if I have docutils version 0.17.1 installed. However the
build/docs directory only contains a symlink to the config directory in
../../docs after make is completed.

> For future reference, if you want to put some questions/notes in the
> submission, it is best to keep them separate from the commit message
> text, as the questions/notes shouldn't end up in git history. To
> separate them, put questions  immediately after the '---' that separate
> the commit message from the diffstat

Thanks! Will do...

> You need to remove the space between :ref: and `keyboard`.
>=20
> You'll also need to add it to a ToC (table of contents) otherwise
> the build system complains.
>=20
> I'd suggest putting the new file at docs/system/devices/keyboards.rst
> and adding to the ToC in docs/system/device-emulation.rst

I will update the .rst files and placements, hopefully the coming weekend a=
nd
come back with an updated patch. However, until I am able to build something
from those .rst files, I can only follow your instructions to finally get t=
hem
right.

Best regards Henrik

