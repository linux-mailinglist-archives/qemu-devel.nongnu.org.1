Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EA17108DD
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 11:28:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q27Go-0003a7-Tq; Thu, 25 May 2023 05:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q27Gl-0003Zk-Ve
 for qemu-devel@nongnu.org; Thu, 25 May 2023 05:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q27Gj-0003rx-4w
 for qemu-devel@nongnu.org; Thu, 25 May 2023 05:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685006902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NAfzwguoRb1+MABvPFCZxrSsrgrt6NGhsddRUOu3akY=;
 b=WyBvguFBgb6au/Pgxfet74z0Ilnc1iDu/FedMUovggSf/oCN6GUyHqAcwjP2NXN0SHOd3P
 pYTe5WTCDdxvCocyseSmSWZWKs4j0JwCMp4Y5HEjMSL35ahMVpusMK5HyR80nFa/9wKxCm
 6g/yCuU1aRn6D7+xdJ/g48gM72039nI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-rKDPm0cjM-enu6Nht-euiA-1; Thu, 25 May 2023 05:28:19 -0400
X-MC-Unique: rKDPm0cjM-enu6Nht-euiA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-521262a6680so1431256a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 02:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685006898; x=1687598898;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NAfzwguoRb1+MABvPFCZxrSsrgrt6NGhsddRUOu3akY=;
 b=T10SPot7xlDznIuN1zFS46VaVm7DRXWb6PQaQ55+dYPFY/TOIBeRfrNt58UdlVeoO3
 IGy7PCuNefpPPFSXE7JhO8wLkaz1QTI4bSQXJPX7HgzR8FoLmQpVZ7lJQ+QE/DzfD2j6
 wmr+0zjVHaGaLcT7xLR77yM6CGaYy6hZGfUP0xjcI1lxbuDCVQ9K8Uft0fvLm+yZbEGS
 2LtBneQ8AuX07eOt6V7XY32nbmhmJBpADS5lmV3ek6WV5jTjHauamTUDud7aiztO3Exa
 0e/rR609A3/ywSk2tOnDeF8PemeLV/YZ8rEhkf3AHe0FcF6HkmXhGf9mp8GrxIVqKxdP
 vcCQ==
X-Gm-Message-State: AC+VfDx2vye4UWbCluT5Axj/+OQ29NmcAj8PFlaL/wxZKNaUy6LI1+ab
 K89/j5faKYpS0ra8oT4J1Xf6hgPvh2aBW38UqdCir+0S5u5f7ZMzExzc2BDVRDRLzKDzLz46hnn
 SiuCW5AZHFJBDgCI=
X-Received: by 2002:a05:6a20:8e22:b0:10e:ed51:a552 with SMTP id
 y34-20020a056a208e2200b0010eed51a552mr2753676pzj.59.1685006898260; 
 Thu, 25 May 2023 02:28:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5f4mWPaZa2zg24Li1ukAzKDaR5nhcKySqx8iZaUPfHpBtUV1PGax4uVDkhZsQRKqUuK71Jyg==
X-Received: by 2002:a05:6a20:8e22:b0:10e:ed51:a552 with SMTP id
 y34-20020a056a208e2200b0010eed51a552mr2753661pzj.59.1685006897922; 
 Thu, 25 May 2023 02:28:17 -0700 (PDT)
Received: from smtpclient.apple ([115.96.198.176])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a62e10f000000b0063b85893633sm790780pfh.197.2023.05.25.02.28.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 May 2023 02:28:17 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH 4/4] tests/qtest/usb-hcd-ehci-test: Check for EHCI and
 UHCI HCDs before using them
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230525081016.1870364-5-thuth@redhat.com>
Date: Thu, 25 May 2023 14:58:12 +0530
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <87F21F23-2417-4512-84D3-8FA87A0B5EA7@redhat.com>
References: <20230525081016.1870364-1-thuth@redhat.com>
 <20230525081016.1870364-5-thuth@redhat.com>
To: Thomas Huth <thuth@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



> On 25-May-2023, at 1:40 PM, Thomas Huth <thuth@redhat.com> wrote:
>=20
> The devices might not be available in the binary (e.g. when compiling
> with "--without-default-devices"), so we have to check before we can
> use them.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> tests/qtest/usb-hcd-ehci-test.c | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/tests/qtest/usb-hcd-ehci-test.c =
b/tests/qtest/usb-hcd-ehci-test.c
> index c51e8bb223..87e37cdd7c 100644
> --- a/tests/qtest/usb-hcd-ehci-test.c
> +++ b/tests/qtest/usb-hcd-ehci-test.c
> @@ -149,6 +149,11 @@ int main(int argc, char **argv)
>=20
>     g_test_init(&argc, &argv, NULL);
>=20
> +    if (!qtest_has_device("ich9-usb-ehci1") ||
> +        !qtest_has_device("ich9-usb-uhci1")) {
> +        return 0;
> +    }
> +
>     qtest_add_func("/ehci/pci/uhci-port-1", pci_uhci_port_1);
>     qtest_add_func("/ehci/pci/ehci-port-1", pci_ehci_port_1);
>     qtest_add_func("/ehci/pci/ehci-config", pci_ehci_config);
> --=20
> 2.31.1
>=20


