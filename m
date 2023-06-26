Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6BC73E125
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:54:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmf9-0004wS-Bq; Mon, 26 Jun 2023 09:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDmf7-0004wJ-Au
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:53:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDmf5-00061P-GX
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687787626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9BBdRQYDklPiYSYDabBdyVmeuUNeX569aqqo98XeLTI=;
 b=FnwZ7xGCTW1pkh0Mkk9kf7vLtneQ6GedjtF+j0Se1yhwAar/LUlLQ1ZPd15JPUOWLW0PXc
 CW0zLbhtHzPnxWNuZYAjrCkONXDGMa4eHdd7Jto8vteoKqrGo6IFwFYqJpXUm9jFpIdFUD
 Sv9sAhA1UsS8FfCe0V7F6hqBxH1JjXs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-qzr8qeoRM9GsYQ7yf9bmiQ-1; Mon, 26 Jun 2023 09:53:45 -0400
X-MC-Unique: qzr8qeoRM9GsYQ7yf9bmiQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so16174825e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687787624; x=1690379624;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9BBdRQYDklPiYSYDabBdyVmeuUNeX569aqqo98XeLTI=;
 b=Jb1A2ztCICmSj+cQCM3nccLJbGoIAbiPpOTbeoJD6oD0ZJUr5jN4HAJogVZr4ElVR2
 AiDu1pRS44Y/DgW/wxtb/PXNYV5U4SMwPPsEALrPfeIMp3v5FRk4WAClqoTlrfQYU6Dh
 U5v1H2o1X9YLrIQk8q1cAhgrXBhp5MgO3/c4csP6V8CwAHziChdyhntobl0FpQnHQ22T
 WhRD/itUtMPLs+ti7Hpr0K+0AEX1huwy5+ZaHNDwi4nLKAh1DGUIY1RyYrQujXfVyWVo
 ex2XBNk9m4cwZLpZCU81rnxlJNUs1MeaM1gbMC0/dpTbxv+Vbt046Q851HG/6mfF5uev
 4CGQ==
X-Gm-Message-State: AC+VfDxKW13Jt/jE/MB07pM8PZqeVaNuj7XOz3IRQqZ0zFwBtxsy0EE1
 xnhF2SLob+w12ORsp4NgjELpo98HdcBfVvY+S/BJSdBT82+HN6duwWOeNN5+nYZikOPYuJCw4Y5
 Or9rKd+wLL6sq2Aw=
X-Received: by 2002:a7b:c4d5:0:b0:3f9:c933:c7d3 with SMTP id
 g21-20020a7bc4d5000000b003f9c933c7d3mr9284515wmk.19.1687787624136; 
 Mon, 26 Jun 2023 06:53:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ64hzjlyC0vtmMtrwYyFEW33eyHVcKObjCBWtP6dPRmu6ec0UyUqlcSaTZob+6n2Tap3xenbQ==
X-Received: by 2002:a7b:c4d5:0:b0:3f9:c933:c7d3 with SMTP id
 g21-20020a7bc4d5000000b003f9c933c7d3mr9284501wmk.19.1687787623839; 
 Mon, 26 Jun 2023 06:53:43 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 hn8-20020a05600ca38800b003fa722e8b48sm10816720wmb.32.2023.06.26.06.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 06:53:43 -0700 (PDT)
Date: Mon, 26 Jun 2023 09:53:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Michael Labiuk <michael.labiuk@virtuozzo.com>
Subject: Re: [PATCH v3 4/5] tests/qtest/hd-geo-test: fix test by removing
 unnecessary pcie-root-port
Message-ID: <20230626095206-mutt-send-email-mst@kernel.org>
References: <20230626124306.4572-1-anisinha@redhat.com>
 <20230626124306.4572-5-anisinha@redhat.com>
 <20230626153014.15a8ec6a@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626153014.15a8ec6a@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 26, 2023 at 03:30:14PM +0200, Igor Mammedov wrote:
