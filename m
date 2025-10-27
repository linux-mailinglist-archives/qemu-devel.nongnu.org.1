Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 351FFC0D6A1
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Oct 2025 13:10:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDM21-0008Gm-N1; Mon, 27 Oct 2025 08:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDM1w-0008GI-JE
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:08:57 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDM1p-0001Y5-Gb
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=CvmTA/4cqWbszmaPCxuoa/O1hUlcDiasarLHuvRyqVo=; b=W0rseKoZcP0jy9W
 K1+icZxtLAGK6oXxKjap7UVR6WULNZS+cmIfXrQq7e0jF0NAbCfnBpMppLh45trWhIJiehvEtBDiL
 HaOKj7Xi/n2MUip64sgF+Xb6IvOWiWCjH3PnBkqT+1BpGjHuF++RSTHcd/ZEo43GnJwiSgQLcNf+/
 F0=;
Date: Mon, 27 Oct 2025 13:11:25 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, palmer@dabbelt.com
Subject: Re: [PATCH 1/5] hw/riscv: Use generic hwaddr for firmware addressses
Message-ID: <uawib6vqxwnso4ic7eqxtgqkvtamj2c22bzuc73nlvbxju7laq@t7wqbdl3vfwa>
References: <20251015-feature-single-binary-hw-v1-v1-0-8b416eda42cf@rev.ng>
 <20251015-feature-single-binary-hw-v1-v1-1-8b416eda42cf@rev.ng>
 <1f8876eb-9e57-4102-8d04-3de29c4832f9@linaro.org>
 <gfywynwh3pl4emzpepos7r2usnapgwdro27qxa3njqo22rbuuj@ydxpxmfa3lu2>
 <0f154c4e-0bc5-403f-a8fb-06090957b0e4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f154c4e-0bc5-403f-a8fb-06090957b0e4@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 23/10/25, Philippe Mathieu-Daudé wrote:
> On 23/10/25 19:14, Anton Johansson wrote:
> > On 15/10/25, Philippe Mathieu-Daudé wrote:
> > > On 15/10/25 15:27, Anton Johansson wrote:
> > > > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > > > ---
> > > >    include/hw/riscv/boot.h    | 20 ++++++++++----------
> > > >    hw/riscv/boot.c            | 22 +++++++++++-----------
> > > >    hw/riscv/microchip_pfsoc.c |  2 +-
> > > >    hw/riscv/sifive_u.c        |  2 +-
> > > >    hw/riscv/spike.c           |  4 ++--
> > > >    hw/riscv/virt.c            |  2 +-
> > > >    6 files changed, 26 insertions(+), 26 deletions(-)
> > > > 
> > > > diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> > > > index 7d59b2e6c6..d835594baa 100644
> > > > --- a/include/hw/riscv/boot.h
> > > > +++ b/include/hw/riscv/boot.h
> > > > @@ -43,21 +43,21 @@ bool riscv_is_32bit(RISCVHartArrayState *harts);
> > > >    char *riscv_plic_hart_config_string(int hart_count);
> > > >    void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
> > > > -target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,
> > > > -                                          target_ulong firmware_end_addr);
> > > > -target_ulong riscv_find_and_load_firmware(MachineState *machine,
> > > > -                                          const char *default_machine_firmware,
> > > > -                                          hwaddr *firmware_load_addr,
> > > > -                                          symbol_fn_t sym_cb);
> > > > +hwaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
> > > > +                                    hwaddr firmware_end_addr);
> > > > +hwaddr riscv_find_and_load_firmware(MachineState *machine,
> > > > +                                    const char *default_machine_firmware,
> > > > +                                    hwaddr *firmware_load_addr,
> > > > +                                    symbol_fn_t sym_cb);
> > > >    const char *riscv_default_firmware_name(RISCVHartArrayState *harts);
> > > >    char *riscv_find_firmware(const char *firmware_filename,
> > > >                              const char *default_machine_firmware);
> > > > -target_ulong riscv_load_firmware(const char *firmware_filename,
> > > > -                                 hwaddr *firmware_load_addr,
> > > > -                                 symbol_fn_t sym_cb);
> > > > +hwaddr riscv_load_firmware(const char *firmware_filename,
> > > > +                           hwaddr *firmware_load_addr,
> > > > +                           symbol_fn_t sym_cb);
> > > >    void riscv_load_kernel(MachineState *machine,
> > > >                           RISCVBootInfo *info,
> > > > -                       target_ulong kernel_start_addr,
> > > > +                       hwaddr kernel_start_addr,
> > > 
> > > vaddr?
> > 
> > Maybe vaddr would be more suitable, I went with hwaddr as
> > kernel_start_addr is fed into load_image_targphys_as()
> > which expects hwaddr, and hw/arm does the same.
> 
> load_kernel() tries to load a file at a vaddr; when it fails
> (because can not be parsed, i.e. ELF) the fallback is to try
> to load as firmware at a hwaddr. My understanding anyway...

For riscv_load_kernel() the kernel_start_addr argument is the fallback
address to load at in case uboot/elf loading fails IIUC.  Also the
RISCVBootInfo struct which is populated holds hwaddr.  I'll submit v2 of
this patch as is, at least it will be more consistent.

