Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F270817E65
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 01:07:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFNd4-0004Mz-Rh; Mon, 18 Dec 2023 19:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rFNd2-0004MQ-Hq; Mon, 18 Dec 2023 19:06:32 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rFNd0-0007tu-J0; Mon, 18 Dec 2023 19:06:32 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A066E75A4BF;
 Tue, 19 Dec 2023 01:06:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id f64Lk_f6Er3p; Tue, 19 Dec 2023 01:06:26 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B372875A406; Tue, 19 Dec 2023 01:06:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AEC49756094;
 Tue, 19 Dec 2023 01:06:26 +0100 (CET)
Date: Tue, 19 Dec 2023 01:06:26 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 06/12] exec/ioport: Add portio_list_set_address()
In-Reply-To: <20231218185114.119736-7-shentey@gmail.com>
Message-ID: <ec4652f1-f47f-62bc-d0ac-9c709453288f@eik.bme.hu>
References: <20231218185114.119736-1-shentey@gmail.com>
 <20231218185114.119736-7-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Mon, 18 Dec 2023, Bernhard Beschow wrote:
> Some SuperI/O devices such as the VIA south bridges or the PC87312 controller
> are able to relocate their SuperI/O functions. Add a convenience function for
> implementing this in the VIA south bridges.
>
> This convenience function relies on previous simplifications in exec/ioport
> which avoids some duplicate synchronization of I/O port base addresses. The
> naming of the function is inspired by its memory_region_set_address() pendant.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> docs/devel/migration.rst |  1 +
> include/exec/ioport.h    |  2 ++
> system/ioport.c          | 19 +++++++++++++++++++
> 3 files changed, 22 insertions(+)
>
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index ec55089b25..389fa24bde 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -464,6 +464,7 @@ Examples of such memory API functions are:
>   - memory_region_set_enabled()
>   - memory_region_set_address()
>   - memory_region_set_alias_offset()

These added here aren't memory API functions so maybe make them a separate 
list with some rewording so that this is not specific to memory API but 
whatever changes memory regions such as memory API or these portio_list 
functions.


