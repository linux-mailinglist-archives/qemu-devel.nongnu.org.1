Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4885B7FD6FD
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 13:41:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Jqm-0002tf-6U; Wed, 29 Nov 2023 07:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1r8Jqk-0002tS-1X
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 07:39:30 -0500
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1r8Jqg-0003Ps-Nl
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 07:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1701261561; bh=nGM1zQ0u/zSmrfTpfVNZVLVTDlZCshWujzKBMVdEOW0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pxacJb2VP5Kvz+iA0WcmK0ZiFwUK0IZrjG3MixmGTIROPkDXabIp5O+6AyLAdtStu
 t6vj1WuAhGFTFeT6LTji4GK/c40u3BqdE4bVlpPkroo0Bg1bSEMN4CyqiYEx2Ba4Un
 AHnfcKQAIhspE7jhf07NWwKqXCaiFT8eWTKdXAt8=
Date: Wed, 29 Nov 2023 13:39:20 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 3/3] hw/misc/pvpanic: add support for normal shutdowns
Message-ID: <2d249b3e-0976-4c7e-969a-88d54feb290a@t-8ch.de>
References: <20231128-pvpanic-shutdown-v2-0-830393b45cb6@t-8ch.de>
 <20231128-pvpanic-shutdown-v2-3-830393b45cb6@t-8ch.de>
 <874jh5x90t.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874jh5x90t.fsf@redhat.com>
Received-SPF: pass client-ip=2a01:4f8:c010:41de::1;
 envelope-from=thomas@t-8ch.de; helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023-11-29 09:23:46+0100, Cornelia Huck wrote:
> On Tue, Nov 28 2023, Thomas Weißschuh <thomas@t-8ch.de> wrote:
> 
> > Shutdown requests are normally hardware dependent.
> > By extending pvpanic to also handle shutdown requests, guests can
> > submit such requests with an easily implementable and cross-platform
> > mechanism.
> >
> > Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> > ---
> >  docs/specs/pvpanic.rst                   | 2 ++
> >  hw/misc/pvpanic.c                        | 5 +++++
> >  include/hw/misc/pvpanic.h                | 2 +-
> >  include/standard-headers/linux/pvpanic.h | 1 +
> >  4 files changed, 9 insertions(+), 1 deletion(-)
> 
> (...)
> 
> > diff --git a/include/standard-headers/linux/pvpanic.h b/include/standard-headers/linux/pvpanic.h
> > index 54b7485390d3..38e53ad45929 100644
> > --- a/include/standard-headers/linux/pvpanic.h
> > +++ b/include/standard-headers/linux/pvpanic.h
> > @@ -5,5 +5,6 @@
> >  
> >  #define PVPANIC_PANICKED	(1 << 0)
> >  #define PVPANIC_CRASH_LOADED	(1 << 1)
> > +#define PVPANIC_SHUTDOWN       	(1 << 2)
> >  
> >  #endif /* __PVPANIC_H__ */
> >
> 
> This hunk needs to come in via a separate headers update, or has to be
> split out into a placeholder patch if it is not included in the Linux
> kernel yet.

Greg KH actually want this header removed from the Linux UAPI headers,
as it is not in fact a Linux UAPI [0].
It's also a weird workflow to have the specification in qemu but the
header as part of Linux that is re-imported in qemu.

What do you think about maintaining the header as a private part of qemu
and dropping it from Linux UAPI?

Contrary to my response to Greg this wouldn't break old versions of
qemu, as qemu is using a private copy that would still exist there.

[0] https://lore.kernel.org/lkml/2023110431-pacemaker-pruning-0e4c@gregkh/

