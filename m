Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC60F7108E0
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 11:29:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q27HM-0004FI-Kx; Thu, 25 May 2023 05:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q27HJ-0004Ee-0f
 for qemu-devel@nongnu.org; Thu, 25 May 2023 05:29:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q27HH-0004A2-J0
 for qemu-devel@nongnu.org; Thu, 25 May 2023 05:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685006938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cGnfvaZA64tzcaIpt2fKDwq+ji//jhqJcATMfsfDUWg=;
 b=ajkBShoyJCJEJTg89FIQcOi6XXCrobw3ZhAZVw+PYEz21k9hpyNoo4c3LJKN8rVMYxFO7x
 9NpC5724ctYKhOFimqUqchFtMuPoYiyHB6okffpdlIhOALfepXaFNAK95HEBmtmZQWC7GZ
 lqVER+NCg03Hq6i2zm/71HsD7+UC28E=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-nFwOzAirNVyKpSl_-XkxnQ-1; Thu, 25 May 2023 05:28:56 -0400
X-MC-Unique: nFwOzAirNVyKpSl_-XkxnQ-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-64d42024c99so1279836b3a.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 02:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685006936; x=1687598936;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cGnfvaZA64tzcaIpt2fKDwq+ji//jhqJcATMfsfDUWg=;
 b=GbRG+uK0CoTt5r3DRD2SBfQCaZVoQAeZTEGduBajEExwOEyMZGSJNKZv0Sy2EmWC9c
 dmssvILacxMHLFiMsb1gJUzJRVRbtDw3M6mdCim0OijEdtUWat2ldZ4jiQqAOw3OJxAz
 kvHmhdGImh5wRwAaflZKLgRd0IDFkSMyet0Rd41YwjdQDhjm7XS6n4hmju4ZuvQK0Swv
 gyiSF42KBO1e6pCJR9m8BPrT6T4bD0Ay/8ER9uiJsecmOw3wkWsmxOPPW2r75kdTBZZK
 uveLJB0ADW4ykUzlAz8dFcsESOe5hKW62jrOJExCifqSdL0ohsTg8RsDwKOFxVLJ2zys
 4tRQ==
X-Gm-Message-State: AC+VfDx5lfbeOQfCwLdzrcTmnFhvgFt1EFVdQHMMhocCwCkiSwozEhVM
 12nUwYvIUoIn05xkYGaPtT/cyrjmHvVIUAwRdGLb0h9YFQGq3D6DlmPUR8LIJrwIxsqNKRvEUJn
 37N0gKGcRMKM4rVY=
X-Received: by 2002:a05:6a00:c92:b0:64f:4586:83fc with SMTP id
 a18-20020a056a000c9200b0064f458683fcmr8188385pfv.31.1685006935728; 
 Thu, 25 May 2023 02:28:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4bAKTssP1K+2NorXRmde2tVlFfa+03EuzDms8jUV2vNq+syrHULJlPs7B4XB3T+1mk1UYF9A==
X-Received: by 2002:a05:6a00:c92:b0:64f:4586:83fc with SMTP id
 a18-20020a056a000c9200b0064f458683fcmr8188368pfv.31.1685006935458; 
 Thu, 25 May 2023 02:28:55 -0700 (PDT)
Received: from smtpclient.apple ([115.96.198.176])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a62e10f000000b0063b85893633sm790780pfh.197.2023.05.25.02.28.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 May 2023 02:28:55 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH 1/4] tests/qtest/usb-hcd-uhci-test: Check whether
 "usb-storage" is available
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230525081016.1870364-2-thuth@redhat.com>
Date: Thu, 25 May 2023 14:58:52 +0530
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <402DBF3E-2B6F-413B-83A2-AE260469BF8A@redhat.com>
References: <20230525081016.1870364-1-thuth@redhat.com>
 <20230525081016.1870364-2-thuth@redhat.com>
To: Thomas Huth <thuth@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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
> The "usb-storage" device might not have been compiled into the binary
> (e.g. when compiling with "--without-default-devices"), so we have to
> check first before using it.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> tests/qtest/usb-hcd-uhci-test.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/qtest/usb-hcd-uhci-test.c =
b/tests/qtest/usb-hcd-uhci-test.c
> index 84ac2f3c1a..28751f53da 100644
> --- a/tests/qtest/usb-hcd-uhci-test.c
> +++ b/tests/qtest/usb-hcd-uhci-test.c
> @@ -74,7 +74,9 @@ int main(int argc, char **argv)
>     qtest_add_func("/uhci/pci/init", test_uhci_init);
>     qtest_add_func("/uhci/pci/port1", test_port_1);
>     qtest_add_func("/uhci/pci/hotplug", test_uhci_hotplug);
> -    qtest_add_func("/uhci/pci/hotplug/usb-storage", =
test_usb_storage_hotplug);
> +    if (qtest_has_device("usb-storage")) {
> +        qtest_add_func("/uhci/pci/hotplug/usb-storage", =
test_usb_storage_hotplug);
> +    }
>=20
>     if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D =
0) {
>         qs =3D qtest_pc_boot("%s", cmd);
> --=20
> 2.31.1
>=20


