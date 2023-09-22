Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2D37AB6D0
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 19:01:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjjWn-000559-P5; Fri, 22 Sep 2023 13:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qjjWk-00054b-KT
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 13:01:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qjjWj-0001rA-6O
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 13:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695402072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QCfpbp+1uS31+SCr6EklJSKnkSjRkNf6o6yqkeWc2GM=;
 b=SuI8huaxp+8xad/KhG9j8tmhqc9db/8d8fERpDGnVX9RC8oAUB1ABQtT3tgFwFfdYnMC3W
 ohm7F6Lj7s4JHk6rdOsZenvfZrDcgw6jHOLOH65MxokNLSG+zlTuw3AfI10G0VTWK7fWwY
 nI1bYYFq6VTlndV62qBITNZsMFsAXTg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-QLEx_ibjOiazjBKh2EIhZg-1; Fri, 22 Sep 2023 13:01:08 -0400
X-MC-Unique: QLEx_ibjOiazjBKh2EIhZg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-56c306471ccso1748099a12.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 10:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695402067; x=1696006867;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QCfpbp+1uS31+SCr6EklJSKnkSjRkNf6o6yqkeWc2GM=;
 b=Lswp4qL6Pstqryu3v14/MBW5upj/2q0SNIh1hnyBZtF2nrRXLedsCNG9HY2fz26Vq8
 KF0uDPMFJqEXvF0+tHd3I86rrBaNAdot3qmgGcRwDbmQ6OQMHUKCzrf1qUiS6lB3yn5K
 7mJA79gpC6Xg7JdeSeg/2MhOLrSSWtFyDrNiJT4FKdEyLm3RznXAa24T5eXx9aelZ9Qu
 mTYjbSEW/OaY7cb5RWMIgv6fmGPsO7eUVm3SL+zncWPIkeb4fPGE9so5OvlhEe8NaywO
 wB5Id3itYWnh7ih1/xiwSeVdUVYDNTuHFpkcEDAxLXz0EoknWb3OaVasrg0idRYlHJ5a
 BcoA==
X-Gm-Message-State: AOJu0YzvRJbQY8LvN0UQ7W5U4muyFSaG7F1Et2Lr/Q4bvl02qLAb8Xid
 NxkrYoDxd+y0E/E5ZT2s/beLeKSYJeb6tFObylVvmgx3fLfWNn9ikHTrJdiT3hcY5foj82HhAfa
 UitS6aVLgCoDF8cI=
X-Received: by 2002:a05:6a20:9699:b0:147:fd40:2482 with SMTP id
 hp25-20020a056a20969900b00147fd402482mr97307pzc.44.1695402067601; 
 Fri, 22 Sep 2023 10:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUQuI0a8O1Tc7kpmOMeSAQgk80KDdjy6xXl55h4GBrSRMN8G7/wQ0Pdc8B6xdvse1kolwLaQ==
X-Received: by 2002:a05:6a20:9699:b0:147:fd40:2482 with SMTP id
 hp25-20020a056a20969900b00147fd402482mr97260pzc.44.1695402067108; 
 Fri, 22 Sep 2023 10:01:07 -0700 (PDT)
Received: from smtpclient.apple ([116.73.132.49])
 by smtp.gmail.com with ESMTPSA id
 d24-20020aa78158000000b0068fc2fe4612sm3440015pfn.194.2023.09.22.10.00.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Sep 2023 10:01:06 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: Help wanted for enabling -Wshadow=local
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <87r0mqlf9x.fsf@pond.sub.org>
Date: Fri, 22 Sep 2023 22:30:53 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jeffery <andrew@aj.id.au>, Brian Cain <bcain@quicinc.com>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Auger <eric.auger@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fan Ni <fan.ni@samsung.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Laurent Vivier <laurent@vivier.eu>, Laurent Vivier <lvivier@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F2CB41E8-F237-4E49-9599-EEE4EEC516E7@redhat.com>
References: <87r0mqlf9x.fsf@pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 22-Sep-2023, at 3:07 PM, Markus Armbruster <armbru@redhat.com> =
wrote:
>=20
> X86 Machines
> ------------
> PC
> M: Michael S. Tsirkin <mst@redhat.com>
> M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>    hw/i386/acpi-build.c(*3*)
>    hw/i386/acpi-microvm.c(*2*)
>    hw/i386/intel_iommu.c(*3*)
>    hw/i386/pc.c(*2*)
>    hw/i386/x86.c(*2*)

Since I already took care of api-build, I will take care of these next =
unless someone is already looking at it.=


