Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2E47CACB8
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:00:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsP3C-0005YS-Ve; Mon, 16 Oct 2023 10:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsP3A-0005YC-CB
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 10:58:32 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsP34-0005JP-H9
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 10:58:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-406609df1a6so45009605e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697468305; x=1698073105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gchKXca8BdcNkCJLVcpk1Sa//72aI4D9Ho9Ts3dG8+k=;
 b=LTYOD+O3R/WUSSIjF1lwAHspEdptwvpmPadZdSxfL6L5kedsFAtpiduUzJuQT+wpCY
 7hH4pQbxogkjNBGJOjFGZ2akboRiDyNGSRnRlTUwLdJKBZEi7OZeMI0oBiI/b8hjQZie
 VJcdOvCcF7RJuPBp/eDyJhmMjRCBqDrflIOSglocu0Je9vk59FpUpUru6Px8ZuqkPuL/
 Qxb2Iz5nUrEwj5DU+6Jn0VaEdmDCTSvtiOW94xWTdJ5T5QPmhY0dQgU/nkX5JmmiyGjF
 ZIjNjvT2quFoOaEtayu/VT2N3ngef8L/dTBmSjJYEUORJOZaS5edZu1bEmJ3xf2Y1Q/e
 pdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697468305; x=1698073105;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gchKXca8BdcNkCJLVcpk1Sa//72aI4D9Ho9Ts3dG8+k=;
 b=WLovzJJAIV/3eRRIAGP5sfMZPcaet8qcyDaHNOvJyRu9BRgrlqrksVlwnQa8v1tgdp
 B8UUtuQotJfKGDGANqUgdWLcHJPnjlKa8sdKDIErCoBR2uziEs1xd1AC7FLcKGHAcMzu
 UnHJBBTDGhLPZztKy24vmxv5dVrSjkh8aF5l5qBh1835mf52bU69Nf32v6Ip5eK1aBJi
 IE0r0ZEbPUwYNbOGKMxqT/R4q+yYtcG7cMhe8g2HjBy8XX/2yoUaWXjq2luiIp9SvEjB
 NTFYWaSLeYnYYYCaN9oe4tx6hDvVooe7Cpsxsh6I7JDZgXfF1Agi9Avg4xpYgM3adykz
 zpIw==
X-Gm-Message-State: AOJu0YwQ51eyfmaZas3/LXpclqRN4yR085WpipJmFJjEBvLm4s059ok5
 twNZS8NoMtYtSEPmNhYthRHEdw==
X-Google-Smtp-Source: AGHT+IGRXhzNhWXIrTEwYY2+eNlcVVNAwNXRiKDkQyyQ2y9+BRoTo3BfCBWIlL5TeZrIrjsBl2DGZQ==
X-Received: by 2002:a05:600c:290:b0:406:177e:5df7 with SMTP id
 16-20020a05600c029000b00406177e5df7mr29368221wmk.29.1697468304782; 
 Mon, 16 Oct 2023 07:58:24 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n23-20020a7bcbd7000000b0040536dcec17sm7288270wmi.27.2023.10.16.07.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 07:58:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E0F161FFBB;
 Mon, 16 Oct 2023 15:58:23 +0100 (BST)
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-12-richard.henderson@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, fei2.wu@intel.com, "Vanderson M. do Rosario"
 <vandersonmr2@gmail.com>
Subject: Re: [PATCH v17 11/16] accel/tcg: Add tb_stats_collect and
 tb_stats_dump
