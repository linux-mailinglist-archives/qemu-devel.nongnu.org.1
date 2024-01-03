Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C384822C49
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 12:39:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKza4-000543-ML; Wed, 03 Jan 2024 06:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1rKzZz-00053i-9a
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 06:38:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1rKzZw-0004oF-No
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 06:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704281911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5owTHrb3aE8LNf+PDidxspj2b3b5oe/aR/5VhaeK35o=;
 b=YYUrVi4S94UshuTDxVpLmCapW1c0DA1crL2W9dG7D0vVre5iTxi0Nr4FfhM2Up8ffOL9Oc
 bhmLYaun/fU/lSlM3tDikY4asplbaCmPHpeAwcyIZ/WZSwhOf0iT+Syk6bolJ2bbTkQ9No
 L8UFyGad/QGzDxs5AApJLC4hyuf+e4M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-2N3w5CV3OM-nu1ptzkJhvg-1; Wed, 03 Jan 2024 06:38:27 -0500
X-MC-Unique: 2N3w5CV3OM-nu1ptzkJhvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66C7C101A555;
 Wed,  3 Jan 2024 11:38:27 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.242.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BB6B51D5;
 Wed,  3 Jan 2024 11:38:25 +0000 (UTC)
Date: Wed, 3 Jan 2024 12:38:23 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v3 0/2] block: commit/stream: Allow users to request only
 format driver names in backing file format
Message-ID: <ZZVHL6ps2ldfikbj@angien.pipo.sk>
References: <cover.1701796348.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701796348.git.pkrempa@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Dec 05, 2023 at 18:14:40 +0100, Peter Krempa wrote:
> Please see patches for rationale.
> 
> Libvirt patches using this new flag will be posted soon-ish (after
> cleanup).
> 
> v3:
>  - changed name of flag to 'backing-mask-protocol' (Eric)
>  - decided to keep Vladimir's R-b as he requested shorter name too
> 
> v2:
>  - fixed mistaken argument order in 'hmp_block_stream'
>  - changed version in docs to 9.0 as getting this into RC 3 probably
>    isn't realistic
> 
> Peter Krempa (2):
>   block: commit: Allow users to request only format driver names in
>     backing file format
>   block: stream: Allow users to request only format driver names in
>     backing file format

Polite ping, now that qemu-8.2 was released.


