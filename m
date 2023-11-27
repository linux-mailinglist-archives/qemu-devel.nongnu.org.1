Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0751F7FA008
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 13:52:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7b4n-0008GX-9r; Mon, 27 Nov 2023 07:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r7b4V-0008Fr-4z; Mon, 27 Nov 2023 07:50:44 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r7b4Q-0003q4-Pz; Mon, 27 Nov 2023 07:50:42 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b20577ef7bso3422864b3a.3; 
 Mon, 27 Nov 2023 04:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701089428; x=1701694228; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gR2Y9QFoYlSdPtHUDVL6HSSR1+h3VHyk/31eLXuWe0g=;
 b=IdT3j4KX5i4pfzsIL7IX+OxcqEo71n5KZ5CbM8hNVvbFjVizgh2CkjFFIo8z57tO1G
 fPCdfH63ds/Fct8onu4j2efHvZ53+9hiJtz1lMVypNOaWR+au8SqPQEiMTi6E5k/fRag
 TfnAVBYsIO2kr/OqIUCCw4zoiodg4OFQ0Dl6YuLGibw827TYEeo8QuBKYzvsCDNpEvM1
 MECaVizOrBLSMrXhT4XMZLfif+cmnjKjzsLhtw5AA0jfMZlv6jHXjpG0EfXoCOyJXnAm
 /8LugxMqH7/oZeR0j77+1jrg3f8j0oL0LFC9Oh5fof9goctYcFuUXUCJ6LZ4193Bqffv
 PO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701089428; x=1701694228;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gR2Y9QFoYlSdPtHUDVL6HSSR1+h3VHyk/31eLXuWe0g=;
 b=E3Npfeu0cHILapUx/Qup/tuFqiTktrV/wYoNYu1dQg1qC6QCJImJ3q1NkqNcKgXhTF
 A46Vc54VTJIGqCrcGKu2frxHnnrmX68aaZibsl0K81JVS99bKH/GSI5bsYbWd2/CqQhH
 nuwHDpRkFB1XhddX/gmd6Lsxwyex32TlOvmTL+az3o61SkcTl2kjjRfTDU94etgeSocL
 kjh5HqIbTvJJCRR5ITL12UhA9AQajDruoeZoZT1iQS7UeajriZ8wTKEmYSZvcy8iqcRh
 JArGxu0mD9nv+yvABwzATZ5NagsZo4PZQobxsxGdkRq9FeC5dqm/VTcDRSFz8F6Vpdok
 qwQQ==
X-Gm-Message-State: AOJu0YzjQG7XlpigqZck9laZ5jwijv/4cUPasRFsUBfxDpg6fVmMdsdf
 dLeKcTyuTT6BMfJfosezb/I=
X-Google-Smtp-Source: AGHT+IGLmhZAEhZpqknx+shD1u/YU6+lkbVvtqzU9xJt/fR197z1w9qs804qAmvkTBBJuabLtOMBag==
X-Received: by 2002:a05:6a00:3a0b:b0:6cb:8dba:ce6c with SMTP id
 fj11-20020a056a003a0b00b006cb8dbace6cmr10897706pfb.18.1701089427823; 
 Mon, 27 Nov 2023 04:50:27 -0800 (PST)
Received: from localhost (121-44-66-27.tpgi.com.au. [121.44.66.27])
 by smtp.gmail.com with ESMTPSA id
 m22-20020aa78a16000000b00692cb1224casm7131070pfa.183.2023.11.27.04.50.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 04:50:27 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Nov 2023 22:50:21 +1000
Message-Id: <CX9LVFYU6MBA.MLF4OMOCHE6K@wheely>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, <clg@kaod.org>, <philmd@linaro.org>
Subject: Re: [PATCH v2 for-8.2] ppc/amigaone: Allow running AmigaOS without
 firmware image
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.15.2
References: <20231125163425.3B3BC756078@zero.eik.bme.hu>
 <CX9EPBH7MMHK.14A30GV035VAZ@wheely>
 <0eb18a77-af0e-a84b-764c-b435ea912a3d@eik.bme.hu>
In-Reply-To: <0eb18a77-af0e-a84b-764c-b435ea912a3d@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon Nov 27, 2023 at 9:43 PM AEST, BALATON Zoltan wrote:
> On Mon, 27 Nov 2023, Nicholas Piggin wrote:
> > On Sun Nov 26, 2023 at 2:34 AM AEST, BALATON Zoltan wrote:
> >> The machine uses a modified U-Boot under GPL license but the sources
> >> of it are lost with only a binary available so it cannot be included
> >> in QEMU. Allow running without the firmware image with -bios none
> >> which can be used when calling a boot loader directly and thus
> >> simplifying booting guests. We need a small routine that AmigaOS calls
> >> from ROM which is added in this case to allow booting AmigaOS without
> >> external firmware image.
> >>
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> ---
> >> v2: Unfortunately AmigaOS needs some additional ROM part which is adde=
d
> >> Please merge for 8.2 as it allows booting AmigaOS simpler without
> >> having to download separate firmware.
> >
> > How to test this?
>
> You can check with -M amigaone -bios none then from QEMU monitor
> (qemu) xp/10i 0xfff7ff80

