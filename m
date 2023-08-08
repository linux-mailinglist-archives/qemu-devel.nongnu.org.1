Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D91A773974
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 11:51:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTJLp-00070e-V2; Tue, 08 Aug 2023 05:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTJLn-00070H-Jr
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 05:50:03 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTJLl-0003GO-QP
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 05:50:03 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso4280454f8f.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 02:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691488199; x=1692092999;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=do4WnFVUDDoOjEbH8IUFNqvX6tUZ2PmSFU0bA3iLv3k=;
 b=xglJluawgZ57+kO5oPMxMWIAxtqK2Bp/kpwkaRdglc0U2/M+lGRqF1+Nd1/ICkA4oc
 r0WZuyYazZCFKgej+rf7e82DYqqoeDCuVmgBPowwS9GNEq+gtS9braoKWJ8o2EJA4LGo
 INcpFOVfyEq8M6ttuljrLYd32CqLHPD2v3ZOVcw3jmGSUgY4ocY0ApilUXQOkv6Kx56A
 P0WSl8xzZQ0dPuRFfWS/J8bULf1DJt3jo2nOQh1WDouHMEJ3kwGJ9npBk4LJj7MX4+qk
 1JPESs4TD/vIM9SKiBcxHg6mKu87lbjNFkc/LVVtf0HDGlvqi+3NVnbe5XBbkFXYerlS
 45UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691488199; x=1692092999;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=do4WnFVUDDoOjEbH8IUFNqvX6tUZ2PmSFU0bA3iLv3k=;
 b=d6GZRtt3gsNC0fw4Puug0eu4xOHHvtpocA9ofbcmI3SkiI+iVXy4rMZarDtt3Wgxwu
 j+E0HLEHKRPStpbYlMEB2xO1xPN4DeKuw2BrzytBK8Z8FKaRt+LArfaudMxWH4l4Zhdj
 u8jPAqrFmfrz1guFF2+DdkXtMxFfuiTjMz4G1zCPWXi3+wCmdwRkFaaR3A0vr/F0A9ht
 Scvo4IjGfamt6iYd8Gku6sj11Rw2LXIZzl7s/EeVTPXPHb3Kl0rzSKqskDgC2bpbTaja
 HHSIqLT/DuX2HJ8IJwRTvEFvrRU6w9S/NP6kaYdfhABVKJPgcW4b5qJ0tKn4cEY5Igd7
 enWA==
X-Gm-Message-State: AOJu0Yx5YClPGbfB4FEdrvSF7wZZkB2qF6zr7V/cwjizigCNh6WRzy4i
 u++BtIvPxd801o34BsVFhUk/rg==
X-Google-Smtp-Source: AGHT+IFP2rmGBioFfWiGJjPc6kS/Yc4PFSjvaJoxGfG0Y5/7bAjc5/NvtPsJsDXMZfp5uRvf+/Wx7A==
X-Received: by 2002:a5d:4e04:0:b0:313:e559:2d4c with SMTP id
 p4-20020a5d4e04000000b00313e5592d4cmr7094224wrt.45.1691488199632; 
 Tue, 08 Aug 2023 02:49:59 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x11-20020adfffcb000000b0031779e82414sm13171975wrs.79.2023.08.08.02.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 02:49:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CC7141FFBB;
 Tue,  8 Aug 2023 10:49:58 +0100 (BST)
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-6-richard.henderson@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu,
 deller@gmx.de, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.1 v10 05/14] linux-user: Use elf_et_dyn_base for
 ET_DYN with interpreter
Date: Tue, 08 Aug 2023 10:49:36 +0100
In-reply-to: <20230807163705.9848-6-richard.henderson@linaro.org>
Message-ID: <87jzu5983d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

> Follow the lead of the linux kernel in fs/binfmt_elf.c,
> in which an ET_DYN executable which uses an interpreter
> (usually a PIE executable) is loaded away from where the
> interpreter itself will be loaded.
>
> Tested-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
<snip>
> @@ -3155,13 +3178,13 @@ static void load_elf_image(const char *image_name=
, int image_fd,
>       *
>       * Otherwise this is ET_DYN, and we are searching for a location
>       * that can hold the memory space required.  If the image is
> -     * pre-linked, LOADDR will be non-zero, and the kernel should
> +     * pre-linked, LOAD_ADDR will be non-zero, and the kernel should
>       * honor that address if it happens to be free.
>       *
>       * In both cases, we will overwrite pages in this range with mappings
>       * from the executable.
>       */
> -    load_addr =3D target_mmap(loaddr, (size_t)hiaddr - loaddr + 1, PROT_=
NONE,
> +    load_addr =3D target_mmap(load_addr, (size_t)hiaddr - loaddr + 1, PR=
OT_NONE,
>                              MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
>                              (ehdr->e_type =3D=3D ET_EXEC ? MAP_FIXED_NOR=
EPLACE : 0),
>                              -1, 0);

See previous comment about verifying address.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

