Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 094ECAA5781
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Apr 2025 23:37:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAF5h-00011z-1z; Wed, 30 Apr 2025 17:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uAF5e-00011o-Py
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 17:35:38 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uAF5a-0007se-OL
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 17:35:37 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2CA9455D24D;
 Wed, 30 Apr 2025 23:35:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id D45CM_-b_3D1; Wed, 30 Apr 2025 23:35:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 310E455D22F; Wed, 30 Apr 2025 23:35:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2C478745682;
 Wed, 30 Apr 2025 23:35:27 +0200 (CEST)
Date: Wed, 30 Apr 2025 23:35:27 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chao Liu <lc00631@tecorigin.com>
cc: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, 
 philmd@linaro.org, armbru@redhat.com, zhangtj@tecorigin.com, 
 zqz00548@tecorigin.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 0/1] Optimizing the print format of the QEMU monitor
 'info mtree'
In-Reply-To: <cover.1746031192.git.lc00631@tecorigin.com>
Message-ID: <9859fa86-2fb7-2380-2320-8b268d900fe9@eik.bme.hu>
References: <cover.1746031192.git.lc00631@tecorigin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1965247327-1746048927=:22499"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1965247327-1746048927=:22499
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 1 May 2025, Chao Liu wrote:
> Hi, all:
>
> Thanks to Markus, BALATON, and Philippe for their reviews
>
> In PATCH v5:
>
> Fix one comment, level 0 no longer prints line characters.
>
> ```
> -    /* Level 0 always has a col. */
> +    /* Level 0 always has not a col. */
>    if (level == 0 || col_string == NULL) {
> ```
>
> PATCH v4 changelog:
> 1. When printing the child nodes of a single node, the line characters from the
> parent node's level are no longer printed, making the output more concise
> and clear overall;
>
> 2. Use more commonly used ASCII characters, such as '|--' instead of '├──',
> and '`--' instead of '└──';

Thanks but I meant only 1 horizontal dash instead of two to keep output 
fit in narrower terminal. So instead of '--' just '-' and instead of '|--' 
with one dash such as '|-'. Would that work?

Regards,
BALATON Zoltan
--3866299591-1965247327-1746048927=:22499--

