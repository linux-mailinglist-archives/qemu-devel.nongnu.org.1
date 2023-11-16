Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DF07EE63B
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 18:56:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3gb5-0008Bt-KB; Thu, 16 Nov 2023 12:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r3gb2-0008Bg-E4; Thu, 16 Nov 2023 12:56:08 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r3gb0-00059C-9L; Thu, 16 Nov 2023 12:56:08 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50a938dd873so1657880e87.3; 
 Thu, 16 Nov 2023 09:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700157364; x=1700762164; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4NwNpGC8Scjjdim/USlCb7d4yzddiUu3ZLjqBdMvoM=;
 b=CtctmbIbOivHq4f42Tab0hyk1cwF90LCo/E9phiVdhs/PTY9gSTnmQZhsyntBXUubt
 6DZnuZUaEa6V24HxYMyNZFt9z5DVXQJVA+N7Z0VRtPcB1CMKjFCVw5ZeCOoo90rQSoq8
 Q6po3rRVxTJqDEfyhQZ/WramUC1qWGxgJvywsV4NhFz1MbYSu19XZPSvpFL1MN4dHbT1
 2VbKub5kY7Um6LhZxejSiOVE9UNvgpYl1eOc2LELXDWx6D99wNLKN1gYwFkElmYzBkJi
 7kV62hX5Jo5wencL7oHZ8PLd0yd5bC4ENxU0/5ZD7n5Oo6crbL5/Z5LkfcwzhzNZBsJW
 TZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700157364; x=1700762164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P4NwNpGC8Scjjdim/USlCb7d4yzddiUu3ZLjqBdMvoM=;
 b=ithT+8iqv/EET8MA5c0OoNoT/XeXrTd5hKWGh11FwzFbZQ25D/GnYJkHVsKAandork
 aNVxR6CemeU7yFkh+u3gax5NdvuOU5tDoUCP1ae6jfQt6ZsFDOUxyvibSiW/ZIZLeotm
 5Dmtq9bRpQ8vT8iA56lq9Ylf6yL9q7zLB0qy4rG2AwZT9NWnY2mplPWPmUXNxyx9jbf5
 MfU8nWo6DEQN+rCbqrj4cg5X7YOaEiBp3/hZgv2+i09sh2mi6u0TmP1BGuyStOstqSt0
 RHcy/ERyRvhdyOPhFBg2Kk0JJrRMWLp2ufAKwPxlgoHvhJS9Nv4U5sjM/4vWaz7AUSSa
 lncg==
X-Gm-Message-State: AOJu0YxjrUTAHxlDNCxNgcTH6We3Kehbj18nN6OtK4GJ8+ewi4OzgAq9
 wRg++sCpu+gl/OMtI6HkYMwv3Re17y+Izc9N4zI=
X-Google-Smtp-Source: AGHT+IGTarWtDEhpLQJ31GEqrc+mqXA76dmp7DKeVuptr2fZv71IxuqbEDGbYPNkL4PvN9cFrJUSKhoEPquzfUrI4dU=
X-Received: by 2002:a05:6512:e99:b0:507:c872:7f84 with SMTP id
 bi25-20020a0565120e9900b00507c8727f84mr13718890lfb.29.1700157362960; Thu, 16
 Nov 2023 09:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20231030121847.4522-1-faithilikerun@gmail.com>
 <20231030121847.4522-3-faithilikerun@gmail.com>
 <20231102103128.GC726730@fedora>
In-Reply-To: <20231102103128.GC726730@fedora>
From: Sam Li <faithilikerun@gmail.com>
Date: Fri, 17 Nov 2023 01:55:36 +0800
Message-ID: <CAAAx-8K-qpE0o__==Znus_W53zd5uzKaWG28F4_nk_s6YoxmoQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] qcow2: add configurations for zoned format
 extension
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 dlemoal@kernel.org, hare@suse.de, 
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=faithilikerun@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=883=E6=
=97=A5=E5=91=A8=E4=BA=94 11:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Oct 30, 2023 at 08:18:45PM +0800, Sam Li wrote:
> > +typedef struct Qcow2ZoneListEntry {
> > +    QLIST_ENTRY(Qcow2ZoneListEntry) exp_open_zone_entry;
> > +    QLIST_ENTRY(Qcow2ZoneListEntry) imp_open_zone_entry;
> > +    QLIST_ENTRY(Qcow2ZoneListEntry) closed_zone_entry;
>
> Where is closed_zone_entry used?

When the number of implicitly open zones are reaching the max
implicitly open zone and one implicitly open zone is closed, it will
add one closed zone to closed_zone_entry. (Will be in the next
version)

