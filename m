Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E38EF707A07
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 08:02:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzWiA-00048b-6o; Thu, 18 May 2023 02:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzWi5-00048C-LX
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:01:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzWi4-0003W4-BC
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684389715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MqCdbIJJ1gkZMUCuX2tv9cIg6h6urFBhHOQMKfNeDuc=;
 b=JW6FEEaWRMjuKYVdv+gposIPFlB8+Hwjp7Xz1iV69VAmAK5NBZZo9TEMnSMCkjxAYzLG/g
 gw0cKaai1EGFsIDsTgtE+cpEybyrEyYQLhQwL9wMyCoLVdMreO6H1MqogqOKmZ9opObP48
 ZAGjILNA9e5tvV1e7901rv8pz/gErRo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-bXV8Aj5BP4aim1L7zWW9yQ-1; Thu, 18 May 2023 02:01:53 -0400
X-MC-Unique: bXV8Aj5BP4aim1L7zWW9yQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-25353056618so596676a91.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 23:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684389712; x=1686981712;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MqCdbIJJ1gkZMUCuX2tv9cIg6h6urFBhHOQMKfNeDuc=;
 b=d7eagr7ovTlAdfZTh8pvi22D2HkC/vQV+VGrO+3CiN7pw9eepSLvUpcPEwF4fKawrm
 cfEtb+vjJtpeTq5f3/y2llzSOc9Im/V3Xq9zdlYvgebHrqPBNT0xPRP8lwkeB9EBYoJy
 vdyus+Y1uosUIBtp0mHrgj+TUp23N5fOKSruTvSuCoakzaimzRfemLz9y9JeQAXnrs2d
 dHkPw3/oWhafk3NfogL5vt8cNXfhOkPWoEaK0n6LI5ugvHGMOHTQwop1AiJVlanybkOG
 owWtoKV3wkG95pV9hozq8nXXP/JgWfXv7z9yu3Hxfb60uxw2NPmdGoS7BIxyvYZGUekC
 WTaw==
X-Gm-Message-State: AC+VfDxTBy5nwDuBcd5lBTR7TvygWYVBCkGbNGD65T6iMH4y6gBNZwel
 ZLkFQftnbCqwXWztBF8M3sPnFSme7iB3F1T28IoJl5ZQQPDW4D9zPt1nj2DO1fhGEy5WM/xcBNI
 37CbFd0m4xIsgT6M=
X-Received: by 2002:a17:902:e80a:b0:19d:297:f30b with SMTP id
 u10-20020a170902e80a00b0019d0297f30bmr1625014plg.19.1684389712421; 
 Wed, 17 May 2023 23:01:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5SCJAF1oDWgkrjEAMeuJ7p3cbL/df4Dc5BlZgUrhsORnMV1UDl0jI27WzW1eOXrBTGFSZuLg==
X-Received: by 2002:a17:902:e80a:b0:19d:297:f30b with SMTP id
 u10-20020a170902e80a00b0019d0297f30bmr1624995plg.19.1684389712144; 
 Wed, 17 May 2023 23:01:52 -0700 (PDT)
Received: from smtpclient.apple ([115.96.106.170])
 by smtp.gmail.com with ESMTPSA id
 4-20020a170902c24400b001a64011899asm454785plg.25.2023.05.17.23.01.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 May 2023 23:01:51 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment variable
 for iasl location
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <87ilcqnckm.fsf@linaro.org>
Date: Thu, 18 May 2023 11:31:47 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C2CC04A8-F0F1-4360-ABF0-1F8DF7768AB1@redhat.com>
References: <20230517120751.14679-1-anisinha@redhat.com>
 <20230517101523-mutt-send-email-mst@kernel.org>
 <B6AD0FB1-CF05-4B4C-B58D-279422895E4D@redhat.com>
 <20230517103522-mutt-send-email-mst@kernel.org>
 <ED522229-5A71-40C2-AF2C-5D921B0B5D54@redhat.com> <87zg63m18g.fsf@linaro.org>
 <20230517112347-mutt-send-email-mst@kernel.org> <87r0rflzd4.fsf@linaro.org>
 <20230517120710-mutt-send-email-mst@kernel.org> <87ilcqnckm.fsf@linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



> On 17-May-2023, at 9:50 PM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
> ./tests/bios-tables-test --iasl-path ${CONFIG_IASL}
>=20
> and then you have the best of both worlds. You can run manually with a
> different path and you don't need to pollute config-host.h

It could also be an environment variable set by meson. Then =
bios-tables-test can do a genenv() just like it does for verbosity etc. =
The environment can also be used by other tools that might need iasl in =
the future. We do not need to introduce new command line option.=


