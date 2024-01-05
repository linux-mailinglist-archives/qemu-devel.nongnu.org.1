Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFC6824C3D
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 01:48:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLYMW-0002cr-LG; Thu, 04 Jan 2024 19:47:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1rLYMK-0002cS-Vk
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 19:46:48 -0500
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1rLYMJ-0001Ka-7D
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 19:46:48 -0500
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7b7fdde8b98so40206539f.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 16:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704415601; x=1705020401;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cTnYoJHYewNSvnqQimJxMlD4GpM+pIR7w/tsHrXDAm0=;
 b=V4uooSi7Ly4F5YYOOmC8ZPBkZ0SK3H4InA4ws0GLpdE1ZIgfVk59LvC7qWvXgTIBnl
 r6nowAPKMsrfAVCV/gwQbpw/Ntz81UGgUFJ6zpND91H/7MT9v4ZnmX8c0mCq1lWjcSCu
 Y+GSwKPqrCaeY5K68f41xYhPhCDfylj5QRCfEpCaP46h718cjbvcb+ihTFtk5yEltfoi
 fv+o29rw61iWol77x/fk4ZZc+PCLp1+E6NwMLtcAE97pkbTNIrfM/iMay81UOXTJN3Wd
 sY8SXkZsacGho4AKc0iLXslPGOsIoWZwiPVmpcURizwBBZT0mYuZAMz4ECx0orCpeNHe
 PYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704415601; x=1705020401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cTnYoJHYewNSvnqQimJxMlD4GpM+pIR7w/tsHrXDAm0=;
 b=xBmJUO2oA9abh1DU0sfR+wVpreWH1o+bVisTv6YFJgYWZ5KJFCCitdxXd50TFmrlzn
 /L8dWttww1k+gv9qpgBvy4Rq2mvArGqYpV0wqnGsSiZQB11/a70Qz7hRgxPY283v0xLT
 KRfDD1sWhDJLP4tStChVxlQ+ZAeP6LSh3fvpZTHWdlkbb74UxV3v1NsgZnl4FHxvxwUR
 nvMar2+w7Pv6o8n9tCQTux2BpW0lv4TdMp85NDVb7sHuguVN5RCbf/Hi39jNLIPWbq/s
 nprli4rW1LSLnCDxzDvXTrAmUAwhiGonnyGhSJIdEsoaD0JLAcV64Q4GND/2NuXTh0zh
 T+Ig==
X-Gm-Message-State: AOJu0Ywh8iaczhQgXeKT+GD/K3604SGEUhMtrWyGJ2o9KDTpKvMsURY9
 oCRK0fP3DkTHCqxxfcMeZLd1Yl2/1Hg2FV0N2d02fVlNhhhZSg==
X-Google-Smtp-Source: AGHT+IFrrlK6zkGcTyx8exwKR+xRBq0XD7q1/A6jVsiRe7HvsLeDBctBpOjn3CEQ2k6D+qE5JW7mraVqTwXeFYDa+hQ=
X-Received: by 2002:a6b:3c09:0:b0:7ba:9b41:4acf with SMTP id
 k9-20020a6b3c09000000b007ba9b414acfmr1354309iob.40.1704415600960; Thu, 04 Jan
 2024 16:46:40 -0800 (PST)
MIME-Version: 1.0
References: <20240103185716.1790546-1-me@deliversmonkey.space>
 <20240103185716.1790546-4-me@deliversmonkey.space>
In-Reply-To: <20240103185716.1790546-4-me@deliversmonkey.space>
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 4 Jan 2024 16:46:29 -0800
Message-ID: <CAKC1njQwWxwSeGKVMUtUVmTkWEO-Z8zL8O20VmC+NJvUQNj94w@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d29;
 envelope-from=debug@rivosinc.com; helo=mail-io1-xd29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 3, 2024 at 10:59=E2=80=AFAM Alexey Baturo <baturo.alexey@gmail.=
com> wrote:
> +
> +bool riscv_cpu_bare_mode(CPURISCVState *env)
> +{
> +    int satp_mode =3D 0;
> +#ifndef CONFIG_USER_ONLY
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> +        satp_mode =3D get_field(env->satp, SATP32_MODE);
> +    } else {
> +        satp_mode =3D get_field(env->satp, SATP64_MODE);
> +    }
> +#endif
> +    return (satp_mode =3D=3D VM_1_10_MBARE);
> +}
> +

Assume the CPU was in S or U with satp =3D non-bare mode but then a
transfer to M-mode happened.
In that case, even though the CPU is in M mode, the above function
will return non-bare mode and enforce
signed extension on M mode pointer masking (if enabled).

right or am I missing something here?

