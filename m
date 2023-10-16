Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9337CA6BA
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 13:30:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsLmk-0003pa-WC; Mon, 16 Oct 2023 07:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1qsLmi-0003pS-PN
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:29:21 -0400
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1qsLmh-0008H2-4Y
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:29:20 -0400
Received: from blackfin.pond.sub.org (p4fd04c8c.dip0.t-ipconnect.de
 [79.208.76.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 7817E269FC;
 Mon, 16 Oct 2023 13:47:45 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4E29B21E6A1F; Mon, 16 Oct 2023 13:29:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Juan Quintela <quintela@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v3 4/4] migration/qapi: Drop @MigrationParameter enum
In-Reply-To: <ZRsrG5QdnEh0jiXd@x1n> (Peter Xu's message of "Mon, 2 Oct 2023
 16:42:03 -0400")
Date: Mon, 16 Oct 2023 08:29:58 +0200
Lines: 112
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-5-peterx@redhat.com>
 <87a5t8is2d.fsf@pond.sub.org> <ZRsrG5QdnEh0jiXd@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Message-ID: <87ttqqiz5f.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a01:4f8:13b:3ad0:1::3;
 envelope-from=armbru@pond.sub.org; helo=oxygen.pond.sub.org
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Sep 26, 2023 at 10:43:22PM +0200, Markus Armbruster wrote:
>> Loophole...  Here's the stupidest solution that could possibly work:
>> 
>>     ##
>>     # @MigrationParameter:
>>     #
>>     # TODO: elide from generated documentation (type is used only
>>     #     internally, and not visible in QMP)
>>     #
>>     # Features:
>>     #
>>     # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
>>     #     are experimental.
>>     #
>>     # Since: 2.4
>>     ##
>> 
>> Works because the QAPI generator currently doesn't flag missing member
>> documentation, and quietly substitutes "Not documented" instead.
>
> Didn't work for me..
>
> In file included from ../qapi/qapi-schema.json:61:
> ../qapi/migration.json:681:1: unexpected de-indent (expected at least 4 spaces)
>
> L681 points to the "Features:".
>
> But maybe I did it wrong somewhere?

Parser bug?  Moving the TODO down some works around the issue:

    ##
    # @MigrationParameter:
    #
    # Features:
    #
    # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
    #     are experimental.
    #
    # TODO: elide from generated documentation (type is used only
    #     internally, and not visible in QMP)
    #
    # Since: 2.4
    ##

Weird.

Better, because even stupider: drop the feature flags.  They have no
effect on internal use, and there is no external use.

    ##
    # @MigrationParameter:
    #
    # TODO: elide from generated documentation (type is used only
    #     internally, and not visible in QMP)
    #
    # Since: 2.4
    ##
    { 'enum': 'MigrationParameter',
      'data': ['announce-initial', 'announce-max',
               'announce-rounds', 'announce-step',
               'compress-level', 'compress-threads', 'decompress-threads',
               'compress-wait-thread', 'throttle-trigger-threshold',
               'cpu-throttle-initial', 'cpu-throttle-increment',
               'cpu-throttle-tailslow',
               'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
               'downtime-limit',
               'x-checkpoint-delay',
               'block-incremental',
               'multifd-channels',
               'xbzrle-cache-size', 'max-postcopy-bandwidth',
               'max-cpu-throttle', 'multifd-compression',
               'multifd-zlib-level', 'multifd-zstd-level',
               'block-bitmap-mapping',
               'x-vcpu-dirty-limit-period',
               'vcpu-dirty-limit'] }


>> Looks like
>> 
>>     "MigrationParameter" (Enum)
>>     ---------------------------
>> 
>> 
>>     Values
>>     ~~~~~~
>> 
>>     "announce-initial"
>>        Not documented
>> 
>>     "announce-max"
>>        Not documented
>> 
>> and so forth.  Sure ugly, but is it really worse than before?  It's now
>> obviously useless, whereas before it was unobviously useless.
>> 
>> This will break when we tighten up the QAPI generator to require member
>> documentation.  Along we a few hundred other violators.
>> 
>> We might want to add a way to say "members intentionally undocumented".
>> Could be useful for qapi/ui.json's QKeyCode.  Most of its 162 members
>> don't really need documentation...
>
> Yes I'd be super happy if we can declare that in qapi/.
>
> Please let me know if I missed something above on the trick; you're right
> it's only about the documentation we want to get rid of.  If we can achieve
> that with qapi generating the helpers that'll definitely be perfect.

Done, I think :)

