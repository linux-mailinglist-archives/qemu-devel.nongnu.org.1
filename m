Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FADE73F7E2
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 10:55:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4TY-0001ad-JX; Tue, 27 Jun 2023 04:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qE4Sq-0001TF-F9
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 04:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qE4So-0007RV-H6
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 04:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687856057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PcRinwJW70Z+okwHmQsYfCUs5P7z2rYgMy/6g4Tlbic=;
 b=cuR69BfkNPjRKiCu+scvlnU+UTo6jeQpgazQeEBiRDVto7brYDa9TykNWtZlvx656DIw2u
 hg9J8MG9i+EVO5MuE+qwvBXxzn3pcmEbGX7hY1AwqNwI5OePPPCad4w/h/iqRhmayA2vJy
 QfKhefpuxozTrqYeSQOP2NNHJLBT3hA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-t5kRhjPeM1SeXw2F77JozQ-1; Tue, 27 Jun 2023 04:54:15 -0400
X-MC-Unique: t5kRhjPeM1SeXw2F77JozQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-51bfa36eef5so2546344a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 01:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687856054; x=1690448054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PcRinwJW70Z+okwHmQsYfCUs5P7z2rYgMy/6g4Tlbic=;
 b=eExdhx8Z1xSKHdIPoKXs5K64gcxQoL/gD7at1alFLATEnpdLA6+x5lneo6fwZ46T0H
 yBXtni7mGKmhMJDtHgjn2UQ1F318UEilWI3IFo36OCqQ+7xY9XFDWI1YhlW1/tY+xl9k
 lRlK9JmXAOZlmZpUckLD6BUJmSrRTLE79hZJO5U6NONtY/Ve5VkG939ln1A2QLE7Qmp/
 QCzc9A+1Hb0C57okLc0brZYT9173z69fCQePn5ftHrQFBOHsO8RgAkvDL2HUyMxY+NAu
 ZO0FXf6nhfEUp5MKvsRTo/frER+hoPfsCi8+lCh4oXmOHW2aorLZ91yM7PPbAoaCEy7R
 6VlQ==
X-Gm-Message-State: AC+VfDxbBqIbsH/fUIFlot+RAwZja2YvrzGyvEAz+PmIsqUW8JUgfGVv
 uqVaaat2x4xmVcx+A+dV6VsAiBr3fBKkghU1FivpAIl0Wb+f6QvljIvXkbq9XBVNVcCjub/kwk9
 hHZbkxkKZBw0yz/M=
X-Received: by 2002:a05:6402:1507:b0:51d:9464:3cae with SMTP id
 f7-20020a056402150700b0051d94643caemr4683679edw.5.1687856054691; 
 Tue, 27 Jun 2023 01:54:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7vtlTgEu24B5uXkxdAbViUYn63ktYWUiQld5tVkGhxKHzqzyB2dwX4gR08jM0DlBKn0Z84Jw==
X-Received: by 2002:a05:6402:1507:b0:51d:9464:3cae with SMTP id
 f7-20020a056402150700b0051d94643caemr4683663edw.5.1687856054384; 
 Tue, 27 Jun 2023 01:54:14 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 m5-20020aa7d345000000b0051495ce23absm3644304edr.10.2023.06.27.01.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 01:54:13 -0700 (PDT)
Date: Tue, 27 Jun 2023 10:54:13 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com,
 Michael Labiuk <michael.labiuk@virtuozzo.com>
Subject: Re: [RESEND PATCH v5 4/5] tests/qtest/hd-geo-test: fix incorrect
 pcie-root-port usage and simplify test
Message-ID: <20230627105413.125f3da7@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230626161244.4145-5-anisinha@redhat.com>
References: <20230626161244.4145-1-anisinha@redhat.com>
 <20230626161244.4145-5-anisinha@redhat.com>
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

On Mon, 26 Jun 2023 21:42:43 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> The test attaches a SCSI controller to a non-zero slot and a pcie-to-pci bridge
> on slot 0 on the same pcie-root-port. Since a downstream device can be attached
> to a pcie-root-port only on slot 0, the above test configuration is not allowed.

> Additionally using pcie.0 as id for pcie-root-port is incorrect as that id is
                                      ^^^^ shouldn't it be pcie-to-pci ?
> reserved only for the root bus.

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


