Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F67D74ABF6
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 09:33:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHfxL-0000yO-Uw; Fri, 07 Jul 2023 03:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHfxJ-0000xa-GG
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 03:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHfxI-0003ea-4c
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 03:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688715158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=43QnX6yNEo+tUWV7GRYdiRIwU35C+WdS1xsF1gEqhMo=;
 b=QfMOqb0UW6jjirqj98xCrE+rVDmPXqc5PBMM2pOuaPtiV6vwRN9G7crocyZLbkBeVru8tz
 YTr2YUA+u24l1KGfJb0CAPyjWEzglquJAJ423/pyn8YxwHpQF2OXnimHsbDskNEtQEIsrw
 lGWc/K30kI14NfZ/2i6mFOtdEpfNTPU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-lZqlvhWvOwCzjWyl3wmpyA-1; Fri, 07 Jul 2023 03:32:37 -0400
X-MC-Unique: lZqlvhWvOwCzjWyl3wmpyA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A39FE1C0878B;
 Fri,  7 Jul 2023 07:32:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8188C2166B25;
 Fri,  7 Jul 2023 07:32:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C41D21E6A1F; Fri,  7 Jul 2023 09:32:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  libvir-list@redhat.com,  Peter Xu
 <peterx@redhat.com>,  qemu-block@nongnu.org,  Eric Blake
 <eblake@redhat.com>,  Fam Zheng <fam@euphon.net>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 0/5] Migration deprecated parts
References: <20230622195019.4396-1-quintela@redhat.com>
Date: Fri, 07 Jul 2023 09:32:35 +0200
In-Reply-To: <20230622195019.4396-1-quintela@redhat.com> (Juan Quintela's
 message of "Thu, 22 Jun 2023 21:50:14 +0200")
Message-ID: <87sfa0kwh8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Doesn't apply to master, and has no Based-on: tags telling me what to
apply first.  Please advise :)


