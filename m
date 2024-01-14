Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E43C982D063
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 11:56:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOy9t-000280-Sh; Sun, 14 Jan 2024 05:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rOy9k-000258-Uw
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 05:55:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rOy9j-0000cT-1R
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 05:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705229752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2+FB+5mA6t4HHPIGcmglHN7HmI8JDyc2s+KzWWFl6Sw=;
 b=NHQlO4Pi/baCMwxdgLy4u6kNLh/r29u3rHwXFCcSs5voxqG4K7sgotuly05dw/zh+EmHsV
 92NlqTqPdlAz/xulXXRWmryI4ISHMa++6zhO5BrKpWbFmZs+ogg9fSLloY6Nv9yWD7JkLx
 tHdyzUBab7KagOYZrxqEGHhY7pjjhAU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-yAe1i99EN5O0hjfaeItdJQ-1; Sun, 14 Jan 2024 05:55:50 -0500
X-MC-Unique: yAe1i99EN5O0hjfaeItdJQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33689c90957so4810520f8f.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 02:55:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705229749; x=1705834549;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+FB+5mA6t4HHPIGcmglHN7HmI8JDyc2s+KzWWFl6Sw=;
 b=D+X/cpiLbVe7zwG1kwkfycrN0/QYOfPMWPm1AedmqTdpIs1i6JF7nm+h2hh+FeOqmw
 1WAMDl3/1YIf2uZJc0r1SyNgTwkQLCZpy82ZBAvSD8UgVhGnDexfYneRPFW2eMKD/gWX
 ZYdDOiCkpExWvIKSzOYHHf2bnqsD9gkyaHuFo5U2qkNWjJUu3P2zO/khGIFSIN09nCrF
 +ZVwchjB9nf0WHS4q5ciSokEQerlS4ghR6X00z6XL5sA9sxzOsZHDH4KqUBKyTbhfDpV
 hkStYKDkL0fa88T2VZsuBxblC07YZ70fVL26EO2Q/a99VEMHQZ5njbq0anYd6fj9JGIv
 RGrA==
X-Gm-Message-State: AOJu0YzX4IRylLj772BC7bfZlJpeIvxaWo2QFzf4av61Xdos2zD4IgE6
 nfl0rqAh5geTi8VyfH3kJRo1zJluX/M2iB/d9AgQVRbm+OUU+EQn64Q/OeG+xDTbwYSDt98Uu/o
 Sk5StKU0BxEKAE8sNyKampvI=
X-Received: by 2002:a05:600c:4c94:b0:40e:4131:7acc with SMTP id
 g20-20020a05600c4c9400b0040e41317accmr2086820wmp.79.1705229749384; 
 Sun, 14 Jan 2024 02:55:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGa8hQ7ttmYkSXBWcEqz6SlMSKcZARiK4wxhswPGARxsKHDY4dkbjA9K59hE6gTPa/nAhU1Eg==
X-Received: by 2002:a05:600c:4c94:b0:40e:4131:7acc with SMTP id
 g20-20020a05600c4c9400b0040e41317accmr2086816wmp.79.1705229749025; 
 Sun, 14 Jan 2024 02:55:49 -0800 (PST)
Received: from redhat.com ([2.52.131.87]) by smtp.gmail.com with ESMTPSA id
 t18-20020a05600c199200b0040e5951f199sm11932339wmq.34.2024.01.14.02.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 02:55:47 -0800 (PST)
Date: Sun, 14 Jan 2024 05:55:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 0/3] Fix PIC interrupt handling of x86 CPUs if APIC is
 globally disabled
Message-ID: <20240114055534-mutt-send-email-mst@kernel.org>
References: <20240106132546.21248-1-shentey@gmail.com>
 <2744F3E2-D8F5-42F1-8520-7FE8C202C341@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2744F3E2-D8F5-42F1-8520-7FE8C202C341@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sun, Jan 14, 2024 at 10:52:28AM +0000, Bernhard Beschow wrote:
> 
> 
> Am 6. Januar 2024 13:25:43 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
> >This series is part of my work emulating the VIA Apollo Pro 133T chipset in QEMU
> >
> >[1] and testing it by running real-world BIOSes on it. The first two patches fix
> >
> >an issue regarding PIC interrupt handling, the third one just fixes a typo in a
> >
> >comment.
> >
> >
> >
> >During testing, I've found that the boot process gets stuck for some BIOSes that
> >
> >disable the LAPIC globally (by disabling the enable bit in the base address
> >
> >register). QEMU seems to emulate PIC interrupt handling only if a CPU doesn't
> >
> >have a LAPIC, and always emulates LAPIC interrupt handling if one is present.
> >
> >According to the Intel documentation, a CPU should resort to PIC interrupt
> >
> >handling if its LAPIC is globally didabled. This series fixes this corner case
> >
> >which makes the boot process succeed. More details can be found in the commit
> >
> >message.
> >
> >
> >
> >Testing done:
> >
> >* `make check`
> >
> >* `make check-avocado`
> >
> >
> >
> >v2:
> >
> >* Pick up R-b tag
> >
> >* Split and rework interrupt handling patch to consider i486 SMP systems. This
> >
> >    required dropping Alex' R-b tag.
> >
> 
> Ping


Tagged now. Thanks!

> >
> >
> >[1] https://github.com/shentok/qemu/tree/via-apollo-pro-133t
> >
> >
> >
> >Bernhard Beschow (3):
> >
> >  hw/i386/x86: Reverse if statement
> >
> >  hw/i386/x86: Fix PIC interrupt handling if APIC is globally disabled
> >
> >  target/i386/cpu: Fix typo in comment
> >
> >
> >
> > include/hw/i386/apic.h |  1 +
> >
> > hw/i386/x86.c          |  8 ++++----
> >
> > hw/intc/apic_common.c  | 13 +++++++++++++
> >
> > target/i386/cpu.c      |  2 +-
> >
> > 4 files changed, 19 insertions(+), 5 deletions(-)
> >
> >
> >
> >-- >
> >2.43.0
> >
> >
> >


