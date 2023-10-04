Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E07587B8104
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:33:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo209-0002if-19; Wed, 04 Oct 2023 09:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qo202-0002iE-Lt
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:33:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qo1zz-0002xH-NP
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:33:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EFF861F38A;
 Wed,  4 Oct 2023 13:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696426390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UIjY2Hskd8c+68QAzg1YLJFWE54CzBPJ6eTQ3SGWNsg=;
 b=0aLSl/KwZ+si+6kO6x3uIEzCznAWmeN5lRr+dQSYmqGA9zsr4sI8UvpAICqCzjiJ2hueBh
 xW5tsTftFq3msXQfCur2j5/S3wxbWEfKThs2iLTw6nP1g5Vxx9Fbwq2be7gxXxZ4SqX6so
 +rOUuknXtKmuX1rBChEPE7WL2Yueu3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696426390;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UIjY2Hskd8c+68QAzg1YLJFWE54CzBPJ6eTQ3SGWNsg=;
 b=/fkt7UTsoOc2cmR1nLICWPkLFkqFYGtxNYbZx+ycOp/SRr0/ZQ0mJ6jguNJXLAIGCgV0cP
 UJHPDhDimlKy0AAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82E43139F9;
 Wed,  4 Oct 2023 13:33:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iqfKE5VpHWXzWAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 04 Oct 2023 13:33:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: Re: [PATCH v11 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
In-Reply-To: <20231004075851.219173-1-het.gala@nutanix.com>
References: <20231004075851.219173-1-het.gala@nutanix.com>
Date: Wed, 04 Oct 2023 10:33:07 -0300
Message-ID: <871qea5x7w.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Het Gala <het.gala@nutanix.com> writes:

> This is v11 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
> for upstream review.
>
> Update: Daniel has reviewed all patches and is okay with them. Markus has also
>         given Acked-by tag for patches related to QAPI syntax change.
> Fabiano, Juan and other migration maintainers, let me know if there are still
> improvements to be made in this patchset series.
>
> Link to previous upstream community patchset links:
> v1: https://lists.gnu.org/archive/html/qemu-devel/2022-12/msg04339.html
> v2: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02106.html
> v3: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02473.html
> v4: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03064.html
> v5: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04845.html
> v6: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg01251.html
> v7: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02027.html
> v8: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02770.html
> v9: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg04216.html
> v10: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg05022.html
>
> v10 -> v11 changelog:
> -------------------
> - Resolved make check errors as its been almost two months since v10
>   version of this patchset series went out. Till date migration workflow
>   might have changed which caused make check errors.

Sorry, there must be a misunderstanding here. This series still has
problems. Just look at patch 6 that adds the "channel-type" parameter and
patch 10 that uses "channeltype" in the test (without hyphen). This
cannot work.

There's also several instances of g_autoptr being used incorrectly. I
could comment on every patch individually, but this series cannot have
passed make check.

Please resend this with the issues fixed and drop the Reviewed-bys from
the affected patches.

Summary of Failures:

  1/418 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test         ERROR           0.44s   killed by signal 6 SIGABRT
  7/418 qemu:qtest+qtest-i386 / qtest-i386/migration-test             ERROR           0.47s   killed by signal 6 SIGABRT
121/418 qemu:qtest+qtest-x86_64 / qtest-x86_64/tpm-crb-swtpm-test     ERROR           0.55s   killed by signal 6 SIGABRT
128/418 qemu:qtest+qtest-x86_64 / qtest-x86_64/tpm-tis-swtpm-test     ERROR           0.72s   killed by signal 6 SIGABRT
131/418 qemu:qtest+qtest-i386 / qtest-i386/ahci-test                  ERROR          12.53s   killed by signal 6 SIGABRT
134/418 qemu:qtest+qtest-x86_64 / qtest-x86_64/ahci-test              ERROR          13.04s   killed by signal 6 SIGABRT
143/418 qemu:qtest+qtest-x86_64 / qtest-x86_64/virtio-net-failover    ERROR           2.95s   killed by signal 6 SIGABRT
147/418 qemu:qtest+qtest-i386 / qtest-i386/qos-test                   ERROR          16.12s   killed by signal 6 SIGABRT
148/418 qemu:qtest+qtest-x86_64 / qtest-x86_64/qos-test               ERROR          16.15s   killed by signal 6 SIGABRT
177/418 qemu:qtest+qtest-i386 / qtest-i386/tpm-crb-swtpm-test         ERROR           0.55s   killed by signal 6 SIGABRT
180/418 qemu:qtest+qtest-i386 / qtest-i386/tpm-tis-swtpm-test         ERROR           0.59s   killed by signal 6 SIGABRT
197/418 qemu:qtest+qtest-i386 / qtest-i386/virtio-net-failover        ERROR           2.38s   killed by signal 6 SIGABRT
305/418 qemu:block / io-qcow2-181                                     ERROR           0.52s   exit status 1
312/418 qemu:block / io-qcow2-060                                     ERROR           9.89s   exit status 1
316/418 qemu:block / io-qcow2-203                                     ERROR           0.84s   exit status 1


