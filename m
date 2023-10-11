Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8B37C5793
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:57:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaeK-0006ri-6W; Wed, 11 Oct 2023 10:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqaeI-0006rI-GH
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqaeH-0001h5-6R
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697036240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qdTRELyGKNrOfhsKs24ayC9lLLWo2rgOUpPX1JPXX/E=;
 b=f6LmGe3ToH8nZqEEMjEJUBfc/FwV7rCcruC4OHFh7VELXLuW9OiKZKsWNB6RBNJqW2Rwk9
 X56D/3jxjR/0z/jxe3Ky/brwwT/Lep+u8nn19V8cpjw6V+eQO2Q33tqQvYvrFyC08VAsHJ
 eduA2VYAGRblxDlq9YxVPDvlJYWiJK0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-ZVw3P8fVMjqWs_PQQUNtOA-1; Wed, 11 Oct 2023 10:57:18 -0400
X-MC-Unique: ZVw3P8fVMjqWs_PQQUNtOA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53D2F1C0CCC2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 14:57:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33474492C3E
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 14:57:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3E0EE21E6904; Wed, 11 Oct 2023 16:57:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] target/i386: fix shadowed variable pasto
References: <20231011135350.438492-1-pbonzini@redhat.com>
Date: Wed, 11 Oct 2023 16:57:17 +0200
In-Reply-To: <20231011135350.438492-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Wed, 11 Oct 2023 15:53:50 +0200")
Message-ID: <877cntfbqq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Commit a908985971a ("target/i386/seg_helper: introduce tss_set_busy",
> 2023-09-26) failed to use the tss_selector argument of the new function,
> which was therefore unused.
>
> This shows up as a #GP fault when booting old versions of 32-bit
> Linux.
>
> Fixes: a908985971a ("target/i386/seg_helper: introduce tss_set_busy", 2023-09-26)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Queued.  Thanks!


