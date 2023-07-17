Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5307565D5
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 16:07:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLOsn-0004NF-BQ; Mon, 17 Jul 2023 10:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qLOsS-0004Gn-Az
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:07:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qLOsQ-000772-Nj
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689602819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OQmZYLlSbKr48zuQpecmTcFGAvgvUC3EvImMUBOtai4=;
 b=ekcn7OBIq+7txnhnlVBS3koH7nPU6OQ0PrAPA6glDw3535oqA6rMOQRRv9IGi/EXACxDHF
 Jweh/ExprUhy0NycUNPf9Q07QU7kGswmnBUtBmYdht5gcvQ8MwZTgB+7JsK6md1PT7fqZ6
 NNrug29jjka4eIgZThwyFx0x+cEbkDg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-grRaHu9_N-i5_rK2slQ8LQ-1; Mon, 17 Jul 2023 10:06:52 -0400
X-MC-Unique: grRaHu9_N-i5_rK2slQ8LQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-994320959f4so256128766b.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 07:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689602807; x=1692194807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQmZYLlSbKr48zuQpecmTcFGAvgvUC3EvImMUBOtai4=;
 b=bBBCYsm5aScR9fMp5IfoUak+cCQiCpvwuQ7M00UUiCm2i8gVQU49RDpBfdSIEGm6cI
 oFp4WSNrOBKUf7J1Z2feeedM2kD1rob7i4xScvQsDdYOebeRS/Nt7vGaAeq+W4bb3lpM
 UvrweeVQuJ0+GAg54SYMtxkL4faAIknT40Ub1z8DwVWjQm69as98wAywvZwEvYXaH50r
 zn/GIS5gxhbGqWPg5y1tE+1d4yT/k1ISIg4KmGyvJv3pMSZMOb6Ds7hN9Z54uTLsvpmQ
 9IfD4eNjoiSY/9/4uVw35Sjp7JXHVvCeRxDm3ZZf78jO2zcJWBr4+/4Kf64QoLoknBoP
 hn8g==
X-Gm-Message-State: ABy/qLY30DqHnohGSuWvm35Bup8VQb/hrc740hOHzbptRZ/OLoXei3W5
 6uT5GaAidTqV0Drjm2TWDVMeO+BbQtEHzmpx2fDVGij8ahocRy3YN7O7q7hfesKxMtFyDAxSQUv
 +HkVG5QjhW6timP8=
X-Received: by 2002:a17:906:2d3:b0:997:865a:77e3 with SMTP id
 19-20020a17090602d300b00997865a77e3mr5765970ejk.11.1689602806902; 
 Mon, 17 Jul 2023 07:06:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHEXzQOOUiTnq9sTfwz+V318/U37KUNM9Dx7RF+63HOmCmhE6sj5ewkKc1b5IG1yi+xzmyvcQ==
X-Received: by 2002:a17:906:2d3:b0:997:865a:77e3 with SMTP id
 19-20020a17090602d300b00997865a77e3mr5765957ejk.11.1689602806632; 
 Mon, 17 Jul 2023 07:06:46 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 q3-20020a1709066b0300b0099290e2c163sm9141392ejr.204.2023.07.17.07.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 07:06:46 -0700 (PDT)
Date: Mon, 17 Jul 2023 16:06:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Joelle van Dyne <j@getutm.app>
Cc: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org, Shannon
 Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani
 Sinha <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, "open list:ARM ACPI Subsystem"
 <qemu-arm@nongnu.org>
Subject: Re: [PATCH v2 09/11] tpm_tis_sysbus: move DSDT AML generation to
 device
Message-ID: <20230717160645.3416d6f0@imammedo.users.ipa.redhat.com>
In-Reply-To: <CA+E+eSDinJuo8xyZTzfqKXr=rf+fyjkvOLVEqam0eapehQ1OYA@mail.gmail.com>
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-10-j@getutm.app>
 <d3d3d9d0-fb88-9500-34d9-9780f9c2644f@linux.ibm.com>
 <CA+E+eSDinJuo8xyZTzfqKXr=rf+fyjkvOLVEqam0eapehQ1OYA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Fri, 14 Jul 2023 10:29:31 -0700
Joelle van Dyne <j@getutm.app> wrote:

> On Fri, Jul 14, 2023 at 9:19=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.=
com> wrote:
> >
> >
> >
> >
> > I don't know whether we would want multiple devices. tpm_find() usage i=
s certainly not prepared for multiple devices. =20
> Sorry, "multiple TPM interfaces" here does not mean "at the same
> time". Will clarify the description.
>=20
> >
> >
> > Good for the consolidation.
> >
> >
> > Does moving the TIS to a different address help on aarch64? =20
> That was the first thing we tried and no it doesn't help.
> >
> > Can the size really be an option? I don't see it useful and if one gave=
 the wrong size it may break things. =20
> It was added for consistency (otherwise we have to determine the size
> by looking at the interface everywhere). Also, it is possible for the
> size to be larger than the constant. For example, Apple Silicon uses
> 16KiB page sizes and we may decide to force the device to be 16KiB
> aligned (not sure if this is needed yet while we still track down why
> the dual mapping was not working). In that case, we would need to
> inform the OS of the true region size to prevent any overlap issues.
> Both baseaddr and size should be provided only by the plug handler in
> the virt machine, otherwise things may break even if we get rid of
> size and have just an incorrect baseaddr.
>=20
if properties  (address/size) are for internal use, it would be better to u=
se
x- prefix as not give user false promise that user can expect them working =
if
they provided them.

> >
> > =20
>=20


