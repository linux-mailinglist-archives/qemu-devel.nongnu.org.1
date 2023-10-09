Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C567BDBB6
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 14:26:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qppKU-0006lM-Rc; Mon, 09 Oct 2023 08:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qppKJ-0006iR-SS
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qppKI-0003EF-8u
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696854333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=24nKu5aYkWSmidfwWtrEiyrAy8+zZPMNcnnGoDXW/KM=;
 b=E8A6bQRfrPYWZreAd9dgxvMfumFsDbUuNBlALgILlOBULYutCI8sl/mu9iUKpko+4N1fC2
 r8yiwe6aiSLvYTf7O5KHLqvBtj8EEzMO67N1sRNICMjSm+9drF7VRWk0sScD4Rr4nV9dvm
 VC9D8W3Fosn6t+JtP+jTHhDx9xfvWCM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-TvBUWvkiOh-BKpbHWileLw-1; Mon, 09 Oct 2023 08:25:30 -0400
X-MC-Unique: TvBUWvkiOh-BKpbHWileLw-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-690bbc5fabaso4577893b3a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 05:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696854329; x=1697459129;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24nKu5aYkWSmidfwWtrEiyrAy8+zZPMNcnnGoDXW/KM=;
 b=qVTXAccJUpDUjfjUHK3h+mbHAWHBnZOWzQxkrhl4En+LMcmeIs4wSXcAAiAWiVCbf5
 FKNLyRQgH6uQzL/1Lzvv5W9Ryxc8n7uBs+xtLbCpZNPbEsDN8fdr/hLK8ZhuDvmqGvUC
 tWdpsVhrJCypD5PWavYPSfJPm9WeojPAlQ3B/8nH3YR3jdVXLYBj/cxiixjKE4ARlK2n
 l1p/UanheFwPzEhAibtqM1U28ZFq9S49mmFi+vbLIf0PzMt3QqTjqFOFIT7T/1eKQOZ0
 BDyJcd7/42yoVfUip2BL5p+sp+zG4SxILJgaPAlRwjx0+0oDBh2BvfGDk7r9pdCJUAnl
 yoqw==
X-Gm-Message-State: AOJu0YydIUfwduiPCvJhTvMsW48tVOKqwvZn5nCtN25YKh8NODfkpRTZ
 5Tam3XYcMqDG6LuDlDglyCaMP3C6KPLFmjmudI9LynWSqHgD+QFm2MwzmDuZWjvCCh/5pJSJlNf
 cTIm14WmBuSSu89w=
X-Received: by 2002:a05:6a00:158c:b0:690:b7a1:ac51 with SMTP id
 u12-20020a056a00158c00b00690b7a1ac51mr19484104pfk.31.1696854328697; 
 Mon, 09 Oct 2023 05:25:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhKnyiJCzgnZEVrNkLYEfp4ER5QFiaXuXsq0z/OYMtxxf+W1Ztmf5kAydNxufwwpgYGOpB5g==
X-Received: by 2002:a05:6a00:158c:b0:690:b7a1:ac51 with SMTP id
 u12-20020a056a00158c00b00690b7a1ac51mr19484076pfk.31.1696854328338; 
 Mon, 09 Oct 2023 05:25:28 -0700 (PDT)
Received: from smtpclient.apple ([115.96.136.216])
 by smtp.gmail.com with ESMTPSA id
 j3-20020aa79283000000b006906aaf1e4dsm6284883pfa.150.2023.10.09.05.25.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Oct 2023 05:25:27 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH 2/6] hw/loader: Clean up global variable shadowing in
 rom_add_file()
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231009094747.54240-3-philmd@linaro.org>
Date: Mon, 9 Oct 2023 17:55:20 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <eduardo@habkost.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 David Hildenbrand <david@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E8F81C49-E0A5-4BD6-8C3B-7139ADD908AB@redhat.com>
References: <20231009094747.54240-1-philmd@linaro.org>
 <20231009094747.54240-3-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
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



> On 09-Oct-2023, at 3:17 PM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Fix:
>=20
>  hw/core/loader.c:1073:27: error: declaration shadows a variable in =
the global scope [-Werror,-Wshadow]
>                       bool option_rom, MemoryRegion *mr,
>                            ^
>  include/sysemu/sysemu.h:57:22: note: previous declaration is here
>  extern QEMUOptionRom option_rom[MAX_OPTION_ROMS];
>                       ^
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> include/hw/loader.h | 2 +-
> hw/core/loader.c    | 4 ++--
> 2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index c4c14170ea..8685e27334 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -272,7 +272,7 @@ void pstrcpy_targphys(const char *name,
>=20
> ssize_t rom_add_file(const char *file, const char *fw_dir,
>                      hwaddr addr, int32_t bootindex,
> -                     bool option_rom, MemoryRegion *mr, AddressSpace =
*as);
> +                     bool has_option_rom, MemoryRegion *mr, =
AddressSpace *as);

Should this be =E2=80=9Cno_option_rom=E2=80=9D instead looking at this =
conditional

if ((!option_rom || mc->option_rom_has_mr) && mc->rom_file_has_mr) {
            data =3D rom_set_mr(rom, OBJECT(fw_cfg), devpath, true);
        } else {
            data =3D rom->data;
        }



> MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t =
len,
>                            size_t max_len, hwaddr addr,
>                            const char *fw_file_name,
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 4dd5a71fb7..7f0cbfb214 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -1070,7 +1070,7 @@ static void *rom_set_mr(Rom *rom, Object *owner, =
const char *name, bool ro)
>=20
> ssize_t rom_add_file(const char *file, const char *fw_dir,
>                      hwaddr addr, int32_t bootindex,
> -                     bool option_rom, MemoryRegion *mr,
> +                     bool has_option_rom, MemoryRegion *mr,
>                      AddressSpace *as)
> {
>     MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
> @@ -1139,7 +1139,7 @@ ssize_t rom_add_file(const char *file, const =
char *fw_dir,
>                  basename);
>         snprintf(devpath, sizeof(devpath), "/rom@%s", fw_file_name);
>=20
> -        if ((!option_rom || mc->option_rom_has_mr) && =
mc->rom_file_has_mr) {
> +        if ((!has_option_rom || mc->option_rom_has_mr) && =
mc->rom_file_has_mr) {
>             data =3D rom_set_mr(rom, OBJECT(fw_cfg), devpath, true);
>         } else {
>             data =3D rom->data;
> --=20
> 2.41.0
>=20


