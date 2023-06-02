Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7682372084B
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 19:22:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q58TP-0004NQ-Kb; Fri, 02 Jun 2023 13:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q58TM-0004Mz-4r
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:21:56 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q58TK-0007UE-EU
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:21:55 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f505aace48so3192237e87.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 10:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685726512; x=1688318512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hXiNFhSr+9b/VXHo2x610ar5DpNTBJ5nCbRuUYJSapg=;
 b=p0GPVaQt3ccyws69ivY2xlqFiHjctfT39+W5ryBx1qQ3xiJv57E7dpm86uWAkWhBvF
 t9tmnqILv4Dul1R6hLKd0WFHlgk/yS1TEULiUur/pdGzt2MYEfpm2NOfD/kjFiONxF4o
 G6hv2+KV07bMKlu0q+/HvXCdGvaOyWke4WkcDpOriNtEhAEDE4YoPzgVG4/z+pDH/PDz
 0zzDhlYypNNa+NB99VTS3cDav5Su8P9/o+WuH4B/JmtGrBGGHOKe5JskUK2NRzm7knEi
 qMGIquHlXyOi2vSUf35zKzv3TQj9tYAKz61EZ01LfdRv8fb6lGI8tUlPvJFMe/jcTKo6
 XjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685726512; x=1688318512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hXiNFhSr+9b/VXHo2x610ar5DpNTBJ5nCbRuUYJSapg=;
 b=QLOvYhZzQ/gwbjhuyzy49N3f4aWjWYudDLQwgO6pPBS8V9/+3qSc+3ofSa50Yc8Mk4
 5KLKjQ8ExTkj87nvcoBqtachwO/r028Jtm38OsqZPhc7gtDm5o8iEjx/hiC4MPfsbRHm
 DScpwObmBQ9dzssckyBmHjki0lBHL8KTvTYem9eAlJgGRaSesrL1nD8MxGhZ2SxUzZqB
 6ZKPDMB1707xNrSJBtdTBAAFmxY2M0R3sSIuNtZ2yhUJQmRGdzxoM5qzMY0fp+r/qPnF
 m+1K7yftvNHl7zZ75zN9kxq5ZjguUPzQ9IANevJeHEzMoKwnVSm31ij5VIvgljWvEYEV
 45EQ==
X-Gm-Message-State: AC+VfDxegnCGVaFFwFK4BFbM3NWUlr3yQlkbBicwBvs262I8CiM83PuO
 ZxAX/nDYSndcWOXIoZU8iZL2VdIbZjowlDcY2xGiLw==
X-Google-Smtp-Source: ACHHUZ70EGntm1iZ+9Uh8iB3BBhO6POeU3+tf73y4UPn3utnPsOM0X8pgka0slmTM41C+srdfR9F98vIYMwukORQ8FY=
X-Received: by 2002:ac2:5dc3:0:b0:4f6:d9e:7c3b with SMTP id
 x3-20020ac25dc3000000b004f60d9e7c3bmr1895913lfq.44.1685726512459; Fri, 02 Jun
 2023 10:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230116223637.3512814-1-richard.henderson@linaro.org>
 <20230116223637.3512814-4-richard.henderson@linaro.org>
In-Reply-To: <20230116223637.3512814-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2023 18:21:41 +0100
Message-ID: <CAFEAcA-pb53hugPBFxkhzAz-zDAt13xhA+yXL6D7iYZbk96NtA@mail.gmail.com>
Subject: Re: [PULL 3/5] tcg: add perfmap and jitdump
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>, 
 "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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

On Mon, 16 Jan 2023 at 22:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Ilya Leoshkevich <iii@linux.ibm.com>
>
> Add ability to dump /tmp/perf-<pid>.map and jit-<pid>.dump.
> The first one allows the perf tool to map samples to each individual
> translation block. The second one adds the ability to resolve symbol
> names, line numbers and inspect JITed code.
>
> Example of use:
>
>     perf record qemu-x86_64 -perfmap ./a.out
>     perf report
>
> or
>
>     perf record -k 1 qemu-x86_64 -jitdump ./a.out
>     DEBUGINFOD_URLS=3D perf inject -j -i perf.data -o perf.data.jitted
>     perf report -i perf.data.jitted
>
> Co-developed-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Co-developed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Message-Id: <20230112152013.125680-4-iii@linux.ibm.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Hi; Coverity thinks (CID 1507521) that there's a memory leak
in this code:

> +void perf_enable_jitdump(void)
> +{
> +    struct jitheader header;
> +    char jitdump_file[32];
> +    void *perf_marker;
> +
> +    if (!use_rt_clock) {
> +        warn_report("CLOCK_MONOTONIC is not available, proceeding withou=
t jitdump");
> +        return;
> +    }
> +
> +    snprintf(jitdump_file, sizeof(jitdump_file), "jit-%d.dump", getpid()=
);
> +    jitdump =3D safe_fopen_w(jitdump_file);
> +    if (jitdump =3D=3D NULL) {
> +        warn_report("Could not open %s: %s, proceeding without jitdump",
> +                    jitdump_file, strerror(errno));
> +        return;
> +    }
> +
> +    /*
> +     * `perf inject` will see that the mapped file name in the correspon=
ding
> +     * PERF_RECORD_MMAP or PERF_RECORD_MMAP2 event is of the form jit-%d=
.dump
> +     * and will process it as a jitdump file.
> +     */
> +    perf_marker =3D mmap(NULL, qemu_real_host_page_size(), PROT_READ | P=
ROT_EXEC,
> +                       MAP_PRIVATE, fileno(jitdump), 0);

Here we mmap() something...

> +    if (perf_marker =3D=3D MAP_FAILED) {
> +        warn_report("Could not map %s: %s, proceeding without jitdump",
> +                    jitdump_file, strerror(errno));
> +        fclose(jitdump);
> +        jitdump =3D NULL;
> +        return;
> +    }
> +
> +    header.magic =3D JITHEADER_MAGIC;
> +    header.version =3D JITHEADER_VERSION;
> +    header.total_size =3D sizeof(header);
> +    header.elf_mach =3D get_e_machine();
> +    header.pad1 =3D 0;
> +    header.pid =3D getpid();
> +    header.timestamp =3D get_clock();
> +    header.flags =3D 0;
> +    fwrite(&header, sizeof(header), 1, jitdump);

...but we never do anything with that pointer, so the memory
we just mmap()ed is never going to be freed.

Is this doing something particularly magical, or should that
pointer be kept track of somewhere ?

thanks
-- PMM