> On Mon, 26 Jun 2023 18:13:05 +0530
> Ani Sinha <anisinha@redhat.com> wrote:
> 
> > The test attaches both a SCSI controller and a pcie-to-pci bridge on the same
> > pcie-root-port.
> 
> at slot addresses ...
> > This is incorrect since only one downstream device can be
> > attached to a pcie-root-port.
> not true in case of multifunction 
> perhaps
>   s/only one downstream device/a downstream device/
>   s/can be attached to/can be attached to slot 0/

The limitation is that devices can only be attached to slot 0.

BTW once we have ARI all these checks will have to be rewritten.



> also point out mess with pcie.0 bus name used for as id for bridge.
> 
> > Further, in the test scenario, there is no need
> > to attach a pcie-root-port to the root complex. A SCSI controller can be
> > attached to a pcie-to-pci bridge which in turn can be directly attached to the
> > root bus (peie.0). Fix the test and simplify it.
> > 
> > CC: mst@redhat.com
> > CC: imammedo@redhat.com
> > CC: Michael Labiuk <michael.labiuk@virtuozzo.com>
> > 
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > ---
> >  tests/qtest/hd-geo-test.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> > 
> > diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
> > index 5aa258a2b3..d08bffad91 100644
> > --- a/tests/qtest/hd-geo-test.c
> > +++ b/tests/qtest/hd-geo-test.c
> > @@ -784,14 +784,12 @@ static void test_override_scsi(void)
> >      test_override(args, "pc", expected);
> >  }
> >  
> > -static void setup_pci_bridge(TestArgs *args, const char *id, const char *rootid)
> > +static void setup_pci_bridge(TestArgs *args, const char *id)
> >  {
> >  
> > -    char *root, *br;
> > -    root = g_strdup_printf("-device pcie-root-port,id=%s", rootid);
> > -    br = g_strdup_printf("-device pcie-pci-bridge,bus=%s,id=%s", rootid, id);
> > +    char *br;
> > +    br = g_strdup_printf("-device pcie-pci-bridge,bus=pcie.0,id=%s", id);
> >  
> > -    args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, root);
> >      args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, br);
> >  }
> >  
> > @@ -811,8 +809,8 @@ static void test_override_scsi_q35(void)
> >      add_drive_with_mbr(args, empty_mbr, 1);
> >      add_drive_with_mbr(args, empty_mbr, 1);
> >      add_drive_with_mbr(args, empty_mbr, 1);
> > -    setup_pci_bridge(args, "pcie.0", "br");
> > -    add_scsi_controller(args, "lsi53c895a", "br", 3);
> > +    setup_pci_bridge(args, "pcie-pci-br");
> > +    add_scsi_controller(args, "lsi53c895a", "pcie-pci-br", 3);
> >      add_scsi_disk(args, 0, 0, 0, 0, 0, 10000, 120, 30);
> >      add_scsi_disk(args, 1, 0, 0, 1, 0, 9000, 120, 30);
> >      add_scsi_disk(args, 2, 0, 0, 2, 0, 1, 0, 0);
> > @@ -868,9 +866,9 @@ static void test_override_virtio_blk_q35(void)
> >      };
> >      add_drive_with_mbr(args, empty_mbr, 1);
> >      add_drive_with_mbr(args, empty_mbr, 1);
> > -    setup_pci_bridge(args, "pcie.0", "br");
> > -    add_virtio_disk(args, 0, "br", 3, 10000, 120, 30);
> > -    add_virtio_disk(args, 1, "br", 4, 9000, 120, 30);
> > +    setup_pci_bridge(args, "pcie-pci-br");
> > +    add_virtio_disk(args, 0, "pcie-pci-br", 3, 10000, 120, 30);
> > +    add_virtio_disk(args, 1, "pcie-pci-br", 4, 9000, 120, 30);
> >      test_override(args, "q35", expected);
> >  }
> >  


