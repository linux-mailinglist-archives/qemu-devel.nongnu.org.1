Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE387D1CDA
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 13:33:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quACz-0000uy-KR; Sat, 21 Oct 2023 07:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1quACw-0000uH-0O; Sat, 21 Oct 2023 07:31:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1quACt-0000xu-Jm; Sat, 21 Oct 2023 07:31:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1B8122C322;
 Sat, 21 Oct 2023 14:32:11 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 21D3530676;
 Sat, 21 Oct 2023 14:31:46 +0300 (MSK)
Message-ID: <78323369-f211-4281-b365-7de1fc5788f8@tls.msk.ru>
Date: Sat, 21 Oct 2023 14:31:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add unvalued folders in tests/tcg/ to the
 right sections
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, qemu-ppc@nongnu.org
References: <20231018062401.20746-1-thuth@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20231018062401.20746-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[Trim recipient list]

18.10.2023 09:24, Thomas Huth:
> Some subfolders in tests/tcg/ are already listed in the MAINTAINERS
> file, some others aren't listed yet. Add the missing ones now to the
> MAINTAINERS file, too, to make sure that get_maintainers.pl reports
> the correct maintainer.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index b3599746c4..b80124f60f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -327,6 +329,7 @@ F: hw/ppc/trace*
>   F: configs/devices/ppc*
>   F: docs/system/ppc/embedded.rst
>   F: docs/system/target-ppc.rst
> +F: tests/tcg/ppc*/*

FWIW, this hunk needs earlier series "MAINTAINERS: Collect unmaintained files
under PPC entries", in particular "MAINTAINERS: Add PPC common files to PowerPC
TCG CPUs", which is still not in master.  Maybe it's better to fold this change
to the PPC series.

/mjt


