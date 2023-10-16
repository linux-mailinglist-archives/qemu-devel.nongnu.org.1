Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C56CA7CADC7
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:40:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsPgt-0002j2-B1; Mon, 16 Oct 2023 11:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsPgr-0002io-NO
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:39:33 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsPgp-0006Lw-Mw
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:39:33 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40537481094so47603145e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 08:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697470769; x=1698075569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ByzgJMOurmLgc91jvmRRyWuVg1Pi9qeHUpfPYOWnlY=;
 b=UQitTORt0ftk6pqWhFRx5YnlHz0ZVdQjdGmKJkfq2rUvVwD4i0IkO4kDh7a3fIUkMp
 PBRTVfKOtntyYv7lBWTGjj4gMSWnizmCsTUC8J9KE14NaIVuKCEZ0nWlFcx8n4dovqEy
 JeMTtmj5jPJfeJwpkAKztA3C6m84rCUWTDdLWTvYCKr9q3S45uyh2BUWJsYwh6noyN9E
 /x9ujgSg37pAatXRWzoyB9rwRMgCUmAAeFKjtn7rqxaYrOKU6XRwxg5aX8+NFgaLQp+E
 Mt6aSQacn5xiAgUdJCz84/Mcw4wAqIaohRzYVlPgRYWWEXJvXf4AQuT2BLAbJ6Z1dBAG
 7aJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697470769; x=1698075569;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8ByzgJMOurmLgc91jvmRRyWuVg1Pi9qeHUpfPYOWnlY=;
 b=bOGBMxNNXdFqjHQQbPDLO6RjW1QTwvlkzlGaLZKDyXudkN7ZnXWZ31x/1af6ohH1ue
 Xh+bZod2Q2N5nzKFnMhE7bQ9d0mHzVo/Jgt9WRhA+AJqSblIrIoQBmt8e7H/onHP58uE
 NmV3u8OFx79f5EPNCDwFdA9gnbncwsz1y/mfA+EU041hFU8UMCNLXhc6yrmBS6KqkzVR
 +1ejXL4uQFvoIf8y+1S0iBmV3MNeu7qEnjH0hPqQcQRaDLU9rCupy0y6iNiCYZq3/B4t
 m98ABBoBq1avlG+PQ9Ll8UF37nhizeaUh+KrU6+e/UjW3AQBETQIORUfQTSm83CoP4mo
 QUzQ==
X-Gm-Message-State: AOJu0YysYEeAZeTOKptpefivUvfJGHJSoQVhINTECWnV71Y6jjVCPvA2
 rUMdGSdp7lEaYox3voht9TUMLQ==
X-Google-Smtp-Source: AGHT+IHys5VKZTVyId4uvlMLQh5XMeniW5NREFW1LXbbWuh/USFqE3awQkSL9GIAPoW450zsk6e1eg==
X-Received: by 2002:adf:f691:0:b0:32d:a0ab:9bae with SMTP id
 v17-20020adff691000000b0032da0ab9baemr7342101wrp.57.1697470768932; 
 Mon, 16 Oct 2023 08:39:28 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 dl1-20020a0560000b8100b0032db01a95f8sm3407844wrb.60.2023.10.16.08.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 08:39:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E5F4A1FFBB;
 Mon, 16 Oct 2023 16:39:27 +0100 (BST)
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-16-richard.henderson@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, fei2.wu@intel.com, "Vanderson M. do Rosario"
 <vandersonmr2@gmail.com>
Subject: Re: [PATCH v17 15/16] accel/tcg: Add info [tb-list|tb] commands to HMP
Date: Mon, 16 Oct 2023 16:02:22 +0100
In-reply-to: <20231003183058.1639121-16-richard.henderson@linaro.org>
Message-ID: <874jiqd1ao.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Richard Henderson <richard.henderson@linaro.org> writes:

> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
>
> These commands allow the exploration of TBs generated by the TCG.
> Understand which one hotter, with more guest/host instructions,
> and examine the guest code.
>
> The goal of this command is to allow the dynamic exploration of
> TCG behavior and code quality. Therefore, for now, a corresponding
> QMP command is not worthwhile.
>
> Example of output:
>
> ------------------------------
>
> TB id:0 | phys:0xa21f562e virt:0x0000000000000000 flags:0x00028010 0 inv/1
>         | exec:6171503732/0 guest inst cov:94.77%
>         | trans:1 ints: g:8 op:28 op_opt:24 spills:0
>         | h/g (host bytes / guest insts): 37.000000
>
> 0xa21f562e:  00002797      auipc         a5,8192           # 0xa21f762e
> 0xa21f5632:  a2278793      addi          a5,a5,-1502
> 0xa21f5636:  639c          ld            a5,0(a5)
> 0xa21f5638:  00178713      addi          a4,a5,1
> 0xa21f563c:  00002797      auipc         a5,8192           # 0xa21f763c
> 0xa21f5640:  a1478793      addi          a5,a5,-1516
> 0xa21f5644:  e398          sd            a4,0(a5)
> 0xa21f5646:  b7e5          j             -24               # 0xa21f562e
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> [rth: Split out of a larger patch]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/tb-context.h |  2 +
>  accel/tcg/monitor.c    | 91 ++++++++++++++++++++++++++++++++++++++++++
>  accel/tcg/tb-stats.c   |  2 +
>  hmp-commands-info.hx   | 14 +++++++
>  4 files changed, 109 insertions(+)
>
> diff --git a/accel/tcg/tb-context.h b/accel/tcg/tb-context.h
> index 4b1abe392b..29d87200b6 100644
> --- a/accel/tcg/tb-context.h
> +++ b/accel/tcg/tb-context.h
> @@ -35,6 +35,8 @@ struct TBContext {
>      /* statistics */
>      unsigned tb_flush_count;
>      unsigned tb_phys_invalidate_count;
> +
> +    GPtrArray *last_search;
>  };
>=20=20
>  extern TBContext tb_ctx;
> diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
> index 370fea883c..1be3218715 100644
> --- a/accel/tcg/monitor.c
> +++ b/accel/tcg/monitor.c
> @@ -15,12 +15,14 @@
>  #include "qapi/qmp/qdict.h"
>  #include "monitor/monitor.h"
>  #include "monitor/hmp.h"
> +#include "monitor/hmp-target.h"
>  #include "sysemu/cpus.h"
>  #include "sysemu/cpu-timers.h"
>  #include "sysemu/tcg.h"
>  #include "tcg/tcg.h"
>  #include "tcg/tb-stats.h"
>  #include "exec/tb-flush.h"
> +#include "disas/disas.h"
>  #include "internal-common.h"
>  #include "tb-context.h"
>=20=20
> @@ -303,10 +305,99 @@ static void hmp_tbstats(Monitor *mon, const QDict *=
qdict)
>                            RUN_ON_CPU_HOST_INT(flags));
>  }
>=20=20
> +static void hmp_info_tblist(Monitor *mon, const QDict *qdict)
> +{
> +    int max;
> +    const char *sortedby_str;
> +    GCompareFunc sort;
> +    GPtrArray *array;
> +
> +    if (!tcg_enabled()) {
> +        monitor_printf(mon, "Only available with accel=3Dtcg\n");
> +        return;
> +    }
> +    if (!tb_stats_enabled) {
> +        monitor_printf(mon, "TB statistics not being recorded\n");
> +        return;
> +    }
> +
> +    max =3D qdict_get_try_int(qdict, "number", 10);
> +    sortedby_str =3D qdict_get_try_str(qdict, "sortedby");
> +
> +    if (sortedby_str =3D=3D NULL || g_str_equal(sortedby_str, "hotness")=
) {
> +        sort =3D tb_stats_sort_by_coverage;
> +    } else if (g_str_equal(sortedby_str, "hg")) {
> +        sort =3D tb_stats_sort_by_hg;
> +    } else if (g_str_equal(sortedby_str, "spills")) {
> +        sort =3D tb_stats_sort_by_spills;
> +    } else {
> +        monitor_printf(mon, "Sort options are: hotness, hg, spills\n");
> +        return;
> +    }
> +
> +    g_ptr_array_unref(tb_ctx.last_search);
> +    tb_ctx.last_search =3D NULL;
> +
> +    array =3D tb_stats_collect(max, sort);
> +    max =3D array->len;
> +    if (max =3D=3D 0) {
> +        monitor_printf(mon, "No TB statistics collected\n");
> +        g_ptr_array_free(array, true);
> +        return;
> +    }
> +
> +    for (int i =3D 0; i < max; ++i) {
> +        TBStatistics *s =3D g_ptr_array_index(array, i);
> +        g_autoptr(GString) buf =3D tb_stats_dump(s, i);
> +        monitor_puts(mon, buf->str);
> +    }
> +
> +    /* Remember for the next "info tb" */
> +    tb_ctx.last_search =3D array;
> +}
> +
> +static void hmp_info_tb(Monitor *mon, const QDict *qdict)
> +{
> +    GPtrArray *array;
> +    int id;
> +
> +    if (!tcg_enabled()) {
> +        monitor_printf(mon, "Only available with accel=3Dtcg\n");
> +        return;
> +    }
> +
> +    array =3D g_ptr_array_ref(tb_ctx.last_search);
> +    if (!array) {
> +        monitor_printf(mon, "No TB statistics collected\n");
> +        return;
> +    }
> +
> +    id =3D qdict_get_int(qdict, "id");
> +    if (id < array->len) {
> +        TBStatistics *s =3D g_ptr_array_index(array, id);
> +        g_autoptr(GString) buf =3D tb_stats_dump(s, id);
> +        monitor_puts(mon, buf->str);
> +
> +        for (int i =3D s->tbs->len - 1; i >=3D 0; --i) {
> +            TranslationBlock *tb =3D g_ptr_array_index(s->tbs, i);
> +            if (!(tb->cflags & CF_INVALID)) {
> +                monitor_disas(mon, mon_get_cpu(mon), s->phys_pc,
> +                              tb->icount, MON_DISAS_GRA);
> +            }

I'm confused by the state I've got to:

  (qemu) info tb 0
  TB id:0 | phys:0x1f59d5918 virt=3D0 flags:0x00000051 invalid:0/1
          | exec:57340981/0 coverage:20.73%
          | trans:1 inst: g:1 op:19 op_opt:18 spills:0
          | h/g (host bytes / guest insts): 136.000000
  0x1f59d5918:  35000354  cbnz     w20, #0x1f59d5980
  (qemu) xp/5i 0x1f59d5918
  0x1f59d5918:  00000000  .byte    0x00, 0x00, 0x00, 0x00
  0x1f59d591c:  00000000  .byte    0x00, 0x00, 0x00, 0x00
  0x1f59d5920:  00000000  .byte    0x00, 0x00, 0x00, 0x00
  0x1f59d5924:  00000000  .byte    0x00, 0x00, 0x00, 0x00
  0x1f59d5928:  00000000  .byte    0x00, 0x00, 0x00, 0x00

It seems this is the kernels busy loop (so I assume resident in memory)
but trying to dump the instructions directly it fails. I assume the
physical memory address in each case is the same right?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

