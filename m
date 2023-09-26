Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9CD7AEE08
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 15:38:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql8G4-00069s-Tz; Tue, 26 Sep 2023 09:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql8G2-000695-Uo
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 09:37:46 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql8Fx-00052R-VT
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 09:37:46 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-533c92e65c9so6772708a12.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 06:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695735459; x=1696340259; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xQx5CbxrTHZrIwtANsYdDdBPL47D84fa+LpNmg8RfHw=;
 b=Rg3HtKTD9sQmNJgxVd45ydsx+YeU2EqXVkXR/fsnIiPxNbnK15L2ONp2D/ku4S+myS
 WfOHbFVOSI7T35JzJuHDFU0tBzzcD0iy/hT9MmJUU5jUe3Tko/lWQshIrSDjAUsKc830
 Ozsh0YaN4TtQdrNaQATqBu+v0A7OtlpHXB0R6ePu+MuhceKVwRqf/WUJYQKM35w8EegO
 +F/GT5HsarNDgpyuPt9IVpX8AZglO7sRYGSVD+bfX933OYm1f8qU7fOiMQpvB8utv5kO
 Fd90W7ILCONQAY+XwBBVJiPG/vS4ovl7Wgwe+KerZVyr1KCcgWt4WDXfATIbImy05BYd
 DNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695735459; x=1696340259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xQx5CbxrTHZrIwtANsYdDdBPL47D84fa+LpNmg8RfHw=;
 b=GOn3qHaG8GNheebIuSsQLPHyPx/tWq86d8xeTwPvbFk822PQW7ed6BALiBxSnbbHDR
 8/OM8LglcMfXIKch+XJCBb9Kj5YfP+ypyQ5lm0OiZGqnzKbhYQfyAnt+465FXK4uBPiM
 wcGunHdV9yHrZ2Kxb9pfYVi8kKSiwEvv5V95HtykkWZa5eSSj3vvdVOEbnHbd6bqqbyH
 fXP507+6pXUd/QbVZgnxeKcYAP6vt0AqyDk/9y31IZmF6Y1Uoua1lZ9vm/xWV16Mz82f
 H2p/vsgMoAo0OHUvfvLCSZjwmE0P8YM4k+gbY9KNpcZBhgTgOWUiFQhnKL1uaOec0oa1
 Tu1A==
X-Gm-Message-State: AOJu0YxNP0C7NVU3U+F6mR4b/aOpI/yaVXsI+L8OCOkcz0oSEFBIBgp+
 WpEpVfL7TNbdzhHRF/Btx5Ds2ybW6urVZTkx8Cq2UA==
X-Google-Smtp-Source: AGHT+IH7c1D/VNpSeRM4ChdZr2W+lAQBKhZbF0U9F2L98hcPO8ISJ6Im99mdetxRsFRR65LrhwmDJzpzMFoEcGSVUk4=
X-Received: by 2002:a05:6402:2075:b0:534:78a6:36b3 with SMTP id
 bd21-20020a056402207500b0053478a636b3mr332497edb.5.1695735459654; Tue, 26 Sep
 2023 06:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230915170153.10959-1-viktor@daynix.com>
 <20230915170153.10959-6-viktor@daynix.com>
In-Reply-To: <20230915170153.10959-6-viktor@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 14:37:20 +0100
Message-ID: <CAFEAcA9qzNfTCn1T3Ni211kRcPhhayz4M-8XS=wLD8YzzHLNOQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] elf2dmp: rework PDB_STREAM_INDEXES::segments
 obtaining
To: Viktor Prutyanov <viktor@daynix.com>
Cc: annie.li@oracle.com, akihiko.odaki@daynix.com, kkostiuk@redhat.com, 
 qemu-devel@nongnu.org, yan@daynix.com, viktor.prutyanov@phystech.edu
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 15 Sept 2023 at 18:02, Viktor Prutyanov <viktor@daynix.com> wrote:
>
> PDB for Windows 11 kernel has slightly different structure compared to
> previous versions. Since elf2dmp don't use the other fields, copy only
> 'segments' field from PDB_STREAM_INDEXES.
>
> Signed-off-by: Viktor Prutyanov <viktor@daynix.com>

Hi; this patch has triggered Coverity to report an issue with
the code:

> ---
>  contrib/elf2dmp/pdb.c | 15 ++++-----------
>  contrib/elf2dmp/pdb.h |  2 +-
>  2 files changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
> index adcfa7e154..6ca5086f02 100644
> --- a/contrib/elf2dmp/pdb.c
> +++ b/contrib/elf2dmp/pdb.c
> @@ -160,7 +160,7 @@ static void *pdb_ds_read_file(struct pdb_reader* r, uint32_t file_number)
>  static int pdb_init_segments(struct pdb_reader *r)
>  {
>      char *segs;
> -    unsigned stream_idx = r->sidx.segments;
> +    unsigned stream_idx = r->segments;
>
>      segs = pdb_ds_read_file(r, stream_idx);
>      if (!segs) {

Here we set stream_idx from r->segments, and later in this
function we're going to call pdb_get_file_size(r, stream_idx),
which uses stream_idx as an index int o the toc->file_size[] array...

> @@ -177,9 +177,6 @@ static int pdb_init_symbols(struct pdb_reader *r)
>  {
>      int err = 0;
>      PDB_SYMBOLS *symbols;
> -    PDB_STREAM_INDEXES *sidx = &r->sidx;
> -
> -    memset(sidx, -1, sizeof(*sidx));
>
>      symbols = pdb_ds_read_file(r, 3);
>      if (!symbols) {
> @@ -188,15 +185,11 @@ static int pdb_init_symbols(struct pdb_reader *r)
>
>      r->symbols = symbols;
>
> -    if (symbols->stream_index_size != sizeof(PDB_STREAM_INDEXES)) {
> -        err = 1;
> -        goto out_symbols;
> -    }
> -
> -    memcpy(sidx, (const char *)symbols + sizeof(PDB_SYMBOLS) +
> +    r->segments = *(uint16_t *)((const char *)symbols + sizeof(PDB_SYMBOLS) +
>              symbols->module_size + symbols->offset_size +
>              symbols->hash_size + symbols->srcmodule_size +
> -            symbols->pdbimport_size + symbols->unknown2_size, sizeof(*sidx));
> +            symbols->pdbimport_size + symbols->unknown2_size +
> +            offsetof(PDB_STREAM_INDEXES, segments));

...but we initialized r->segments based on data from the file we're reading,
and we never do any kind of bounds checking on it. So we'll crash if the
file is corrupt/malicious.

Presumably there should be some sort of bounds check somewhere.

(This is CID 1521597.)

thanks
-- PMM

