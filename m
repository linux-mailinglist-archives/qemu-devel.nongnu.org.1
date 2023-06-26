Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F7873E12D
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:55:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmgm-0008TT-Sl; Mon, 26 Jun 2023 09:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDmgM-0008DX-Mx
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDmgK-0006a6-NO
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687787704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EBOZx1CLK9yDdOFR8zIkFXKLWstSftGUYk2BbjCA8KU=;
 b=G54udGOyb5qRk2L7ZaCiMYOCIK5btKT5yHLv4aCSl4p2RIWfosIHyNNrgH9ZhHXKzj7eA6
 ahtz224ADjzlMvzwey6R+0aID+Hq0VCdAV2sbmyG3N9EZrxv98j4/1c+nlTmZa++9U24SD
 DqqxtwRfGvorPvaQt7t/9CfGE4EeN5c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-bxI6TQnqMoq9C-TGtQ2Esw-1; Mon, 26 Jun 2023 09:55:02 -0400
X-MC-Unique: bxI6TQnqMoq9C-TGtQ2Esw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3113da8b778so1226511f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687787701; x=1690379701;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBOZx1CLK9yDdOFR8zIkFXKLWstSftGUYk2BbjCA8KU=;
 b=lHI+oREwmFSPBTeGra56Tvp9wuC9SbrDLdhxHYShciX/GwZ7qBZj94aOTucNKnfrJH
 eGZ9phOZ0jNG6sIzcvXXIa4ev6tx7OSdm0kJ3y49W+JVqORS0byum29WSHGtCTg76Fsy
 C4JD4WJxLOfizGboiGuFw0mzHNF7XhwaL9fRA2V44CL1IM/bXuso91HLNdwsHVKwiKqB
 tWZfvGtylrloy7Vp0+gNd1OEkYnO5qf6AajkuMnbcacat+rI/3zY9jUN6HdWT1d0E96g
 hOXJAUVYRaC+nbzW0rBVsK9Prio1whBRAFffgywpvgTbP2bV9+o07F9fiUfuDUmTjUf9
 zEQw==
X-Gm-Message-State: AC+VfDy2P69k0mKGT0xvGzOnb65GkVlptzEz9o3yyPMpfHvg8bbRm8U7
 t8EJihk3LpSTduP5aVjS63ATjo4UiTFAsJ0WK+RTBPaucHG+AKXgVEEAZ6+xFP4kXDAf8yRQROU
 2PB8X2Tv1tvM0eGLuOly4pxY=
X-Received: by 2002:adf:fac3:0:b0:313:f6bb:ec2b with SMTP id
 a3-20020adffac3000000b00313f6bbec2bmr933027wrs.47.1687787701351; 
 Mon, 26 Jun 2023 06:55:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ77n3nE+txFXG7Rkk4ddDqZKnJHzrB9Yl8BkSpHpgfZxNhHXGKRSRnxXQ1zyiI1rqA7wAurOw==
X-Received: by 2002:adf:fac3:0:b0:313:f6bb:ec2b with SMTP id
 a3-20020adffac3000000b00313f6bbec2bmr933018wrs.47.1687787701082; 
 Mon, 26 Jun 2023 06:55:01 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 s6-20020a5d4ec6000000b0030ae849c70csm7470691wrv.37.2023.06.26.06.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 06:55:00 -0700 (PDT)
Date: Mon, 26 Jun 2023 09:54:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, jusual@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, michael.labiuk@virtuozzo.com
Subject: Re: [PATCH v4 0/5] test and QEMU fixes to ensure proper PCIE device
 usage
Message-ID: <20230626095407-mutt-send-email-mst@kernel.org>
References: <20230626135324.10687-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626135324.10687-1-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

Ani, two versions a day is too much, pls don't unless first one
has been sent by mistake or something. then explain what
it was pls.

On Mon, Jun 26, 2023 at 07:23:19PM +0530, Ani Sinha wrote:
> Patches 1-4:
> Fix tests so that devices do not use non-zero slots on the pcie root
> ports. PCIE ports only have one slot, so PCIE devices can only be
> plugged into slot 0 on a PCIE port.
> 
> Patch 5:
> Enforce only one slot on PCIE port.
> 
> The test fixes must be applied before the QEMU change that checks for use
> of a single slot in PCIE port.
> 
> CC: mst@redhat.com
> CC: imammedo@redhat.com
> CC: jusual@redhat.com
> CC: thuth@redhat.com
> CC: lvivier@redhat.com
> CC: michael.labiuk@virtuozzo.com
> 
> Changelog:
> v4: reword commit log for patch 4.
> v3: tags added. reword the error description in patch 5. Reword commit log in patch 4. 
> v2: add hd-geo-test fix as well as the actual QEMU code fix to the patchset.
> The patches are added in the right order.
> 
> Ani Sinha (5):
>   tests/acpi: allow changes in DSDT.noacpihp table blob
>   tests/acpi/bios-tables-test: use the correct slot on the
>     pcie-root-port
>   tests/acpi/bios-tables-test: update acpi blob q35/DSDT.noacpihp
>   tests/qtest/hd-geo-test: fix incorrect pcie-root-port usage and
>     simplify test
>   hw/pci: ensure PCIE devices are plugged into only slot 0 of PCIE port
> 
>  hw/pci/pci.c                      |   6 ++++++
>  tests/data/acpi/q35/DSDT.noacpihp | Bin 8248 -> 8241 bytes
>  tests/qtest/bios-tables-test.c    |   4 ++--
>  tests/qtest/hd-geo-test.c         |  18 ++++++++----------
>  4 files changed, 16 insertions(+), 12 deletions(-)
> 
> -- 
> 2.39.1


