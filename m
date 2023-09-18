Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E887A4B6B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:06:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFoc-000234-QO; Mon, 18 Sep 2023 11:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFoW-0001yO-7Y
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFoT-0007Wf-L7
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695049524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hyQYA7IIeCzdPkW4Ca2xXB9ZVoHu7kA9b3a5ereaXB4=;
 b=c6Xkco5Tlvo0aH9qC3Xgao0n94rbF+2cgYllWlCXWbk8Zq/Lc/Rk5ISsGoq7nBtAACrUV3
 jcc0kMQpGd6+pgvDQsHtNjHQRfBgL9IoVtCGUOVqda3SQ9kdOerTwXBzGm02G8RkIo9wkp
 inNPuwksjMPoqKZ6PRoSYLS2MHrWA2Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-ss7Gj89nMoqc3YVwzhwKuA-1; Mon, 18 Sep 2023 11:05:19 -0400
X-MC-Unique: ss7Gj89nMoqc3YVwzhwKuA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3D7829ABA21;
 Mon, 18 Sep 2023 15:05:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB749C158BA;
 Mon, 18 Sep 2023 15:05:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B5E7821E6900; Mon, 18 Sep 2023 17:05:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: kkostiuk@redhat.com,  michael.roth@amd.com,  berrange@redhat.com,
 qemu-devel@nongnu.org,  hmodi@aviatrix.com
Subject: Re: [PATCH 2/3] qga: Add optional stream-output argument to guest-exec
References: <cover.1695034158.git.dxu@dxuuu.xyz>
 <604ef5fd5bda8acdb837b5d28ec405e9fb0332a3.1695034158.git.dxu@dxuuu.xyz>
Date: Mon, 18 Sep 2023 17:05:03 +0200
In-Reply-To: <604ef5fd5bda8acdb837b5d28ec405e9fb0332a3.1695034158.git.dxu@dxuuu.xyz>
 (Daniel Xu's message of "Mon, 18 Sep 2023 04:54:22 -0600")
Message-ID: <87il87bjz4.fsf@pond.sub.org>
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

Daniel Xu <dxu@dxuuu.xyz> writes:

> Currently, commands run through guest-exec are "silent" until they
> finish running. This is fine for short lived commands. But for commands
> that take a while, this is a bad user experience.
>
> Usually long running programs know that they will run for a while. To
> improve user experience, they will typically print some kind of status
> to output at a regular interval. So that the user knows that their
> command isn't just hanging.
>
> This commit adds support for an optional stream-output parameter to
> guest-exec. This causes subsequent calls to guest-exec-status to return
> all buffered output. This allows downstream applications to be able to
> relay "status" to the end user.
>
> If stream-output is requested, it is up to the guest-exec-status caller
> to keep track of the last seen output position and slice the returned
> output appropriately. This is fairly trivial for a client to do. And it
> is a more reliable design than having QGA internally keep track of
> position -- for the cases that the caller "loses" a response.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

[...]

> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index b720dd4379..0a76e35082 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1315,13 +1315,18 @@
>  # @capture-output: bool flag to enable capture of stdout/stderr of
>  #     running process.  defaults to false.
>  #
> +# @stream-output: causes future guest-exec-status calls to always
> +#     return current captured output rather than waiting to return
> +#     it all when the command exits. defaults to false. (since: 8.2)

So guest-exec-status normally returns no captured output until the
process terminates, right?  Its documentation (shown below for
convenience) did not make me expect this!

> +#
>  # Returns: PID on success.
>  #
>  # Since: 2.5
>  ##
>  { 'command': 'guest-exec',
>    'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
> -               '*input-data': 'str', '*capture-output': 'GuestExecCaptureOutput' },
> +               '*input-data': 'str', '*capture-output': 'GuestExecCaptureOutput',
> +               '*stream-output': 'bool' },
>    'returns': 'GuestExec' }

   ##
   # @GuestExecStatus:
   #
   # @exited: true if process has already terminated.
   #
   # @exitcode: process exit code if it was normally terminated.
   #
   # @signal: signal number (linux) or unhandled exception code (windows)
   #     if the process was abnormally terminated.
   #
   # @out-data: base64-encoded stdout of the process
   #
   # @err-data: base64-encoded stderr of the process Note: @out-data and
   #     @err-data are present only if 'capture-output' was specified for
   #     'guest-exec'
   #
   # @out-truncated: true if stdout was not fully captured due to size
   #     limitation.
   #
   # @err-truncated: true if stderr was not fully captured due to size
   #     limitation.
   #
   # Since: 2.5
   ##
   { 'struct': 'GuestExecStatus',
     'data': { 'exited': 'bool', '*exitcode': 'int', '*signal': 'int',
               '*out-data': 'str', '*err-data': 'str',
               '*out-truncated': 'bool', '*err-truncated': 'bool' }}
   ##
   # @guest-exec-status:
   #
   # Check status of process associated with PID retrieved via
   # guest-exec.  Reap the process and associated metadata if it has
   # exited.
   #
   # @pid: pid returned from guest-exec
   #
   # Returns: GuestExecStatus on success.
   #
   # Since: 2.5
   ##
   { 'command': 'guest-exec-status',
     'data':    { 'pid': 'int' },
     'returns': 'GuestExecStatus' }

Could you throw in a patch to clarify what exactly is returned while the
process is still running, and what only after it terminated?  It should
go first.


