Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B85C7C6952
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 11:19:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqrpl-0005B0-SM; Thu, 12 Oct 2023 05:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qqrpj-0005AZ-Hx
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 05:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qqrpi-0003df-29
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 05:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697102296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LepUdVLCl/fCvbpNSRBn5BGZavLnmLUL9eElXwg6Rgs=;
 b=D/kVukpqyeO1LU1MV9SCdWOUVVInxl+PSrkp/x2mmZR3nNtciL9GfQhxteQuEOKxRwp0dj
 fIGIEnuDk9b/jCydt2iisjIeXCvGsgWaWCqzdSXxGr/he4DZ4GHss/d4jXiQv4kl3cIWuT
 WkENSIGhao+aVSwWvdubifq66aDh1Bs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-ytCPqbL9Nfm8a-KmIC0ySg-1; Thu, 12 Oct 2023 05:18:14 -0400
X-MC-Unique: ytCPqbL9Nfm8a-KmIC0ySg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5ECD6803C96;
 Thu, 12 Oct 2023 09:18:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CB3440C6F79;
 Thu, 12 Oct 2023 09:18:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7547818009E6; Thu, 12 Oct 2023 11:18:12 +0200 (CEST)
Date: Thu, 12 Oct 2023 11:18:12 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, 
 qemu-devel@nongnu.org, lersek@redhat.com
Subject: Re: [PATCH v5 0/3] ramfb: migration support
Message-ID: <foqw7o42pm7fys42zscstnfln77sof237j7slqcbupyximekba@p7uj37bce2nh>
References: <20231009063247.119333-1-marcandre.lureau@redhat.com>
 <0cdcd25f-9ed5-cbfe-1633-213bd6a2c82f@redhat.com>
 <CAJ+F1CJ+yKL8aSg=OdBBHzdfsaRj+fvD8y1QLgxT4UbjxAbUZg@mail.gmail.com>
 <346b5a63-b477-5de8-fc93-65904b8ceda6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <346b5a63-b477-5de8-fc93-65904b8ceda6@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 11, 2023 at 07:09:19PM +0200, Cédric Le Goater wrote:
> On 10/10/23 15:46, Marc-André Lureau wrote:
> > Hi
> > 
> > On Tue, Oct 10, 2023 at 4:49 PM Cédric Le Goater <clg@redhat.com> wrote:
> > > 
> > > Hello,
> > > 
> > > On 10/9/23 08:32, marcandre.lureau@redhat.com wrote:
> > > > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > > 
> > > > Hi,
> > > > 
> > > > Implement RAMFB migration, and add properties to enable it only on >= 8.2
> > > > machines, + a few related cleanups.
> > > 
> > > Should this series go in vfio-next ?
> > > 
> > 
> > That's a good option for me.
> 
> Gerd, fine with you ?

Yes.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd


