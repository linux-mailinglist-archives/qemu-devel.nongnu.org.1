Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA3173E20E
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:24:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDn7p-0008UE-Bk; Mon, 26 Jun 2023 10:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDn7a-0008SB-LY
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 10:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDn7I-0004SU-LD
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 10:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687789371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z3CeAv6nG9HE0z2e5n0PoIQSsq//6Vop//LoThl7VRo=;
 b=ZlrFdvdI8X/EKWqkNh8H4o/SsBaLunZEmJ6Jgn6tA+FA3WMkX6al0km0tZw2QFaVSXi1r5
 g9S/IRnDScEgO7PEF+WCaQai3rqmXDVWFDqyFNjag6VESP7wt09lmuEf7flSQOzGv6gz7f
 cW9kUmFcR6LqdZ7xaq91rABGOW+Ytcc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-ojMrWifVNtuyQ0kpMrwp0g-1; Mon, 26 Jun 2023 10:22:49 -0400
X-MC-Unique: ojMrWifVNtuyQ0kpMrwp0g-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-51d9c4b42c1so538041a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 07:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687789368; x=1690381368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z3CeAv6nG9HE0z2e5n0PoIQSsq//6Vop//LoThl7VRo=;
 b=bZ7+oSPorqddDmCv5wa0G8fsK8Vh/HFMg7pv+9ThJd/Jc4wg/XuKI1YU5KeCRKJ2+H
 PB0da5aB4Zqaf8EQruRM/OSxlxZ5MWJpxFVDkijgdJBw999d+/HwkRCE34qRNhqF1MON
 Y7kaj/StDvYogXrIIS6dwoYewLMe19WOoS9etxbDIiYH5vcu5qKsjIkpwoL0SEnOC2lT
 UC+HGyuRLcRL1GJojE1xeTYtP/8dEBJdSFlzJOikIryimFFIrDN4qhAy/4LPoBoVyIZn
 5UUDyu7VkxSgplvbATeQ/Hq21XHFh9cj9JtXWKviZI4HxleiPdF5jExOtz02hr58eQQ7
 eGzA==
X-Gm-Message-State: AC+VfDxela0E5DmqDfutPFGbpgifKSCqykdxz4d9cIrh+9CMOs8kWoNM
 6uRaldnajmlbBcA1sLhzGlNpqtrrcBDSfSdDf1wnc+cG7XUKZVl3S1/IyzRZ0Nh5d3kLo6KxDIM
 9vgb0puLucxflikM=
X-Received: by 2002:a05:6402:2037:b0:51d:92bf:e6ae with SMTP id
 ay23-20020a056402203700b0051d92bfe6aemr2356183edb.18.1687789368485; 
 Mon, 26 Jun 2023 07:22:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6SSUeLpvYiKVtsoJqSlBHe+yE8Sgg+3E/d9/XsOr6wgW4cXiOr8MGF0wQKnb75SC34FJNH6g==
X-Received: by 2002:a05:6402:2037:b0:51d:92bf:e6ae with SMTP id
 ay23-20020a056402203700b0051d92bfe6aemr2356170edb.18.1687789368193; 
 Mon, 26 Jun 2023 07:22:48 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 n14-20020aa7d04e000000b0050d83a39e6fsm2922712edo.4.2023.06.26.07.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 07:22:47 -0700 (PDT)
Date: Mon, 26 Jun 2023 16:22:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com,
 Michael Labiuk <michael.labiuk@virtuozzo.com>
Subject: Re: [PATCH v4 4/5] tests/qtest/hd-geo-test: fix incorrect
 pcie-root-port usage and simplify test
Message-ID: <20230626162246.0ba91051@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230626135324.10687-5-anisinha@redhat.com>
References: <20230626135324.10687-1-anisinha@redhat.com>
 <20230626135324.10687-5-anisinha@redhat.com>
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
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 26 Jun 2023 19:23:23 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> The test attaches both a SCSI controller and a pcie-to-pci bridge on the same
> pcie-root-port on slot 0.
statement is right only for bridge, while it's still incorrect for storage part
(see add_scsi_controller/add_virtio_disk)
they try to use slot !0

> This is incorrect since a single downstream device
> can be attached to a non-multifunction pcie-root-port on slot 0.

>Additionally
> using pcie.0 as id for pcie-root-port is incorrect as that id is reserved
> only for the root bus.
 ack on this part
 
> In the test scenario, there is no need to attach a pcie-root-port to the
> root complex. A SCSI controller can be attached to a pcie-to-pci bridge
> which can then be directly attached to the root bus (pcie.0).
> 
> Fix the test and simplify it.
> 
> CC: mst@redhat.com
> CC: imammedo@redhat.com
> CC: Michael Labiuk <michael.labiuk@virtuozzo.com>
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tests/qtest/hd-geo-test.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
> index 5aa258a2b3..d08bffad91 100644
> --- a/tests/qtest/hd-geo-test.c
> +++ b/tests/qtest/hd-geo-test.c
> @@ -784,14 +784,12 @@ static void test_override_scsi(void)
>      test_override(args, "pc", expected);
>  }
>  
> -static void setup_pci_bridge(TestArgs *args, const char *id, const char *rootid)
> +static void setup_pci_bridge(TestArgs *args, const char *id)
>  {
>  
> -    char *root, *br;
> -    root = g_strdup_printf("-device pcie-root-port,id=%s", rootid);
> -    br = g_strdup_printf("-device pcie-pci-bridge,bus=%s,id=%s", rootid, id);
> +    char *br;
> +    br = g_strdup_printf("-device pcie-pci-bridge,bus=pcie.0,id=%s", id);
>  
> -    args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, root);
>      args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, br);
>  }
>  
> @@ -811,8 +809,8 @@ static void test_override_scsi_q35(void)
>      add_drive_with_mbr(args, empty_mbr, 1);
>      add_drive_with_mbr(args, empty_mbr, 1);
>      add_drive_with_mbr(args, empty_mbr, 1);
> -    setup_pci_bridge(args, "pcie.0", "br");
> -    add_scsi_controller(args, "lsi53c895a", "br", 3);
> +    setup_pci_bridge(args, "pcie-pci-br");
> +    add_scsi_controller(args, "lsi53c895a", "pcie-pci-br", 3);
>      add_scsi_disk(args, 0, 0, 0, 0, 0, 10000, 120, 30);
>      add_scsi_disk(args, 1, 0, 0, 1, 0, 9000, 120, 30);
>      add_scsi_disk(args, 2, 0, 0, 2, 0, 1, 0, 0);
> @@ -868,9 +866,9 @@ static void test_override_virtio_blk_q35(void)
>      };
>      add_drive_with_mbr(args, empty_mbr, 1);
>      add_drive_with_mbr(args, empty_mbr, 1);
> -    setup_pci_bridge(args, "pcie.0", "br");
> -    add_virtio_disk(args, 0, "br", 3, 10000, 120, 30);
> -    add_virtio_disk(args, 1, "br", 4, 9000, 120, 30);
> +    setup_pci_bridge(args, "pcie-pci-br");
> +    add_virtio_disk(args, 0, "pcie-pci-br", 3, 10000, 120, 30);
> +    add_virtio_disk(args, 1, "pcie-pci-br", 4, 9000, 120, 30);
>      test_override(args, "q35", expected);
>  }
>  


