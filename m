Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E92DF830399
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 11:30:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ3Ah-0007na-QW; Wed, 17 Jan 2024 05:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ3Af-0007mE-O9
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 05:29:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ3Ae-0002SV-2k
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 05:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705487359;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=La0cg8cp9ukVMmKXnuwCQS2fRF+UJWEUB9HZ0B48xXo=;
 b=O2BGqmHGem8JTUHXY3X5vIGpejONrghXLkDhuF4NVjrcDjOWP9KOvqOBNOgZfvx8qODGyS
 BOTlfIFREWgtkc4aLqzw1E35UauC8GgmKcxkrrC+EJWsPuv4ws0u2viDixi36s30PFyaCD
 slk5lk6PnTkEu23w9a00CaKsyy4bpTo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-UIiHMvpHNE6sAb8i7ybcWA-1; Wed, 17 Jan 2024 05:29:03 -0500
X-MC-Unique: UIiHMvpHNE6sAb8i7ybcWA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7817253831cso1644124985a.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 02:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705487343; x=1706092143;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=La0cg8cp9ukVMmKXnuwCQS2fRF+UJWEUB9HZ0B48xXo=;
 b=OSr35PfLbV63SMmjIc1ZAOnLJSLu1LyO3za9ZYUV62zxRWOw3lDYlQXvTV2ncRotsZ
 X9KU/A+lEyBSSaogNskUk2W6bl9IuwZQZ+xzBMI3HrVL71pcwVqE4FYMWGqsD0FBMedz
 ATLBGJXr0dYf3b9iLHegMQUw82Vf0LFOt9aTAUU39l3e1AiTs26HK6mgjyrV0m99RAR8
 De6Y2ArSsGZP722Tj8hYBhVLSTY5froXycxJROEO4GXh2Uv9qpaBVtocJ/cZFjPulk2g
 UdDHGXubG1t/lWv9uWtVx5oaJcdLIm0G7YLEUz7WvL3Gs3DU2doeGJxTmZVrfl3UJb0p
 2kqA==
X-Gm-Message-State: AOJu0Yy1HgR7gmpQdQwKsj6+tlM8X4Js6TVIK+ZHh32XmVg+IgSwLrO7
 IULwNTOtJe9iBsGQVxaDGYzkwx8sdMn3N0v8kLNtcBvlkmB9Ie1jS9VueR2lBkX5Wsup1MoCKul
 a9GJSewSBYwWqPxv8VE6zSYk=
X-Received: by 2002:a05:620a:f12:b0:783:4a7f:9049 with SMTP id
 v18-20020a05620a0f1200b007834a7f9049mr10575344qkl.68.1705487342902; 
 Wed, 17 Jan 2024 02:29:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERVq5KVsrwA4mpvQ5AtyloE3/smGdTMRuYY9eRmaxrydBTHDlTWTKe0ntgcwHmZfoungO3xw==
X-Received: by 2002:a05:620a:f12:b0:783:4a7f:9049 with SMTP id
 v18-20020a05620a0f1200b007834a7f9049mr10575335qkl.68.1705487342670; 
 Wed, 17 Jan 2024 02:29:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 bl26-20020a05620a1a9a00b0078366823711sm1516900qkb.119.2024.01.17.02.29.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 02:29:02 -0800 (PST)
Message-ID: <1bc3d59d-41a6-4ca7-9d9b-ee6ba6639bd0@redhat.com>
Date: Wed, 17 Jan 2024 11:28:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] reset: Allow multiple stages of system resets
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240117091559.144730-1-peterx@redhat.com>
 <20240117091559.144730-3-peterx@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240117091559.144730-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Peter,
