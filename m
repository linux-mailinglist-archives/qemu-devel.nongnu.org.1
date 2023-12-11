Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C6F80C17C
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 07:46:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCa3h-0000ZT-S3; Mon, 11 Dec 2023 01:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rCa3Y-0000Xa-O6
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:46:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rCa3V-0007JP-3z
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702277175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YILVIsgLQ0J2MBPTarV08CA5vVG/czTnfdocOcx7sDs=;
 b=BVIEzjXG71kfFVKm9tDoDVc/9AwTH3BlARjYbohtnXGUbE6F5NlLAV6blQvyFIbunPK38I
 W8CE2lOGoAWQUpwborTrv/VOdPbEcwdel9+aEeH29ilrM2aaQALsCxo6eCz4LjAQHUfdy+
 d/QDycjQnc3UBBhVYuNzKOdghtzfUeI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-F2E6grd0MMyz9UgVC0Cspg-1; Mon, 11 Dec 2023 01:46:13 -0500
X-MC-Unique: F2E6grd0MMyz9UgVC0Cspg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2886837d325so1352882a91.0
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 22:46:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702277172; x=1702881972;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YILVIsgLQ0J2MBPTarV08CA5vVG/czTnfdocOcx7sDs=;
 b=Bf/T+5P+vrB2hjRD0mMFran922UfN3d9V8HBI/QFesZNWJOyarLGJ2/H0ia5wu9UAX
 WIBrW9QANv7H9u4SBABuvp0T/GYTWcKZwl1dWEKpSCtvumVdQ2FXtClJOq6vHWuPrzfq
 cBX2d+XRJA2nXEkBr/45YymVeDUzUXQqSv0pJrZlA3Li9kSqur4wYiOOUEYPziDfOUSZ
 dsDT2a99t6eel641GfHSkHmXtBH+vh5b8NMG5QzRmsLJVjc9J6pphkwTAF+Q8Dbhz3Xj
 zD6M1aRBKkEh8kzxs51NHI7rvRuijcLhc6kC46A+nITt6Fu+sPHOb5KowVn4kfxPvOwY
 Wo5Q==
X-Gm-Message-State: AOJu0YzM2CPeeVChjvU9eey4QQ1xXxnpwb8Xt21BQmmG2bTm6csHmEB9
 z5dgwo2RDB+QrM4qyqbJWyRbN9sMN62ihjlMYjwzvMxHChNpLgM6aR8gDC3VOuvza1XLJTQbSnZ
 8N/1V0rl1QPWkCaU=
X-Received: by 2002:a05:6a20:7d8e:b0:187:df59:5c43 with SMTP id
 v14-20020a056a207d8e00b00187df595c43mr9079545pzj.2.1702277172696; 
 Sun, 10 Dec 2023 22:46:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmYOB1H3uEVNNq77a97VYy46dfZO/8VId9SD2/MJ2T4cTvASWmOYB57XkNHTv6xGvEM040uw==
X-Received: by 2002:a05:6a20:7d8e:b0:187:df59:5c43 with SMTP id
 v14-20020a056a207d8e00b00187df595c43mr9079536pzj.2.1702277172420; 
 Sun, 10 Dec 2023 22:46:12 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 gw17-20020a17090b0a5100b00285be64e529sm7595692pjb.39.2023.12.10.22.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 22:46:12 -0800 (PST)
Date: Mon, 11 Dec 2023 14:46:04 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V7 05/12] migration: propagate suspended runstate
Message-ID: <ZXawLKhxgJiPYfdX@x1n>
References: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
 <1701883417-356268-6-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1701883417-356268-6-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Dec 06, 2023 at 09:23:30AM -0800, Steve Sistare wrote:
> If the outgoing machine was previously suspended, propagate that to the
> incoming side via global_state, so a subsequent vm_start restores the
> suspended state.  To maintain backward and forward compatibility, reclaim
> some space from the runstate member.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

One nitpick below.

> ---
>  migration/global_state.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 4e2a9d8..d4f61a1 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -22,7 +22,16 @@
>  
>  typedef struct {
>      uint32_t size;
> -    uint8_t runstate[100];
> +
> +    /*
> +     * runstate was 100 bytes, zero padded, but we trimmed it to add a
> +     * few fields and maintain backwards compatibility.
> +     */
> +    uint8_t runstate[32];
> +    uint8_t has_vm_was_suspended;
> +    uint8_t vm_was_suspended;
> +    uint8_t unused[66];
> +
>      RunState state;
>      bool received;
>  } GlobalState;
> @@ -35,6 +44,10 @@ static void global_state_do_store(RunState state)
>      assert(strlen(state_str) < sizeof(global_state.runstate));
>      strpadcpy((char *)global_state.runstate, sizeof(global_state.runstate),
>                state_str, '\0');
> +    global_state.has_vm_was_suspended = true;
> +    global_state.vm_was_suspended = vm_get_suspended();
> +
> +    memset(global_state.unused, 0, sizeof(global_state.unused));
>  }
>  
>  void global_state_store(void)
> @@ -68,6 +81,12 @@ static bool global_state_needed(void *opaque)
>          return true;
>      }
>  
> +    /* If the suspended state must be remembered, it is needed */
> +
> +    if (vm_get_suspended()) {
> +        return true;
> +    }

Can we drop this section?

I felt unsafe when QEMU can overwrite the option even if user explicitly
specified store-global-state=off but we still send this..  Ideally I think
it's better if it's as simple as:

static bool global_state_needed(void *opaque)
{
    return migrate_get_current()->store_global_state;
}

I don't think we can remove the old trick due to compatibility reasons, but
maybe nice to not add new ones to make this section more unpredictable in
the migration stream?

IMHO it shouldn't matter in reality for the current use case even dropping
it, as I don't expect any non-Xen QEMU VMs migrates without having the
option turned on (store-global-state=on) after QEMU 2.4.

Thanks,

-- 
Peter Xu


