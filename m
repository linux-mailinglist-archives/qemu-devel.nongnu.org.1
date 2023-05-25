Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEE271130F
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:03:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FJ4-0004cx-BF; Thu, 25 May 2023 14:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2FIw-0004X4-W0
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2FIu-0003SV-Bj
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685037791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NH3SrGZ+F7wGIGejdkJMF89luqdwQhNViRZoVsrhVxg=;
 b=PObknF6XrLY1AzX41KEYnFNmq5jMkzCLMsoKKwmNg/c7K36nWxAgtyGa9MGtMvFF5jEefe
 X/RDtElxTHK22gQFjEG1QdODSd2Pg+p2FPd8qpVRhOy2slSIlfB0ZpPcj1sAaIfhz/915k
 xygZDdGrqX6N1LCinQSFGyY0NgSq3DY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-FNLJ9GtiPRaHSzvkfo9PHQ-1; Thu, 25 May 2023 14:03:00 -0400
X-MC-Unique: FNLJ9GtiPRaHSzvkfo9PHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B51D53C13934;
 Thu, 25 May 2023 18:02:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F6ADC0448E;
 Thu, 25 May 2023 18:02:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 81B7E21E692E; Thu, 25 May 2023 20:02:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  quintela@redhat.com,
 dgilbert@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v5 8/9] migration: Introduced MigrateChannelList struct
 to migration code flow.
References: <20230519094617.7078-1-het.gala@nutanix.com>
 <20230519094617.7078-9-het.gala@nutanix.com>
Date: Thu, 25 May 2023 20:02:58 +0200
In-Reply-To: <20230519094617.7078-9-het.gala@nutanix.com> (Het Gala's message
 of "Fri, 19 May 2023 09:46:16 +0000")
Message-ID: <871qj4jnl9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Het Gala <het.gala@nutanix.com> writes:

> Integrated MigrateChannelList with all transport backends (socket, exec
> and rdma) for both source and destination migration code flow.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>

clang warns for me:

../migration/migration.c:497:13: warning: variable 'addrs' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../migration/migration.c:503:54: note: uninitialized use occurs here
    if (!migration_channels_and_transport_compatible(addrs, errp)) {
                                                     ^~~~~
../migration/migration.c:497:9: note: remove the 'if' if its condition is always true
        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../migration/migration.c:497:13: warning: variable 'addrs' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
            ^~~
../migration/migration.c:503:54: note: uninitialized use occurs here
    if (!migration_channels_and_transport_compatible(addrs, errp)) {
                                                     ^~~~~
../migration/migration.c:497:13: note: remove the '&&' if its condition is always true
        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
            ^~~~~~
../migration/migration.c:477:36: note: initialize the variable 'addrs' to silence this warning
    g_autoptr(MigrateAddress) addrs;
                                   ^
                                    = NULL
../migration/migration.c:1735:13: warning: variable 'addrs' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../migration/migration.c:1741:54: note: uninitialized use occurs here
    if (!migration_channels_and_transport_compatible(addrs, errp)) {
                                                     ^~~~~
../migration/migration.c:1735:9: note: remove the 'if' if its condition is always true
        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../migration/migration.c:1735:13: warning: variable 'addrs' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
            ^~~
../migration/migration.c:1741:54: note: uninitialized use occurs here
    if (!migration_channels_and_transport_compatible(addrs, errp)) {
                                                     ^~~~~
../migration/migration.c:1735:13: note: remove the '&&' if its condition is always true
        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
            ^~~~~~
../migration/migration.c:1715:36: note: initialize the variable 'addrs' to silence this warning
    g_autoptr(MigrateAddress) addrs;
                                   ^
                                    = NULL
4 warnings generated.


