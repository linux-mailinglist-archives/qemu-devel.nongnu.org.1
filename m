Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4361C7D1D7C
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 16:32:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quCzw-0008Hx-Hn; Sat, 21 Oct 2023 10:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1quCzu-0008HW-6d
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 10:30:38 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1quCzs-0003ih-6I
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 10:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7En9Be13Maz9GbbWeaE+sVGdk4oxTp4vGrDCyGqwz/o=; b=Y9+he1j49hgLme2U+HH27rGpR1
 xd03+cWZrzlldNqmsaQlu1Dm8RNaAPMQ5d8bYlfy7khD3Yt3AtOAjQuDsWE0mh+dc3ebU74THFgA+
 hFkpEIOdWMXN76/PnusgAvnG4w+/5Qmd15ZmFqXN37e+ZLno8EUFthHOCHal+4v+vnsTEqn85X7gI
 UPbeqX8uOAaqMdWpftEnWRd6DdPSldQAEp4pmLKRsA0t6EtR3E1tReT2kIgvEDWMxrrc/i8tqz8Dt
 TA3S4swDY7UB6ADtGsAYqKlTfLhWlOM1lnq0u5qlnVWP35EwkmaP8GR0RHHjMqyqo0ZojI+zIWGSS
 xJDkb77Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1quCzn-005nhc-1s;
 Sat, 21 Oct 2023 14:30:31 +0000
Date: Sat, 21 Oct 2023 14:30:31 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH] hmp: implement hmp_ram_memory_dump
Message-ID: <ZTPghzKOZnyGA50A@gallifrey>
References: <20231016164235.2179049-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231016164235.2179049-1-alex.bennee@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-12-amd64 (x86_64)
X-Uptime: 14:06:33 up 35 days, 17:05, 1 user, load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Alex Bennée (alex.bennee@linaro.org) wrote:
> While reviewing the tb-stats series I was confused by the different
> between physical and ram address. This implements the RAM dump so I
> can replicate the disassembly of "info tb". Whether or not that is a
> good idea remains to be discussed.

Do you have the definition of what the address space for info tb is?


> Based-on: 20231003183058.1639121-1-richard.henderson@linaro.org
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/monitor/hmp-target.h |  1 +
>  monitor/hmp-cmds-target.c    | 10 ++++++++++
>  hmp-commands.hx              | 19 ++++++++++++++++++-
>  3 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
> index 730507bd65..a3fa7dc089 100644
> --- a/include/monitor/hmp-target.h
> +++ b/include/monitor/hmp-target.h
> @@ -50,6 +50,7 @@ void hmp_info_sgx(Monitor *mon, const QDict *qdict);
>  void hmp_info_via(Monitor *mon, const QDict *qdict);
>  void hmp_memory_dump(Monitor *mon, const QDict *qdict);
>  void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict);
> +void hmp_ram_memory_dump(Monitor *mon, const QDict *qdict);
>  void hmp_info_registers(Monitor *mon, const QDict *qdict);
>  void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
>  void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index 476cf68e81..21ce790502 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -253,6 +253,16 @@ void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
>      memory_dump(mon, count, format, size, addr, MON_DISAS_GPA);
>  }
>  
> +void hmp_ram_memory_dump(Monitor *mon, const QDict *qdict)
> +{
> +    int count = qdict_get_int(qdict, "count");
> +    int format = qdict_get_int(qdict, "format");

How does that does match your described '/countformatsize' syntax
you list below?
This just looks like 3 separate parameters; but I guess that's a copy.


> +    int size = qdict_get_int(qdict, "size");
> +    hwaddr addr = qdict_get_int(qdict, "addr");
> +
> +    memory_dump(mon, count, format, size, addr, MON_DISAS_GRA);

OK, so really the only difference is that flag.


> +}
> +
>  void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
>  {
>      Int128 gpa_region_size;
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index e1d78ab69d..5a9ecefdcb 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -471,7 +471,10 @@ ERST
>  
>  SRST
>  ``x/``\ *fmt* *addr*
> -  Virtual memory dump starting at *addr*.
> +  Virtual memory dump starting at *addr*. See xp/ for physical memory and xr/ for ram
> +
> +  *fmt* is a format which tells the command how to format the
> +  data. Its syntax is: ``/{count}{format}{size}``
>  ERST
>  
>      {
> @@ -530,7 +533,21 @@ SRST
>      0x000b8090: 0x0720 0x0720 0x0720 0x0720 0x0720 0x0720 0x0720 0x0720
>  
>  ERST
> +    {
> +        .name       = "xr",
> +        .args_type  = "fmt:/,addr:l",
> +        .params     = "/fmt addr",
> +        .help       = "ram memory dump starting at 'addr'",
> +        .cmd        = hmp_ram_memory_dump,
> +    },
> +
> +SRST
> +``xr /``\ *fmt* *addr*
> +  RAM memory dump starting at *addr*. See xp/ for physical and x/ for virtual memory
>  
> +  *fmt* is a format which tells the command how to format the
> +  data. Its syntax is: ``/{count}{format}{size}``
> +ERST
>      {
>          .name       = "gpa2hva",
>          .args_type  = "addr:l",
> -- 
> 2.39.2
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

