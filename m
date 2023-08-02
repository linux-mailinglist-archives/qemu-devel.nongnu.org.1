Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E578B76DB7B
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 01:27:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRLEO-0006TI-Kj; Wed, 02 Aug 2023 19:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc981@poolhem.se>) id 1qRLEL-0006Sp-Ke
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 19:26:13 -0400
Received: from mailout12.inleed.net ([2a0b:dc80:cafe:112::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc981@poolhem.se>)
 id 1qRLEJ-0005dB-JU; Wed, 02 Aug 2023 19:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=poolhem.se; 
 s=x;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MowTebXMXg6FKeltIVwvEezwiP2MQizBz9NfJqh79SY=; b=BXEf1LEMF0CvEmLryp7J+1nSEI
 ry3xYQkXi2qKqZWZb+dQoEj4/Ti+rp9sJVBGbAngBAdM9oDX/UkgcfDY5SFWzyib7wNvIxiHckkzH
 XWlkwt67JjXu8teyFB6KanCrvys8XCixazvVGfY6rya0Oh4tPa17WNnUKJSzyzaQld6WHzMFCdiCh
 Ll28iHxIUaRWBDmliIuURD6nkQd62nFrL4ywg11nzPDwduhiTlJJa7H1E3yGAb6cLssT3yyqOg4f0
 ACqyRjK+P8F4qsJjU0WIXSaCbTOlHH+L1wL1mhG02zxEf5isCIoI+fj4MyZD/ed3Xv6v1OFsjdJ3u
 w/cZRXlw==;
Received: from [213.115.245.47] (helo=balrog.lkp.se)
 by ns12.inleed.net with esmtpa (Exim 4.96-58-g4e9ed49f8)
 (envelope-from <hc981@poolhem.se>) id 1qRLEH-005Iz0-2X;
 Thu, 03 Aug 2023 01:26:09 +0200
Date: Thu, 3 Aug 2023 01:26:02 +0200
From: Henrik Carlqvist <hc981@poolhem.se>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v1] Allowing setting and overriding parameters in smb.conf
Message-Id: <20230803012602.7c75df75.hc981@poolhem.se>
In-Reply-To: <20230802231324.b5zk2kf44oqzocel@begin>
References: <20230610122912.0fc157de.hc981@poolhem.se>
 <20230611014751.22f22674.hc94@poolhem.se>
 <ZJFv4Hq8RMVOUum/@redhat.com>
 <20230620215043.6124c450.hc94@poolhem.se>
 <ZJKiGBJNQa5Kx+Dg@redhat.com>
 <20230621201447.712ec73a.hc94@poolhem.se>
 <20230623203007.56d3d182.hc981@poolhem.se>
 <20230801232725.4cc838fb.hc981@poolhem.se>
 <20230802195356.rwibjix3bub7s7qw@begin>
 <20230803010909.723e2c1f.hc981@poolhem.se>
 <20230802231324.b5zk2kf44oqzocel@begin>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Id: henrik@poolhem.se
Received-SPF: none client-ip=2a0b:dc80:cafe:112::1;
 envelope-from=hc981@poolhem.se; helo=mailout12.inleed.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
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

On Thu, 3 Aug 2023 01:13:24 +0200
Samuel Thibault <samuel.thibault@gnu.org> wrote:

> Henrik Carlqvist, le jeu. 03 ao=C3=BBt 2023 01:09:09 +0200, a ecrit:
> > On Wed, 2 Aug 2023 21:53:56 +0200
> > Samuel Thibault <samuel.thibault@gnu.org> wrote:
> >=20
> > > Henrik Carlqvist, le mar. 01 ao=C3=83=C2=BBt 2023 23:27:25 +0200, a e=
crit:
> > > > @@ -950,10 +953,11 @@ static int slirp_smb(SlirpState* s, const char
> > > > *exported_dir,
> > > >              "printing =3D bsd\n"
> > > >              "disable spoolss =3D yes\n"
> > > >              "usershare max shares =3D 0\n"
> > > > -            "[qemu]\n"
> > > > -            "path=3D%s\n"
> > > >              "read only=3Dno\n"
> > > >              "guest ok=3Dyes\n"
> > > > +           "%s"
> > > > +            "[qemu]\n"
> > > > +            "path=3D%s\n"
> > >=20
> > > ?This is moving read only and guest ok to the global section?
> >=20
> > Thanks for your quick reply!
> >=20
> > Yes, I thought that would be OK because the [qemu] share will inherit
> > those settings from the global section. By placing those in the global
> > section it is possible to override them with later contradicting
> > statements like "read only=3Dyes\n" in the %s before the [qemu] section.
>=20
> Ok, it would be useful to mention that in the changelog.

Is there a changelog in the repo? Or do you mean that I should mention that=
 in
the git commit message?

Best regards Henrik

