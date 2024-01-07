Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 027CE8262EB
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 06:07:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMLMq-0006kf-Nx; Sun, 07 Jan 2024 00:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@trasno.org>)
 id 1rMIXg-0003oy-IY
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 21:05:36 -0500
Received: from ocean.trasno.org ([167.172.185.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@trasno.org>)
 id 1rMIXf-0002JR-2j
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 21:05:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=trasno.org; 
 s=dkim20221213;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-ID:Date:Reply-To:References:In-Reply-To:Subject:Cc:To:From:Sender:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=96rTKq5jABwonZNu0voPFAn25VfsOwkD5Tak7oKSR7g=; t=1704593133; x=1705457133; 
 b=GbkO4NyDhQEFemFw3IHHAxTlAEQNCPh09IfL051qA8ZFaBQRDtoeGXQyHFgpVidyG5XKRtQhLS/
 LM+SpSVINb5WxLs3gP8HWDjgUhcwL2vPL/J6eLejd2Wmg4inVsY6B9C2r2EkQzRtVFOa68PJZW733
 z8DtubVgkOtOIB2jX8VdHGD5OtVspI6CNxsqPP1lokcX4O00mpEYtU297y7vWC71VlbHEAl4Oycsa
 H+GQE4SuNE1Nm/pDxCUboQnTvqeSZejBHQOBGcgbsyLmy35Ojd8s67HRW9/VYDxOvQd5T5iLut5I2
 2K73/nWazBBw1QHcW4BYwgW7JGzw3oji0eSA==;
Received: from static-133-204-7-89.ipcom.comunitel.net ([89.7.204.133]
 helo=trasno.org)
 by ocean.trasno.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <quintela@trasno.org>)
 id 1rMIVR-00Dv00-1Z; Sun, 07 Jan 2024 03:03:17 +0100
To: Bin Meng <bmeng.cn@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] Leaving Migration
In-Reply-To: <CAEUhbmX3iAwtBkH2hPa031rok0OH01uSkiMPp3fde+wbKxDkhQ@mail.gmail.com>
 (Bin Meng's message of "Wed, 3 Jan 2024 06:43:50 +0800")
References: <20240102201908.1987-1-quintela@redhat.com>
 <20240102201908.1987-2-quintela@redhat.com>
 <CAEUhbmX3iAwtBkH2hPa031rok0OH01uSkiMPp3fde+wbKxDkhQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sun, 07 Jan 2024 03:03:18 +0100
Message-ID: <87zfxh7vdl.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=167.172.185.48; envelope-from=quintela@trasno.org;
 helo=ocean.trasno.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 07 Jan 2024 00:06:35 -0500
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
Reply-to:  quintela@trasno.org
X-ACL-Warn: ,  Juan Quintela <quintela@trasno.org>
From:  Juan Quintela via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Bin Meng <bmeng.cn@gmail.com> wrote:
> On Wed, Jan 3, 2024 at 4:20=E2=80=AFAM Juan Quintela <quintela@redhat.com=
> wrote:
>>
>> I am leaving Red Hat, and as part of that I am leaving Migration
>> maintenarship.
>
> maintainership?

You are right, as usual O:-)

>>
>> You are left in good hands with Peter and Fabiano.
>>
>> Thanks for all the fish.
>
> Best wishes!

Thanks very much.

>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  MAINTAINERS | 3 ---
>>  .mailmap    | 1 +
>>  2 files changed, 1 insertion(+), 3 deletions(-)
>>
>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

