Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAB0738E51
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 20:15:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC2M8-00086M-Kn; Wed, 21 Jun 2023 14:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc94@poolhem.se>) id 1qC2M6-00085w-RE
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:14:58 -0400
Received: from mailout12.inleed.net ([2a0b:dc80:cafe:112::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc94@poolhem.se>) id 1qC2M4-0001s4-Jj
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=poolhem.se; 
 s=x;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Lrly/rtlLlyTAIk7R5disLPNvopey7UogWd/EWYJJ1A=; b=SPq4wXUHg8AqZtmP35o8d9XISr
 raH6ISF1s9LKCnJDIfJRJCjURD3K+45SfcYWCn7bKygI6bBVTD8aJ6HaDIoaiZACu8D9zxPMMGhFm
 j62s/2EJX5WF/XyENGGN6YTXMJkK/bBtjewwv+kAw27iwGSbADCl1f3DJyVUYkxd6Bp1aMDGLc9QN
 d2UwxM1ij7LY6Sc9fnhl4fzWROBnV+beH9mo5uv7ja+aKzfpkmuS7t3OvjqfayXTX7wfbnBXTPzwq
 QyiHRIBRXndyCYXG57oT46SRLAQ8nMe1rjseZuW5RYK4sDFrLRBFPMH6nVJ6+osz5W7mvdWUYXnlb
 UGBx+TZQ==;
Received: from [213.115.245.47] (helo=balrog.lkp.se)
 by ns12.inleed.net with esmtpa (Exim 4.96-58-g4e9ed49f8)
 (envelope-from <hc94@poolhem.se>) id 1qC2M1-00AWMA-0R;
 Wed, 21 Jun 2023 20:14:53 +0200
Date: Wed, 21 Jun 2023 20:14:47 +0200
From: Henrik Carlqvist <hc94@poolhem.se>
To: Daniel P. =?ISO-8859-1?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: hc981@poolhem.se, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org
Subject: Re: [PATCH v7] Emulate dip switch language layout settings on SUN
 keyboard
Message-Id: <20230621201447.712ec73a.hc94@poolhem.se>
In-Reply-To: <ZJKiGBJNQa5Kx+Dg@redhat.com>
References: <20230328191958.3e3eb5e4.hc981@poolhem.se>
 <ZCMq/imcAq0ApLQp@redhat.com>
 <20230328221608.328ab80f.hc981@poolhem.se>
 <20230430225533.1a57879a.hc981@poolhem.se>
 <20230608181439.7ea3a5c5.hc981@poolhem.se>
 <4e8f027a-ca00-c54f-ef2f-f0df1f5b2f9e@ilande.co.uk>
 <20230610122912.0fc157de.hc981@poolhem.se>
 <20230611014751.22f22674.hc94@poolhem.se>
 <ZJFv4Hq8RMVOUum/@redhat.com>
 <20230620215043.6124c450.hc94@poolhem.se>
 <ZJKiGBJNQa5Kx+Dg@redhat.com>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On Wed, 21 Jun 2023 08:09:12 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> If you're using one of the common Linux distros, you'll find a list of
> the full set of packages you need to enable QEMU feuatres in the
> dockerfiles at tests/docker/dockerfiles/. Those all have enough to
> enable the docs build.

Thanks for your support! I am using Slackware 15.0 as my build system which
wasn't among those container configurations, but studying those files and t=
he
output from "./configure" made me realize that I needed to install Sphinx w=
ith
all its dependencies and a rather recent version of sphinx-rtd-theme.

Now I am able to do  "make html" and as expected with my broken files I get=
=20

-8<---------------------------
Warning, treated as error:
/tmp/qemu/docs/system/keyboard.rst:document isn't included in any toctree
ninja: build stopped: subcommand failed.
-8<---------------------------

It will be a lot easier to work from here when I get feedback on any typos =
in
the .rst files and then also get to read the content in a formatted way.

I hope to be able to produce an updated patch the next weekend.

Best regards Henrik

