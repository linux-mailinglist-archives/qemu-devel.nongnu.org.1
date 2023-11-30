Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8C47FFF2E
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 00:08:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8q77-0007UF-2d; Thu, 30 Nov 2023 18:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r8q75-0007U3-Oj
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 18:06:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r8q73-0001Wf-Rd
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 18:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701385587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AJlvh65LGx+0S8s8Tf7FahrqRPjxv6Ary5GlEVkzjZg=;
 b=FJ7AsJXuC43qfzP1XGEYk+NVcSR5OtgTVUJMCxxv+jsX8TU/Io7VF1PiYqvkUibA6nNJa7
 cf31x7jlYB4QjxtyGQ7lx1H+tPB4ODYQWhq3EmxC8AZnazbEIONBvlHUu0vLo2/S2IeQyw
 LQOT2CBsMOkKO6WRlmAddRN+BH++Nc0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-4RxnrmOEMrq98jMAYMx1JA-1; Thu, 30 Nov 2023 18:06:26 -0500
X-MC-Unique: 4RxnrmOEMrq98jMAYMx1JA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-423f3c6c904so3854481cf.1
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 15:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701385586; x=1701990386;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AJlvh65LGx+0S8s8Tf7FahrqRPjxv6Ary5GlEVkzjZg=;
 b=RljiEtE0MTehH1kcnx1jb8tsYKvOpg+JN/ohKlab8kG6BAIoyjdV68xDH4avBwRl/b
 ZwUGUUaX3f/NnmyHyaI2ArTfArF6FhUMcUfjZKnPdpR7bATDsm8IRzfaIAVqfzuU7L+A
 iBkqGMsfIey84Fl7woHtSTZK7kuGTs7/6x09u+c7FbxQE2y0U13b2lKV7d1CH3Cja09u
 mdjUHwvMi5X76jPJ6dV1JFUEswe0e5j+4mhuoYLscBm5Z0fHZDRu5oXDqVcS0i3vfkTB
 WCD8IlfiaU1FsODafIgp5txQSn68NbttaLdXKxvWBWoYhi98vdHq7gvPBXbgW1htvvs6
 FEQw==
X-Gm-Message-State: AOJu0Yzxvx6ACDW43U3ZmiBmBRI2KwVAE+8ev7yKVqbv9RvsIZcKjkJg
 9dDswPth8Nj5nFIp9qZ5M8IVRUf+5kQLXOHYL3BXVQGNC13bMH7KVZerlEzEcVfIzrc2uqrLEEj
 tklYh2qVfq/lKdEQ=
X-Received: by 2002:ac8:4d8f:0:b0:422:b29:ab71 with SMTP id
 a15-20020ac84d8f000000b004220b29ab71mr3111411qtw.0.1701385585855; 
 Thu, 30 Nov 2023 15:06:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5CoYOK2YYGiHGZNoFwAP1F1C50Hbp1NXxqjb7N2jONocm+JBbGBmn2iHbvTl3Wybe4clLDw==
X-Received: by 2002:ac8:4d8f:0:b0:422:b29:ab71 with SMTP id
 a15-20020ac84d8f000000b004220b29ab71mr3111390qtw.0.1701385585506; 
 Thu, 30 Nov 2023 15:06:25 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 b18-20020ac86bd2000000b0042388bce404sm910534qtt.57.2023.11.30.15.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 15:06:25 -0800 (PST)
Date: Thu, 30 Nov 2023 18:06:22 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V6 05/14] migration: propagate suspended runstate
Message-ID: <ZWkVbiQNl16hC1LW@x1n>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-6-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1701380247-340457-6-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Nov 30, 2023 at 01:37:18PM -0800, Steve Sistare wrote:
> If the outgoing machine was previously suspended, propagate that to the
> incoming side via global_state, so a subsequent vm_start restores the
> suspended state.  To maintain backward and forward compatibility, define
> the new field in a zero'd hole in the GlobalState struct.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  migration/global_state.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 4e2a9d8..de2532c 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -25,6 +25,7 @@ typedef struct {
>      uint8_t runstate[100];
>      RunState state;
>      bool received;
> +    bool vm_was_suspended;
>  } GlobalState;
>  
>  static GlobalState global_state;
> @@ -35,6 +36,7 @@ static void global_state_do_store(RunState state)
>      assert(strlen(state_str) < sizeof(global_state.runstate));
>      strpadcpy((char *)global_state.runstate, sizeof(global_state.runstate),
>                state_str, '\0');
> +    global_state.vm_was_suspended = vm_get_suspended();
>  }
>  
>  void global_state_store(void)
> @@ -68,6 +70,12 @@ static bool global_state_needed(void *opaque)
>          return true;
>      }
>  
> +    /* If the suspended state must be remembered, it is needed */
> +
> +    if (vm_get_suspended()) {
> +        return true;
> +    }
> +
>      /* If state is running or paused, it is not needed */
>  
>      if (strcmp(runstate, "running") == 0 ||
> @@ -109,6 +117,7 @@ static int global_state_post_load(void *opaque, int version_id)
>          return -EINVAL;
>      }
>      s->state = r;
> +    vm_set_suspended(s->vm_was_suspended || r == RUN_STATE_SUSPENDED);

