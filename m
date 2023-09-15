Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F63F7A17A4
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 09:42:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh3Sd-0004e7-SJ; Fri, 15 Sep 2023 03:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qh3Sb-0004db-Qd
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qh3Sa-0000sG-9H
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694763711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pRC3RshYLS4HmQNALCOSRKQWLBPF3YgAiPkaToAE920=;
 b=A2FNF51C5oQIvS0hyHVJVSjGpXKeDZ+XQOTpNXBQ3ir41tDy3+ZiiJ3yt4VxBAYltSy2Ac
 8X0/GJxUcsPKHsCoZp9BIvTVPxdaTrr4qOiIfE03Z3DKlsnMCMeYXDL3pzQZ6Td3yPVH13
 ziG2QFgL510Hpyo3CGy2jdMzTMPLypQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-nGWXfUAWOlyJ8o2oDKoGSQ-1; Fri, 15 Sep 2023 03:41:45 -0400
X-MC-Unique: nGWXfUAWOlyJ8o2oDKoGSQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA17E858F19;
 Fri, 15 Sep 2023 07:41:44 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AAD7A21B2413;
 Fri, 15 Sep 2023 07:41:40 +0000 (UTC)
Date: Fri, 15 Sep 2023 09:41:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, idryomov@gmail.com,
 pl@kamp.de, sw@weilnetz.de, sstabellini@kernel.org,
 anthony.perard@citrix.com, paul@xen.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, stefanha@redhat.com, fam@euphon.net,
 quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 kraxel@redhat.com, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH 5/7] block/vdi: Clean up local variable shadowing
Message-ID: <ZQQKsxgrT2mLokFi@redhat.com>
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-6-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831132546.3525721-6-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 31.08.2023 um 15:25 hat Markus Armbruster geschrieben:
> Local variables shadowing other local variables or parameters make the
> code needlessly hard to understand.  Tracked down with -Wshadow=local.
> Clean up: delete inner declarations when they are actually redundant,
> else rename variables.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

> @@ -700,7 +699,7 @@ nonallocating_write:
>          /* One or more new blocks were allocated. */
>          VdiHeader *header;
>          uint8_t *base;
> -        uint64_t offset;
> +        uint64_t offs;
>          uint32_t n_sectors;
>  
>          g_free(block);
> @@ -723,11 +722,11 @@ nonallocating_write:
>          bmap_first /= (SECTOR_SIZE / sizeof(uint32_t));
>          bmap_last /= (SECTOR_SIZE / sizeof(uint32_t));
>          n_sectors = bmap_last - bmap_first + 1;
> -        offset = s->bmap_sector + bmap_first;
> +        offs = s->bmap_sector + bmap_first;
>          base = ((uint8_t *)&s->bmap[0]) + bmap_first * SECTOR_SIZE;
>          logout("will write %u block map sectors starting from entry %u\n",
>                 n_sectors, bmap_first);
> -        ret = bdrv_co_pwrite(bs->file, offset * SECTOR_SIZE,
> +        ret = bdrv_co_pwrite(bs->file, offs * SECTOR_SIZE,
>                               n_sectors * SECTOR_SIZE, base, 0);
>      }

Having two variables 'offset' and 'offs' doesn't really help with
clarity either. Can we be more specific and use something like
'bmap_offset' here?

Kevin


