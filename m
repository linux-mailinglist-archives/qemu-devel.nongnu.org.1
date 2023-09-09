Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 330307995E2
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 04:02:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qenHb-0002kC-QZ; Fri, 08 Sep 2023 22:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qenHa-0002jo-52
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 22:01:10 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qenHX-0008It-NV
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 22:01:09 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-401d67434daso27897325e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 19:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694224865; x=1694829665; darn=nongnu.org;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+/+kGp157xuEU/RvkcHkHbCS3SCbIEi4+97lEjc76Ug=;
 b=nfN5XUR3wz37FS8qfnHbI1IVplwfLwKO5vTZJVHYsqvgB4bkVl9Q96Nyiz1NqnR2iR
 ABqrgdbhyk4LTbEBhXxnk63zxa9kMw+zzBX3mDEBuCABtJSd3yHhQFxwDHNWiSDZs234
 VZx/qO1h+tbanyP9iMHuQBQEbihJ4KuHGzL8pV1LojAn6zZXDjqnX+L7wBH+PDqw0Nep
 P1PY940WlDhvTEZkp1lbIFbhrEootwV58U0Rtj1D+EnixcEVauQUNPRI6fHO1ey2pFMk
 fAvCTZLgfS5VDwWlCOq+Jgm3/zTtCT/jjy2XY2BVMvxXsP1feOhw+QXMqKxv9Ic/LU9q
 ubKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694224865; x=1694829665;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+/+kGp157xuEU/RvkcHkHbCS3SCbIEi4+97lEjc76Ug=;
 b=FnxdKO6EGlwsEKGlFbRPJGSaTOxd/f2u/5ZPDeXQ1oq+yzjCQGXCSJPOEUfiRdDdpK
 njO/lsLa0ACaI8twP4/HGCkwtmTLEOvOBwhcjjth+RDZaR+t//USG+AM3BkSEzT3BM2W
 rpDTB4abQSZCeH25P0DhU/xodsvClOHP99B1NRP/d+lf/H3bW+F+VE9OwEI5P3SY9OpQ
 rta31A3ym4Nj9qLseZNNyXtvI+PsuBvpsZF6nyDkXtDqT5vm56A5Lc6sfvMpsk0vmnyp
 6hM+ppe2imQ1s+g+c7TXPCS+75flNQg5VG8QnaE0yeBaFx4ukj2bw1XSE5UvIfihUtAR
 2P+w==
X-Gm-Message-State: AOJu0YxSbmpZruz8jtAouRLGLkqHljNs21wf87ybhR/sFI1DqBD05qlO
 zxovhPdHyfTB2uRx+Ung34kpcyLdNc4=
X-Google-Smtp-Source: AGHT+IHuXTR9bjqNZR6D6hx6vQvyKhBWfCEKsB3LQQl1M8tgQlNFs33wrVUPQBQBtPOIVXRh92qicg==
X-Received: by 2002:a05:600c:ad3:b0:401:bcd9:4871 with SMTP id
 c19-20020a05600c0ad300b00401bcd94871mr3600763wmr.21.1694224864809; 
 Fri, 08 Sep 2023 19:01:04 -0700 (PDT)
Received: from karim ([197.39.120.250]) by smtp.gmail.com with ESMTPSA id
 s14-20020a7bc38e000000b00401d8181f8bsm6491728wmj.25.2023.09.08.19.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 19:01:04 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>
Subject: Re: [PATCH 20/22] Implement shmctl(2)
In-Reply-To: <ec99a998-7793-1c01-e9e5-d84c3ada68ee@linaro.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-21-kariem.taha2.7@gmail.com>
 <ec99a998-7793-1c01-e9e5-d84c3ada68ee@linaro.org>
Date: Sat, 09 Sep 2023 04:59:31 +0300
Message-ID: <875y4knm2k.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32e.google.com
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

> On 8/19/23 02:48, Karim Taha wrote:
>> +    switch (cmd) {
>> +    case IPC_STAT:
>> +    case IPC_SET:
>> +        if (target_to_host_shmid_ds(&dsarg, buff)) {
>> +            return -TARGET_EFAULT;
>> +        }
>> +        ret = get_errno(shmctl(shmid, cmd, &dsarg));
>> +        if (host_to_target_shmid_ds(buff, &dsarg)) {
>> +            return -TARGET_EFAULT;
>> +        }
>> +        break;
>
> IPC_STAT treats buff as output, IPC_SET treats buff as input,
> so these cases can't be combined.
>
>
> r~

I think they can be combined:
1- we marshal the struct `buff` from target to host
2- call `shmctl`
3- marshal the results back.

--
Karim Taha

