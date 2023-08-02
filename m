Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6F076DB45
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 01:10:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRKy3-0001AO-KV; Wed, 02 Aug 2023 19:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc981@poolhem.se>) id 1qRKxz-00014Z-VA
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 19:09:19 -0400
Received: from mailout12.inleed.net ([2a0b:dc80:cafe:112::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc981@poolhem.se>)
 id 1qRKxy-0004JK-23; Wed, 02 Aug 2023 19:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=poolhem.se; 
 s=x;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KJO27lGgQj+qY2FtQZvCBFtqeCMWNGga7EQ54FXg7YU=; b=eIoQIwtyxxtV+SopTzKvk8XqJN
 LXTVhEaTD+PVi/1jjGcMisWtbvYczjQRn9uccCOCtK4Vyxgy9kcMrw6PM1usub1nYEhGCFx2h1CeX
 znK14+Bhe4Vs/l+F6qi667dlk1W44dp8UHPCy5AYT2dAzlpijlyJbO0VueoCKUpxMXrKdOu5DADF5
 idmDY8OO16ouOPbLupRlIVg+Dx30ysoGALnrcv/LvCYU7RuIrk7NSNA4y8Rw2LpKAoLRkTToFani+
 jP62ldvYzc5HoY+6uLCUhYYlrMiuBGm7jwKnKNtt79d35ww+/tn+CcIxxI2HESKkNp5vvnfBwwAKw
 zWTxrY/Q==;
Received: from [213.115.245.47] (helo=balrog.lkp.se)
 by ns12.inleed.net with esmtpa (Exim 4.96-58-g4e9ed49f8)
 (envelope-from <hc981@poolhem.se>) id 1qRKxw-0052wu-2D;
 Thu, 03 Aug 2023 01:09:16 +0200
Date: Thu, 3 Aug 2023 01:09:09 +0200
From: Henrik Carlqvist <hc981@poolhem.se>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v1] Allowing setting and overriding parameters in smb.conf
Message-Id: <20230803010909.723e2c1f.hc981@poolhem.se>
In-Reply-To: <20230802195356.rwibjix3bub7s7qw@begin>
References: <20230608181439.7ea3a5c5.hc981@poolhem.se>
 <4e8f027a-ca00-c54f-ef2f-f0df1f5b2f9e@ilande.co.uk>
 <20230610122912.0fc157de.hc981@poolhem.se>
 <20230611014751.22f22674.hc94@poolhem.se>
 <ZJFv4Hq8RMVOUum/@redhat.com>
 <20230620215043.6124c450.hc94@poolhem.se>
 <ZJKiGBJNQa5Kx+Dg@redhat.com>
 <20230621201447.712ec73a.hc94@poolhem.se>
 <20230623203007.56d3d182.hc981@poolhem.se>
 <20230801232725.4cc838fb.hc981@poolhem.se>
 <20230802195356.rwibjix3bub7s7qw@begin>
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

On Wed, 2 Aug 2023 21:53:56 +0200
Samuel Thibault <samuel.thibault@gnu.org> wrote:

> Henrik Carlqvist, le mar. 01 ao=C3=BBt 2023 23:27:25 +0200, a ecrit:
> > @@ -950,10 +953,11 @@ static int slirp_smb(SlirpState* s, const char
> > *exported_dir,
> >              "printing =3D bsd\n"
> >              "disable spoolss =3D yes\n"
> >              "usershare max shares =3D 0\n"
> > -            "[qemu]\n"
> > -            "path=3D%s\n"
> >              "read only=3Dno\n"
> >              "guest ok=3Dyes\n"
> > +           "%s"
> > +            "[qemu]\n"
> > +            "path=3D%s\n"
>=20
> ?This is moving read only and guest ok to the global section?

Thanks for your quick reply!

Yes, I thought that would be OK because the [qemu] share will inherit those
settings from the global section. By placing those in the global section it=
 is
possible to override them with later contradicting statements like=20
"read only=3Dyes\n" in the %s before the [qemu] section.

If I wouldn't have moved them to the global section there could have been a
need to be able to alter parameters both in the global section and the [qem=
u]
share section as any setting in a share section overrides any global settin=
gs.

By only adding custom parameter settings to the end of the global section t=
he
user interface was kept in a more simple way.

regards Henrik

