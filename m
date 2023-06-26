Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9205B73DD2A
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:19:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkCX-0004MB-TX; Mon, 26 Jun 2023 07:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDkCK-00044s-4x
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDkCI-00016e-3c
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/F+r2FbWayY/UkpMGwi9VME8vci8sLOZ9VBIe03wo8I=;
 b=iKEzGCtnR/gZDMaeWLlU68aIdYsQYctLUvmHFFx4lLin7CxKgwzSQTSn84wqtL5Rlw0ZBJ
 nRVXCoNjGvLzr4ngkGDnupgngJRxCkz8ak1UqsKbRYMfThVltb/gZ2AlOo/HmaliP8zC7v
 r+Uv55J67qmn1X4Z8yeAtFJg9aMXW2s=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-kizkV7vyO2iU6f-hNQeA_w-1; Mon, 26 Jun 2023 07:15:51 -0400
X-MC-Unique: kizkV7vyO2iU6f-hNQeA_w-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b626e49e46so13104931fa.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778148; x=1690370148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/F+r2FbWayY/UkpMGwi9VME8vci8sLOZ9VBIe03wo8I=;
 b=NV55qAj6PMgh6gitBpi42KH4ykRbOSBQIRgqfjGgVGNM7WFgxDPpL+Uw9netDseT6L
 N+FNlzB1eKivRYLy9ZEoz6zJwjnRS9X0e3ZlsLlh8h73/GYMQTZ8T3nRwzm5Pf0ZQH1G
 8ZGTzMioiar4SmFDf+hZCUsMW+b1+WaauVtSrVwxI4fp38TMXoY7eaPPIPgLFXviFpCP
 s4a7lpbESwW4k4EruWNVJttiL5o9pKg8gTg9FJgyWWKb9s8HyJScxzhCR1/ncp0m7LvG
 MA2M+n3wOG3TOy0tXS8lc3KVOOE/Q9mEOCcGbkrYhaKcXkoPa/XV40A21ZXjwx8nGvqC
 2vuA==
X-Gm-Message-State: AC+VfDycK0kuFMN5JfWSsARVfCQ0NDYmwtyvmhc39DfN1yNRDIduDU3l
 D2oawzE4KoLxYPHahPBg4MvF1Iey1zwUngx/2nY4V+CezMzG5VZgURVT94TsPO+6vGUM66Og/+G
 oblwuBpuXljpauw7p1G88qpY=
X-Received: by 2002:a2e:9b4e:0:b0:2b3:4e76:9c6a with SMTP id
 o14-20020a2e9b4e000000b002b34e769c6amr19079657ljj.39.1687778148779; 
 Mon, 26 Jun 2023 04:15:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Bu2sq9/H1+LSlpKnBP3dKOk7f6jQfs7Rc5CPUMAgYtAz9UFPjiiCma2+pJKsDsIrYAj7xAg==
X-Received: by 2002:a2e:9b4e:0:b0:2b3:4e76:9c6a with SMTP id
 o14-20020a2e9b4e000000b002b34e769c6amr19079644ljj.39.1687778148495; 
 Mon, 26 Jun 2023 04:15:48 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 i7-20020aa7c9c7000000b0051a3334f873sm2674287edt.89.2023.06.26.04.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:15:47 -0700 (PDT)
Date: Mon, 26 Jun 2023 13:15:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com,
 Michael Labiuk <michael.labiuk@virtuozzo.com>
Subject: Re: [PATCH v2 4/5] tests/qtest/hd-geo-test: fix test by removing
 unnecessary pcie-root-port
Message-ID: <20230626131547.010ccdd8@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230622103255.267289-5-anisinha@redhat.com>
References: <20230622103255.267289-1-anisinha@redhat.com>
 <20230622103255.267289-5-anisinha@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Thu, 22 Jun 2023 16:02:54 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> A SCSI controller can be attached to a pcie-to-pci bridge which in turn can be
> attached directly to the root bus (peie.0). There is no need to attach a
> pcie-root-port on the root bus in order to attach the pcie-ro-pci bridge.
> Fix it.

bridge can be both on pcie.0 or on root-port and both are valid configs.
So what exactly and why we are fixing here?

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


