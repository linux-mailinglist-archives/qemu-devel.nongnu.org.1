Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4237CD49B
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 08:39:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt0Cb-00071Z-1L; Wed, 18 Oct 2023 02:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=IJBG=GA=kaod.org=clg@ozlabs.org>)
 id 1qt0CW-00070J-2R; Wed, 18 Oct 2023 02:38:40 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=IJBG=GA=kaod.org=clg@ozlabs.org>)
 id 1qt0CU-0001qI-Em; Wed, 18 Oct 2023 02:38:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S9LlZ3s1cz4x80;
 Wed, 18 Oct 2023 17:38:34 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9LlX4wHdz4x1v;
 Wed, 18 Oct 2023 17:38:32 +1100 (AEDT)
Message-ID: <746b3fa0-dff6-4db7-a07e-57228447d32a@kaod.org>
Date: Wed, 18 Oct 2023 08:38:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] MAINTAINERS: Collect unmaintained files under PPC
 entries
Content-Language: en-US
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-trivial@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20231002122326.365368-1-clg@kaod.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231002122326.365368-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=IJBG=GA=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


Adding Cc: qemu-trivial@nongnu.org because these changes don't need to go
through the ppc tree.

On 10/2/23 14:23, Cédric Le Goater wrote:
> Hello,
> 
> All PPC files should now be correctly assigned to some entry.
> 
> Cheers,

Last patch should be dropped though. It is replaced by:

  https://lore.kernel.org/qemu-devel/20231018062401.20746-1-thuth@redhat.com/

Thanks,

C.



> C.
> 
> Cédric Le Goater (8):
>    ppc/{bamboo, virtex_ml507}: Remove useless dependency on ppc405.h
>      header
>    MAINTAINERS: Adjust file list for PPC ref405ep machine
>    MAINTAINERS: Adjust file list for PPC 4xx CPUs
>    MAINTAINERS: Adjust file list for PPC e500 machines
>    MAINTAINERS: Adjust file list for PPC pseries machine
>    MAINTAINERS: Add fw_cfg.c to PPC mac99 machine
>    MAINTAINERS: Add PPC common files to PowerPC TCG CPUs
>    MAINTAINERS: Update PPC TCG target with tests
> 
>   MAINTAINERS            | 19 +++++++++++++++++--
>   hw/ppc/ppc440_bamboo.c |  1 -
>   hw/ppc/virtex_ml507.c  |  1 -
>   3 files changed, 17 insertions(+), 4 deletions(-)
> 


