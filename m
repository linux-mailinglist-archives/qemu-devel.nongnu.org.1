Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 413DC7CDD10
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:19:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6RZ-0006r8-Uh; Wed, 18 Oct 2023 09:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt6RH-0006oB-SX
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt6RG-0001uF-6v
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697635096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EYeXZaaa28TX2qcvt5ezSxrTblylyeqPFfgZbmbvhV8=;
 b=hjL5BWs6W5kC4O41puNKhpIjt1hMmMCz5fwT9ttRoDPAQ9gThInGNka0NglcI7C7i426xG
 NOTzKm5HNatXf8YjkdJn44Q1HoymYZIbN7OmyTeIjUP437LQtpiZ1BZAKhQQuDvI3yDLeF
 z+TnWjE7n5PPkeryuGfyqNtkvzENfqM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-plnaMNjkO_m3F2BzUrWwFQ-1; Wed, 18 Oct 2023 09:18:09 -0400
X-MC-Unique: plnaMNjkO_m3F2BzUrWwFQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c5047f94bdso39364531fa.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697635078; x=1698239878;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYeXZaaa28TX2qcvt5ezSxrTblylyeqPFfgZbmbvhV8=;
 b=OQQOBOOIhCSmnAwMDd9s8xM4+EYSaX10h7JdYLPHaTYQtYfGZqOwnFAY7UvUZNmX7k
 sPFoomfRte2zSteyyV8CO0PvBEsmlI2A3HwB9265VesCp8bap08IAwfVGOpn8Cs0ElMr
 PO2lyxphlIqOOdbFZs748QBzxOkDlHWZdcKbz1ITUPPNl7k1WfDMC+hDTGkL/FeGYox1
 grOR+ufH6PfI3TBQdpgpHoU8TDsMN68ZkoXvXcOtXTwDKlCN0A+BLaNqUGZTnAM+deiy
 urdtuhh3FsDJaefAm9WwrOTSi0TDJIGD4mCyUidFc9Ywd0lW3wMHpyHp83lPoxKNoIeA
 VoZA==
X-Gm-Message-State: AOJu0YxvFBybaWJ2yBUzYBrSeqzX2hB26nJFRSa7TNVP+o2JNqbjFV9N
 YT6GBLUvevOlGwmmriffwOOYDsOyMMoXKjLm+M7HUklvjsGUjjm+P06aHLiWEjDhW0imWBqnTiT
 WGrhwIDJZ8IVkGAY=
X-Received: by 2002:a2e:a593:0:b0:2c5:8a0:b502 with SMTP id
 m19-20020a2ea593000000b002c508a0b502mr4261430ljp.48.1697635078295; 
 Wed, 18 Oct 2023 06:17:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv3mT0uPOuO7VpRjcIxz+JKdLGA2JS5LfjLwqxiE99mcJjuhx5BVbDvqeoDyGtrwQc148fpw==
X-Received: by 2002:a2e:a593:0:b0:2c5:8a0:b502 with SMTP id
 m19-20020a2ea593000000b002c508a0b502mr4261411ljp.48.1697635077933; 
 Wed, 18 Oct 2023 06:17:57 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a05600c421300b003fc16ee2864sm1626928wmh.48.2023.10.18.06.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 06:17:57 -0700 (PDT)
Date: Wed, 18 Oct 2023 09:17:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] docs/about: Mark the old pc-i440fx-2.0 - 2.3 machine
 types as deprecated
Message-ID: <20231018091534-mutt-send-email-mst@kernel.org>
References: <20231006075247.403364-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006075247.403364-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Fri, Oct 06, 2023 at 09:52:47AM +0200, Thomas Huth wrote:
> As we've seen in the past, it's useful for deprecating old machine
> types to finally be able to get of legacy code or do other clean-ups
> (see e.g. commit ea985d235b868047 that was used to drop the PCI code in
> the 128k bios binaries to free some precious space in those binaries).
> 
> So let's continue deprecating the oldest pc machine types. QEMU 2.3
> has been released 8 years ago, so that's plenty of time since such
> machine types have been used by default, thus deprecating pc-i440fx-2.0
> up to pc-i440fx-2.3 should be fine nowadays.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/about/deprecated.rst | 8 ++++++++
>  hw/i386/pc_piix.c         | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index e43de9c183..c016bb9b20 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -277,6 +277,14 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
>  better reflects the way this property affects all random data within
>  the device tree blob, not just the ``kaslr-seed`` node.
>  
> +``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +These old machine types are quite neglected nowadays and thus might have
> +various pitfalls with regards to live migration. Use a newer machine type
> +instead.
> +
> +
>  Backend options
>  ---------------

Wait a sec. Which tree is this against?
I don't see this context ever since:

commit f59fb1889f480b0324a7ed0404a68ad5a0ad4f6c
Author: Thomas Huth <thuth@redhat.com>
Date:   Mon Jan 17 20:16:39 2022 +0100

    hw/i386/pc_piix: Mark the machine types from version 1.4 to 1.7 as deprecated


Also, do we intentionally keep 1.8 and 1.9 as not deprecated?



> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index ff8654ecda..9789e9e75c 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -784,6 +784,7 @@ static void pc_i440fx_2_3_machine_options(MachineClass *m)
>  {
>      pc_i440fx_2_4_machine_options(m);
>      m->hw_version = "2.3.0";
> +    m->deprecation_reason = "old and unattended - use a newer version instead";
>      compat_props_add(m->compat_props, hw_compat_2_3, hw_compat_2_3_len);
>      compat_props_add(m->compat_props, pc_compat_2_3, pc_compat_2_3_len);
>  }
> -- 
> 2.41.0


