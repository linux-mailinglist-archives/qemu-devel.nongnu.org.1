Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDC87FA447
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 16:20:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7dNv-0000K0-59; Mon, 27 Nov 2023 10:18:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r7dNs-0000GS-MG
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:18:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r7dNr-0000kl-3y
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701098330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CTtphWJILVrbhrM7+hg7F3Jm8aR8ZUMRejNVIxOcWBs=;
 b=Z+jLMrawOENwgQ8ruks/ve4SHw1ZHWPOLU9gSAhgZ1S2ccH1XjwyG9UggFch+lqfNR+2qH
 ctJAjQcDACF2Y09FldIesUdlruo4TXjP4n2FN5XFA/Lmf4+WLO8OoQrOtS0+FJ2+17OmEU
 UpRA8vZzxO9WMB9by+T5gm4nF9p1IgY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-CBYyZBBGO62H5a8B2JD_cw-1; Mon, 27 Nov 2023 10:18:47 -0500
X-MC-Unique: CBYyZBBGO62H5a8B2JD_cw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BB058556EC;
 Mon, 27 Nov 2023 15:18:47 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D43E81C060B0;
 Mon, 27 Nov 2023 15:18:46 +0000 (UTC)
Date: Mon, 27 Nov 2023 09:18:45 -0600
From: Eric Blake <eblake@redhat.com>
To: Fam <fam@euphon.net>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH] vmdk: Don't corrupt desc file in vmdk_write_cid
Message-ID: <d7ktomuufu2yrhqlqfuqllllbrzsyzmpup53q7rn5ybal6et4v@tf4ovvmqszfx>
References: <20231124115654.3239137-1-fam@euphon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124115654.3239137-1-fam@euphon.net>
User-Agent: NeoMutt/20231103
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

On Fri, Nov 24, 2023 at 11:56:54AM +0000, Fam wrote:
> From: Fam Zheng <fam@euphon.net>
> 
> If the text description file is larger than DESC_SIZE, we force the last
> byte in the buffer to be 0 and write it out.
> 
> This results in a corruption.
> 
> Try to allocate a big buffer in this case.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1923
> 
> Signed-off-by: Fam Zheng <fam@euphon.net>
> ---
>  block/vmdk.c               | 28 ++++++++++++++++++++--------
>  tests/qemu-iotests/059     |  2 ++
>  tests/qemu-iotests/059.out |  4 ++++
>  3 files changed, 26 insertions(+), 8 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

Are we trying to get this into 8.2, since it is a data corruption?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