Date: Mon, 16 Oct 2023 15:48:10 +0100
In-reply-to: <20231003183058.1639121-12-richard.henderson@linaro.org>
Message-ID: <87cyxed374.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
> These functions will be used together to output statistics.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> [rth: Split out of a larger patch]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tb-stats.h |  25 +++++++++
>  accel/tcg/tb-stats.c   | 119 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 144 insertions(+)
>
> diff --git a/include/tcg/tb-stats.h b/include/tcg/tb-stats.h
> index 1ec0d13eff..edee73b63b 100644
> --- a/include/tcg/tb-stats.h
> +++ b/include/tcg/tb-stats.h
> @@ -129,4 +129,29 @@ void tb_stats_reset_tbs(void);
>  TBStatistics *tb_stats_lookup(tb_page_addr_t phys_pc, vaddr pc,
>                                uint32_t flags, uint64_t flags2);
>=20=20
> +/**
> + * tb_stats_collect:
> + * @max: maximum number of results
> + * @sort: sort function
> + *
> + * Collect all TBStatistics and return the first @max items,
> + * as dictated by the sort criteria.
> + */
> +GPtrArray *tb_stats_collect(unsigned max, GCompareFunc sort);
> +
> +/* Sort functions for tb_stats_collect. */
> +gint tb_stats_sort_by_spills(gconstpointer, gconstpointer);
> +gint tb_stats_sort_by_coverage(gconstpointer, gconstpointer);
> +gint tb_stats_sort_by_hg(gconstpointer, gconstpointer);
> +
> +/**
> + * tb_stats_dump:
> + * @s: structure to dump
> + * @index: label to emit
> + *
> + * Return a string with the rendering of the data in @s;
> + * @index is included in the output.
> + */
> +GString *tb_stats_dump(TBStatistics *s, unsigned index);
> +
>  #endif /* TCG_TB_STATS_H */
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> index 424c9a90ec..b2c9445b67 100644
> --- a/accel/tcg/tb-stats.c
> +++ b/accel/tcg/tb-stats.c
> @@ -83,3 +83,122 @@ TBStatistics *tb_stats_lookup(tb_page_addr_t phys_pc,=
 vaddr pc,
>      }
>      return s;
>  }
> +
> +static void tb_stats_collect_iter(void *p, uint32_t hash, void *u)
> +{
> +    g_ptr_array_add(u, p);
> +}
> +
> +static void calculate_coverages(GPtrArray *array)
> +{
> +    double total_exec_count =3D 0;
> +    guint i, n =3D array->len;
> +
> +    for (i =3D 0; i < n; ++i) {
> +        TBStatistics *s =3D g_ptr_array_index(array, i);
> +        double avg_insns =3D 1;
> +        double exec_count;
> +
> +        if (s->translations.total) {
> +            avg_insns =3D s->code.num_guest_inst / (double)s->translatio=
ns.total;
> +        }
> +        exec_count =3D ((double)s->executions.atomic + s->executions.nor=
mal)
> +                     / avg_insns;
> +        s->executions.coverage =3D exec_count;
> +        total_exec_count +=3D exec_count;
> +    }
> +
> +    for (i =3D 0; i < n; ++i) {
> +        TBStatistics *s =3D g_ptr_array_index(array, i);
> +        s->executions.coverage /=3D total_exec_count;
> +    }
> +}
> +
> +GPtrArray *tb_stats_collect(unsigned max, GCompareFunc sort)
> +{
> +    GPtrArray *array =3D g_ptr_array_new();
> +
> +    /*
> +     * Collect all TBStatistics and sort.
> +     * Note that coverage data requires both execution and jit collectio=
n.
> +     */
> +    qht_iter(&tb_ctx.stats, tb_stats_collect_iter, array);
> +    calculate_coverages(array);
> +    g_ptr_array_sort(array, sort);
> +
> +    /* Truncate to the first MAX entries. */
> +    if (max < array->len) {
> +        g_ptr_array_set_size(array, max);
> +    }
> +    return array;
> +}
> +
> +gint tb_stats_sort_by_spills(gconstpointer p1, gconstpointer p2)
> +{
> +    const TBStatistics *s1 =3D *(TBStatistics **)p1;
> +    const TBStatistics *s2 =3D *(TBStatistics **)p2;
> +    double c1 =3D (double)s1->code.spills / s1->translations.total;
> +    double c2 =3D (double)s2->code.spills / s2->translations.total;
> +
> +    return c1 < c2 ? 1 : c1 =3D=3D c2 ? 0 : -1;
> +}
> +
> +gint tb_stats_sort_by_coverage(gconstpointer p1, gconstpointer p2)
> +{
> +    const TBStatistics *s1 =3D *(TBStatistics **)p1;
> +    const TBStatistics *s2 =3D *(TBStatistics **)p2;
> +    double c1 =3D s1->executions.coverage;
> +    double c2 =3D s2->executions.coverage;
> +
> +    return c1 < c2 ? 1 : c1 =3D=3D c2 ? 0 : -1;
> +}
> +
> +gint tb_stats_sort_by_hg(gconstpointer p1, gconstpointer p2)
> +{
> +    const TBStatistics *s1 =3D *(TBStatistics **)p1;
> +    const TBStatistics *s2 =3D *(TBStatistics **)p2;
> +    double c1 =3D (double)s1->code.out_len / s1->code.num_guest_inst;
> +    double c2 =3D (double)s2->code.out_len / s2->code.num_guest_inst;
> +
> +    return c1 < c2 ? 1 : c1 =3D=3D c2 ? 0 : -1;
> +}
> +
> +GString *tb_stats_dump(TBStatistics *s, unsigned index)
> +{
> +    unsigned n =3D s->tbs->len;
> +    unsigned invalid =3D 0;
> +    GString *buf;
> +
> +    for (unsigned i =3D 0; i < n; ++i) {
> +        TranslationBlock *tb =3D g_ptr_array_index(s->tbs, i);
> +        if (tb->cflags & CF_INVALID) {
> +            invalid +=3D 1;
> +        }
> +    }
> +
> +    buf =3D g_string_new("");
> +    g_string_append_printf(buf,
> +        "TB id:%u | phys:0x" TB_PAGE_ADDR_FMT " virt=3D%" VADDR_PRIx
> +        " flags:0x%08x invalid:%u/%u\n",
> +        index, s->phys_pc, s->pc, s->flags, invalid, n - invalid);

This is a little unclear in the output maybe:

  flags:0x%08x translations:%u (of which %u invalidated)

and adjust the names appropriately?

> +
> +    if (tb_stats_enabled & TB_STATS_EXEC) {
> +        g_string_append_printf(buf,
> +            "\t| exec:%lu/%lu coverage:%.2f%%\n",
> +            s->executions.normal, s->executions.atomic,
> +            s->executions.coverage * 100);
> +    }
> +
> +    if (tb_stats_enabled & TB_STATS_JIT) {
> +        g_string_append_printf(buf,
> +            "\t| trans:%lu inst: g:%lu op:%lu op_opt:%lu spills:%ld\n"
> +            "\t| h/g (host bytes / guest insts): %f\n",
> +            s->translations.total,
> +            s->code.num_guest_inst / s->translations.total,
> +            s->code.num_tcg_ops / s->translations.total,
> +            s->code.num_tcg_ops_opt / s->translations.total,
> +            s->code.spills / s->translations.total,
> +            (double)s->code.out_len / s->code.num_guest_inst);
> +    }
> +    return buf;
> +}


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

