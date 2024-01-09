Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C338281D3
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 09:36:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN7aQ-0000Af-BQ; Tue, 09 Jan 2024 03:35:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rN7aN-00005j-5E; Tue, 09 Jan 2024 03:35:47 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rN7aC-0007HJ-6p; Tue, 09 Jan 2024 03:35:46 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id 6AC1A80029;
 Tue,  9 Jan 2024 09:35:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1704789332; bh=Wvs+ZpMGNj5529qltq45x8acRb1oXAHl/6YczVouUxY=;
 h=References:From:To:Cc:Subject:Date:In-reply-to;
 b=giikOdmRenu9HtN/S9ZrygxGgJB5QggDqPhJtb7+maJJAuM/46P8nBMe9JGDl0C9X
 rQqBjV1uIWo2GpY9+3CVXBMYPYSCy7LT46SugckEEk4fLF3hBMLm6sGl1xcuRcCCCU
 fxxd4j878GUF7CUgBM9hz8AdcnYoM1nAK64dovXd1fdWxEuSYTgb9Tu1d2aWYOB35i
 HY1ZEXLZURH+3LPBA/z9/k3T/U170OkiXq4v92z0eO2h2hWfy137P+lsru8kWfyDlb
 Fuz0NRPp1m0J0LLvaW63NgigiwJUeY4SiEKVkHfgr+086g+6+sj9jLD5fbRcy4Z1Ff
 JcUdO+LRNx0hA==
References: <20240109083053.2581588-1-sam@rfc1149.net>
User-agent: mu4e 1.10.8; emacs 29.1
From: Samuel Tardieu <sam@rfc1149.net>
To: Samuel Tardieu <sam@rfc1149.net>
Cc: Magnus Damm <magnus.damm@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 devel@lists.libvirt.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/2] Deprecate the shix machine and the TC58128 flash
 device
Date: Tue, 09 Jan 2024 09:35:07 +0100
In-reply-to: <20240109083053.2581588-1-sam@rfc1149.net>
Message-ID: <87sf36ykdn.fsf@rfc1149.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Samuel Tardieu <sam@rfc1149.net> writes:

> The shix machine was a research project started around 2003 at
> T=C3=A9l=C3=A9com Paris. Preliminary support in QEMU was added in 2005
> back when the QEMU architecture was less structured than it is
> now. Unfortunately, the support for the shix machine and its
> peripherals, such as the TC58128 16MiB flash device, has never
> been maintained as the research project used the real machine.
>
> This project stopped around 2010 and to the best of my knowledge
> and after consulting with the original author Alexis Polti,
> I propose to deprecate it in QEMU as well as the TC58128
> flash device which does not implement the QOM model and still
> contains debug fprintf statements.

I forgot to include the change from v1: simplify the deprecation=20
statements.

  Sam
--=20
Samuel Tardieu

