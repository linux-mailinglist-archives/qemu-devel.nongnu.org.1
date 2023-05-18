Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F7708A9B
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 23:34:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzlG3-0007Hy-2E; Thu, 18 May 2023 17:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzlG1-0007HV-Ar
 for qemu-devel@nongnu.org; Thu, 18 May 2023 17:33:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzlFz-0006hI-SM
 for qemu-devel@nongnu.org; Thu, 18 May 2023 17:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684445635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7s09xnxpexVz0QYNy4nSoOKMhOyh8D0WhQK8jBI3lIo=;
 b=Faj2S4bQxYvVu+jAkhBC6DWd7801k5KltZ0ZGGjE/MMNWXLJMFVZzbxNd+xgOK7mcJhLR3
 lL1d2GGDnMyp82fAga7Yde9PztFa6/JAUo5DOlBYJJBmzg+xYUCifEYcaut/FjXUggL2Mv
 ERyOLicBxqXPRODKgm39V10BDLyyQe4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-H65FvJV-NruWnzXiVzVkrg-1; Thu, 18 May 2023 17:33:53 -0400
X-MC-Unique: H65FvJV-NruWnzXiVzVkrg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2af222cc3a1so1431191fa.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 14:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684445632; x=1687037632;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7s09xnxpexVz0QYNy4nSoOKMhOyh8D0WhQK8jBI3lIo=;
 b=Kdp0CYrNZnkIEX+qQE+7mGaSSU9HXnTqnKGQe9XX8i/iB8+Jk/iEXSgagsKtavmFfu
 t8CWRpYeGxe/DNbTurmgjYiU1+3StxhElFcPiPt9KvmZW8XggRIDS/ZReTKPXl5BSUOL
 0ykZB+FVMueFlvf5rEx9w6YsruBgGTYvBc+M05gbdRL+65J8qAn2hSBQvHi/GEESIge1
 sDT6i6ehAjrtAYpox+PzYreYDlz4HJtdaIbsB4FfSj/gtj+PqbNbssyfb3W+f64qwoCy
 V/8LWnB5UxX7bR+P4VimdYdOsH8SbyuJkTbTvq2vgoK1t/QM6+MArSMYbYEV3azjrX9H
 nn2A==
X-Gm-Message-State: AC+VfDw6Y7fPWWozRjoklxn4u/Euzj3/L+y2V1N/Sbwz/Vi4yB9KzEv3
 7Qff+TrfJEjkCEGPGprMFFJf21nYKEESQ2F2pPviUltIgzFia+fs0Qey7o0Zhzwr6NfB3TcE2SR
 9LoITdme4ZQjAQk0=
X-Received: by 2002:ac2:5973:0:b0:4f3:98b4:e45a with SMTP id
 h19-20020ac25973000000b004f398b4e45amr84459lfp.21.1684445632283; 
 Thu, 18 May 2023 14:33:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4sMtsQeLWYHS8w2u2HTrJaY0tRujQqwnc+ABZBXbJxykRl6QHF7DhYZcwyFWMDb3fxkMxHCQ==
X-Received: by 2002:ac2:5973:0:b0:4f3:98b4:e45a with SMTP id
 h19-20020ac25973000000b004f398b4e45amr84451lfp.21.1684445631892; 
 Thu, 18 May 2023 14:33:51 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:3e4d:6703:27b9:6f74:5282])
 by smtp.gmail.com with ESMTPSA id
 s18-20020ac25fb2000000b004edb8fac1cesm363730lfe.215.2023.05.18.14.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 14:33:51 -0700 (PDT)
Date: Thu, 18 May 2023 17:33:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org,
 qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/4] Trivial cleanups
Message-ID: <20230518173332-mutt-send-email-mst@kernel.org>
References: <20230513100906.46672-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230513100906.46672-1-shentey@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Sat, May 13, 2023 at 12:09:02PM +0200, Bernhard Beschow wrote:
> This series:
> * Removes dead code from omap_uart and i82378
> * Resolves redundant code in the i8254 timer devices
> * Replaces string literals by macro usage for TYPE_ISA_PARALLEL devices
> 
> Bernhard Beschow (4):
>   hw/timer/i8254_common: Share "iobase" property via base class
>   hw/arm/omap: Remove unused omap_uart_attach()
>   hw/char/parallel: Export TYPE_ISA_PARALLEL macro
>   hw/isa/i82378: Remove unused "io" attribute


Acked-by: Michael S. Tsirkin <mst@redhat.com>

>  include/hw/arm/omap.h      | 1 -
>  include/hw/char/parallel.h | 2 ++
>  hw/char/omap_uart.c        | 9 ---------
>  hw/char/parallel-isa.c     | 2 +-
>  hw/char/parallel.c         | 1 -
>  hw/i386/kvm/i8254.c        | 1 -
>  hw/isa/i82378.c            | 1 -
>  hw/isa/isa-superio.c       | 3 ++-
>  hw/timer/i8254.c           | 6 ------
>  hw/timer/i8254_common.c    | 6 ++++++
>  10 files changed, 11 insertions(+), 21 deletions(-)
> 
> -- 
> 2.40.1
> 


