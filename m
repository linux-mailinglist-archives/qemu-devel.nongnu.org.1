Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EDA7BFBD7
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:55:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqCGI-00033d-F4; Tue, 10 Oct 2023 08:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qqCGG-00032t-GJ
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qqCGE-0004aS-RJ
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696942493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BacrgWD88oDSDEhglwm757BdWPfVz2B2pwFsbjsHh4=;
 b=Narj4Qa7IwspO1UI/Hfb7PVcVttsi4wY3C2Lo+UFTvNmr/raawFCnOtGCcUAwZl4mARJEx
 GenDfsQNzolOMHlv3s3B+X9qAdX+SXRqT7X3jLIWbDzo3oO/5TzpKzsgKIBvkrOAq1fxaX
 rSzOPn0hTOYnM2H2YP8WRTyuWXfeW04=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-JoIhYD6DO1m8cXcZufsBEQ-1; Tue, 10 Oct 2023 08:54:36 -0400
X-MC-Unique: JoIhYD6DO1m8cXcZufsBEQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-58945463375so3413097a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 05:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942476; x=1697547276;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8BacrgWD88oDSDEhglwm757BdWPfVz2B2pwFsbjsHh4=;
 b=nS2cXSfF81lC6lN9zW0I8hqBuPGPA+u6LEc5N3pg3L7JbgeYk0pGydUP4qfB2PBIOi
 f1XvvofuzDrHuAGFUQCkcwxkT6dYQqq9L5QWj0Dj6nhF96jtTxl7Ik8HTVUg2uJJ6vQj
 8Nwi3vUWX4dVHgqUIzJOOQzDc2FvxMPIuXRk3P5YHZtZLYJPY5NTuq8N3xtlbWS9dRxZ
 4u/oIzGsvsmjPcTXUuBmv2q1NQMQQN0AALEIPa0whtjdvH3DV4v6zk4OxwtmE52CP0Xx
 6xIPSuCjTCVi24ORvNOY4XMf9h6SEu/venmSPAsl5H8hRLQ64A8gqymh7r86YeT8Ix8t
 g/dg==
X-Gm-Message-State: AOJu0YypNkmFicRwzOp55IDHQbcF9geoESfKwTWmGaBGEUEKhOPS+wPV
 ZEhaZCRcD6JacPI9AvjFJ8xubxaOq9kY9EnkMla7viS0J5RoopoSZcCpYkWYB9u6HU3p88SkQIm
 v/2uROews12bMhSs=
X-Received: by 2002:a05:6a20:daa6:b0:16c:13b1:2c6d with SMTP id
 iy38-20020a056a20daa600b0016c13b12c6dmr10761775pzb.56.1696942475750; 
 Tue, 10 Oct 2023 05:54:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQpooYqSbSW/K2x2mieRVLUSZ9F4Tg225a9KYDdefjLHeEa4f+WqtB9yzsa6jASTI8qs2PvA==
X-Received: by 2002:a05:6a20:daa6:b0:16c:13b1:2c6d with SMTP id
 iy38-20020a056a20daa600b0016c13b12c6dmr10761763pzb.56.1696942475466; 
 Tue, 10 Oct 2023 05:54:35 -0700 (PDT)
Received: from smtpclient.apple ([115.96.109.49])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a1709028c8800b001b7ffca7dbcsm11625378plo.148.2023.10.10.05.54.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 10 Oct 2023 05:54:35 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH v2 2/6] hw/loader: Clean up global variable shadowing in
 rom_add_file()
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231010115048.11856-3-philmd@linaro.org>
Date: Tue, 10 Oct 2023 18:24:28 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <23FA019B-28DA-491B-A9DF-C142A5C7DD84@redhat.com>
References: <20231010115048.11856-1-philmd@linaro.org>
 <20231010115048.11856-3-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
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



