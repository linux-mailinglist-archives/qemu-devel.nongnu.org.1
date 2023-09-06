Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C317941F2
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 19:19:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdwAe-0003QS-MQ; Wed, 06 Sep 2023 13:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qdwAc-0003Q0-Ps
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 13:18:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qdwAa-0003C2-Gg
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 13:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694020703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pQx5k23JpmrGuTY2FX0Dd4+vsj0QJe7mfchUwfpeg0Q=;
 b=HQWvC32yZ1HGmO2I4C6hZVmYZKAIEjHyBoX58vodbLUoC5HN6TsNylgY9aoEcvdNuKa+EJ
 XHLESK8h5b6DlsC3L/GQ/haTzVyte0oZvOiUlrpMsvBJgMGvcWdLiLu9DVH2EE+k+rZOTS
 QWXgTp8anKyqe2/VtH5r9H/fgsCKD00=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-VIABuUPlM4Ol1nLoCfBVWw-1; Wed, 06 Sep 2023 13:18:19 -0400
X-MC-Unique: VIABuUPlM4Ol1nLoCfBVWw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A4C79498C0;
 Wed,  6 Sep 2023 17:18:19 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4FC540C2070;
 Wed,  6 Sep 2023 17:18:17 +0000 (UTC)
Date: Wed, 6 Sep 2023 12:18:15 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 peter.maydell@linaro.com
Subject: Re: [PATCH v6 04/17] nbd: Prepare for 64-bit request effect lengths
Message-ID: <myh3j66p7hl3dzfqebjazm4w4z52joghfgcmcabp2v54lk6iln@ivukxunpgsji>
References: <20230829175826.377251-19-eblake@redhat.com>
 <20230829175826.377251-23-eblake@redhat.com>
 <3a136ddb-2ea7-ef26-d9b8-7f55f068996c@yandex-team.ru>
 <54b6a72ltz7uvb2lyhlyi4aptz2oaxyb7d5egsj24t7ueibqjb@tds7ps6lfvis>
 <92852634-105c-9368-aebc-fdea8be307f0@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92852634-105c-9368-aebc-fdea8be307f0@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 05, 2023 at 05:41:33PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > @@ -1899,7 +1899,7 @@ static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
> > > >                                                     NBDRequest *request,
> > > >                                                     uint32_t error,
> > > >                                                     void *data,
> > > > -                                                 size_t len,
> > > > +                                                 uint64_t len,
> > > >                                                     Error **errp)
> > > >    {
> > > >        NBDSimpleReply reply;
> > > > @@ -1910,6 +1910,7 @@ static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
> > > >        };
> > > > 
> > > >        assert(!len || !nbd_err);
> > > > +    assert(len <= NBD_MAX_STRING_SIZE);
> > > 
> > > NBD_MAX_BUFFER_SIZE ?
> > 
> > No. MAX_STRING_SIZE is 4k, MAX_BUFFER_SIZE is 32M.  The smaller size
> > is the correct bound here (an error message has to be transmitted as a
> > single string, and the recipient does not expect more than a 4k error
> > message).
> > 
> 
> I miss something.. Why it's an error message? It's may be a simple reply for CMD_READ, where len is request->len

Oh; I was confusing this with the length of an error message; but when
an error message is sent over the wire, it's done with
nbd_co_send_chunk_error().  And a quick audit only shows two callers
of nbd_co_send_simple_reply(): nbd_send_generic_reply() which only
uses it with data/len NULL/0; and nbd_do_cmd_read() does indeed use up
to MAX_BUFFER_SIZE when structured mode was not negotiated.  Our unit
tests aren't covering interoperability with clients that don't request
structured replies, so I wasn't seeing the problem with just 'make
check' or any of the iotests; but libnbd's testsuite does do interop
testing, and there I was able to trip this assertion.  I'll fix the
assertion.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


