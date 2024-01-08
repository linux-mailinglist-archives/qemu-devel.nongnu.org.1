Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2668268D3
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 08:45:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMkIe-0007c7-Dx; Mon, 08 Jan 2024 02:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rMkIO-0007bn-HK
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 02:43:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rMkIM-0001f5-MU
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 02:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704699817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bf0AYtKzIdP1WL09gQVf/zrTdEJ0JDyOaDrCfk3tjew=;
 b=bFkkrLYN3ueUNEl1sb0f0rs3QjGfhgO8mYze8eeEywxOEjyCuRqUeBYsClimCr+eYFIAzg
 cdNsaM1DQjfIN/YiYH+RECGNE+U/V0LETU2quEslUDyc79a57vY4+kVqpKwFx8/wd/ukoL
 R+GozHIPV3hShSFyQUdxOBFZDcacC6g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-JvLuypwOPE-h_5iVww5JUA-1; Mon, 08 Jan 2024 02:43:33 -0500
X-MC-Unique: JvLuypwOPE-h_5iVww5JUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CF13845DC2;
 Mon,  8 Jan 2024 07:43:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2884A2166B33;
 Mon,  8 Jan 2024 07:43:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2480C21E6682; Mon,  8 Jan 2024 08:43:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Juan Quintela <quintela@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH V6 03/14] cpus: stop vm in suspended runstate
In-Reply-To: <bcc1622d-fdc9-4faa-8f7e-6e76c8a6ec0e@oracle.com> (Steven
 Sistare's message of "Wed, 3 Jan 2024 09:47:20 -0500")
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-4-git-send-email-steven.sistare@oracle.com>
 <87bkaiig2s.fsf@pond.sub.org>
 <9d613137-24aa-4323-aee1-0d38b91339c5@oracle.com>
 <87sf3ta31i.fsf@pond.sub.org>
 <bcc1622d-fdc9-4faa-8f7e-6e76c8a6ec0e@oracle.com>
Date: Mon, 08 Jan 2024 08:43:32 +0100
Message-ID: <87y1d0w9qz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Steven Sistare <steven.sistare@oracle.com> writes:

[...]

> With these changes, can I add your Acked-by to the commit?

I'm afraid I lost context over the break.  Suggest you post v7, and I
provide my Acked-by there.  Likely easier for me.

Happy new year!

[...]


