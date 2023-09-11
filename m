Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DA679AC0D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 00:48:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfpg2-0007An-Hj; Mon, 11 Sep 2023 18:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qfpg0-0007AK-PN
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 18:46:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qfpfy-0007eT-36
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 18:46:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401b393ddd2so57418675e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 15:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694472396; x=1695077196; darn=nongnu.org;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=YL96dmKZvdhKC0kN5yR3QInj7oD1PhpHuztzwYgwRZs=;
 b=NOj4aEJDTfYyz6MYG6at/vpp5J9KPF3xN0eSwP/t2YTN9Jd2/CL0DEzZS2FkddBBya
 /c0CeQin8hqoauSmx69HjBQ9b59Qq8UKxOR66eItVawCFMcdx/yyBoiHZZsZPCV36P5O
 ZFYqzIkNzYLEbBKanYP2Mplf69VOZTd1alwhT0yvha3Rcp4e/qofxI9zWK4V+fOXd/2J
 lbPEWvPmV9h7KIU0oALuvmJrkarYoDNUCRF6luO7G6ODoxF2diqzImtadk307XtowaEc
 zrLDbxHCygMY43zTVvoooDNp8lu33hYcZqpUImex8briEPX2GmsJD5Gz8x8t4SI49Ylh
 QYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694472396; x=1695077196;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YL96dmKZvdhKC0kN5yR3QInj7oD1PhpHuztzwYgwRZs=;
 b=v/oFfCZIU94+jopc7IwwlCupwjRx9dg/pvssf2EJSzRgUlUXoIejzamtQrxVXVFZ6k
 OUqRYwibhTV2qaJZFT0EU4jnT8RewSsMhuKtWXgrcjzf8hJ7qbcLoh0soidYMTVi6S9m
 H2KShTZGmc4R49IEwPGCMJ3xjPOMXmNdX7BQLfVRUa2ogtchIS5F7DDZ/uk81c5Lp9Pd
 BSijF54227xlUxhBxO5PjHZVDUgJYlhr1+lW9xQCHEbVQEOHX35P3TMFVH9kCxsG4Odv
 84hi32zGZ5p6x4I6FwOKqjycwDRS1A8vVGSTB7ixc2AXjdi3hArbEMphZq6w33Hv4aI7
 J/gQ==
X-Gm-Message-State: AOJu0YytfYvyngCQHGMVgRkinBZYJT50LC+j7Y6MJjcLE27P08DGIA9V
 o8zUFlW5tuFNI1E8VDSV+4c=
X-Google-Smtp-Source: AGHT+IGAJILmuTqyWk4WfLNvCSNFXjhTRdWANOy77+pKE1FHmbLbakt3+zkO3KGokdfc9o9uLqUdmQ==
X-Received: by 2002:adf:ce0b:0:b0:319:785a:fce0 with SMTP id
 p11-20020adfce0b000000b00319785afce0mr10201368wrn.26.1694472396134; 
 Mon, 11 Sep 2023 15:46:36 -0700 (PDT)
Received: from karim ([197.39.181.42]) by smtp.gmail.com with ESMTPSA id
 o17-20020a5d4751000000b003197b85bad2sm11316676wrs.79.2023.09.11.15.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 15:46:35 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>
Subject: Re: [PATCH 06/32] bsd-user: Add bsd-proc.c to meson.build
In-Reply-To: <0ba04d33-b3d9-75a4-d421-17d16fc2e2ac@linaro.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-7-kariem.taha2.7@gmail.com>
 <0ba04d33-b3d9-75a4-d421-17d16fc2e2ac@linaro.org>
Date: Tue, 12 Sep 2023 01:45:04 +0300
Message-ID: <87y1hcl47j.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Richard Henderson <richard.henderson@linaro.org> wrote:

>> +elf = cc.find_library('elf', required: true)
>> +procstat = cc.find_library('procstat', required: true)
>> +kvm = cc.find_library('kvm', required: true)
>> +bsd_user_ss.add(elf, procstat, kvm)
>
> What are these for?  Particularly kvm?
>
>
> r~

It's need to link with `libprocstat`, which is need for the 
`filestat` struct definition, and it's `proc_*` functions used
is `get_filename_from_fd` function, however the function is declared
static, which emits an `unused function warning`, but compiles
successfully.

The linker errors only when the `get_filename_from_fd` is used in
`freebsd_exec_common` function.

--
Karim Taha

