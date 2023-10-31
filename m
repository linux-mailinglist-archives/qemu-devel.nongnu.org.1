Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DD67DC3C1
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 02:04:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxd9t-0005bU-2s; Mon, 30 Oct 2023 21:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qxd9q-0005b7-Ev
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 21:03:02 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qxd9n-0006Ij-Cy
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 21:03:02 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9c3aec5f326so1294350066b.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 18:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1698714174; x=1699318974; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxgN3j4+/t0Om4aW95uoZQaDkJDAaqhRa/qS7kB5ET8=;
 b=Ani0OkDYsHPzGVEmKjV1uFnmim5sGsLNDFU+NCxNRvWYgwSx3iYV/WdUYEljH8vhJv
 NYO2Xx14yL3TbXHsqyIQp9xMLzMmWJX/hDNkt+cyQVQ87stGHUGMee9mzVwO2C24pQ5z
 TW3mX5BXAymmossRW48h1QJMMJLYqMx8jpbg/DNuMAzxeFklw1Jq+elFpg0hTC6785Rb
 9mgNeMN/LaFc8cetPDEN17E9nOpAuhQXvir64A11gPQr7STByAAUBRF06ZD5OzyI7ls6
 jomLslwr+jDxTSS/PVWda8jOPWhW6X1+nsFIHCkVZz+KjWULYHQ6y7RqjW+PjAF5v7Ul
 7F6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698714174; x=1699318974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZxgN3j4+/t0Om4aW95uoZQaDkJDAaqhRa/qS7kB5ET8=;
 b=DsPvpu45WHQ9NJ7Ok8gUeCFFmGlKZ8dKQPPWNzio2y/O9bZzbSnMdA8KPci15DY3At
 f8OglJY+NypLXuY7C01e4DyHdoDbMkAMJpaxC5aE0XyaMSMvGvzQMzHinWD+znyKYrm7
 tm3/hwGJR/y79aCYls1kbhy3ElMDEtuUSavuOstuiRqY0oKqymOk1HkK0R6wAlxQDhcI
 KyjNZOQMY24htNfcXLNxPfrb/uopdEatkpolhMZtc1N8pdYA2wtaQL89cUXJGbqL5C84
 OACzE4C06l34H7FtY9qaiV5XTZtqLT+SK6ywswlmKwPU6BMZL6beoTvTUSUxgy/jvm3g
 +HGA==
X-Gm-Message-State: AOJu0Yz0WgD8R7c1Pokqwymm2zDiRS/eOiCzSU7lfOLf31MntwYoqh8i
 2yipRsok3zie2fQs5QzKAhiP9cOmINO4z405GmX+tg==
X-Google-Smtp-Source: AGHT+IHiFahy5+fZbusRGK/8U01/4M1G3fUVpDkXCREHcmyVDt3+NCJiFk2FVI7/M6fBB8ogI77+ZhcswrN4DeVQeEs=
X-Received: by 2002:a17:907:da9:b0:9b2:bdbb:f145 with SMTP id
 go41-20020a1709070da900b009b2bdbbf145mr1187520ejc.34.1698714174620; Mon, 30
 Oct 2023 18:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
 <875y2onnbh.fsf@suse.de>
In-Reply-To: <875y2onnbh.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Mon, 30 Oct 2023 18:02:43 -0700
Message-ID: <CAAYibXghK5V1iT2AJ+vZ3gwNMm3_mfSmDHpBZx7m0nYvTKdwKA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 00/16] Use Intel DSA accelerator to offload
 zero page checking in multifd live migration.
To: Fabiano Rosas <farosas@suse.de>
Cc: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com, 
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x633.google.com
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

On Mon, Oct 30, 2023 at 8:26=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > * Background:
> > I posted an RFC about DSA offloading in QEMU:
> > https://patchew.org/QEMU/20230529182001.2232069-1-hao.xiang@bytedance.c=
om/
> >
> > This patchset implements the DSA offloading on zero page checking in
> > multifd live migration code path.
> >
> > * Overview:
> > Intel Data Streaming Accelerator(DSA) is introduced in Intel's 4th gene=
ration
> > Xeon server, aka Sapphire Rapids.
> > https://01.org/blogs/2019/introducing-intel-data-streaming-accelerator
>
> Btw, this link seems to be broken.
>

Thanks for reviewing the code. I will address all your comments in an
updated patchset.

