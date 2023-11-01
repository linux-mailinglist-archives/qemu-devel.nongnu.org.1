Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD067DDFDA
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 11:53:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy8qW-0000JO-WE; Wed, 01 Nov 2023 06:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qy8qU-0000J5-De
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 06:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qy8qR-0000wk-6r
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 06:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698835986;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1aeRDcNE5IuNBZUmUd/Q7yHAggwxk1CyggDM/8CPRmE=;
 b=M6ZVgrF7d3QSKY/yl5gQTOwehBvACQB3XBvQY7GxBBMRublT8Ajvv5G0pgFumDCWKYvaoh
 3WYA70GdpYGpa3kkoJjYn/X3sfUdLfz6LPIf9uEYlSuKJqiOQhkEQt2gYoJz34Blm04/9e
 BGYtfPx9pCk927oXkmhZ6MKLYLO1Fyg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-1XaGxc9pOMC2kWCIL5qWSw-1; Wed, 01 Nov 2023 06:53:01 -0400
X-MC-Unique: 1XaGxc9pOMC2kWCIL5qWSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A2B9811E82
 for <qemu-devel@nongnu.org>; Wed,  1 Nov 2023 10:53:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FD8B134;
 Wed,  1 Nov 2023 10:53:00 +0000 (UTC)
Date: Wed, 1 Nov 2023 10:52:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com
Subject: Re: [PATCH v2 2/3] tools: build qemu-vmsr-helper
Message-ID: <ZUIuCgtbT2Oj+w74@redhat.com>
References: <20231031144605.64822-1-aharivel@redhat.com>
 <20231031144605.64822-3-aharivel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231031144605.64822-3-aharivel@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Oct 31, 2023 at 03:46:02PM +0100, Anthony Harivel wrote:
> Introduce a privileged helper to access RAPL MSR.
> 
> The privileged helper tool, qemu-vmsr-helper, is designed to provide
> virtual machines with the ability to read specific RAPL (Running Average
> Power Limit) MSRs without requiring CAP_SYS_RAWIO privileges or relying
> on external, out-of-tree patches.
> 
> The helper tool leverages Unix permissions and SO_PEERCRED socket
> options to enforce access control, ensuring that only processes
> explicitly requesting read access via readmsr() from a valid Thread ID
> can access these MSRs.
> 
> The list of RAPL MSRs that are allowed to be read by the helper tool is
> defined in rapl-msr-index.h. This list corresponds to the RAPL MSRs that
> will be supported in the next commit titled "Add support for RAPL MSRs
> in KVM/QEMU."
> 
> Signed-off-by: Anthony Harivel <aharivel@redhat.com>
> ---
>  docs/tools/index.rst            |   1 +
>  docs/tools/qemu-vmsr-helper.rst |  89 ++++++
>  meson.build                     |   5 +
>  tools/i386/qemu-vmsr-helper.c   | 507 ++++++++++++++++++++++++++++++++
>  tools/i386/rapl-msr-index.h     |  28 ++
>  5 files changed, 630 insertions(+)
>  create mode 100644 docs/tools/qemu-vmsr-helper.rst
>  create mode 100644 tools/i386/qemu-vmsr-helper.c
>  create mode 100644 tools/i386/rapl-msr-index.h
> 


> +/*
> + * Check if the TID that request the MSR read
> + * belongs to the peer. It should a TID of a vCPU.
> + */
> +static bool is_tid_present(pid_t pid, pid_t tid)
> +{
> +    char pidStr[20];
> +    char tidStr[20];
> +
> +    snprintf(pidStr, sizeof(pidStr), "%d", pid);
> +    snprintf(tidStr, sizeof(tidStr), "%d", tid);
> +
> +    char pidPath[256];
> +    char tidPath[256];
> +
> +    snprintf(pidPath, sizeof(pidPath), "/proc/%s", pidStr);
> +    snprintf(tidPath, sizeof(tidPath), "/proc/%s/task/%s", pidStr, tidStr);
> +
> +    /* Check if the TID directory exists within the PID directory */
> +    if (access(tidPath, F_OK) == 0) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +/*
> + * Only the RAPL MSR in target/i386/cpu.h are allowed
> + */
> +static bool is_msr_allowed(uint32_t reg)
> +{
> +    switch (reg) {
> +    case MSR_RAPL_POWER_UNIT:
> +    case MSR_PKG_POWER_LIMIT:
> +    case MSR_PKG_ENERGY_STATUS:
> +    case MSR_PKG_POWER_INFO:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}

> +    /*
> +     * Check peer credentials
> +     * Only QEMU PID/TID are allowed

This says only QEMU is allowed

> +     */
> +    qio_channel_get_peercred(QIO_CHANNEL(client->ioc), &cred, &local_err);
> +
> +    if (cred.pid == 0) {
> +        if (local_err != NULL) {
> +            error_report_err(local_err);
> +        }
> +        error_report("Failed to get peer credentials");
> +        goto out;
> +    }
> +
> +    /*
> +     * Read the requested MSR
> +     * Only RAPL MSR in rapl-msr-index.h is allowed
> +     */
> +    r = qio_channel_read_all(QIO_CHANNEL(client->ioc),
> +                             (char *) &request, sizeof(request), NULL);
> +    if (!is_msr_allowed(request[0]) || r < 0) {
> +        error_report("Read request fail: %d, %d", request[0], request[1]);
> +        goto out;
> +    }
> +
> +    vmsr = vmsr_read_msr(request[0], request[1]);
> +
> +    if (!is_tid_present(cred.pid, request[2])) {
> +        error_report("requested TID not in peer PID");
> +        vmsr = 0;
> +    }

This check is merely validating the the thread ID in the message
is a child of the process ID connected to the socket. Any process
on the entire host can satisfy this requirement.

I don't see what is limiting this to only QEMU as claimed earlier,
unless you're expecting the UNIX socket permissions to be such
that only processes under the qemu:qemu user:group pair can
access to the socket ? That would be a libvirt based permissions
assumption though.



> +
> +    r = qio_channel_write_all(QIO_CHANNEL(client->ioc),
> +                         (char *) &vmsr, sizeof(vmsr), NULL);
> +    if (r < 0) {
> +        error_report("write vmsr failed");
> +        goto out;
> +    }
> +
> +out:
> +    object_unref(OBJECT(client->ioc));
> +    g_free(client);
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


