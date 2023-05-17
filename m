Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 345C7706D30
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:49:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJP0-0008JW-79; Wed, 17 May 2023 11:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzJOq-000892-57
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzJOn-00051h-2e
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684338548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K5JbRrqhEF1XNjaB5ptmTpO1noZAarLiZSuAanZ0gfM=;
 b=PDB9cUoy/DhtcUfqKchT/GCvY3Q8rnIU5AAX+8qbxKVCWZXXBDc+2owlklaUYau1tldmlS
 nvm39CZ4tbj8RSZHFXbEeZUlb1B/UYrGGf9w3oLe+kB6K5+ACGq0gPmfFskYi0BaV7xeTR
 HTJV56pg+rDkvkI8P2zw/HIv5cIGwNU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-DVBemeCvOxSgocfkqET-ig-1; Wed, 17 May 2023 11:49:05 -0400
X-MC-Unique: DVBemeCvOxSgocfkqET-ig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76E0718A647F;
 Wed, 17 May 2023 15:49:05 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB71F40206C9;
 Wed, 17 May 2023 15:48:50 +0000 (UTC)
Date: Wed, 17 May 2023 17:48:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: ~akihirosuda <suda.kyoto@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, akihiro.suda.cz@hco.ntt.co.jp
Subject: Re: [PATCH qemu] docs/interop/qcow2.txt: fix description about
 "zlib" clusters
Message-ID: <ZGT3YRo8pN6urEtw@redhat.com>
References: <168424874322.11954.1340942046351859521-0@git.sr.ht>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168424874322.11954.1340942046351859521-0@git.sr.ht>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Am 16.05.2023 um 16:32 hat ~akihirosuda geschrieben:
> From: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
> 
> "zlib" clusters are actually raw deflate (RFC1951) clusters without
> zlib headers.
> 
> Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>

Thanks, applied to the block branch.

Kevin


