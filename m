Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 542647EA0F6
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 17:09:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ZUZ-0000k7-Et; Mon, 13 Nov 2023 11:08:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1r2ZUV-0000jT-Vj
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 11:08:47 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1r2ZUT-0003Gk-EA
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 11:08:47 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso3559758a12.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 08:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1699891723; x=1700496523; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fdhByzTYG4Z1xzCS3Jra0JQD5DDZUgvgtJrpeN1q2as=;
 b=AN0xlljc1MXl8+K9nGeaXnaOIz5Qjc1Fc7wvFknrjSL7En+Z25TQG8r5i/zKVObzSc
 TRqw2IxmkjSmPWj9/jTdu1qfpxqfEd7R6wz/AMuq3NiBuD9b9Zl0SscbI452Y2e1DDVA
 EbvOETZlQK748I4xA4By1z6MM/HBQ77u+dYiAdAQ7XM4PLexNxmktIWCLxI1aN7DdXTp
 hU3coxeV3ZTlnObkG/EYEdzodlUYRFZ8LLBsAXA7LeEjyCQ46ZpBWk1Dgi2/7Iu0HoLz
 kmgAzAPSkiQmlhVPRltyQZEhUw6bP7YtQD2ys60NDKOAml0Dq8mJHbqFtGal4Za+y1hW
 NbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699891723; x=1700496523;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fdhByzTYG4Z1xzCS3Jra0JQD5DDZUgvgtJrpeN1q2as=;
 b=rasoqsVFGRsOe7kxr2bwGdM4ppiNKaWJkFM/ztlz8meNI9YfC4H7Jt3QqI2pvG5gkR
 stqmZ2smrdSj8o6Ewxx/w/rCz1Zs6vJ7d6YqJ/SD7dkM3buYX2LVnxRhhCWZRLS0mhFP
 hFFuiDNqUAfuJ/Aegu/9G1HTn7Oy4lXhlwKR0iuMw3j9h7KZOyGDCn1PygP6tiZucgzf
 S31eHydOT9+a5niLPDy7JP/fu2spJdCINaGciyONGvuYWBGVwn4fhzmw/uoc/nus/f7f
 inqm/bRCH0tIv6sW0eMAwZCpQwVkTahF6S92PHOlUuIr7Jh7BJwnK6ILi9a3uooVLYtp
 HV6A==
X-Gm-Message-State: AOJu0YzEJrLLTy18++FDJOs9ArQcb1CGDtZziOInku2sCNcj6m8EAn3L
 RoH+o0tOcyugwFY5veabTJ6Kg+vraDic2CJlJQdMysWeJwAhLvHm2Vs=
X-Google-Smtp-Source: AGHT+IGm6IbblZT4EBGblIO00wfmFxsfWX+Yg3k4BinJNFHcwKRFJ3zK5CEUUWV5Qj/iREV12rYnNDBF8ktjcYwLj/Q=
X-Received: by 2002:a17:90b:4ad0:b0:283:27e0:654b with SMTP id
 mh16-20020a17090b4ad000b0028327e0654bmr6817249pjb.3.1699891723213; Mon, 13
 Nov 2023 08:08:43 -0800 (PST)
MIME-Version: 1.0
References: <20231023153927.435083-1-dbarboza@ventanamicro.com>
In-Reply-To: <20231023153927.435083-1-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Mon, 13 Nov 2023 17:08:32 +0100
Message-ID: <CAJ307EhA_m3u7VgML1thYpLozcn-iKr-FY-LtPNMzKUDSTvZQQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] riscv: zicntr/zihpm flags and disable support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=chigot@adacore.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Daniel,

This series is triggering warnings when instantiating a CPU having a
spec version older than 1.12.
  | $ qemu-system-riscv32 -M sifive_e
  | qemu-system-riscv32: warning: disabling zicntr extension for hart
0x00000000 because privilege spec version does not match
  | qemu-system-riscv32: warning: disabling zihpm extension for hart
0x00000000 because privilege spec version does not match

And IIUC cpu-tcg.c:riscv_cpu_disable_priv_spec_isa_exts(), they will
end up being disabled as a result of these warnings.

I think these two extensions should be skipped in the above function.
Though we can also disable them on purpose in those old CPUs. WDYT ?

Thanks,
Cl=C3=A9ment

On Mon, Oct 23, 2023 at 5:40=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> In this v3 the patches that added the extensions flags were squashed
> with the patches that handled the disablement of the extensions in TCG,
> as suggested by Alistair in v2.
>
> No other change made. Patches based on Alistair's riscv-to-apply.next.
>
> Patches missing acks: patch 3
>
> Changes from v2:
> - patch 2: squashed with patch 1
> - patch 5: squashed with patch 4
> - v2 link: https://lore.kernel.org/qemu-riscv/20231017221226.136764-1-dba=
rboza@ventanamicro.com/
>
> Daniel Henrique Barboza (4):
>   target/riscv: add zicntr extension flag for TCG
>   target/riscv/kvm: add zicntr reg
>   target/riscv: add zihpm extension flag for TCG
>   target/riscv/kvm: add zihpm reg
>
>  target/riscv/cpu.c         | 15 +++++++++++++++
>  target/riscv/cpu_cfg.h     |  2 ++
>  target/riscv/csr.c         |  4 ++++
>  target/riscv/kvm/kvm-cpu.c |  2 ++
>  target/riscv/tcg/tcg-cpu.c | 21 +++++++++++++++++++++
>  5 files changed, 44 insertions(+)
>
> --
> 2.41.0
>
>

