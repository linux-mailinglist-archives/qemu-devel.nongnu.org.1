Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AFF7AAF96
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 12:34:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjdTt-0008Ug-E2; Fri, 22 Sep 2023 06:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qjdTn-0008Tj-Ao
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qjdTl-0000O9-OX
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695378823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lypLV0l6T/hJ7jgKYjwsA4d7BCBM0vPq25Nqf9rFnlY=;
 b=T/dlqLdIXUvLt7a+03HA3vmJmei/5FjrHzckU9usUvu4c6BSsBumUb43iL3Sa/3nxVArHp
 DxsixOj1MiliS0XZ5wx7eKZLiCIEG5eGVnqG90Qk8WnohcDjNQxen457YcqJxu+jTa2JT0
 yNleDERlcLj9j5tEO2wqKRlA9L6F1w8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-HuUenWjoMACmw1mlJpYGXA-1; Fri, 22 Sep 2023 06:33:42 -0400
X-MC-Unique: HuUenWjoMACmw1mlJpYGXA-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1c5763601c8so17156325ad.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 03:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695378821; x=1695983621;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lypLV0l6T/hJ7jgKYjwsA4d7BCBM0vPq25Nqf9rFnlY=;
 b=w7+TF+q/QE+ZI/EKKB3fTB7WCFZijspqozdvbcuKDhwqrV116ZFxDJR3WQSJdcGq47
 BLEZ3SSTylsEIYuve2NW4URXGd3Xhnw91oQxEYX0k1KEFzSdz52+kJPzr12iPJ7T32sC
 tF3mTPPht9fJm073PW5vdGvAy0D89QdNDACZe9Zct5+fWsW8HiVgNX4aN4MzNIwS3drk
 0zq5PZcnpFZjMK6okq4luSz8iMm6CanGJmyunKzwOoauBRdiNoDoloKsPYT3BpzKDOIO
 97w3IQHM8J0NYPavz5UrEip7WkOTcDWIcYEQhbTGR1AumA7pSK5mY4z6a5J6AtgrfSS3
 /kvA==
X-Gm-Message-State: AOJu0YzfoAsGv3wIi2nQ3lQCZXuy6W3ptPmPqMg1eD0ZzmtX+0f7zD0k
 CH6dfoCopLvR44qyydCnbHwq4j+1KUwkGUnuZn7AlHIlKQUhiflXpORoU4xJVZgFwg6EZgJyKp4
 RX97QZLAU+b7Q3jM=
X-Received: by 2002:a17:902:e886:b0:1c2:1068:1f4f with SMTP id
 w6-20020a170902e88600b001c210681f4fmr7250627plg.17.1695378821459; 
 Fri, 22 Sep 2023 03:33:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrfrvEQbKHfbo58kPk9nrwiuoaXAWJjszXXu2vdrg+zjP7V3GABBoCJCSWFMAjq6gUgbttNg==
X-Received: by 2002:a17:902:e886:b0:1c2:1068:1f4f with SMTP id
 w6-20020a170902e88600b001c210681f4fmr7250594plg.17.1695378821099; 
 Fri, 22 Sep 2023 03:33:41 -0700 (PDT)
Received: from smtpclient.apple ([116.73.132.49])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a170902b28700b001b9ecee459csm3098731plr.34.2023.09.22.03.33.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Sep 2023 03:33:40 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: Help wanted for enabling -Wshadow=local
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <87r0mqlf9x.fsf@pond.sub.org>
Date: Fri, 22 Sep 2023 16:03:27 +0530
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
Content-Transfer-Encoding: 7bit
Message-Id: <5255ABB8-8D1D-4AF4-9015-84573056973C@redhat.com>
References: <87r0mqlf9x.fsf@pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 22-Sep-2023, at 3:07 PM, Markus Armbruster <armbru@redhat.com> wrote:
> 
> Devices
> -------
> ACPI/SMBIOS
> M: Michael S. Tsirkin <mst@redhat.com>
> M: Igor Mammedov <imammedo@redhat.com>
> R: Ani Sinha <anisinha@redhat.com>
>    hw/acpi/cpu_hotplug.c
>    hw/i386/acpi-build.c(*3*)
>    hw/smbios/smbios.c

I will look into this after enabling

diff --git a/meson.build b/meson.build
index 98e68ef0b1..9fc4c7ac9d 100644
--- a/meson.build
+++ b/meson.build
@@ -466,6 +466,9 @@ warn_flags = [
   '-Wno-tautological-type-limit-compare',
   '-Wno-psabi',
   '-Wno-gnu-variable-sized-type-not-at-end',
+  '-Wshadow=local',
+  '-Wno-error=shadow=local',
+  '-Wno-error=shadow=compatible-local',
 ]


