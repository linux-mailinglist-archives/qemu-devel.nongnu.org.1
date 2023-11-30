Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D48AA7FF05D
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 14:41:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8hIJ-0002Ht-MN; Thu, 30 Nov 2023 08:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8hI3-0002Ed-1B
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 08:41:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8hI1-0008Ae-Jp
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 08:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701351672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kawx21l4Sqb97cinJgnCFNHuqemu9NZkb9To8vuw+Sk=;
 b=YnPMdtZbIkwPqSj08fSvk8yWLGGUoZv4+23ttt7fQoB+eHM/ukJs2lgpumcmIg2wB1l01f
 udT+/8zp9GT8nEBGxhs87VBRiBmRVoyuPTCCSVcg0M6D61OW+RHfCGPHdh3HVX5JgQjSxO
 O02SOAm1/ENxdp9IKg64mxUbAp6175c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-863pm83-OSyMve0bF47UEQ-1; Thu, 30 Nov 2023 08:41:09 -0500
X-MC-Unique: 863pm83-OSyMve0bF47UEQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04429101A594;
 Thu, 30 Nov 2023 13:41:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D678E492BFC;
 Thu, 30 Nov 2023 13:41:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A035821E6A1F; Thu, 30 Nov 2023 14:41:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>,  qemu-devel@nongnu.org,
 thuth@redhat.com,  philmd@linaro.org,  peter.maydell@linaro.org,  Stefan
 Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH for-8.2 2/2] string-output-visitor: Support lists for
 non-integer types
References: <20231121173416.346610-1-kwolf@redhat.com>
 <20231121173416.346610-3-kwolf@redhat.com>
 <87bkbb9yht.fsf@pond.sub.org>
 <CAJSP0QXsbVV45587ufPM5MFErMQUonHzoCFc2ZzGWJKFqbYN7w@mail.gmail.com>
Date: Thu, 30 Nov 2023 14:41:02 +0100
In-Reply-To: <CAJSP0QXsbVV45587ufPM5MFErMQUonHzoCFc2ZzGWJKFqbYN7w@mail.gmail.com>
 (Stefan Hajnoczi's message of "Thu, 30 Nov 2023 08:21:24 -0500")
Message-ID: <87fs0n8ikx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Thu, 30 Nov 2023 at 08:12, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> I understand Stefan already took this patch.  I'm looking at it anyway,
>> because experience has taught me to be very afraid of the string
>> visitors.
>
> Hi Markus,
> I should have waited for your review. Sorry!

No reason to be sorry!  It's a regression, and we're at rc2 already.


