Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D17D756C9D
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 20:58:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLTPi-0001cn-Jy; Mon, 17 Jul 2023 14:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qLTPg-0001YV-7t
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 14:57:40 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qLTPd-0001oh-Ky
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 14:57:39 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82dc7so45146595e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 11:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689620256; x=1692212256;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y6RwSQQBJv70W2PiSXys7NHQn8u2poOC27YnL1I1LpU=;
 b=J/gpMQy5l8cALp9ZGZLhu6F+Bu/7yhLQv6MOR+h/QvbgaMLy4ZZaNw4O0rvOyu6h8I
 vPqaFHVDkfFSz1ZM+pygXbBeKyQifgp8ZyHsnoT1zpxmMdEhTrO3yNlzpi+rJ/O4ihkY
 4mwHrRqqsVY6wmu7i05NxZH0vSPTX0whpClH35E7qPbbLlUUk1075SCm2Rz6UK4FXuaM
 Ypr73Xu7+OPJpcor9yMgLwbRtJ0mqRuo9J8UzBN9xMY4dis7wexwDZUx71sN0XHtgi3P
 3e45oTPGZLsrX0DTtuQbrWk5kdPHpFasgDk1b5kqc01W9ivzvmiVS13ShejbV+c+sG97
 dBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689620256; x=1692212256;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y6RwSQQBJv70W2PiSXys7NHQn8u2poOC27YnL1I1LpU=;
 b=KrBWXzQcAzFJqdGr8so3eAyUfXoPhQxHd+NqS2JZ5XY1INOFwhDx6ISetOZ1APJkE0
 hHenETSFplwQnV9b/9FXjPfdmAZsSKMfXSbC52jRCiQ/Ic5rA986wwQizcZgxuHrS3us
 hK4gkjjl4Fy7A9MWJ7ek4ogfrDoNvytDJuwcFk4sfroz1KKSGB/PebnhWsRvLBfn/85v
 2wxKH+sPGKjvlH/j3hRuO/Yfg+rDUtM0c8eIS6rEf6BbqAbLrTToKpckFu4cxBt99FT9
 YgwdTzGk8RFM6l+qyPuMyhGwdQYZeYCS2mmzawPIJ34WlN2opggZ9Z60NQhQOoOUYs9k
 eyvQ==
X-Gm-Message-State: ABy/qLbViIR3yeAc6vjvBuz3wPIsYM4FsLtoWk3ZDd3HpCA6v7iCqzxx
 dblOPkhjpQpW2r2ur/BA5XPbfw==
X-Google-Smtp-Source: APBJJlF9K4IUKf7Qfw8RWFzXwOqOsLgZ6pZ7eQsmmy3Ne+aC5VHOz9N2O9/8OiiRYDvjqD/0lsSZ2Q==
X-Received: by 2002:adf:d092:0:b0:314:220d:7 with SMTP id
 y18-20020adfd092000000b00314220d0007mr65282wrh.45.1689620255573; 
 Mon, 17 Jul 2023 11:57:35 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 r17-20020adfe691000000b0031444673643sm197685wrm.57.2023.07.17.11.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 11:57:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5BD101FFBB;
 Mon, 17 Jul 2023 19:57:34 +0100 (BST)
References: <20230716170150.22398-1-richard.henderson@linaro.org>
 <878rbeyg5m.fsf@linaro.org>
 <10893737-8628-672d-af7d-7d959d1773f5@linaro.org>
User-agent: mu4e 1.11.9; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.1] accel/tcg: Take mmap_lock in load_atomic16_or_exit
Date: Mon, 17 Jul 2023 19:57:29 +0100
In-reply-to: <10893737-8628-672d-af7d-7d959d1773f5@linaro.org>
Message-ID: <875y6iweld.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/17/23 11:40, Alex Benn=C3=A9e wrote:
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>=20
>>> For user-only, the probe for page writability may race with another
>>> thread's mprotect.  Take the mmap_lock around the operation.  This
>>> is still faster than the start/end_exclusive fallback.
>> Did we have a bug report or replication for this?
>
> See the comment:
>
>> +         * We must take mmap_lock so that the query remains valid until
>> +         * the write is complete -- tests/tcg/multiarch/munmap-pthread.c
>> +         * is an example that can race.

doh...

>
>
> r~


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

