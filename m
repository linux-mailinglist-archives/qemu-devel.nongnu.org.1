Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B90BE73E19D
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:10:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmuH-0002s4-5h; Mon, 26 Jun 2023 10:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDmuE-0002rg-HD
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 10:09:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDmuC-0001iN-Be
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 10:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687788563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K0MhHfKcJnGSLIWvKrfIgmko0u9JkpKs9eUnOKpTbWc=;
 b=gzJ9uGHHalCyUh2VzGk+Tx5aNTY1cx8z9aI3jCNRe2JuA1SzMf/RG9Noo66CTaJ6iZE/Ws
 0oExzWKI/wpQuMibp3pHnvAjCCrCz6IzYhEhjMPZtJlvab2Tq4xE75XL3zeuBKXGcc3RSi
 L/WXOBLXFg++Gy/hQxKP88qUX/IMsKg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-bwzF5b8_PbSIkYGC1KwRUg-1; Mon, 26 Jun 2023 10:09:21 -0400
X-MC-Unique: bwzF5b8_PbSIkYGC1KwRUg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6997407faso11662901fa.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 07:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687788558; x=1690380558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K0MhHfKcJnGSLIWvKrfIgmko0u9JkpKs9eUnOKpTbWc=;
 b=LryNg4Fd1EBZzej+dIcnPPVx30+vS4uJH4h6+8klzZLCIAzZxxKy+i2/NciINrkgHu
 VO8xRDIZh2c08T34gWZreHt/xpYmnIatKOn7ZXDNgfO56B0eiSzguY9/NQ+bsYb8Q/yx
 xqjcIjPfnTFqtMRZs3KGEIxMdY1X/Fvbn0rZX6r3xwu006gchu8Wsy16slw4MQiwRISd
 KtRVn6OOGn/wPBYYcUCJ4QC+Rh4FkoJvjQIp1lH6N+DrFDbAaIFBFU9xLRhgJxOV4JwR
 QO9BEV8/yNSIOI9AwmANUPaGXDO62MTuPWW5x0o9XSsKgXi//sr3wJ27zgDdej+KNG/k
 3l4w==
X-Gm-Message-State: AC+VfDwNWZufaBy6xLlcciiV2UGQisvbPzuQFsEuYB8+YlcxKOtAII1a
 xCa6LEcAM+T/ytgBUzFivczq68BLnEriY5Djvfj6O7NMS/ltzP7IIfhkIeSCYL1ytcqFXvWRLfW
 icrNqIUFROzuiAfvT9dybM+Y=
X-Received: by 2002:a2e:7a06:0:b0:2b6:97e6:93f5 with SMTP id
 v6-20020a2e7a06000000b002b697e693f5mr2600232ljc.11.1687788558144; 
 Mon, 26 Jun 2023 07:09:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6LaHSICnu69o8v+QZmEKFEmSjolSEes6MUzIZ/OrAe7vu2SZASs0z9FIIp5hZ0avUsrOP/Pg==
X-Received: by 2002:a2e:7a06:0:b0:2b6:97e6:93f5 with SMTP id
 v6-20020a2e7a06000000b002b697e693f5mr2600219ljc.11.1687788557814; 
 Mon, 26 Jun 2023 07:09:17 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 l4-20020aa7c3c4000000b0051879e2505bsm2861644edr.40.2023.06.26.07.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 07:09:17 -0700 (PDT)
Date: Mon, 26 Jun 2023 16:09:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Michael Labiuk <michael.labiuk@virtuozzo.com>
Subject: Re: [PATCH v3 4/5] tests/qtest/hd-geo-test: fix test by removing
 unnecessary pcie-root-port
Message-ID: <20230626160916.53176531@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230626095206-mutt-send-email-mst@kernel.org>
References: <20230626124306.4572-1-anisinha@redhat.com>
 <20230626124306.4572-5-anisinha@redhat.com>
 <20230626153014.15a8ec6a@imammedo.users.ipa.redhat.com>
 <20230626095206-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Mon, 26 Jun 2023 09:53:40 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jun 26, 2023 at 03:30:14PM +0200, Igor Mammedov wrote:
> > On Mon, 26 Jun 2023 18:13:05 +0530
> > Ani Sinha <anisinha@redhat.com> wrote:
> >   
> > > The test attaches both a SCSI controller and a pcie-to-pci bridge on the same
> > > pcie-root-port.  
> > 
> > at slot addresses ...  
> > > This is incorrect since only one downstream device can be
> > > attached to a pcie-root-port.  
> > not true in case of multifunction 
> > perhaps
> >   s/only one downstream device/a downstream device/
> >   s/can be attached to/can be attached to slot 0/  
> 
> The limitation is that devices can only be attached to slot 0.
> 
> BTW once we have ARI all these checks will have to be rewritten.

I'm under impression that we already support ARI (pcie_ari_init)

> 
> 
> 
> > also point out mess with pcie.0 bus name used for as id for bridge.
> >   
> > > Further, in the test scenario, there is no need
> > > to attach a pcie-root-port to the root complex. A SCSI controller can be
> > > attached to a pcie-to-pci bridge which in turn can be directly attached to the
> > > root bus (peie.0). Fix the test and simplify it.
> > > 
> > > CC: mst@redhat.com
> > > CC: imammedo@redhat.com
> > > CC: Michael Labiuk <michael.labiuk@virtuozzo.com>
> > > 
> > > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > > ---
> > >  tests/qtest/hd-geo-test.c | 18 ++++++++----------
> > >  1 file changed, 8 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
> > > index 5aa258a2b3..d08bffad91 100644
> > > --- a/tests/qtest/hd-geo-test.c
> > > +++ b/tests/qtest/hd-geo-test.c
> > > @@ -784,14 +784,12 @@ static void test_override_scsi(void)
> > >      test_override(args, "pc", expected);
> > >  }
> > >  
> > > -static void setup_pci_bridge(TestArgs *args, const char *id, const char *rootid)
> > > +static void setup_pci_bridge(TestArgs *args, const char *id)
> > >  {
> > >  
> > > -    char *root, *br;
> > > -    root = g_strdup_printf("-device pcie-root-port,id=%s", rootid);
> > > -    br = g_strdup_printf("-device pcie-pci-bridge,bus=%s,id=%s", rootid, id);
> > > +    char *br;
> > > +    br = g_strdup_printf("-device pcie-pci-bridge,bus=pcie.0,id=%s", id);
> > >  
> > > -    args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, root);
> > >      args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, br);
> > >  }
> > >  
> > > @@ -811,8 +809,8 @@ static void test_override_scsi_q35(void)
> > >      add_drive_with_mbr(args, empty_mbr, 1);
> > >      add_drive_with_mbr(args, empty_mbr, 1);
> > >      add_drive_with_mbr(args, empty_mbr, 1);
> > > -    setup_pci_bridge(args, "pcie.0", "br");
> > > -    add_scsi_controller(args, "lsi53c895a", "br", 3);
> > > +    setup_pci_bridge(args, "pcie-pci-br");
> > > +    add_scsi_controller(args, "lsi53c895a", "pcie-pci-br", 3);
> > >      add_scsi_disk(args, 0, 0, 0, 0, 0, 10000, 120, 30);
> > >      add_scsi_disk(args, 1, 0, 0, 1, 0, 9000, 120, 30);
> > >      add_scsi_disk(args, 2, 0, 0, 2, 0, 1, 0, 0);
> > > @@ -868,9 +866,9 @@ static void test_override_virtio_blk_q35(void)
> > >      };
> > >      add_drive_with_mbr(args, empty_mbr, 1);
> > >      add_drive_with_mbr(args, empty_mbr, 1);
> > > -    setup_pci_bridge(args, "pcie.0", "br");
> > > -    add_virtio_disk(args, 0, "br", 3, 10000, 120, 30);
> > > -    add_virtio_disk(args, 1, "br", 4, 9000, 120, 30);
> > > +    setup_pci_bridge(args, "pcie-pci-br");
> > > +    add_virtio_disk(args, 0, "pcie-pci-br", 3, 10000, 120, 30);
> > > +    add_virtio_disk(args, 1, "pcie-pci-br", 4, 9000, 120, 30);
> > >      test_override(args, "q35", expected);
> > >  }
> > >    
> 


