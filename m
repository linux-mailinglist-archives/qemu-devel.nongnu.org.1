Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 537EF718ACD
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:09:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4S7S-0004NH-NL; Wed, 31 May 2023 16:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4S7N-0004Mt-Fw
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:08:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4S7F-0006Ye-OJ
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685563695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ydu59z3P/m3XDHDDmzpMn91vIsgJKHN7ylgsTTZKq7A=;
 b=JTomXfXafoTMP2kC8zF6ENDfhoZfDhh4Z8N+O5fx7IHJ6WeB/NkJ4UN/fKblcI/XTxj5jL
 krQxy1tDGdge56RE5XQPI9AmUIjDxunNq7CcYf0UxOqHmgo554RhKey/scEZB6rLjtedVK
 ncuUaN9iMNMxcY1FWH9+fM0wARUcmUo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-CG3FQ_BzMSCJRW9EdJti8A-1; Wed, 31 May 2023 16:08:12 -0400
X-MC-Unique: CG3FQ_BzMSCJRW9EdJti8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40D1D800888;
 Wed, 31 May 2023 20:08:11 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 836152166B25;
 Wed, 31 May 2023 20:08:09 +0000 (UTC)
Date: Wed, 31 May 2023 15:08:07 -0500
From: Eric Blake <eblake@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Riku Voipio <riku.voipio@iki.fi>, Markus Armbruster <armbru@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, Eduardo Habkost <eduardo@habkost.net>, 
 Warner Losh <imp@bsdimp.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 libvir-list@redhat.com, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v6 05/11] docs/deprecated: move QMP events bellow QMP
 command section
Message-ID: <f2xpjdhqm6i4nnyhcicqndmbv4y5oop4td3464ebf4plfr7yl5@2s7r7gqgiv6l>
References: <20230526165401.574474-1-alex.bennee@linaro.org>
 <20230526165401.574474-6-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230526165401.574474-6-alex.bennee@linaro.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

In the subject: s/bellow/below/

On Fri, May 26, 2023 at 05:53:55PM +0100, Alex Bennée wrote:
> Also rename the section to make the fact this is part of the
> management protocol even clearer.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  docs/about/deprecated.rst | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Otherwise,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


