Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93472A12EF4
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Jan 2025 00:04:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCPU-0003Tr-Ey; Wed, 15 Jan 2025 18:02:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1tYCPI-0003TT-MH
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:02:41 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1tYCPG-0000qA-O8
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:02:40 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21670dce0a7so5665925ad.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736982155; x=1737586955; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K9d3uYSIPYWNud+YDQsOCHfkq3IiZOUwPDKvG3lAzMk=;
 b=VlZJ1ntvXEG2aMz4gUpLj9rFDudZdojNRztGBrYyW6xwZ/oytwaoeIHNGmmBe/EuC6
 3gHw+LC2UCt22qYbuPkKDU9ojR0mNP6DdoBmP7MgYmmAKBkFiLlOujNxdUsOKQAi5i7t
 KBstmR7GeqBWVJIOgbNK5PdQwnk9RYhFqHr05mnheA9V7d6D4Jq2TzrBFPHjeyemGWHU
 xpTG/zDYnJDLBC2pf6iT2Wt5Mlqf8MvF/qNkznouUyXNyjcEsTQmgCL5U85e820sBJy8
 Exd68nl1+KnU5VYuGqF0yUiPRCEFG9lJ/JtYtBYYvi8zgLz8wRf+tbnacqSzBpYubfAH
 uTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736982155; x=1737586955;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K9d3uYSIPYWNud+YDQsOCHfkq3IiZOUwPDKvG3lAzMk=;
 b=DfP82zcp16IX5C9Dahb1sY+1/Uq43/UvV8YH2E6f/zRnD79BtXiRjRXaeGTbB0OWGn
 vIKk/w0evtteekvcGcjJk2Ol+3iZxZSc1EOfUR5RVuDfI2CMQKPtf6yIYgJE93PKwJsA
 H6PbDIdetSIFHmevrILrnMhTn6GcZJjGRpB+pVHdBLO5x87gWvgd7BVPZv2sZt0m74VO
 GN49KB8IlyWAH5ZtpWtWT9UPa52C/jP6YM6h3zHSdtN18pa+nUz7r7nC6O/tzfng7fIr
 SIKcRFa5YghaUyGVG02csI+jvtFGJqnHjhN7/IZUHJeq4Gtt42TlSbHJfW4iqH4JlVbL
 kTPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU22Xng1San3c6+hRRgtOf5edoDnuoxh4sfPiZM5zPzeS4KkNeMau274Hw9UgXiUFzAskRZfTl+jtIA@nongnu.org
X-Gm-Message-State: AOJu0YxHt2ZBxeSNO0DSxTu+ifEoPa/99fx1AdRRGbL2cTTNChFsLEUc
 H3q3e3TUpOLpp1h1/sqPmh3QZYkKlBBztgLFDj2mZx4foCXgFlPA
X-Gm-Gg: ASbGncv/0y5T1OsXavJk1YoFMX3TVr1QaRA2p76wFhRQ4eqR2h/1NLWdxJnL3zKyt3D
 /c5APpROE1MOaByRNAa5FusvC+++42kENy3+5cBGb70QmEIpKqowgzoWmXTZsKlSOqu8hlnuLFO
 wHVe7FntKwcrY7VlBo8Kbw1wn2qqXfASw3bP8usO3Vuo5qRvEgs7x/Z5Ix7W5OJDLNrNDq9juCu
 nAyOslDM64m/pAMUDZSYrLyXh0tVB9AYUL9lMGDN0LYKGDwUIvAfxOmjAg0
X-Google-Smtp-Source: AGHT+IH3g4QHIMuDRVS0YnWIWvg4zTkwKT2DoinlYse6FjEVmTgx30vwMXAVTILqmo1vF6KJ4iR9Xw==
X-Received: by 2002:a05:6a21:4a41:b0:1e3:e836:8ad8 with SMTP id
 adf61e73a8af0-1e88d0ef9f6mr53073682637.38.1736982155451; 
 Wed, 15 Jan 2025 15:02:35 -0800 (PST)
Received: from smc-140338-bm01 ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a318130b711sm10278212a12.10.2025.01.15.15.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 15:02:34 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 15 Jan 2025 23:02:32 +0000
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Fan Ni <nifan.cxl@gmail.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
 "anisa.su887@gmail.com" <anisa.su887@gmail.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [ISSUE] memdev cannot be enabled after reboot due to failed
 dvsec range check [QEMU setup]
Message-ID: <Z4g-iMVj4D2sUE20@smc-140338-bm01>
References: <Z4bJdCliETI_t2DL@fan>
 <80665bcd-7d6e-4f7a-9ab4-e292486f2681@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80665bcd-7d6e-4f7a-9ab4-e292486f2681@fujitsu.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 15, 2025 at 01:06:24AM +0000, Zhijian Li (Fujitsu) wrote:
