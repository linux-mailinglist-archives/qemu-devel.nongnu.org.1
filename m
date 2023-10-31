Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6FD7DCE3A
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:52:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxp9x-0006xf-6x; Tue, 31 Oct 2023 09:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qxp9u-0006xL-Es
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qxp9s-0008Bg-V9
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698760312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s+sdcpZNMUnAap9z/iWf/KN0SHeP/0M99pAOHq5Vj5o=;
 b=QOo5aFiO0+E6z02iYWzehmvblGzKWw9/SiXfJ6VkGVlSFZ36KeKJKzosKAQ4aulDcW5u06
 NwBr0e6cOcXdkEiTmLdbkJpCc1RvfV/pyPKDhAUR02+HPFY5d/2rkNu7PCtBQJdWX0S7bh
 vNV3AljGHd1kGFi7lMNmxnOrWAfUUNg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-00Dv6SDyPkCIZddCDwlqCA-1; Tue, 31 Oct 2023 09:51:35 -0400
X-MC-Unique: 00Dv6SDyPkCIZddCDwlqCA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32f8c4e9b88so1104929f8f.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 06:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698760294; x=1699365094;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+sdcpZNMUnAap9z/iWf/KN0SHeP/0M99pAOHq5Vj5o=;
 b=VbQRaq6yuJjXJXkgI9OhDMn1vocSULzu1pEMeDTKbVDag2aLrThzjibPqQ9i9WbfXD
 jhsgH8e2qEWpz1QFBsO0ctqroiIGC9hZB9RO+Kuxc/Dcn9SSbryfWMUh+99V2XmX/mrm
 j3W7wykHL7KVboqhS6s3FHCE1YlzFQL8hEvWD2dv6f7NGjepzRPLjfx1W5TZBSaepV2k
 RIqmmB/l3TtGxJZKbB1kAiLCzQiogTJzYOkm/ZVbGTUn1Mj0Ezcegt2LTYzs/tWGnquA
 Hspwu/yyDFlA0v5mw4WmC3JcuZetaaia3VC1xabB+JgpJ94HiQ++NCBw019YXGAmYOUi
 4kiA==
X-Gm-Message-State: AOJu0YyVaKZGAap6keO567qChDaSmXjCABv2DigAIevR0SjuJxLhtJAI
 B/QBNrzaK1T0wM4MAfslITfLPNJw4ehkPSE3UAbCdQ2hvvWw0f13ZHzOvXBWvH4pHtAKBdmTDyy
 BUZ8a3AtRogCVbPY=
X-Received: by 2002:a5d:5985:0:b0:32f:8853:78df with SMTP id
 n5-20020a5d5985000000b0032f885378dfmr3158399wri.11.1698760294344; 
 Tue, 31 Oct 2023 06:51:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNt0gXuOfOjNn4GddNcQJwPjv36Htr10lC7OeRUTJFdTywHoCykWONUrQbSblmPkc/a3KQjQ==
X-Received: by 2002:a5d:5985:0:b0:32f:8853:78df with SMTP id
 n5-20020a5d5985000000b0032f885378dfmr3158376wri.11.1698760294015; 
 Tue, 31 Oct 2023 06:51:34 -0700 (PDT)
Received: from redhat.com ([2.52.26.150]) by smtp.gmail.com with ESMTPSA id
 t10-20020a1c770a000000b0040641a9d49bsm1780758wmi.17.2023.10.31.06.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 06:51:33 -0700 (PDT)
Date: Tue, 31 Oct 2023 09:51:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: tests/data/acpi/rebuild-expected-aml.sh creates files for arm
 virt that don't exist in git
Message-ID: <20231031094948-mutt-send-email-mst@kernel.org>
References: <CAFEAcA_qBLXdeB7aQLcjcfMdEf9hpJu4ZhZZdHbF4SOSyZZXdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_qBLXdeB7aQLcjcfMdEf9hpJu4ZhZZdHbF4SOSyZZXdw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

On Tue, Oct 31, 2023 at 01:08:01PM +0000, Peter Maydell wrote:
> I'm doing a patchset that requires rebuilding the bios-tables-test
> expected-data files for the arm virt board. The instructions in
> bios-tables-test.c say that you should run rebuild-expected-aml.sh
> to update the data files. But running that script generates a lot
> of new data files that don't exist in git at all and are unrelated
> to the change I'm making:
> 
>         tests/data/acpi/virt/APIC.memhp
>         tests/data/acpi/virt/APIC.numamem
>         tests/data/acpi/virt/APIC.pxb
>         tests/data/acpi/virt/DBG2.acpihmatvirt
>         tests/data/acpi/virt/DBG2.memhp
>         tests/data/acpi/virt/DBG2.numamem
>         tests/data/acpi/virt/DBG2.pxb
>         tests/data/acpi/virt/DBG2.topology
>         tests/data/acpi/virt/DSDT.numamem
>         tests/data/acpi/virt/FACP.acpihmatvirt
>         tests/data/acpi/virt/FACP.memhp
>         tests/data/acpi/virt/FACP.numamem
>         tests/data/acpi/virt/FACP.pxb
>         tests/data/acpi/virt/FACP.topology
>         tests/data/acpi/virt/GTDT.acpihmatvirt
>         tests/data/acpi/virt/GTDT.memhp
>         tests/data/acpi/virt/GTDT.numamem
>         tests/data/acpi/virt/GTDT.pxb
>         tests/data/acpi/virt/GTDT.topology
>         tests/data/acpi/virt/IORT.acpihmatvirt
>         tests/data/acpi/virt/IORT.memhp
>         tests/data/acpi/virt/IORT.numamem
>         tests/data/acpi/virt/IORT.pxb
>         tests/data/acpi/virt/IORT.topology
>         tests/data/acpi/virt/MCFG.acpihmatvirt
>         tests/data/acpi/virt/MCFG.memhp
>         tests/data/acpi/virt/MCFG.numamem
>         tests/data/acpi/virt/MCFG.pxb
>         tests/data/acpi/virt/MCFG.topology
>         tests/data/acpi/virt/PPTT.memhp
>         tests/data/acpi/virt/PPTT.numamem
>         tests/data/acpi/virt/PPTT.pxb
>         tests/data/acpi/virt/SPCR.acpihmatvirt
>         tests/data/acpi/virt/SPCR.memhp
>         tests/data/acpi/virt/SPCR.numamem
>         tests/data/acpi/virt/SPCR.pxb
>         tests/data/acpi/virt/SPCR.topology
> 
> Does the script need fixing to not generate these files, or should
> they exist in the git repo?

The script is not smart enough to notice that files are identical - e.g.
tests/data/acpi/virt/PPTT are all the same so we just have one of these
- and so all the copies don't need to be there. Just check and then blow
away the unnecessary files.

-- 
MST


