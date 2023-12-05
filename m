Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ADA805B4D
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 18:47:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAZVs-0000Xp-Vm; Tue, 05 Dec 2023 12:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1rAZVq-0000XX-9v
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 12:47:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1rAZVo-00014N-Ti
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 12:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701798431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0hkJKVxipy8o+EDX5dGvU4ekSBe+kWuVTek7syZ9NJA=;
 b=gm5FY/24AxWeIdbd++PHyL96q4haPFrA9Kkkl2jQeicU49Fs4LV2DFGfzG23o4CRK9fhIK
 bqM6ZemMG8clbTuro+pyneHZGqzYD3WKzhenX1Xha16dHx4/1nzMmcp4wwbFGFJa95PmMx
 Qrakcb/rSDuIjFF9+G3XLfGX0tqqv7M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-PmR55v6xOK28RtYzYZLhsg-1; Tue, 05 Dec 2023 12:47:10 -0500
X-MC-Unique: PmR55v6xOK28RtYzYZLhsg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1B9388B7AE;
 Tue,  5 Dec 2023 17:47:09 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.242.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC32A492BC6;
 Tue,  5 Dec 2023 17:47:07 +0000 (UTC)
Date: Tue, 5 Dec 2023 18:47:05 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v3 0/2] block: commit/stream: Allow users to request only
 format driver names in backing file format
Message-ID: <ZW9iGZiqZNF1JhMr@angien.pipo.sk>
References: <cover.1701796348.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701796348.git.pkrempa@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Dec 05, 2023 at 18:14:40 +0100, Peter Krempa wrote:
> Please see patches for rationale.
> 
> Libvirt patches using this new flag will be posted soon-ish (after
> cleanup).

https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/message/GCCZP5ANYTPVXCIEYGSM5NWYCGDL23V6/


