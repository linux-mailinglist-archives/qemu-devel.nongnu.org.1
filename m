Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F4C7B2C01
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 07:48:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm6M0-0000wR-9f; Fri, 29 Sep 2023 01:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm6Lv-0000w1-TY
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 01:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm6Lf-0004oo-5n
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 01:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695966453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d1kpfHhNbA1821fA0+8CurRqn+GEPGqvSujsQ9paAMk=;
 b=P6HgSEUz8YoUuzpby7Vt+x4nmr+DjAAgEno58jfhr87HU5spB1nKHeraQzfS7aGzuzgKXb
 SsCXbF/pnEFtiHJwmRZsxbSQLNWkXFyT/ULF8E/9rFbVAzBkfBMjOB6JHTMMNYuTN6BixD
 FZZXt1wh7haSdnz7MKXS5Rumrbfniug=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-ca9pnaZnNbqt5-p52Ocnvw-1; Fri, 29 Sep 2023 01:47:30 -0400
X-MC-Unique: ca9pnaZnNbqt5-p52Ocnvw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B24FC101A585;
 Fri, 29 Sep 2023 05:47:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8422510F1BE7;
 Fri, 29 Sep 2023 05:47:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8FA6F21E6904; Fri, 29 Sep 2023 07:47:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/acpi: changes towards enabling -Wshadow=local
References: <20230922124203.127110-1-anisinha@redhat.com>
Date: Fri, 29 Sep 2023 07:47:28 +0200
In-Reply-To: <20230922124203.127110-1-anisinha@redhat.com> (Ani Sinha's
 message of "Fri, 22 Sep 2023 18:12:02 +0530")
Message-ID: <87msx5jztb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

Ani Sinha <anisinha@redhat.com> writes:

> Code changes in acpi that addresses all compiler complaints coming from enabling
> -Wshadow flags. Enabling -Wshadow catches cases of local variables shadowing
> other local variables or parameters. These makes the code confusing and/or adds
> bugs that are difficult to catch.
>
> The code is tested to build with and without the flag turned on.
>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Philippe Mathieu-Daude <philmd@linaro.org>
> CC: mst@redhat.com
> CC: imammedo@redhat.com
> Message-Id: <87r0mqlf9x.fsf@pond.sub.org>

This is my "Help wanted for enabling -Wshadow=local" post.

A commit's Message-Id tag is supposed to point to the patch submission
e-mail, and git-am will add that:

  Message-ID: <20230922124203.127110-1-anisinha@redhat.com>

We'll have two Message-IDs then.  Confusing.

Could perhaps use

  See-also: Message-Id: <87r0mqlf9x.fsf@pond.sub.org>

but I doubt it's worth the bother.

> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Queued less the extra Message-Id, thanks!


