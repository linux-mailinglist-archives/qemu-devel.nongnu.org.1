Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4319E822C7B
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 12:58:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKzrz-0004Oy-N1; Wed, 03 Jan 2024 06:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rKzrx-0004OX-U6
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 06:57:09 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rKzrw-0003sR-92
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 06:57:09 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2cd0d05838fso17956581fa.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 03:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704283026; x=1704887826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvoZ6IgDrB3aQFjwPkQf+HcJNunkFL1LrGDQmKGB5+8=;
 b=riL00rJLVqzCyTQjMFLnov/smbBS1IAByGuylr+uXhHfdL63csL9YiEtU5f0X4NZs1
 vMaXyhZP4mMG7g5X0I8CoV1Y2D+VDJCjM9upHzgVMq77/bUNqkO2fRsc4NVxoyIU470h
 rqEU6I5M3sEToenpt/lmVIUotdbV4d2or2yYuwTrhj8EBFimznvtr4rpAteWK7rbb6xK
 v4L27B4LhBlU6kHex9xs673AxlTVq+urqFpAzt+aeU5qDtoKpqVY1oulsl+5d7QdLlDI
 yzsxvEQdiMicdJmvBgsQ60b63/uQ/v8FkJ40TS0Hspx3qwBAzKJ7v9c3BUImMpYfmPXu
 ktfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704283026; x=1704887826;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yvoZ6IgDrB3aQFjwPkQf+HcJNunkFL1LrGDQmKGB5+8=;
 b=hntplOB06e2S6FTvca4w1uTn/kYu2qEFqzJkVzAp/eV3tmWW4M5fcxcZBxbtjRssRO
 +EdYqZbCX3sLXfSKo9iLadDY0G/4RWrtsDqUtocoy+TbwbpfV2wfSQgxQBUpvNE5m2+v
 qtNQhXnfaPlq76Jmz//YK2hSYJNkRq73TUWVrUC0kKgCof5Re+EqFzIORjHhcEQmOQvy
 uTcAaZ4G5Xn9oFtiZ0zklzhV/JW6lmGWOrxCxyUbyTunIKIfEcgn5KK5HwbKPoW5sx8H
 kqEKZwxVsu+j8P5lR89kyjb6odRDHVjSkTSCrr+E5dz/YXhiQUmIvb3CgmJD0Z8tFVof
 pS4g==
X-Gm-Message-State: AOJu0YxHjcKxJyMTqO7lyK81VKaioh/LZYU9BpxQuHaFwI0YOt878G4h
 6V4TWh4wezsOdXs5QXwL6bxTOUp+xZBk1CH6MUGcbx4erMQ=
X-Google-Smtp-Source: AGHT+IEdyb6f0eHjb2sD00WNEz6gAUV2d85DOCgzRgwLsNo5GWOsNfV9cjRM0H+odAY1FbbW4ZDsOg==
X-Received: by 2002:a2e:9296:0:b0:2cc:d616:ff9b with SMTP id
 d22-20020a2e9296000000b002ccd616ff9bmr5102868ljh.46.1704283025609; 
 Wed, 03 Jan 2024 03:57:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z13-20020adfe54d000000b00333359b522dsm30794294wrm.77.2024.01.03.03.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 03:57:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B6DFA5F926;
 Wed,  3 Jan 2024 11:57:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>,  qemu-devel@nongnu.org,  Stefan
 Hajnoczi <stefanha@redhat.com>
Subject: Re: QEMU developers call
In-Reply-To: <ZZS9-H2g6qjlY-4_@x1n> (Peter Xu's message of "Wed, 3 Jan 2024
 09:52:56 +0800")
References: <87mstno2ob.fsf@secure.mitica> <ZZS9-H2g6qjlY-4_@x1n>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Wed, 03 Jan 2024 11:57:04 +0000
Message-ID: <87ttnuhbov.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22a.google.com
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Jan 02, 2024 at 10:17:40PM +0100, Juan Quintela wrote:
>>=20
>> Uv
>>=20
>> As I am leaving QEMU development, I can't handle this call.  Should
>> anyone take care of it?
>>=20
>> I have talked about this with Peter, and I think that if nobody steps
>> up, he can "volunteer" to handle it.
>>=20
>> Later, Juan.
>
> If I'd make a list of good candidates, I'll probably be the last one out =
of
> tens, especially considering my current timezone. :-D
>
> Take care, Juan.
> --=20
> Peter Xu
> # tr 'U-ZA-Tu-za-t' 'H-ZA-Gh-za-g'

Another way of saying M-x rot13-region ;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

