Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D523E8115AA
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 16:05:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDQmW-0000gF-M0; Wed, 13 Dec 2023 10:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rDQmQ-0000fY-JF
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:04:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rDQmO-0007uX-TA
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702479847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ql/h0ik4f5uW1mgj6YsdikjU3OZOIrMOYEuhxdRAz4M=;
 b=GuRzhwD8KWHDCsEYcIOQPrPa59erLYU3/6lu3M2ZCZ74kQlYSfR40Ohkfx6Y/iOBV9q89k
 BrveO21nkMRNVx9WW49Sncr0s+7sO9HOb/DRxXSSNbQutzYq99TuYGj6UjTNksfh5NL/tu
 yWp5s1jgIJY1VfyVWFO5n59O7UCfATE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-h2pDzb6gMmevgpeXC_t90Q-1; Wed, 13 Dec 2023 10:04:06 -0500
X-MC-Unique: h2pDzb6gMmevgpeXC_t90Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a19725a3a84so414334966b.0
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 07:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702479844; x=1703084644;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ql/h0ik4f5uW1mgj6YsdikjU3OZOIrMOYEuhxdRAz4M=;
 b=bwtOHC/mGOCLpd+LuytjSxfoIfrrXTmc1GIKK+RH75tyL1RmBzktmoo+yfatMjMNNE
 Rxe1sjaIBGl6rxlEyq8uJtivCQgej91UJEaH3QW462THyEDgHoLL7EhJnpIfOx0OVV7p
 IEi2UTK5UrARUNY3IPEn4+0YnPYU8egDboNwuQpR01mHPXg99Acabq2NcNaB0lCK7MF7
 KZ5L3jH3XH3ItpY2rIm98Pv0ZkZUPyaWsyaXyn2UARsthf5ut9++36dIlfe1kvI3R2b7
 B9zrCh25YodjnuQTVUVImZB1BiHjkKELV6CnwWou9MmsWQJS2tLHUQvo8Q5HDDCSFnsP
 vcEw==
X-Gm-Message-State: AOJu0YxbbTsLam18HeVig7vozur95O7bpMJotE46oAsBiQWTwMg6YABx
 QaOmWAjQM8toQTriqeLEcRFIDiV444pgdW8iXzl5RHMPkw/jy17SkAOmHtTWA2Ap+w8OatpUltf
 2EnrqxrDP7JSd/OA=
X-Received: by 2002:a17:906:1042:b0:9fe:1681:22c7 with SMTP id
 j2-20020a170906104200b009fe168122c7mr2437997ejj.26.1702479843861; 
 Wed, 13 Dec 2023 07:04:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRtUDB9ZFPFUZmeN60cmJCt1LadiZ/5W8gNAeLtb9kqM3m3DUJr1XzgVfpyZWpXi/TWdxBIw==
X-Received: by 2002:a17:906:1042:b0:9fe:1681:22c7 with SMTP id
 j2-20020a170906104200b009fe168122c7mr2437984ejj.26.1702479843474; 
 Wed, 13 Dec 2023 07:04:03 -0800 (PST)
Received: from redhat.com ([2a02:14f:16d:d414:dc39:9ae8:919b:572d])
 by smtp.gmail.com with ESMTPSA id
 hu18-20020a170907a09200b00a1e081369a9sm7849591ejc.23.2023.12.13.07.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 07:04:02 -0800 (PST)
Date: Wed, 13 Dec 2023 10:03:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 6/6] tests/acpi: disallow tests/data/acpi/virt/SSDT.memhp
 changes
Message-ID: <20231213100321-mutt-send-email-mst@kernel.org>
References: <20231213105026.1944656-1-kraxel@redhat.com>
 <20231213105026.1944656-7-kraxel@redhat.com>
 <AD96681F-FBF0-4AB9-8F2B-5B6C1FB5A52F@redhat.com>
 <20231213093242-mutt-send-email-mst@kernel.org>
 <98BBB08F-31A9-48B8-9DAF-CF32E1F8B742@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98BBB08F-31A9-48B8-9DAF-CF32E1F8B742@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Dec 13, 2023 at 08:09:29PM +0530, Ani Sinha wrote:
> 
> 
> > On 13-Dec-2023, at 8:03 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Wed, Dec 13, 2023 at 04:24:24PM +0530, Ani Sinha wrote:
> >> 
> >> 
> >>> On 13-Dec-2023, at 4:20 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >>> 
> >>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >> 
> >> Please combine this patch with patch 5. No need to do this separately.
> > 
> > 
> > Yes but since it's done - it's fine either way I think. No?
> 
> Yes I did not realise it was a PR and not a review. I thought it was sent for review. If it’s done it’s ok.
> That being said, I would have preferred that the commit had a description and not completely empty.


I agree, Gerd, going forward please include the diff of the
disassemled AML.


> > 
> >>> ---
> >>> tests/qtest/bios-tables-test-allowed-diff.h | 1 -
> >>> 1 file changed, 1 deletion(-)
> >>> 
> >>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> >>> index e569098abddc..dfb8523c8bf4 100644
> >>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> >>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> >>> @@ -1,2 +1 @@
> >>> /* List of comma-separated changed AML files to ignore */
> >>> -"tests/data/acpi/virt/SSDT.memhp",
> >>> -- 
> >>> 2.43.0
> >>> 
> > 


