Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FAE822FB8
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 15:41:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL2QJ-0007VP-UQ; Wed, 03 Jan 2024 09:40:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.tardieu@telecom-paris.fr>)
 id 1rL2Q5-0007V3-Nd; Wed, 03 Jan 2024 09:40:33 -0500
Received: from zproxy4.enst.fr ([2001:660:330f:2::df])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.tardieu@telecom-paris.fr>)
 id 1rL2Py-0006lN-6o; Wed, 03 Jan 2024 09:40:30 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 1D745206DF;
 Wed,  3 Jan 2024 15:40:17 +0100 (CET)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id vHmJFdcbV1ZL; Wed,  3 Jan 2024 15:40:16 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 7635B206F5;
 Wed,  3 Jan 2024 15:40:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr 7635B206F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1704292816;
 bh=8Bpi2UyXi9bDygv9v87FHzYkLF/eVApRysLUBHQGI/8=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=QnCUkvGKnlmqtfXDEDq9Xie09Hi3eFjsYe5bffXaNzHVootKdxZ2vI+csRQxDdAAC
 utdzfamEL4wRp6DQiwcTvfgO9Hn1kjcBBiqB7m1oyWME0LUIvYzTlRmgi9zXDk6n0B
 JMg8ZcTewm9UoN56qGrMMn1JrhTfp1us0TcLF2q8=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id pCZ9mus-PDFd; Wed,  3 Jan 2024 15:40:16 +0100 (CET)
Received: from buffy (unknown [IPv6:2a01:e34:ec63:e440:5c00:58bd:886:e993])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id AD3E5206DF;
 Wed,  3 Jan 2024 15:40:15 +0100 (CET)
References: <20231215103448.3822284-1-zhao1.liu@linux.intel.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Darren Kenny <darren.kenny@oracle.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-trivial@nongnu.org, Zhenyu Wang
 <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma
 <yongwei.ma@intel.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] scripts/checkpatch: Support codespell checking
Date: Wed, 03 Jan 2024 15:36:59 +0100
In-reply-to: <20231215103448.3822284-1-zhao1.liu@linux.intel.com>
Message-ID: <87frze5vlc.fsf@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::df;
 envelope-from=samuel.tardieu@telecom-paris.fr; helo=zproxy4.enst.fr
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

> +  --codespell                Use the codespell dictionary for=20
> spelling/typos
> +                             (default:$codespellfile)

Nitpick: I would have used a space after ":".

> +	# If /usr/share/codespell/dictionary.txt is not present,=20
> try to find it
> +	# under codespell's install directory:=20
> <codespell_root>/data/dictionary.txt

This works correctly on my NixOS system using a non-FHS layout and=20
properly locates the codespell file.

This patch made me find a typo in one of my commit messages.

Tested-by: Samuel Tardieu <sam@rfc1149.net>

  Sam
--=20
Samuel Tardieu
T=C3=A9l=C3=A9com Paris - Institut Polytechnique de Paris

