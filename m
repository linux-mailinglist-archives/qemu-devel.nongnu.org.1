Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 350F273E0A6
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:30:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmIQ-0000is-FZ; Mon, 26 Jun 2023 09:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDmIO-0000ii-St
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDmIN-0000a5-CB
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687786218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pNobnUdGVAQxct8S45RqeMG4xUON4/9FHvYLt/v2Q+k=;
 b=S0SjHPHmODOPMDIsDD33/WLS6Qn19BGHvV6llA76YWIk6K+ui7vw0liK+DszAnPqlRx48L
 A50EqtrokGBmjBhXJVPQyrF9I6gp5dHGnN+ID2FL8pJ2YyZiVOav691kZcGrvE7OGohJNP
 GuhLiTTe2H/A7l0hlVjxjHPl3A7Mbs4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-dNT3b9aDMgCp5L4j9i7gvg-1; Mon, 26 Jun 2023 09:30:17 -0400
X-MC-Unique: dNT3b9aDMgCp5L4j9i7gvg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-987accb96dbso220132166b.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687786216; x=1690378216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pNobnUdGVAQxct8S45RqeMG4xUON4/9FHvYLt/v2Q+k=;
 b=DuGgQ5ruruGOEces2/kg9wig3OdGvFrGXS9gheGnDSpEiaQW21z4PWMwTRYUiF59d+
 UAvYUO7iaGD2M7sO40m7dT0AkrV2eNidjRM1ET+yNxNyF5/2AwVcy3wKG3lhDSzHSV63
 KSrcCikEPwvbMj7Kt0toCcd7auA8+F1Qmb7EZ3+uv9WJIB7q7gQwqYczORP14dwGFqlo
 FZNJrfCb6KgLS7YoidRu1gxJM2EzrL93pDGhsI2Acbe8fhN9O15pMGk/qqpj1qNMj4Dj
 sv+rv3DCSpM38qOmx2ft3vjCmDurHnQtLSYk5G221+U+24V6vSGfU2F74RHh0OZ2LsPr
 sMVg==
X-Gm-Message-State: AC+VfDzdupFRO9cqBHQ+UwrcCHlj9seBvOF4HvPMBKi0xbTIDBwR+vQ+
 0bZZIbwXbZNemUOSJN2NdrMw8LxUg0DMuSGMBC6aQ0DclRhcB0rOj3nKhuLOabMy5m38TBnM7vc
 QhJgdVfvCuDazIQ0=
X-Received: by 2002:a17:907:5cb:b0:988:7d68:9fee with SMTP id
 wg11-20020a17090705cb00b009887d689feemr19548458ejb.34.1687786216176; 
 Mon, 26 Jun 2023 06:30:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4mxXSlr7dbPvv2FFfboGkhntme3ef3Fd34eSg5S8HROT3Rcutoiky/kkAh25rhhT1xOCbsfA==
X-Received: by 2002:a17:907:5cb:b0:988:7d68:9fee with SMTP id
 wg11-20020a17090705cb00b009887d689feemr19548439ejb.34.1687786215918; 
 Mon, 26 Jun 2023 06:30:15 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 q22-20020a17090622d600b009895af2580asm3236422eja.36.2023.06.26.06.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 06:30:15 -0700 (PDT)
Date: Mon, 26 Jun 2023 15:30:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com,
 Michael Labiuk <michael.labiuk@virtuozzo.com>
Subject: Re: [PATCH v3 4/5] tests/qtest/hd-geo-test: fix test by removing
 unnecessary pcie-root-port
Message-ID: <20230626153014.15a8ec6a@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230626124306.4572-5-anisinha@redhat.com>
References: <20230626124306.4572-1-anisinha@redhat.com>
 <20230626124306.4572-5-anisinha@redhat.com>
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

On Mon, 26 Jun 2023 18:13:05 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> The test attaches both a SCSI controller and a pcie-to-pci bridge on the same
> pcie-root-port.

at slot addresses ...
> This is incorrect since only one downstream device can be
> attached to a pcie-root-port.
not true in case of multifunction 
perhaps
  s/only one downstream device/a downstream device/
  s/can be attached to/can be attached to slot 0/

also point out mess with pcie.0 bus name used for as id for bridge.

> Further, in the test scenario, there is no need
> to attach a pcie-root-port to the root complex. A SCSI controller can be
> attached to a pcie-to-pci bridge which in turn can be directly attached to the
> root bus (peie.0). Fix the test and simplify it.
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


