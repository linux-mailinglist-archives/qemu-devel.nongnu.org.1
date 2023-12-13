Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCD3810EFF
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 11:55:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDMtG-0008Vc-Ux; Wed, 13 Dec 2023 05:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rDMtD-0008Uw-FH
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 05:54:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rDMtC-0006ci-3b
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 05:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702464893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/vChOf/4vAb4ISLXKpehSaGuprmXbR/p5pxIiBf+uAE=;
 b=W5klJ0T91XpgAPbaSIukfqc6cdet260BRJr8zSXNRo++vG+l7Llv7bmLVm1XLpvTxPnkwi
 iC4RVHftoR792BD47QqDCCcU3cX9Jjkg9XrCJjBClSWYdW/M5f4IUCC0uJuwuR9nwQ9NFZ
 ymkXHIp6Nw7pNGEzplAEe92L+BIo71Y=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-AZPlS46SPNS-UWmmdBu92Q-1; Wed, 13 Dec 2023 05:54:45 -0500
X-MC-Unique: AZPlS46SPNS-UWmmdBu92Q-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-286e0d3e04dso7507809a91.1
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 02:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702464884; x=1703069684;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/vChOf/4vAb4ISLXKpehSaGuprmXbR/p5pxIiBf+uAE=;
 b=hTyRRcLhxBvH6jH3Bp37Ej+XrQ0iXfHjaOdyMpqB9kMaycBu74h0F0yIIE5jPnHUk3
 Cokl825c6mJXI124piXlhyj62JFL8hLmlAyswu4jIq3aoE3Hvcriksf0DjnVv1/6QL/x
 mDgHF46afZwzj7eeHu0TnPaeY/bBksQOhn4irPK+6mO9gf1evdEbjAvq+yLDKyXoQtF7
 PhNByIpepkKj7l2FIm/SRoMAbZr7u6LcNPJfpgs/B68pSj6EZZcAaOFuaKDQS+/c2DOK
 5GUZXdnadd2KuWtTYRimTcAO02MJhVzBK3N//8MEn15Uw7X42Jb+REqyAu2NmZ9tjqLe
 lGbQ==
X-Gm-Message-State: AOJu0YzcYWpusIUAj3zp3r7VWKUxw3noxbezesMcBXwpS0ob5cnO07i2
 aMGPP1xiVDT8hO6TlZz+I3wJVKf/DSl80YD60Xdb8AP8WGVdkAKbkX2aNSj6PVeUyiyabbroDXz
 r3o9sEeQgXsTqz7o=
X-Received: by 2002:a17:903:28d:b0:1d0:c229:a00d with SMTP id
 j13-20020a170903028d00b001d0c229a00dmr8464787plr.34.1702464884713; 
 Wed, 13 Dec 2023 02:54:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwTnUEZMADK0/+hSk3X+0UgfS28PS2GUzlq5Zc0xLDxTpLRKaloIAfXNHNbSjZJeEePji8GA==
X-Received: by 2002:a17:903:28d:b0:1d0:c229:a00d with SMTP id
 j13-20020a170903028d00b001d0c229a00dmr8464777plr.34.1702464884410; 
 Wed, 13 Dec 2023 02:54:44 -0800 (PST)
Received: from smtpclient.apple ([203.163.232.58])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a170902ee0400b001cfc44aac0fsm10280404plb.111.2023.12.13.02.54.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Dec 2023 02:54:44 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PULL 6/6] tests/acpi: disallow tests/data/acpi/virt/SSDT.memhp
 changes
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231213105026.1944656-7-kraxel@redhat.com>
Date: Wed, 13 Dec 2023 16:24:24 +0530
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD96681F-FBF0-4AB9-8F2B-5B6C1FB5A52F@redhat.com>
References: <20231213105026.1944656-1-kraxel@redhat.com>
 <20231213105026.1944656-7-kraxel@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



> On 13-Dec-2023, at 4:20=E2=80=AFPM, Gerd Hoffmann <kraxel@redhat.com> =
wrote:
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Please combine this patch with patch 5. No need to do this separately.

> ---
> tests/qtest/bios-tables-test-allowed-diff.h | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h =
b/tests/qtest/bios-tables-test-allowed-diff.h
> index e569098abddc..dfb8523c8bf4 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
> /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/virt/SSDT.memhp",
> --=20
> 2.43.0
>=20


