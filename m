Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA6486994F
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Feb 2024 15:56:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reyrr-0001DP-9I; Tue, 27 Feb 2024 09:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1reyrU-00013F-8l
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:55:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1reyrN-0005Ng-Rx
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709045708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u9tGborc83MJFY+JGFE2IZcSTWXP6kPQjnX1S6vVv1k=;
 b=XAIfj5wHSAfA29ysZrjN0DF1trPXyyezhI5C2idQ49FzeduNbPYCDZwxgnwdD2w7eABcEe
 bVKTJZ9HOD5a308m23MLUuPxOmPsAQJiLyvh0a43QfNotpfKYNSqiGjAJGegjIfhfxrRVL
 22f8uw2npJPCpvbG9hjVjSUShjpA4Sw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-qjbuhvc1Px2D4XXhcLY3nw-1; Tue,
 27 Feb 2024 09:55:06 -0500
X-MC-Unique: qjbuhvc1Px2D4XXhcLY3nw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 843E0381200F
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 14:55:06 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9335B1C060B1;
 Tue, 27 Feb 2024 14:55:05 +0000 (UTC)
Date: Tue, 27 Feb 2024 08:55:04 -0600
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH 2/2] docs/devel/writing-monitor-commands: Minor
 improvements
Message-ID: <psbj2phr7s5wl4zks624ajsscrjfcepwvhlzjt7rbxseulu4kf@2nzxhwtlgv6o>
References: <20240227115617.237875-1-armbru@redhat.com>
 <20240227115617.237875-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227115617.237875-3-armbru@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Tue, Feb 27, 2024 at 12:56:17PM +0100, Markus Armbruster wrote:
> Avoid "JSON" when talking about the QAPI schema syntax.  Capitalize
> QEMU.  Don't claim all HMP commands live in monitor/hmp-cmds.c (this
> was never true).  Fix punctuation and drop inappropriate "the" here
> and there.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/devel/writing-monitor-commands.rst | 32 ++++++++++++-------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


