Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B77F76DB9E
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 01:34:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRLM2-0000bD-0M; Wed, 02 Aug 2023 19:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1qRLM0-0000b3-9d
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 19:34:08 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1qRLLz-000817-3J; Wed, 02 Aug 2023 19:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=EJicziCB1qxxlrnEA26OWLY79pa/NUWzxwBsLGmLwzY=; b=Zz+dGMGa8QjO2sVoZo9q
 ZiFYqiMM3ASqe/J6I6wkM0XVPA7xi2hAvFEMuF1i3xzHcOCHISw7lZlg8XUePx+07VgUsOX22pTeZ
 SE/D35lRQKkaGd9qOBvTnTq72WiKsNM1Og5Nbkf1ih3otY16Z9PeoSY6EhGhVyElIsgFyCo9poZhP
 BViTlop1/UyCgEpB9uCG1eYkIIlvxoViN9gUu0uOFE2nSQa/zH2XQZeWzbpVVisLuOC0J2KLdz3yy
 RRMnAv51rQNQNRFVXuveE4LFKlVyLxg2emO0F1AgiLPAK6D8PlVVMD4EQa05AG4rHkKyOtKKl3iOf
 pT8mHwKsVtM/bg==;
Received: from [2a01:cb19:4a:a400:de41:a9ff:fe47:ec49] (helo=begin)
 by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1qRLLy-0007Q6-Sl; Wed, 02 Aug 2023 19:34:06 -0400
Received: from samy by begin with local (Exim 4.96)
 (envelope-from <samuel.thibault@gnu.org>) id 1qRLLw-00AVCu-0p;
 Thu, 03 Aug 2023 01:34:04 +0200
Date: Thu, 3 Aug 2023 01:34:04 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Henrik Carlqvist <hc981@poolhem.se>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v1] Allowing setting and overriding parameters in smb.conf
Message-ID: <20230802233404.lnpa5owybhvbbkyl@begin>
References: <ZJFv4Hq8RMVOUum/@redhat.com>
 <20230620215043.6124c450.hc94@poolhem.se>
 <ZJKiGBJNQa5Kx+Dg@redhat.com>
 <20230621201447.712ec73a.hc94@poolhem.se>
 <20230623203007.56d3d182.hc981@poolhem.se>
 <20230801232725.4cc838fb.hc981@poolhem.se>
 <20230802195356.rwibjix3bub7s7qw@begin>
 <20230803010909.723e2c1f.hc981@poolhem.se>
 <20230802231324.b5zk2kf44oqzocel@begin>
 <20230803012602.7c75df75.hc981@poolhem.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230803012602.7c75df75.hc981@poolhem.se>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
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

Henrik Carlqvist, le jeu. 03 août 2023 01:26:02 +0200, a ecrit:
> On Thu, 3 Aug 2023 01:13:24 +0200
> Samuel Thibault <samuel.thibault@gnu.org> wrote:
> 
> > Henrik Carlqvist, le jeu. 03 aoÃ»t 2023 01:09:09 +0200, a ecrit:
> > > On Wed, 2 Aug 2023 21:53:56 +0200
> > > Samuel Thibault <samuel.thibault@gnu.org> wrote:
> > > 
> > > > Henrik Carlqvist, le mar. 01 aoÃÂ»t 2023 23:27:25 +0200, a ecrit:
> > > > > @@ -950,10 +953,11 @@ static int slirp_smb(SlirpState* s, const char
> > > > > *exported_dir,
> > > > >              "printing = bsd\n"
> > > > >              "disable spoolss = yes\n"
> > > > >              "usershare max shares = 0\n"
> > > > > -            "[qemu]\n"
> > > > > -            "path=%s\n"
> > > > >              "read only=no\n"
> > > > >              "guest ok=yes\n"
> > > > > +           "%s"
> > > > > +            "[qemu]\n"
> > > > > +            "path=%s\n"
> > > > 
> > > > ?This is moving read only and guest ok to the global section?
> > > 
> > > Thanks for your quick reply!
> > > 
> > > Yes, I thought that would be OK because the [qemu] share will inherit
> > > those settings from the global section. By placing those in the global
> > > section it is possible to override them with later contradicting
> > > statements like "read only=yes\n" in the %s before the [qemu] section.
> > 
> > Ok, it would be useful to mention that in the changelog.
> 
> Is there a changelog in the repo? Or do you mean that I should mention that in
> the git commit message?

I mean the latter, yes.

Samuel

