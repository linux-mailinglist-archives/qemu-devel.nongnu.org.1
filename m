Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4207F1D86
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 20:47:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5AEY-0004Pd-TZ; Mon, 20 Nov 2023 14:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5AEK-0004NH-2g
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 14:46:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5AEI-0003Rh-Dz
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 14:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700509605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vOhRLOoz9aNvCEscWVyNA93OsKc/dnhT9WXNZ5FanAU=;
 b=XWNXFSEDCkkFqLrtZBv6D8vYDw7u3gHiifVWuDmxdHmmSu3S/A4491lij0z0F6sUsr/WAI
 xdrqnd3kqT8NVfqrGeKQRzhkhWtTmQKmQVCX4cT5eiiWUplUuRGEOt3hYNULwlbeQyRDpb
 RifEy2+Xqua29JBPHXCv4vW24LhHgeI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-_HZcxH23OW6mmN53VypWJA-1; Mon, 20 Nov 2023 14:46:43 -0500
X-MC-Unique: _HZcxH23OW6mmN53VypWJA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-677fb270eacso8105716d6.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 11:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700509603; x=1701114403;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vOhRLOoz9aNvCEscWVyNA93OsKc/dnhT9WXNZ5FanAU=;
 b=M1BtUBhaTufhqxuPpTm4n7hXMk6Ql3tKJ8xb11UwVoBkvcSZL+H3wkDoPTwNPvUs2Q
 lGCoIc3G4GD21bLn7P3jNl4kEoJ26OJVps+ntRH1WqmFPHZB54G4DyxgCvDV9rT8c2h/
 kpHw+zmzMERpPBH8Iau6mLSjalNXzmuNrh/zo/Z8sVHp13AVP8VVh5mW3YseD6NsMEGE
 ACYG+W4g2s8J6lbEWjb0I0kJFTBR3mrUw4uj4u32z0qzc0qwWX8oZQU6yney3ZJtCUXT
 mWWEjos9SpnxgHPahyDxAZaOXpJymHO/ZHR5kbD1ShRC4ySqXXC7xTioRuyuKilKyBop
 yhyQ==
X-Gm-Message-State: AOJu0Yya+h2qs/ciaWJ1Qif71oRCalboXcEz0MbPI9xvlB/sw3dT73lS
 1CdETLQrOOXb2mpuZpycB1mTay/wggIRPTPR/rjktfEprSZQzF32q55Hd4bDo9o082rkC1NKEZ5
 XrUjTcZU7gAr8UrA=
X-Received: by 2002:a05:6214:176b:b0:675:6380:9912 with SMTP id
 et11-20020a056214176b00b0067563809912mr8182195qvb.1.1700509603240; 
 Mon, 20 Nov 2023 11:46:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzPLKeuUrhYF2X2xaTrKwBjBG2b9R/3NPQn9bInGQpibTIzwdqNc7ZcjwF/GR0dkWmtNm+3A==
X-Received: by 2002:a05:6214:176b:b0:675:6380:9912 with SMTP id
 et11-20020a056214176b00b0067563809912mr8182173qvb.1.1700509602883; 
 Mon, 20 Nov 2023 11:46:42 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 o18-20020a0cfa92000000b00678043fa587sm2121898qvn.118.2023.11.20.11.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 11:46:42 -0800 (PST)
Date: Mon, 20 Nov 2023 14:46:41 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V5 01/12] cpus: refactor vm_stop
Message-ID: <ZVu3oawbZS6IEbHO@x1n>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-2-git-send-email-steven.sistare@oracle.com>
 <87leas5zlo.fsf@suse.de>
 <250d0338-d29d-4cd0-8e33-0520fd1fb354@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <250d0338-d29d-4cd0-8e33-0520fd1fb354@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 20, 2023 at 02:09:31PM -0500, Steven Sistare wrote:
> On 11/20/2023 8:22 AM, Fabiano Rosas wrote:
> > Steve Sistare <steven.sistare@oracle.com> writes:
> >> Refactor the vm_stop functions into one common subroutine do_vm_stop called
> >> with options.  No functional change.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>  system/cpus.c | 44 +++++++++++++++++---------------------------
> >>  1 file changed, 17 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/system/cpus.c b/system/cpus.c
> >> index 0848e0d..f72c4be 100644
> >> --- a/system/cpus.c
> >> +++ b/system/cpus.c
> >> @@ -252,10 +252,21 @@ void cpu_interrupt(CPUState *cpu, int mask)
> >>      }
> >>  }
> >>  
> >> -static int do_vm_stop(RunState state, bool send_stop)
> >> +static int do_vm_stop(RunState state, bool send_stop, bool force)
> >>  {
> >>      int ret = 0;
> >>  
> >> +    if (qemu_in_vcpu_thread()) {
> >> +        qemu_system_vmstop_request_prepare();
> >> +        qemu_system_vmstop_request(state);
> >> +        /*
> >> +         * FIXME: should not return to device code in case
> >> +         * vm_stop() has been requested.
> >> +         */
> >> +        cpu_stop_current();
> >> +        return 0;
> >> +    }
> > 
> > At vm_stop_force_state(), this block used to be under
> > runstate_is_running(), but now it runs unconditionally.
> 
> vm_stop_force_state callers should never be called in a vcpu thread, so this block
> is never executed for them.  I could assert that.
> 
> > At vm_shutdown(), this block was not executed at all, but now it is.
> 
> vm_shutdown should never be called from a vcpu thread.
> I could assert that.

Would you split the patch into two?  Moving qemu_in_vcpu_thread() is one,
the rest can be put into another, IMHO.  That may also help to make the
review easier.  OTOH the code changes look all correct here.  Thanks,

-- 
Peter Xu