> Cced QEMU,
> 
> Hi Fan,
> 
> I recalled we had a reboot issue[1] months ago
> I guess your issue was caused by some registers not reset during reboot.
> 
> [1] https://lore.kernel.org/linux-cxl/20240409075846.85370-1-lizhijian@fujitsu.com/
> 
Hi Zhijian,
Thanks for the pointer. With the fix applied, the issue goes away.

Fan
> 
> On 15/01/2025 04:30, Fan Ni wrote:
> > Hi,
> > 
> > Recently, while testing cxl with qemu setup, I found the memdev cannot
> > be enabled successfully after reboot.
> > 
> > Here is the setup and the steps I have tried.
> > 
> > QEMU:
> > https://gitlab.com/qemu-project/qemu.git
> > branch: master
> > commit: 8032c78e556cd0baec111740a6c636863f9bd7c8
> > 
> > Kernel:
> > https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/
> > branch: next
> > 2f84d072bdcb7d6ec66cc4d0de9f37a3dc394cd2
> > 
> > Steps to reproduce the issue.
> > 1.  start the vm with cxl pmem device attached directly to RP.
> > 2. Load the cxl drivers cxl_acpi cxl_core cxl_pci cxl_port cxl_mem, etc.
> > Everyting works expected, the memory is corrected enabled and shown with
> > cxl list.
> > 3. Reboot the VM (run reboot command inside vm, no shutdown);
> > 4. Load the cxl drivers as in step 2. the cxl pmem is not correctly enabled.
> > 
> > dmesg shows some error as below:
> > -------------------------------
> > [   17.131729] cxl_core:cxl_hdm_decode_init:443: cxl_pci 0000:0d:00.0: DVSEC Range0 denied by platform
> > [   17.135267] cxl_pci 0000:0d:00.0: Range register decodes outside platform defined CXL ranges.
> > [   17.138428] cxl_core:cxl_bus_probe:2073: cxl_port endpoint2: probe: -6
> > [   17.141104] cxl_core:devm_cxl_add_port:936: cxl_mem mem0: endpoint2 added to port1
> > [   17.143703] cxl_mem mem0: endpoint2 failed probe
> > [   17.145324] cxl_core:cxl_bus_probe:2073: cxl_mem mem0: probe: -6
> > [   17.171416] cxl_core:cxl_detach_ep:1499: cxl_mem mem0: disconnect mem0 from port1
> > ------------------------------
> > Compare the step 2 and 4 with debug info. we can see,
> > In step 2, when entry function: cxl_hdm_decode_init().
> > 
> > (gdb) p *info
> > $2 = {mem_enabled = false, ranges = 0, port = 0xffff8881097eac00, dvsec_range = {{start = 0, end = 0}, {start = 0, end = 0}}}
> > 
> > The info struct is from cxl_dvsec_rr_decode(), where if mem_enabled is
> > not enabled, it will return directly without reading dvsec range, so
> > ranges == 0.
> > This is what happened in step 2: no dvsec ranges are provided to the function for checking.
> > 
> > When init the hdm decoder in cxl_hdm_decode_init function, the memory enable bit will be set.
> > 
> > In step 4, after reboot, the enabled memory enable bit sustained and the dvsec range
> > register will be read from the device in cxl_dvsec_rr_decode.
> > So when entrying cxl_hdm_decode_init(),
> > ------------------------------------
> > $2 = {mem_enabled = true, ranges = 1, port = 0xffff888103c77400, dvsec_range = {{start = 0, end = 536870911}, {start = 0, end = 0}}}
> > Breakpoint 2 at 0xffffffffc0657bbe: file drivers/cxl/core/pci.c, line 416.
> > ------------------------------------
> > It will cause the dvsec_range_allowed() failing as the range from dvsec range
> > registers starts at address zero [0, 512], which does not match the hpa range
> > stored in cxld->hpa_range, causing the issue.
> > 
> > ------------------------------------
> > Thread 1 hit Breakpoint 4, dvsec_range_allowed (dev=0xffff888108af9848,
> >      arg=0xffffc9000059f9b0) at drivers/cxl/core/pci.c:265
> > 265		if (!(cxld->flags & CXL_DECODER_F_RAM))
> > (gdb) b 268
> > Breakpoint 5 at 0xffffffffc0657d31: file drivers/cxl/core/pci.c, line 271.
> > (gdb) p /x cxld->hpa_range
> > $5 = {start = 0xa90000000, end = 0xb8fffffff}
> > (gdb) p /x *dev_range
> > $7 = {start = 0x0, end = 0x1fffffff}
> > (gdb)
> > ------------------------------------
> > The hpa_range is set when parsing the cfmws in __cxl_parse_cfmws.
> > 
> > Any throughts?
> > 
> > Open question: do we need to update the dvsec range register after we parse the
> > cfmws to make the two above match.

-- 
Fan Ni (From gmail)

