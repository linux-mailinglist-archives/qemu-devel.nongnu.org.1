Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3334F7D0139
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:16:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXYr-0004eU-Dh; Thu, 19 Oct 2023 14:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXYp-0004e6-GW
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXYn-00085Z-Vo
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LJ+/dSkhB9tkTffYHbrEh20K8ME+i+dVet5nO4yzjz8=;
 b=W6W+qi6lfBLOX882Jn0XvitLRZodGzQghpsL61CP7uRcBLltpzYHEuDSChiwpf4omt05vI
 1Dprn3XjuthdPAghpIyNuALktXNC3HHYiiMxE4y/quoq5Ls4mM5fiS3bZlEALg+arKbNnn
 Zchk2QnOo6uksRQgKrGtu7BGiFFYgs4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-CVLq6Jo_MMGEusBwLcc4nA-1; Thu, 19 Oct 2023 14:15:51 -0400
X-MC-Unique: CVLq6Jo_MMGEusBwLcc4nA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31f79595669so588633f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739350; x=1698344150;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJ+/dSkhB9tkTffYHbrEh20K8ME+i+dVet5nO4yzjz8=;
 b=dlU1NWo1Io25NvjOjrpr3YK8HMgjlAmUSlsyp7FKs81R0VJX5pZH4SPhqz+10qPb5O
 882PYbaO7My73S0a1xFWmsw+cQyzASUQ1MF9LE1geBRIr0TTEVH6rGNq9Is9KfX2p7p3
 9OatieIHdy8FwUrf1tU1VEnzr7qHAMTnJMHwc7e/V6JkvMw8wVnb/6PDy2Rutza+FPSN
 oeafj75Z6pu21CHJXSzwVmoRnbWh15mDgxT/qN87cCca/kNp5LZeqnbr2GdqWHBN4TgE
 N2ypUilPLaSD8re/dcK3yDhN/JvgIKLlFfMGcAZNnhuPeYDeb6EPnWZ/1Y/HKb63KT5B
 OtuA==
X-Gm-Message-State: AOJu0Yw17Pu2YEoJbrs8wBZUZI397ysVhCh6vp8oh0ZdUbjfI0Mr6Rpl
 08gQBp8y+4d/MiPpb1LBvzJN94QxtIz8OXfP45hvad9I+p1L6S7wXhflLVI9eziEbN3B2OnKHq0
 l6GYWpV7Y4G8NJZk=
X-Received: by 2002:a5d:4ed0:0:b0:317:6579:2b9f with SMTP id
 s16-20020a5d4ed0000000b0031765792b9fmr2297638wrv.30.1697739350171; 
 Thu, 19 Oct 2023 11:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu6JdQB4EgQNJqx8wX7+xA/aek+k+VCyNWmkYKlCNbwXz2GDihoDJoc11UEv4qfvpZuCA5DQ==
X-Received: by 2002:a5d:4ed0:0:b0:317:6579:2b9f with SMTP id
 s16-20020a5d4ed0000000b0031765792b9fmr2297619wrv.30.1697739349800; 
 Thu, 19 Oct 2023 11:15:49 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a056000115200b003217cbab88bsm4952933wrx.16.2023.10.19.11.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:15:49 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:15:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: Salil Mehta <salil.mehta@opnsrc.net>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sergio Lopez <slp@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PULL v2 29/53] hw/i386: Remove now redundant TYPE_ACPI_GED_X86
Message-ID: <20231019141517-mutt-send-email-mst@kernel.org>
References: <cover.1696477105.git.mst@redhat.com>
 <c9c8ba69d5dbe5c1c6370e1f09ebd7531509d075.1696477105.git.mst@redhat.com>
 <15e70616-6abb-63a4-17d0-820f4a254607@opnsrc.net>
 <BE6564AF-6317-49CB-91AF-C88F1D31DF4E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE6564AF-6317-49CB-91AF-C88F1D31DF4E@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 19, 2023 at 10:33:08AM +0000, Bernhard Beschow wrote:
> 
> 
> Am 18. Oktober 2023 17:38:33 UTC schrieb Salil Mehta <salil.mehta@opnsrc.net>:
> >Hello,
> 
> Hi Salil,
> 
> >Can we assume that every machine type will have all the features which a GED Device can multiplex present together? like will Memory and CPU Hotplug makes sense for all the type of machines?
> 
> I can't really answer these questions -- I'm by no means an ACPI expert. My idea about removing TYPE_ACPI_GED_X86 really was not more than the commit message says: To remove unneeded code.
> 
> That said, I wonder myself if the GED device could be uniformly implemented across architectures and if -- in theory -- it could be used in the pc-i440fx machine instead of the Frankenstein hotplug implementation in PIIX4.
> 
> Best regards,
> Bernhard



I am redoing the pull anyway. I dropped this until this discussion
concludes then.


