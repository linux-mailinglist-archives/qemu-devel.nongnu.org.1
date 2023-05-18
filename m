Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CBD708510
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 17:35:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzfeb-0005oR-08; Thu, 18 May 2023 11:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1pzfeY-0005nf-K0
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1pzfeW-00054X-Kz
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684424091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=92T2/1p7R9xALop+yhb4HOiwXwISYJn1Hfp3n7oPYmM=;
 b=IdswIz2gExqUMYIQeFqqjZ6FtjPVcEs1yZBcgrDgpUZlFkrjfBDlUAm+5VfKiUNlXTIIv4
 1o4SFaz78DXa5QlHGEp+bEwjqeIVICxy9ZN4c23FsQjAkU2m8DNzf87aclsUY4XM3kDPr6
 PZJDr1Odp8UXN7nCSwtRBwh09uGhLW4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-jh0etJJJOe2v9xC0IGU8Ew-1; Thu, 18 May 2023 11:34:50 -0400
X-MC-Unique: jh0etJJJOe2v9xC0IGU8Ew-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5308f5d8ac9so1270006a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 08:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684424089; x=1687016089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=92T2/1p7R9xALop+yhb4HOiwXwISYJn1Hfp3n7oPYmM=;
 b=X1GwfSWukxw5/H1F4gU78j1bLX1bXnIkccef5tmuFEorX3Gfj5Jeq27AVdIuJKzaqC
 sDbibA/lUSp0vKGAC+0USAuNLpGcnGIWMLn2X5Zs0Qnp2fOELEyhyl38/wnjYvJhgH1K
 8jA2Y5AJX77z0glnMF9dFdHLdhGPnLlZTH/Ii1rF59w1Ma9daJ95ogiaMfQP1i+0jnyZ
 ms3NZbY5b4hYcOCsPLqvEt8418yfq3WRHq/ym7oFjwj5BoPAAw5E+7tlSxIS89zapqaQ
 oDsSpslfDSk5Rw8tWi+ghypU95E45kMUkPySXydDIKp0xqD9hJAvh0d+HMopVg/3CgfV
 bn8g==
X-Gm-Message-State: AC+VfDzPnImMy6pi+XI0+lH3GXwR8L65ABIs11p3fuEr6nSfq6abG56n
 D19DcP0+qL6zGLiw9BnLJmVhSJnUc8FbxsMs2n52et9LlIi7lDpOo1zzZpK4EIt4dLAa9/l22kB
 3ithmuP4eAm3JQHM2fM8ILnwe11v0MOk=
X-Received: by 2002:a17:90a:fe93:b0:250:d293:5da0 with SMTP id
 co19-20020a17090afe9300b00250d2935da0mr3018575pjb.17.1684424088974; 
 Thu, 18 May 2023 08:34:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ62jLH/n4jmxcgDPZevsf5KlD8tkpxkugwqPskxlOwI9RhjWF5azsKIySkU1XPbaqRjKW1hhu9ftXdf/JRPe/o=
X-Received: by 2002:a17:90a:fe93:b0:250:d293:5da0 with SMTP id
 co19-20020a17090afe9300b00250d2935da0mr3018553pjb.17.1684424088604; Thu, 18
 May 2023 08:34:48 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 May 2023 08:34:47 -0700
From: Andrea Bolognani <abologna@redhat.com>
References: <20230425102545.162888-1-sunilvl@ventanamicro.com>
 <b520d913-27a9-dea5-53c8-af1cdd967ab2@canonical.com>
 <ZFiRr8d2zyAJlZJv@sunil-laptop>
 <CABJz62OTBEOMzcXLYc=DqRwH8N4DP=o0-kCfALwoREZVyOxLPg@mail.gmail.com>
 <a8dd5f20-30ab-903a-6bd0-15c6a91fdf52@linaro.org>
MIME-Version: 1.0
In-Reply-To: <a8dd5f20-30ab-903a-6bd0-15c6a91fdf52@linaro.org>
Date: Thu, 18 May 2023 08:34:47 -0700
Message-ID: <CABJz62NKZMoEkHZxXa3t11Um9LedJ8jw47-gDm+8_+vgxKZ4Mg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/riscv: virt: Assume M-mode FW in pflash0 only when
 "-bios none"
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Sunil V L <sunilvl@ventanamicro.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
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

On Wed, May 17, 2023 at 02:47:42PM +0200, Philippe Mathieu-Daud=C3=A9 wrote=
:
> > > On Mon, May 08, 2023 at 07:37:23AM +0200, Heinrich Schuchardt wrote:
> > > > On amd64 and arm64 unit=3D0 is used for code and unit=3D1 is used f=
or variables.
> > > > Shouldn't riscv64 do the same?
> >
> > Good catch, I had missed that!
>
> This is a design mistake spreading.
>
> What EDK2 maintainers want is one Read-Only + Exec region for CODE and
> one Read-Write + NoExec region for VARS.
>
> QEMU never implemented correctly pflash bank (multiple sectors) write
> protected.

Does setting -drive if=3Dpflash,unit=3D0,readonly=3Don not do the trick?

> When EDK2 (x86, OVMF) was tried on QEMU, QEMU was using a single pflash.
> To separate CODE/VARS, a second pflash was added, the first one being
> "locked" into Read-Only mode. Using a pflash allowed the firmware to
> identify device size using pflash CFI commands.
>
> Then this design was copied to the ARM virt board for EDK2 needs.
>
> In retrospective, this design was declared a mistake, since a simple
> ROM region for the CODE is sufficient, and much simpler [*].
>
> Thankfully the Loongarch64 virt machine started cleanly avoiding the
> previous design flaw. It provides a ROM for CODE and pflash for VARS.

Based on the documentation both in QEMU and edk2, it looks like a
single file is used? I haven't seen an example where the pflash is
used to provide a R/W area for VARS.

Note that the current version of the firmware.json standard doesn't
include a way to describe builds that have to be consumed by loading
the CODE via -bios and the VARS via pflash.

This is likely an artifact of codifying existing usage (x86/arm) and
could probably be fixed, but the point remains that there is
currently no way to represent such a build in a way that makes it
possible for consumers such as libvirt to automatically pick it up.

> [*] Having 2 distinct pflash is useful for non-virt machines where the
>     firmware might want to (re)program the CODE region, in the "capsule
>     update" scenario. This scenario is irrelevant for virt machines,
>     since a guest will never update its CODE. CODE is updated by the
>     host.

Yeah, this makes sense.

But I don't understand what's wrong with using a R/O pflash for CODE
as opposed to -bios? What makes that approach so problematic? You're
still going to need to use pflash for VARS anyway...

--=20
Andrea Bolognani / Red Hat / Virtualization


