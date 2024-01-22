Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C93B583625C
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 12:45:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRsjf-0004Kf-N5; Mon, 22 Jan 2024 06:45:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRsjZ-0004JR-DS
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 06:44:57 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRsjX-0004sZ-GE
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 06:44:57 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so3302276a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 03:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705923893; x=1706528693; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YuYWbSwTik+hhs++MPAjkzQJq1wD4hmbUDCVCg3RcxI=;
 b=cxhKYoP3ARPiwD3mJjfIBDawAnZgDpbYXYIKEYpIHzBk7qXSc5VyjbGV7bFs3regNO
 xA0uoCFuaytsU4ji08qjaNoZpKXcNjtPfH6g2gBytx+0NQVsE9vp7/zgFrkflZXy1kB4
 8WBxvJH1JuXT3vwPB477f8kQahXicuX+dkDSo435B8atDTslMjKYgf8nPDoXt9YePh5v
 SnOsidBk+4GZ8/w3q4KOaNuiRFuJ06KlML7dJfjzfd8k6nOE972FSyLqqyAidUJKFU7f
 w1knm5ryzBhQtW7H4D0q2y4C5mf1isC/2IpRl2J+/TkviLTnlcmArs6MLfRWoF2kFEUb
 x8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705923893; x=1706528693;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YuYWbSwTik+hhs++MPAjkzQJq1wD4hmbUDCVCg3RcxI=;
 b=nTwovcCsDDO4CfBlKl4MffsSNP65v0DrAzE1XG84G1IAs0ciMsvdbPd3KN26Ul3Ohn
 uKMVtvPJWQTOUHUCmLh8Qmaq9lskNnTa1Ra5kIZRX/1b5N3hKSgN923P8bACiYvE9OBb
 MIZ9gN6LV9wxYNvRGYsrI1EZ1zm4OxeIfpXlOmQ0+pPFdar/F+BnzkPJTAVcoe8FfkKb
 JDXMajijnrg2qlbn9vqaxGWqsFbGlc4GVhB8v+AfChSZ0A+7GXlfuRbvC7z93KQmGHjI
 bVts6pwFE3E39FALVnpUplwk4asc2wX/z0a85DGyamLUrMem4KiDIgpwGwtWrRPJsSMR
 7Xog==
X-Gm-Message-State: AOJu0Yz9RWXqv4+ZsR3TAmA/OxabjfC8PaNgT2/3IjulYDtM99Mkr8+C
 8JAzu/h9tEwXj2JivcGDczKB9u0ch3kZHjLoUExaaZriaqtke5820ZmU1CtefH8eOD0CCTEFSjX
 0wyr9kSCI+OiyxjeNFMe10krggXWLuZyXpYAGYg==
X-Google-Smtp-Source: AGHT+IHxqTIMmIYoDOmDBXkaKjxBmXp97zTrSn/zrbMHRs/M1Q4TTGFNfAUPIdlVqXLRj971FEyOGVuy9d41zvizaIc=
X-Received: by 2002:a05:6402:b03:b0:55a:3b6d:dd16 with SMTP id
 bm3-20020a0564020b0300b0055a3b6ddd16mr2130756edb.17.1705923893619; Mon, 22
 Jan 2024 03:44:53 -0800 (PST)
MIME-Version: 1.0
References: <20240119181327.236745-1-kwolf@redhat.com>
 <CAFEAcA9eR1Hs9CUu7MTdMsc93kUXt_btzS364AaO6V1axn5P8g@mail.gmail.com>
 <Za5OL56iirwteiEe@redhat.com>
In-Reply-To: <Za5OL56iirwteiEe@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2024 11:44:42 +0000
Message-ID: <CAFEAcA8N1K-KXjA2THKaOPsDMJN45ZL1L7X1jizp=VJ+SpqTiQ@mail.gmail.com>
Subject: Re: [PULL 00/14] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, ira.weiny@intel.com, 
 Jonathan.Cameron@huawei.com, mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 22 Jan 2024 at 11:15, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 20.01.2024 um 18:21 hat Peter Maydell geschrieben:
> > Got some compile failures on this one; looks like the compiler
> > on our s390 box didn't like this:
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/5973441293
> > https://gitlab.com/qemu-project/qemu/-/jobs/5973441291
> > https://gitlab.com/qemu-project/qemu/-/jobs/5973441330
> >
> > In file included from ../include/qemu/host-utils.h:33,
> > from ../include/qemu/bitops.h:16,
> > from ../include/qemu/timer.h:4,
> > from ../include/block/aio.h:24,
> > from ../include/block/aio-wait.h:28,
> > from ../include/block/block-io.h:27,
> > from ../block/blklogwrites.c:15:
> > ../block/blklogwrites.c: In function =E2=80=98blk_log_writes_co_do_log=
=E2=80=99:
> > ../include/qemu/bswap.h:148:36: error: left shift count >=3D width of
> > type [-Werror=3Dshift-count-overflow]
> > 148 | ((((_x) & 0x00000000000000ffU) << 56) | \
> > | ^~
> > ../block/blklogwrites.c:409:27: note: in expansion of macro =E2=80=98co=
nst_le64=E2=80=99
> > 409 | .nr_entries =3D const_le64(0),
> > | ^~~~~~~~~~
> > ../include/qemu/bswap.h:149:36: error: left shift count >=3D width of
> > type [-Werror=3Dshift-count-overflow]
> > 149 | (((_x) & 0x000000000000ff00U) << 40) | \
> > | ^~
> > ../block/blklogwrites.c:409:27: note: in expansion of macro =E2=80=98co=
nst_le64=E2=80=99
> > 409 | .nr_entries =3D const_le64(0),
> > | ^~~~~~~~~~
> > cc1: all warnings being treated as errors
>
> Looks like const_le64() introduced in commit 845d80a8 is buggy. I wonder
> why we even added it when there is no user of it (this blklogwrites one
> is the first one, so it exposes the error).
>
> Of course, 0 is just as good as const_le64(0), so I'll just change it to
> that for now. But I suppose const_le64() should either be fixed (and
> used by something) or removed.

Using ULL as the suffix on the constants in the macro should
be sufficient to fix the problem, I suspect.

-- PMM

