Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04351719B7C
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:08:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4h5V-0008Tv-39; Thu, 01 Jun 2023 08:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q4h5L-0008Sc-3C
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q4h5I-0004xM-2u
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685621233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6KQU5YIHTzsd3r14/A+S7fdQB5OW96KUk6rgK9mse6M=;
 b=Qg2aWal5gOr3nVZMthEy/sxrmujoIqgFRcMIdThiYqXq8Qwsv4zJFkF57uI/cgAKy5Rm6p
 bdSebSJDcVVXi56sfJYB1IqK8d3TeD2q5svXH63RvLOLCxR4+nGOylOEeizfpO3hJPKylv
 akHpQEwIl/Y4jKHx832ALD7iyQ0bUOE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-12K_AQCsPS281PvPYEBAXQ-1; Thu, 01 Jun 2023 08:07:12 -0400
X-MC-Unique: 12K_AQCsPS281PvPYEBAXQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4edc7406cb5so494054e87.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 05:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685621230; x=1688213230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6KQU5YIHTzsd3r14/A+S7fdQB5OW96KUk6rgK9mse6M=;
 b=etBTEcbE+v2YnOFIXv/Upf+zZ8KrqPu3gQmLTTVDfwuorclEaifcXq1ePULC54pM5D
 cD49jZ5QbUCfGwzz295Nc+/hv+xeWgeqRIvuTAtvD/Uscu6osuOvlND8FU7sRFztIKm5
 NEJANLkYp2ec73s+UtTfvr9iUajRqhOrrwyQSKmX8bysFEsnnC65X/u0bUEK13hUB/L+
 SE2OjPb8ZR1DlljgVVSGCdrPNPDsq1PONA2zDDQ+mRd5vpW8yLVjuMRUg+ZJQhFwkCiU
 G80RiepMMk2W9Tri+FarVWlJu41ln8MI9GmnFm6Ucado2cSfKr7Y5JvVCHbH58nWXwou
 +O0A==
X-Gm-Message-State: AC+VfDwbMV2B+Wv2IkdQcFyCV2kAuEml18c6kIyT1EkjSMa2llhwbg4B
 zf/pxV0S2DnUWbDl7rQEHf2FbYz4hXy3Lz5JvjZ9TCD+GjRxSODB5AuxQKrjbOzAQvz6eFgVqgq
 bPeCfYj0vTRX95LU=
X-Received: by 2002:ac2:46c4:0:b0:4f4:e353:6a98 with SMTP id
 p4-20020ac246c4000000b004f4e3536a98mr1308896lfo.36.1685621230608; 
 Thu, 01 Jun 2023 05:07:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7iNpvYVUmMrMSrpcGPHqQOuA2IyyZrvWZAHBIYEYChay1pOWCjlXj3jjzLEXg4rDkIbO41HA==
X-Received: by 2002:ac2:46c4:0:b0:4f4:e353:6a98 with SMTP id
 p4-20020ac246c4000000b004f4e3536a98mr1308868lfo.36.1685621230292; 
 Thu, 01 Jun 2023 05:07:10 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 l22-20020a1c7916000000b003f6f6a6e760sm2168994wme.32.2023.06.01.05.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 05:07:08 -0700 (PDT)
Date: Thu, 1 Jun 2023 08:07:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 0/3] Trivial cleanups
Message-ID: <20230601080655-mutt-send-email-mst@kernel.org>
References: <20230523195608.125820-1-shentey@gmail.com>
 <c138717c-5085-3b4b-5a46-0fa93179f6a8@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c138717c-5085-3b4b-5a46-0fa93179f6a8@ilande.co.uk>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, May 25, 2023 at 05:03:15PM +0100, Mark Cave-Ayland wrote:
> On 23/05/2023 20:56, Bernhard Beschow wrote:
> 
> > This series:
> > * Removes dead code from omap_uart and i82378
> > * Resolves redundant code in the i8254 timer devices
> > 
> > v3:
> > * Drop TYPE_ISA_PARALLEL since they became obsolete by
> >    https://lore.kernel.org/qemu-devel/20230522115014.1110840-9-thuth@redhat.com/
> 
> Oh I didn't see that this had already been merged :/
> 
> It's not a reason to block this series, but I'd still like to see your
> changes to ParallelState and ISAParallelState merged separately since they
> are a better match for our QOM coding standards.
> 
> > v2:
> > * Export ParallelState and ISAParallelState (Mark)
> > 
> > Testing done:
> > * `make check`
> > 
> > Bernhard Beschow (3):
> >    hw/timer/i8254_common: Share "iobase" property via base class
> >    hw/arm/omap: Remove unused omap_uart_attach()
> >    hw/isa/i82378: Remove unused "io" attribute
> > 
> >   include/hw/arm/omap.h   | 1 -
> >   hw/char/omap_uart.c     | 9 ---------
> >   hw/i386/kvm/i8254.c     | 1 -
> >   hw/isa/i82378.c         | 1 -
> >   hw/timer/i8254.c        | 6 ------
> >   hw/timer/i8254_common.c | 6 ++++++
> >   6 files changed, 6 insertions(+), 18 deletions(-)
> 
> Do we know who is going to pick up these series? I can send a PR if no-one minds?
> 


Go ahead:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ATB,
> 
> Mark.


