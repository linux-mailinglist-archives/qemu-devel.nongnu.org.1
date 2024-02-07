Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 396C884CC37
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Feb 2024 15:00:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXiSZ-0008U3-HA; Wed, 07 Feb 2024 08:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXiSX-0008TQ-5R
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:59:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXiSV-0006A2-U6
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707314367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3B9cNfVS43pyWIPsyOxDT+UPK4CBphBQ5ESplLLUFvA=;
 b=EfPcpo51z097sRKOEqQoXW7p7JaxRDMscpmGEhrXDN7jJU2XBXKJmq2EzvX0zmHPe9YyAe
 0J6KUEmMsPwHw0VJCPuT9V0w2U6n12CRke+hWgFjxuIcjbXFOjYTahXoV/bpzRnOPphM0v
 S+PUEOkp9i7LAKru7r9xSgsVlJ7dewU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-PgDCJPgaP-WQ1WFgC7pcow-1; Wed,
 07 Feb 2024 08:59:23 -0500
X-MC-Unique: PgDCJPgaP-WQ1WFgC7pcow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54CE62823801;
 Wed,  7 Feb 2024 13:59:23 +0000 (UTC)
Received: from redhat.com (pixel-6a.str.redhat.com [10.33.192.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9904B1C02EB3;
 Wed,  7 Feb 2024 13:59:22 +0000 (UTC)
Date: Wed, 7 Feb 2024 14:59:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH] iotests: fix leak of tmpdir in dry-run mode
Message-ID: <ZcOMuaT52lJDdYKJ@redhat.com>
References: <20240205154019.1841037-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240205154019.1841037-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 05.02.2024 um 16:40 hat Daniel P. Berrang� geschrieben:
> Creating an instance of the 'TestEnv' class will create a temporary
> directory. This dir is only deleted, however, in the __exit__ handler
> invoked by a context manager.
> 
> In dry-run mode, we don't use the TestEnv via a context manager, so
> were leaking the temporary directory. Since meson invokes 'check'
> 5 times on each configure run, developers /tmp was filling up with
> empty temporary directories.
> 
> Signed-off-by: Daniel P. Berrang� <berrange@redhat.com>

Thanks, applied to the block branch.

Kevin