Okay, so to fully test it you really need a non-free AmigaOS image?

And, how does a user know how or when to use this? Should it just be
default if there is no bios binary found?

>
> >>  hw/ppc/amigaone.c | 20 +++++++++++++++++---
> >>  1 file changed, 17 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> >> index 992a55e632..a11d2d5556 100644
> >> --- a/hw/ppc/amigaone.c
> >> +++ b/hw/ppc/amigaone.c
> >> @@ -40,6 +40,16 @@
> >>  #define PROM_ADDR 0xfff00000
> >>  #define PROM_SIZE (512 * KiB)
> >>
> >> +/* AmigaOS calls this routine from ROM, use this if -bios none */
> >> +static const char dummy_fw[] =3D {
> >> +    0x38, 0x00, 0x00, 0x08, /* li      r0,8 */
> >> +    0x7c, 0x09, 0x03, 0xa6, /* mtctr   r0 */
> >> +    0x54, 0x63, 0xf8, 0x7e, /* srwi    r3,r3,1 */
> >> +    0x42, 0x00, 0xff, 0xfc, /* bdnz    0x8 */
> >> +    0x7c, 0x63, 0x18, 0xf8, /* not     r3,r3 */
> >> +    0x4e, 0x80, 0x00, 0x20, /* blr */
> >> +};
> >
> > This is clever, but does anything else create blobs like this?
>
> There are some examples in hw/mips/{loongson3_virt.c, malta.c} at least=
=20
> and maybe others that put code in guest memory. If this was longer than=
=20
> this few instructions I'd consider putting it in a binary but this seems=
=20
> simpler for such small code.

Thanks, compiling blob inline looks fine then.

It's 0x80 bytes from the end of prom AFAIKS. Should you make that
PROM_ADDR + PROM_SIZE - 0x80 instead of hard coding it?

>
> > It could be put into a .S in pc-bios, which might be a bit more
> > consistent.
> >
> > We might make a ppc/ subdirectory under there, but that's for
> > another time.
>
> Maybe later we could reorganise these unless it's really necessary to=20
> change this for 8.2 now.

Nah that's fine.

> (The mips boards and some arm and riscv machines=20
> seem to use rom_add_blob_fixed() which sould show up in info roms under=
=20
> monitor so maybe I could look at changing to use that now if you think it=
=20
> would be better that way.)

I'm not sure, I don't think it's necessary if your minimal patch works.

I'll do a PR for 8.2 for SLOF and Skiboot updates, so happy to include
this as well.

Thanks,
Nick

>
> Regards,
> BALATON Zoltan
>
> > Thanks,
> > Nick
> >
> >> +
> >>  static void amigaone_cpu_reset(void *opaque)
> >>  {
> >>      PowerPCCPU *cpu =3D opaque;
> >> @@ -94,17 +104,21 @@ static void amigaone_init(MachineState *machine)
> >>      }
> >>
> >>      /* allocate and load firmware */
> >> +    rom =3D g_new(MemoryRegion, 1);
> >> +    memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal)=
;
> >> +    memory_region_add_subregion(get_system_memory(), PROM_ADDR, rom);
> >>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, fwname);
> >>      if (filename) {
> >> -        rom =3D g_new(MemoryRegion, 1);
> >> -        memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fa=
tal);
> >> -        memory_region_add_subregion(get_system_memory(), PROM_ADDR, r=
om);
> >>          sz =3D load_image_targphys(filename, PROM_ADDR, PROM_SIZE);
> >>          if (sz <=3D 0 || sz > PROM_SIZE) {
> >>              error_report("Could not load firmware '%s'", filename);
> >>              exit(1);
> >>          }
> >>          g_free(filename);
> >> +    } else if (!strcmp(fwname, "none")) {
> >> +        address_space_write_rom(&address_space_memory, 0xfff7ff80,
> >> +                                MEMTXATTRS_UNSPECIFIED, dummy_fw,
> >> +                                ARRAY_SIZE(dummy_fw));
> >>      } else if (!qtest_enabled()) {
> >>          error_report("Could not find firmware '%s'", fwname);
> >>          exit(1);
> >
> >
> >