On 1/17/24 10:15, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
>
> QEMU resets do not have a way to order reset hooks.  Add one coarse grained
> reset stage so that some devices can be reset later than some others.
I would precise that the lowest stage has the highest priority and is
handled first.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/sysemu/reset.h |  5 ++++
>  hw/core/reset.c        | 60 +++++++++++++++++++++++++++++++-----------
>  2 files changed, 49 insertions(+), 16 deletions(-)
>
> diff --git a/include/sysemu/reset.h b/include/sysemu/reset.h
> index 609e4d50c2..0de697ce9f 100644
> --- a/include/sysemu/reset.h
> +++ b/include/sysemu/reset.h
> @@ -5,9 +5,14 @@
>  
>  typedef void QEMUResetHandler(void *opaque);
>  
> +#define  QEMU_RESET_STAGES_N  2
> +
>  void qemu_register_reset(QEMUResetHandler *func, void *opaque);
> +void qemu_register_reset_one(QEMUResetHandler *func, void *opaque,
> +                             bool skip_snap, int stage);
>  void qemu_register_reset_nosnapshotload(QEMUResetHandler *func, void *opaque);
>  void qemu_unregister_reset(QEMUResetHandler *func, void *opaque);
> +void qemu_unregister_reset_one(QEMUResetHandler *func, void *opaque, int stage);
>  void qemu_devices_reset(ShutdownCause reason);
>  
>  #endif
> diff --git a/hw/core/reset.c b/hw/core/reset.c
> index 8cf60b2b09..a84c9bee84 100644
> --- a/hw/core/reset.c
> +++ b/hw/core/reset.c
> @@ -36,55 +36,83 @@ typedef struct QEMUResetEntry {
>      bool skip_on_snapshot_load;
>  } QEMUResetEntry;
>  
> -static QTAILQ_HEAD(, QEMUResetEntry) reset_handlers =
> -    QTAILQ_HEAD_INITIALIZER(reset_handlers);
> +typedef QTAILQ_HEAD(QEMUResetList, QEMUResetEntry) QEMUResetList;
> +static QEMUResetList reset_handlers[QEMU_RESET_STAGES_N];
>  
> -static void qemu_register_reset_one(QEMUResetHandler *func, void *opaque,
> -                                    bool skip_snap)
> +static void __attribute__((__constructor__)) qemu_reset_handlers_init(void)
> +{
> +    QEMUResetList *head;
> +    int i = 0;
nit: you may put the declarations within the block
> +
> +    for (i = 0; i < QEMU_RESET_STAGES_N; i++) {
> +        head = &reset_handlers[i];
> +        QTAILQ_INIT(head);
> +    }
> +}
> +
> +void qemu_register_reset_one(QEMUResetHandler *func, void *opaque,
> +                             bool skip_snap, int stage)
>  {
>      QEMUResetEntry *re = g_new0(QEMUResetEntry, 1);
> +    QEMUResetList *head;
> +
> +    assert(stage >= 0 && stage < QEMU_RESET_STAGES_N);
> +    head = &reset_handlers[stage];
>  
>      re->func = func;
>      re->opaque = opaque;
>      re->skip_on_snapshot_load = skip_snap;
> -    QTAILQ_INSERT_TAIL(&reset_handlers, re, entry);
> +    QTAILQ_INSERT_TAIL(head, re, entry);
>  }
>  
>  void qemu_register_reset(QEMUResetHandler *func, void *opaque)
>  {
> -    /* By default, do not skip during load of a snapshot */
Shouldn't the above comment stay since the statement is not affected by
this patch? Or remove it in previous patch?
> -    qemu_register_reset_one(func, opaque, false);
> +    qemu_register_reset_one(func, opaque, false, 0);
>  }
>  
>  void qemu_register_reset_nosnapshotload(QEMUResetHandler *func, void *opaque)
>  {
> -    qemu_register_reset_one(func, opaque, true);
> +    qemu_register_reset_one(func, opaque, true, 0);
>  }
>  
> -void qemu_unregister_reset(QEMUResetHandler *func, void *opaque)
> +void qemu_unregister_reset_one(QEMUResetHandler *func, void *opaque, int stage)
>  {
> +    QEMUResetList *head;
>      QEMUResetEntry *re;
>  
> -    QTAILQ_FOREACH(re, &reset_handlers, entry) {
> +    assert(stage >= 0 && stage < QEMU_RESET_STAGES_N);
> +    head = &reset_handlers[stage];
> +
> +    QTAILQ_FOREACH(re, head, entry) {
>          if (re->func == func && re->opaque == opaque) {
> -            QTAILQ_REMOVE(&reset_handlers, re, entry);
> +            QTAILQ_REMOVE(head, re, entry);
>              g_free(re);
>              return;
>          }
>      }
>  }
>  
> +void qemu_unregister_reset(QEMUResetHandler *func, void *opaque)
> +{
> +    qemu_unregister_reset_one(func, opaque, 0);
> +}
> +
>  void qemu_devices_reset(ShutdownCause reason)
>  {
>      QEMUResetEntry *re, *nre;
> +    QEMUResetList *head;
> +    int stage;
>  
>      /* reset all devices */
> -    QTAILQ_FOREACH_SAFE(re, &reset_handlers, entry, nre) {
> -        if (reason == SHUTDOWN_CAUSE_SNAPSHOT_LOAD &&
> -            re->skip_on_snapshot_load) {
> -            continue;
> +    for (stage = 0; stage < QEMU_RESET_STAGES_N; stage++) {
> +        head = &reset_handlers[stage];
> +        QTAILQ_FOREACH_SAFE(re, head, entry, nre) {
> +            if (reason == SHUTDOWN_CAUSE_SNAPSHOT_LOAD &&
> +                re->skip_on_snapshot_load) {
> +                continue;
> +            }
> +            re->func(re->opaque);
>          }
> -        re->func(re->opaque);
>      }
>  }
>  
Thanks

Eric


