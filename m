Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5697FEA72
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 09:25:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8cMC-0006za-Or; Thu, 30 Nov 2023 03:25:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8cMB-0006z3-2O
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 03:25:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8cM9-0006Wc-JT
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 03:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701332707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U4Hly2vHbB/BTRbV32kTu5h5ZCkYuyAIegoP2iQo3l0=;
 b=cSDsrQRausXqNMnjpsu61/0rH9TWL/eAPKywNTOjTRVEgNAaA0p9F3KGZlrnbmDRgu4Rs+
 WyIiWwZQrvcEHeNg9a8JaslzoMMytboCXLj6hJhnxpmkYY+7X037yya/CTxhrbyanSrchI
 sH3o6J4ScjgMT2BsKg+PYHPutn24XgY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-TNRTSKmNNR6V0KGCsTyQDw-1; Thu, 30 Nov 2023 03:25:01 -0500
X-MC-Unique: TNRTSKmNNR6V0KGCsTyQDw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70876811E7E;
 Thu, 30 Nov 2023 08:25:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49A941C060AE;
 Thu, 30 Nov 2023 08:25:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3FC8821E6A1F; Thu, 30 Nov 2023 09:25:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org,  dmitry.fomichev@wdc.com,  qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,  dlemoal@kernel.org,  hare@suse.de,  Hanna
 Reitz <hreitz@redhat.com>,  stefanha@redhat.com,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v6 0/4] Add full zoned storage emulation to qcow2 driver
References: <20231127043703.49489-1-faithilikerun@gmail.com>
Date: Thu, 30 Nov 2023 09:25:00 +0100
In-Reply-To: <20231127043703.49489-1-faithilikerun@gmail.com> (Sam Li's
 message of "Mon, 27 Nov 2023 12:36:59 +0800")
Message-ID: <87leafejhf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Clang reports

../block/qcow2.c:4066:5: error: mutex 'graph_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
    blk_co_unref(blk);
    ^
../block/qcow2.c:3928:5: note: mutex acquired here
    bdrv_graph_co_rdlock();
    ^
../block/qcow2.c:4066:5: error: mutex 'graph_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
    blk_co_unref(blk);
    ^
../block/qcow2.c:3928:5: note: mutex acquired here
    bdrv_graph_co_rdlock();
    ^
2 errors generated.