> On 10-Oct-2023, at 5:20 PM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Invert 'option_rom' logic and rename it as 'option_rom_has_mr' to fix:
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

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> include/hw/loader.h | 11 ++++++-----
> hw/core/loader.c    | 10 +++++-----
> 2 files changed, 11 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index c4c14170ea..9dbb9f7fdb 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -272,7 +272,8 @@ void pstrcpy_targphys(const char *name,
>=20
> ssize_t rom_add_file(const char *file, const char *fw_dir,
>                      hwaddr addr, int32_t bootindex,
> -                     bool option_rom, MemoryRegion *mr, AddressSpace =
*as);
> +                     bool option_rom_has_mr,
> +                     MemoryRegion *mr, AddressSpace *as);
> MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t =
len,
>                            size_t max_len, hwaddr addr,
>                            const char *fw_file_name,
> @@ -341,15 +342,15 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr =
addr, size_t size);
> void hmp_info_roms(Monitor *mon, const QDict *qdict);
>=20
> #define rom_add_file_fixed(_f, _a, _i)          \
> -    rom_add_file(_f, NULL, _a, _i, false, NULL, NULL)
> +    rom_add_file(_f, NULL, _a, _i, true, NULL, NULL)
> #define rom_add_blob_fixed(_f, _b, _l, _a)      \
>     rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, NULL, true)
> #define rom_add_file_mr(_f, _mr, _i)            \
> -    rom_add_file(_f, NULL, 0, _i, false, _mr, NULL)
> +    rom_add_file(_f, NULL, 0, _i, true, _mr, NULL)
> #define rom_add_file_as(_f, _as, _i)            \
> -    rom_add_file(_f, NULL, 0, _i, false, NULL, _as)
> +    rom_add_file(_f, NULL, 0, _i, true, NULL, _as)
> #define rom_add_file_fixed_as(_f, _a, _i, _as)          \
> -    rom_add_file(_f, NULL, _a, _i, false, NULL, _as)
> +    rom_add_file(_f, NULL, _a, _i, true, NULL, _as)
> #define rom_add_blob_fixed_as(_f, _b, _l, _a, _as)      \
>     rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, _as, true)
>=20
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 4dd5a71fb7..f0d20fd776 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -1070,8 +1070,8 @@ static void *rom_set_mr(Rom *rom, Object *owner, =
const char *name, bool ro)
>=20
> ssize_t rom_add_file(const char *file, const char *fw_dir,
>                      hwaddr addr, int32_t bootindex,
> -                     bool option_rom, MemoryRegion *mr,
> -                     AddressSpace *as)
> +                     bool option_rom_has_mr,
> +                     MemoryRegion *mr, AddressSpace *as)
> {
>     MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
>     Rom *rom;
> @@ -1139,7 +1139,7 @@ ssize_t rom_add_file(const char *file, const =
char *fw_dir,
>                  basename);
>         snprintf(devpath, sizeof(devpath), "/rom@%s", fw_file_name);
>=20
> -        if ((!option_rom || mc->option_rom_has_mr) && =
mc->rom_file_has_mr) {
> +        if ((option_rom_has_mr || mc->option_rom_has_mr) && =
mc->rom_file_has_mr) {
>             data =3D rom_set_mr(rom, OBJECT(fw_cfg), devpath, true);
>         } else {
>             data =3D rom->data;
> @@ -1239,12 +1239,12 @@ int rom_add_elf_program(const char *name, =
GMappedFile *mapped_file, void *data,
>=20
> ssize_t rom_add_vga(const char *file)
> {
> -    return rom_add_file(file, "vgaroms", 0, -1, true, NULL, NULL);
> +    return rom_add_file(file, "vgaroms", 0, -1, false, NULL, NULL);
> }
>=20
> ssize_t rom_add_option(const char *file, int32_t bootindex)
> {
> -    return rom_add_file(file, "genroms", 0, bootindex, true, NULL, =
NULL);
> +    return rom_add_file(file, "genroms", 0, bootindex, false, NULL, =
NULL);
> }
>=20
> static void rom_reset(void *unused)
> --=20
> 2.41.0
>=20


