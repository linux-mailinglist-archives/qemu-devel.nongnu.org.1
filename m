Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3564971FA24
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 08:33:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4yLX-0002EF-Js; Fri, 02 Jun 2023 02:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q4yLG-0002D1-UR
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 02:32:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q4yL1-0002Kn-PH
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 02:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685687557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XCSZNpzwibbmoN2/Pc9VgJxMJV/HQUBOBMsGd3xFYSQ=;
 b=Rpj+MSjla7GGeMKBblIHFFiO/e/wCFCqdJ5wd+4oqboGDVYXSKdoaHOxyY6Z6YckqaHKNK
 li5No2Ln2eG0aPM/fxT4lwU5k2hMj+xucP0TZ/Y3wgf/jxmR+vYjeYhmfXlMuhin2Bmcpn
 Fx1/BtGULa8oZIx9BN9ObTx01FmwqFE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-Gz6gzdCfNBulL9RmGxD5dQ-1; Fri, 02 Jun 2023 02:32:35 -0400
X-MC-Unique: Gz6gzdCfNBulL9RmGxD5dQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 717DF800B2A
 for <qemu-devel@nongnu.org>; Fri,  2 Jun 2023 06:32:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50628492B0A
 for <qemu-devel@nongnu.org>; Fri,  2 Jun 2023 06:32:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 436B521E692E; Fri,  2 Jun 2023 08:32:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Conclusion of yet another expensive UI folly (was: [PULL 00/21] NBD
 and miscellaneous patches for 2023-06-01)
References: <20230601220305.2130121-1-eblake@redhat.com>
Date: Fri, 02 Jun 2023 08:32:34 +0200
In-Reply-To: <20230601220305.2130121-1-eblake@redhat.com> (Eric Blake's
 message of "Thu, 1 Jun 2023 17:02:44 -0500")
Message-ID: <87sfbaxtkt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Pattern:

First, one of us gets a bright idea on user-friendly interface (here:
fractional sizes like 1.5M).  Objections, if any, get brushed aside.

Then the thing sprouts warts, tentacles, sores, and starts to give off
that sickly-sweet smell of bugs feasting on misguided ideas.

Until one of us spends a lot more time on containing and reducing the
damage than the thing could ever be worth.

Cobbler, stick to your last.

Thanks, Eric!


