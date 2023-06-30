Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7317437EB
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 11:11:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFA8m-0006AG-6d; Fri, 30 Jun 2023 05:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qFA8g-0006A0-Lu
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 05:10:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qFA8e-0007nZ-Sg
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 05:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688116199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=en2XUnJeH8h6EAsfxqFqb7cTQpWcVVy9GMuJQLcUU8c=;
 b=J2Zqcv+g7XC3sLwLP1VYKYz8hUvJuJAdWQ7f5Dq93DNHwaQu+ccBSMzrm7yFhEMSX/OAOa
 gE8Hu9G+A3mt0YScFqzSz9I+G1T1nLQNS6scJ5/33yxmXSXZ752PDSi5fXTRBWPMJu+g0x
 FPiAoNJVP7037EVzcD7XCERbP7XMamU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-G9Wi_hd9N4qZpHUF8bhGOw-1; Fri, 30 Jun 2023 05:09:57 -0400
X-MC-Unique: G9Wi_hd9N4qZpHUF8bhGOw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-98843cc8980so153298466b.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 02:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688116196; x=1690708196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=en2XUnJeH8h6EAsfxqFqb7cTQpWcVVy9GMuJQLcUU8c=;
 b=WoRzlPCa16qZh7Y5SF2GqeoC90z2JmBhHriCUB1JihUYIOOBHLpO0rnUcPNQmX46Ly
 n5+D3tTGrN13H7XrQQU+BEKzYwEDw9nJzznsAgjsxynPgK/W73ZCBuhV89ydAY1sDKss
 60wcmhAVZ1CXvzB50CvG+Atgxc7aqruaKfrEW6OFK2xL9jrL8xZlAuM0z3Am51/WdRrX
 EDlBjXWsa4syk2d9R3/G5c0hI7HOPERrIvkJ5X1B6er7BraufjwAOr5vulCzTbXHp3Zy
 tcBe4K1HSNlx+d6PEnmuUKVxr7Or0VwHdNHhT3C5i+4qgR/IshVW4uf0Fv8bG3Gws3a4
 s0TA==
X-Gm-Message-State: ABy/qLboksjr/U4fCbBjBr8vHugPqmSvvRbBxY34o9gnJ1oD7l3p0eJ4
 4QiKYE9PGpKCVVfjmUeHZJw6xA1igC8mm8OOo03sdIoXut08zPusVxxfw4q/tHwj5J+8uo5x44E
 Mzr+Uc5RLkznglo8=
X-Received: by 2002:a17:906:bce8:b0:98e:933:2909 with SMTP id
 op8-20020a170906bce800b0098e09332909mr1419855ejb.22.1688116196357; 
 Fri, 30 Jun 2023 02:09:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG6RXiKkvZX85UqiKx4H6DVxzZuTmOrqBiSL5PaVXQT7tlpkosbCcbx/mMwuN+EQ1SKaZSq5g==
X-Received: by 2002:a17:906:bce8:b0:98e:933:2909 with SMTP id
 op8-20020a170906bce800b0098e09332909mr1419836ejb.22.1688116196092; 
 Fri, 30 Jun 2023 02:09:56 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 p13-20020a1709060e8d00b00989065149d0sm7752649ejf.86.2023.06.30.02.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 02:09:55 -0700 (PDT)
Date: Fri, 30 Jun 2023 11:09:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com,
 Michael Labiuk <michael.labiuk@virtuozzo.com>
Subject: Re: [PATCH v6 4/5] tests/qtest/hd-geo-test: fix incorrect
 pcie-root-port usage and simplify test
Message-ID: <20230630110954.0302d5f9@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230629040707.115656-5-anisinha@redhat.com>
References: <20230629040707.115656-1-anisinha@redhat.com>
 <20230629040707.115656-5-anisinha@redhat.com>
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

On Thu, 29 Jun 2023 09:37:06 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> The test attaches a SCSI controller to a non-zero slot and a pcie-to-pci bridge
> on slot 0 on the same pcie-root-port. Since a downstream device can be attached
> to a pcie-root-port only on slot 0, the above test configuration is not allowed.
> Additionally using pcie.0 as id for pcie-to-pci bridge is incorrect as that id
> is reserved only for the root bus.
> 
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

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

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


