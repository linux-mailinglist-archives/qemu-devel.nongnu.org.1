Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC95473F51C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 09:12:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE2ra-0004Gc-7Y; Tue, 27 Jun 2023 03:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qE2rW-0004GR-Gb
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qE2rV-0001vK-4g
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687849900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6VVhVzXs6+8xF41LtPYoUG8bj5MGwR49pfsVcwj9t1w=;
 b=B13qZYtbPwn7JfnzN4RCZdf7uqfUIjT2m6nAidF2HfWa+2nMGDRwp3pwI5iaUmL5H8G2mk
 8pgcELGtyOu81wbV/YhbITjocdUl+wzK7qYl5DcdvRYLt1pQk6gkjWXxQOtwSCt/bGtFri
 Mm2B64mjfzp1lWrm3efIHhiX/mbZiQw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-Om0P_TD4MnGolPpHYWaTug-1; Tue, 27 Jun 2023 03:11:36 -0400
X-MC-Unique: Om0P_TD4MnGolPpHYWaTug-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-313f5021d9bso716172f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 00:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687849895; x=1690441895;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6VVhVzXs6+8xF41LtPYoUG8bj5MGwR49pfsVcwj9t1w=;
 b=TUFc003Hmauel7ETpEsztwbLfK+7sNFFJMDgxNjupOuezV2Fb4G6HSyHzxV4qcJZQK
 vqX2mgZrK9I7xEnYU70gbLthb/WNkeJnW2x4y2mTRRbnr2fOuIXblIFWiwqVcQombada
 V+jxKxlbw94+/kTmzKdz7vp134OFexZgfruPJvz9aaDf6+oQ0yxEH1P/HZOELl3Cx8+8
 6d1zWkF4toKMK29lBYZIjWf6dn1x3F+0psi6GsmlpYHiCa94cHcsHWwUtSaggvgdj1x3
 wB06UQVWEnYZ3+gKkBuTyknsOIxEdsuhsONzweIC+NBlspCBDyZ4134tKd8sTdifWbzg
 0GHA==
X-Gm-Message-State: AC+VfDz9DcGWj3H4YUDZWjWPmxxe31jE/+D+PkfqryjfFKulKceLTvOD
 lknP0SfsdigCXd36IzuYLGqv/K9pttEJQzYBNqvLauxJmu5Szdv5CgGw4Auzp54i9wx1k3Ica8k
 mSjtBRwjR6g3rkMevem64/EY=
X-Received: by 2002:adf:f24c:0:b0:313:f152:d7f2 with SMTP id
 b12-20020adff24c000000b00313f152d7f2mr3411357wrp.36.1687849895422; 
 Tue, 27 Jun 2023 00:11:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4J0rxCyrrQw+AA+6R0HF8+A45hIRxv5L1efnDXk13eePybHu/MGpnTkhS12Kw8pRPV67ZBeg==
X-Received: by 2002:adf:f24c:0:b0:313:f152:d7f2 with SMTP id
 b12-20020adff24c000000b00313f152d7f2mr3411352wrp.36.1687849895119; 
 Tue, 27 Jun 2023 00:11:35 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 d1-20020a5d6dc1000000b00304adbeeabbsm9439847wrz.99.2023.06.27.00.11.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 00:11:34 -0700 (PDT)
Message-ID: <c939b695-2b68-085a-0f19-108ecdcc1a05@redhat.com>
Date: Tue, 27 Jun 2023 09:11:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] piix: fix regression during unplug in Xen HVM domUs
Content-Language: en-US
To: Olaf Hering <olaf@aepfle.de>, John Snow <jsnow@redhat.com>
Cc: xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
References: <20210317070046.17860-1-olaf@aepfle.de>
 <4441d32f-bd52-9408-cabc-146b59f0e4dc@redhat.com>
 <20210325121219.7b5daf76.olaf@aepfle.de>
 <dae251e1-f808-708e-902c-05cfcbbea9cf@redhat.com>
 <20230509225818.GA16290@aepfle.de> <20230626231901.5b5d11c1.olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230626231901.5b5d11c1.olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/26/23 23:19, Olaf Hering wrote:
> I need advice on how to debug this.
> 
> One thing that stands out is uhci_irq().
> It reads a u16 from the USBSTS register.
> 
> On the qemu side, this read is served from bmdma_read. Since the read
> size is 2, the result is ~0, and uhci_irq() turns the controller off.
> In other words, memory_region_ops_read from addr=0xc102 is served from "piix-bmdma"
> 
> If the pci_set_word calls in piix_ide_reset are skipped, the read is
> served from uhci_port_write. This is the expected behavior.
> In other words, memory_region_ops_read from addr=0xc102 is served from "uhci".

I think what's happening is that

     pci_set_byte(pci_conf + 0x20, 0x01);  /* BMIBA: 20-23h */

is setting the BAR to 0xC100, therefore overlapping the UHCI device's 
region.  In principle this line shouldn't be necessary at all though; 
it's enough to clear the COMMAND register.

Can you check the value of the COMMAND register (pci_conf + 0x04, 16 
bits, little endian)?  Something might be causing the register to be set 
back to a nonzero value, therefore re-enabling the I/O at the address 
that overlaps the UHCI device.

Paolo