IIUC current vm_was_suspended (based on my read of your patch) was not the
same as a boolean representing "whether VM is suspended", but only a
temporary field to remember that for a VM stop request.  To be explicit, I
didn't see this flag set in qemu_system_suspend() in your previous patch.

If so, we can already do:

  vm_set_suspended(s->vm_was_suspended);

Irrelevant of RUN_STATE_SUSPENDED?

>  
>      return 0;
>  }
> @@ -134,6 +143,7 @@ static const VMStateDescription vmstate_globalstate = {
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32(size, GlobalState),
>          VMSTATE_BUFFER(runstate, GlobalState),
> +        VMSTATE_BOOL(vm_was_suspended, GlobalState),
>          VMSTATE_END_OF_LIST()
>      },
>  };

I think this will break migration between old/new, unfortunately.  And
since the global state exist mostly for every VM, all VM setup should be
affected, and over all archs.

We used to have the version_id field right above for adding fields, but I
_think_ that will still break backward migration fron new->old binary, so
not wanted.  Juan can keep me honest.

The best thing is still machine compat properties, afaict, to fix.  It's
slightly involved, but let me attach a sample diff for you (at the end,
possibly working with your current patch kind-of squashed, but not ever
tested), hopefully make it slightly easier.

I'm wondering how bad it is to just ignore it, it's not as bad as if we
don't fix stop-during-suspend, in this case the worst case of forgetting
this field over migration is: if VM stopped (and used to be suspended) then
after migration it'll keep being stopped, however after "cont" it'll forget
the suspended state.  Not that bad!  IIUC SPR should always migrate with
suspended (rather than any fully stopped state), right?  Then shouldn't be
affected.  If risk is low, maybe we can leave this one for later?

Thanks,

===8<===

diff --git a/migration/migration.h b/migration/migration.h
index cf2c9c88e0..c3fd1f8347 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -470,6 +470,8 @@ struct MigrationState {
     bool switchover_acked;
     /* Is this a rdma migration */
     bool rdma_migration;
+    /* Whether remember global vm_was_suspended field? */
+    bool store_vm_was_suspended;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0c17398141..365e01c1c9 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -37,6 +37,7 @@ GlobalProperty hw_compat_8_1[] = {
     { "ramfb", "x-migrate", "off" },
     { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
     { "igb", "x-pcie-flr-init", "off" },
+    { "migration", "store-vm-was-suspended", false },
 };
 const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
 
diff --git a/migration/global_state.c b/migration/global_state.c
index 4e2a9d8ec0..ffa7bf82ca 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -25,6 +25,7 @@ typedef struct {
     uint8_t runstate[100];
     RunState state;
     bool received;
+    bool vm_was_suspended;
 } GlobalState;
 
 static GlobalState global_state;
@@ -124,6 +125,25 @@ static int global_state_pre_save(void *opaque)
     return 0;
 }
 
+static bool global_state_has_vm_was_suspended(void *opaque)
+{
+    return migrate_get_current()->store_vm_was_suspended;
+}
+
+static const VMStateDescription vmstate_vm_was_suspended = {
+    .name = "globalstate/vm_was_suspended",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    /* TODO: Fill these in */
+    .pre_save = NULL,
+    .post_load = NULL,
+    .needed = global_state_has_vm_was_suspended,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(vm_was_suspended, GlobalState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_globalstate = {
     .name = "globalstate",
     .version_id = 1,
@@ -136,6 +156,10 @@ static const VMStateDescription vmstate_globalstate = {
         VMSTATE_BUFFER(runstate, GlobalState),
         VMSTATE_END_OF_LIST()
     },
+    .subsections = (const VMStateDescription*[]) {
+        &vmstate_vm_was_suspended,
+        NULL
+    },
 };
 
 void register_global_state(void)
diff --git a/migration/options.c b/migration/options.c
index 8d8ec73ad9..5f9998d3e8 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -88,6 +88,8 @@
 Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
                      store_global_state, true),
+    DEFINE_PROP_BOOL("store-vm-was-suspended", MigrationState,
+                     store_vm_was_suspended, true),
     DEFINE_PROP_BOOL("send-configuration", MigrationState,
                      send_configuration, true),
     DEFINE_PROP_BOOL("send-section-footer", MigrationState,

-- 
Peter Xu


