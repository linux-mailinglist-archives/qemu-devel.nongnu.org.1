Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C4283557F
	for <lists+qemu-devel@lfdr.de>; Sun, 21 Jan 2024 12:39:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRW92-0002lZ-BW; Sun, 21 Jan 2024 06:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rRW90-0002lK-Bf
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 06:37:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rRW8y-0007Gy-Ik
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 06:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705837058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZSjNHdTUUhNegNqIQrmP/ec7BZ8VKJDL6NrNfwFOq/A=;
 b=V8wGhErPKHDh5thBPTyV+73cs4zbCodjNaIC1AgWlSZ+Xzehu8qWSN80JQsjb9UssJNR62
 avkCGROIDA+qZoi9ktJYzO/DPqSbrOmTfONd6m3bGLUh4RqostKAMScMv5pvq/vgPlXNYt
 10mMoclWAeThcE6a9/74O80pu6lcDss=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-BLN_386kNqC7VTbuzFnChQ-1; Sun, 21 Jan 2024 06:37:36 -0500
X-MC-Unique: BLN_386kNqC7VTbuzFnChQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50e75f8d722so1722415e87.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jan 2024 03:37:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705837055; x=1706441855;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZSjNHdTUUhNegNqIQrmP/ec7BZ8VKJDL6NrNfwFOq/A=;
 b=ZAAP6t3mKB9/bSa1TkvWBdMiGiswbPKcDotpjhoMu28mUhu57v51dTjTwh6Vf8L9jk
 GqzMnpHXzS98LaVId2Uxq08LS8K8X1wKrwqfvqb6f39QBFCcxh2iI2ILrPhtV+dKGAL1
 1rVnJb+BryIdolp0hTYubyVpLRh7GMRsFbuCVF6L7fQVn7ez7okKkoRtMEMmiloQKRU8
 483FyOiy0Ci/K/5FoTdUxGxKpFQB/y5rxGmLI07ZtutGOF3ANPJ9njRwVyjQQ/eWuiRD
 96iv0makuIWpPHOt9awwB2hR1i2rdB9MlYzufjdL6lOBNllpsocu1YYfyVuqCUJeD7DJ
 HMUA==
X-Gm-Message-State: AOJu0YzSlOyv+Tq6dSSRQ0bChISgwClcOz/NlV9SxRqgmWdBhxZYt9RW
 6ayDsdrVAbhVyqzUHWo/pDjRxcPHlZuPssZcDc/q/+mia8635m4jXvXCMV8hKT/aWm5ogZURs2g
 CvRUGkg+L1tZpK+IEmAFCctSIPi+TAzSALnytuJWXQRpQPxReEtpU2/YVBFFO4Fk=
X-Received: by 2002:a05:6512:1598:b0:50f:fac9:b8f1 with SMTP id
 bp24-20020a056512159800b0050ffac9b8f1mr45798lfb.28.1705837054869; 
 Sun, 21 Jan 2024 03:37:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgGb9HjBu8D3ELiQYi6pju+UjOZe2vzDwidkmEigW8+2PqIJsP8XcRvefHPRATfEplXoT5gA==
X-Received: by 2002:a05:6512:1598:b0:50f:fac9:b8f1 with SMTP id
 bp24-20020a056512159800b0050ffac9b8f1mr45789lfb.28.1705837054500; 
 Sun, 21 Jan 2024 03:37:34 -0800 (PST)
Received: from redhat.com ([2.52.14.57]) by smtp.gmail.com with ESMTPSA id
 o6-20020ac24c46000000b0050eab0f6a59sm1613996lfk.84.2024.01.21.03.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jan 2024 03:37:33 -0800 (PST)
Date: Sun, 21 Jan 2024 06:37:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 0/5] buses: switch to 3-phase-reset
Message-ID: <20240121063612-mutt-send-email-mst@kernel.org>
References: <20240119163512.3810301-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119163512.3810301-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jan 19, 2024 at 04:35:07PM +0000, Peter Maydell wrote:
> This patchset switches the handful of bus types that implement a
> reset method over to using the 3-phase-reset APIs, and then removes
> the transitional infrastructure from the core bus class that was
> supporting the ability to have bus types that use old-style reset.
> 
> I wrote this ages ago and recently picked it back up because of a
> recent PCI related reset ordering problem noted by Peter Xu.  I'm not
> sure if this patchset is necessary as a part of fixing that ordering
> problem (it might even be possible now to have the intel_iommu device
> use 3-phase reset and put the relevant parts of its reset into the
> 'exit' phase), but either way we really ought to do this cleanup
> to reduce the amount of legacy/transitional handling we have.
> 
> In theory this patchset should be fine and shouldn't be changing
> behaviour.  On the other hand the reason I never sent it out when I
> originally wrote it was that I ran into a test failure in the
> BootLinuxConsole.test_sh4_r2d avocado test.  Rerunning all the
> avocado tests I don't see that failing now, so maybe I was just
> confused by a flaky test back then.
> 
> In any case, this could probably use a thorough soak testing with
> workloads that do resets of the PCI bus; I've only done 'make check'
> and 'make check-avocado' on it.  But I wanted to get it out onto the
> list anyway.
> 
> thanks
> -- PMM

From a quick look, we need this cleanup

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I'll try some tests too, and report.

> Peter Maydell (5):
>   pci: Switch bus reset to 3-phase-reset
>   vmbus: Switch bus reset to 3-phase-reset
>   adb: Switch bus reset to 3-phase-reset
>   hw/s390x/css-bridge: switch virtual-css bus to 3-phase-reset
>   hw/core: Remove transitional infrastructure from BusClass
> 
>  include/hw/qdev-core.h |  2 --
>  hw/core/bus.c          | 67 ------------------------------------------
>  hw/hyperv/vmbus.c      |  7 +++--
>  hw/input/adb.c         |  7 +++--
>  hw/pci/pci.c           | 10 ++++---
>  hw/s390x/css-bridge.c  |  5 ++--
>  6 files changed, 17 insertions(+), 81 deletions(-)
> 
> -- 
> 2.34.1


