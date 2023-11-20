Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E27847F1DA6
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 21:01:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5AQl-0007OT-9U; Mon, 20 Nov 2023 14:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5AQj-0007OA-39
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 14:59:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5AQh-0007en-Gb
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 14:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700510374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MUP+ncsAxpROjlugPgk+m7xrqKtuog4RDOwAky07VY8=;
 b=WwdV6rerZ5YJe/NtWhRw0ajuwPl1ApFJXK+RnOLvvRFMg7BOstlq2rqWyr9PGODm0KF5ai
 8snhBn4/N/1yGBEYr7j3s5cWp3jV50cXRj6nsV/Xmj32PPvAxGD8iKJOIfvgTa9XCeEIUX
 uA4wE5EJepujtsEdkP86AehwQs4puS4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-D4iRJipDNk-aJ6x8nqaU9Q-1; Mon, 20 Nov 2023 14:59:32 -0500
X-MC-Unique: D4iRJipDNk-aJ6x8nqaU9Q-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6cd01bd39a3so827975a34.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 11:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700510372; x=1701115172;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MUP+ncsAxpROjlugPgk+m7xrqKtuog4RDOwAky07VY8=;
 b=VJ48u5BLTS+MJhSv5RMkR7yLpFkcARVTNhpRs0d+sCizSMydVp56VdEcVH3OwbFDyj
 WiFNGQehor+xn857vPlVDju4g/15dKCRotq3Y8rNvpb+zCanCr7ENezT1QCLZTTxsV7I
 8QBnZZaBKDDM26UlJO6K6/F8LQQOtHZ3YPeW/ctnyBLDOVPuH6kml3AiJndlg2217Zax
 TWTmqlF98yv6XFAUInZrJnklXInVNGk/dIsEZl3cqXkOqz0PknsvOCeyGsMi8hO0rZux
 iG5AKSvW27Q5LFwFJR8+P4graqhF/bjMtmS9v/1m/JK/+OlAFbrhRU2j8b27rKiRTHPf
 syJw==
X-Gm-Message-State: AOJu0YwJ9kd2pABSlvU+t0idrj2dL5sGtV2ecB0/SqWzkmTdFOXW3VeF
 J0zmOOQx+eXod4vCPfaZJVyuDQkLF5/6hUB3MJ4q4gD0LJufyPEFUF5k78g2h3Daul24N33AE7u
 dd0crGbswOdgVAZM=
X-Received: by 2002:a05:6358:199b:b0:16b:9882:2b7 with SMTP id
 v27-20020a056358199b00b0016b988202b7mr6055952rwn.3.1700510371945; 
 Mon, 20 Nov 2023 11:59:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQW/dESrWk3v24g7k1SLML/ITer3OQn8gmd6q2NiWF1KS8SXi1f8BghRLyQql8P9tqV9J6Bg==
X-Received: by 2002:a05:6358:199b:b0:16b:9882:2b7 with SMTP id
 v27-20020a056358199b00b0016b988202b7mr6055933rwn.3.1700510371616; 
 Mon, 20 Nov 2023 11:59:31 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 s8-20020ad44388000000b0067835abc38bsm2075089qvr.129.2023.11.20.11.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 11:59:31 -0800 (PST)
Date: Mon, 20 Nov 2023 14:59:30 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V5 02/12] cpus: stop vm in suspended state
Message-ID: <ZVu6ohk8_8xzyL-x@x1n>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-3-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1699900440-207345-3-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Nov 13, 2023 at 10:33:50AM -0800, Steve Sistare wrote:
> A vm in the suspended state is not completely stopped.  The VCPUs have been
> paused, but the cpu clock still runs, and runstate notifiers for the
> transition to stopped have not been called.  Modify vm_stop_force_state to
> completely stop the vm if the current state is suspended, to be called for
> live migration and snapshots.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  system/cpus.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/system/cpus.c b/system/cpus.c
> index f72c4be..c772708 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -255,6 +255,8 @@ void cpu_interrupt(CPUState *cpu, int mask)
>  static int do_vm_stop(RunState state, bool send_stop, bool force)
>  {
>      int ret = 0;
> +    bool running = runstate_is_running();
> +    bool suspended = runstate_check(RUN_STATE_SUSPENDED);
>  
>      if (qemu_in_vcpu_thread()) {
>          qemu_system_vmstop_request_prepare();
> @@ -267,10 +269,12 @@ static int do_vm_stop(RunState state, bool send_stop, bool force)
>          return 0;
>      }
>  
> -    if (runstate_is_running()) {
> +    if (running || (suspended && force)) {
>          runstate_set(state);
>          cpu_disable_ticks();

Not directly relevant, but this is weird that I just notice.

If we disable ticks before stopping vCPUs, IIUC it means vcpus can see
stall ticks.  I checked the vm_start() and indeed that one did it in the
other way round: we'll stop vCPUs before stopping the ticks.

> -        pause_all_vcpus();
> +        if (running) {
> +            pause_all_vcpus();
> +        }
>          vm_state_notify(0, state);
>          if (send_stop) {
>              qapi_event_send_stop();

IIUC the "force" is not actually needed.  It's only used when SUSPENDED,
right?

In general, considering all above, I'm wondering something like this would
be much cleaner (and dropping force)?

===8<===
static int do_vm_stop(RunState state, bool send_stop)
 {
+    bool suspended = runstate_check(RUN_STATE_SUSPENDED);
+    bool running = runstate_is_running();
     int ret = 0;
 
-    if (runstate_is_running()) {
+    /*
+     * RUNNING:   VM and vCPUs are all running
+     * SUSPENDED: VM is running, VCPUs are stopped
+     * Others:    VM and vCPUs are all stopped
+     */
+
+    /* Whether do we need to stop vCPUs? */
+    if (running) {
+        pause_all_vcpus();
+    }
+
+    /* Whether do we need to stop the VM in general? */
+    if (running || suspended) {
         runstate_set(state);
         cpu_disable_ticks();
-        pause_all_vcpus();
         vm_state_notify(0, state);
         if (send_stop) {
             qapi_event_send_stop();

-- 
Peter Xu


